##
## InsertVcf Plugin
## $Id: InsertVcf.pm $
##


package GUS::Community::Plugin::InsertVcf;
@ISA = qw(GUS::PluginMgr::Plugin);

use strict;
use GUS::PluginMgr::Plugin;
use Data::Dumper;
use Vcf;
# use Bio::EnsEMBL::Variation::Utils::dbSNP qw(decode_bitfield);
# use GUS::Community::Utils::dbSnpBits;

use GUS::Model::DoTS::SnpFeature;
use GUS::Model::DoTS::ExternalNASequence;
use GUS::Model::DoTS::NALocation;
use GUS::Model::DoTS::DbRefNAFeature;
use GUS::Model::SRes::DbRef;
use GUS::Model::Results::SeqVariation;

my %infoHash;
my %seqHash;

# ----------------------------------------------------------------------
# Arguments
# ---------------------------------------------------------------------

sub getArgumentsDeclaration {
  my $argumentDeclaration  =
    [
     fileArg({name => 'vcfFile',
	      descr => 'The full path of the input VCF file.',
	      constraintFunc=> undef,
	      reqd  => 1,
	      isList => 0,
	      mustExist => 1,
	      format => 'VCF'
	     }),
     stringArg({ name  => 'extDbRlsSpec',
                 descr => "The ExternalDBRelease specifier for dbSnp. Must be in the format 'name|version', where the name must match a name in SRes::ExternalDatabase and the version must match an associated version in SRes::ExternalDatabaseRelease.",
                 constraintFunc => undef,
                 reqd           => 1,
                 isList         => 0 
             }),
     booleanArg({name => 'checkExists',
		 descr => "before loading each RS ID, check that it doesn't already exist in the database (silently skipping it if it does)",
		 reqd => 0,
		 default => 0
            }),
    ];
  return $argumentDeclaration;
}

# ----------------------------------------------------------------------
# Documentation
# ----------------------------------------------------------------------

sub getDocumentation {
  my $purposeBrief = 'Loads dbSNP';

  my $purpose = 'This plugin reads SNPs from a VCF file, and inserts its content into GUS';

  my $tablesAffected = [['Study::Protocol', 'Loads the "sample" protocol, which links a population to one of its members'], ['Study::ProtocolApp', 'Creates applications of the "sample" protocol'], ];

  my $tablesDependedOn = []; 

  my $howToRestart = '';

  my $failureCases = '';

  my $notes = <<NOTES;

Written by John Iodice.
Copyright Trustees of University of Pennsylvania 2013. 
NOTES

  my $documentation = {purpose=>$purpose, purposeBrief=>$purposeBrief, tablesAffected=>$tablesAffected, tablesDependedOn=>$tablesDependedOn, howToRestart=>$howToRestart, failureCases=>$failureCases, notes=>$notes};

  return $documentation;
}

# ----------------------------------------------------------------------
# create and initalize new plugin instance.
# ----------------------------------------------------------------------

sub new {
  my ($class) = @_;
  my $self = {};
  bless($self,$class);


  my $documentation = &getDocumentation();
  my $argumentDeclaration    = &getArgumentsDeclaration();

  $self->initialize({requiredDbVersion => 4.0,
		     cvsRevision => '$Revision$',
		     name => ref($self),
		     revisionNotes => '',
		     argsDeclaration => $argumentDeclaration,
		     documentation => $documentation
		    });
  return $self;
}

# ----------------------------------------------------------------------
# run method to do the work
# ----------------------------------------------------------------------

sub run {
  my ($self) = @_;

  $self->logAlgInvocationId();
  $self->logCommit();
  $self->logArgs();
  $self->getAlgInvocation()->setMaximumNumberOfObjects(100000);


  $self->{extDbRlsId} = $self->getExtDbRlsId($self->getArg('extDbRlsSpec'));

  $self->processVcfFile($self->getArg('vcfFile'));

}

# ----------------------------------------------------------------------
# methods called by run
# ----------------------------------------------------------------------


sub processVcfFile {
    my ($self, $vcfFile) = @_;

    my $vcf = Vcf->new(file=>$vcfFile);
    $vcf->parse_header();

    my $recordCount;
    my $skipCount;
    my $checkExists = $self->getArg('checkExists');
    while (my $vcfHash = $vcf->next_data_hash()) {

	my $rsId = $vcfHash->{ID};

	my $snpFeature = GUS::Model::DoTS::SnpFeature
	    ->new( {
		"source_id" => "$rsId",
		   } );

	if ($checkExists) {
	    if ($snpFeature->retrieveFromDB()) {
		unless ( ($skipCount++) % 50000) {
		    $self->undefPointerCache();
		}
		next;
	    }
	}

	my $naSequenceId = $self->getSequenceId($vcfHash->{CHROM});
	$snpFeature->setNaSequenceId($naSequenceId);
	$snpFeature->setName('variation');
	$snpFeature->setMajorAllele($vcfHash->{REF});
	$snpFeature->setMinorAllele(join(',', @{$vcfHash->{ALT}}));
	$snpFeature->submit();

	my $pos = $vcfHash->{POS};
	my $naLocation = GUS::Model::DoTS::NALocation
	    ->new( {
		"na_feature_id" => $snpFeature->getNaFeatureId(),
		"start_min" => $pos,
		"end_max" => $pos,
		   } );
	$naLocation->submit();

	$self->log("$rsId on chromosome " . $vcfHash->{CHROM} . " at location " . $vcfHash->{POS})
	    if $self->getArg('veryVerbose');

	# is "FILTER" used? We aren't handling that.
	my $filterString = ${$vcfHash->{FILTER}}[0];
	if ($filterString ne '.') {
	    $self->log("WARNING: $rsId has the filter \"$filterString\"");
	}

	my %info = %{$vcfHash->{INFO}};
	my $infoString;
	foreach my  $infoKey (keys %info) {
	    my $infoVal = $info{$infoKey};
	    my %headerHash = %{$vcf->get_header_line(key=>'INFO', ID=>$infoKey)->[0]};
	    $infoString .= ";" if $infoString;
	    $infoString .= $infoKey;
	    $infoString .= "=\"$infoVal\"" if defined($infoVal);

	    my $dbRefId = $self->getDbRefId($vcf, $infoKey);
	    my $dbRefNaFeature = GUS::Model::DoTS::DbRefNAFeature
		->new( {
		    "db_ref_id" => $dbRefId,
		    "na_feature_id" => $snpFeature->getId(),
		       } );
	    $dbRefNaFeature->submit();
	    
	    if ($self->getArg('veryVerbose')) {
		my $infoMsg;
		$infoMsg .= "  info:\n" unless $infoString;
		$infoMsg .= "    $infoKey";
		$infoMsg .= " = \"$infoVal\"" if defined($infoVal);
		$infoMsg .= " (" . $headerHash{Description} . ")";
		$infoMsg .= "\n";
		$self->log($infoMsg);
	    }

	    # if this is the "VC" field, use its value to set name
	    if ($infoKey eq "VC" && defined($infoVal)) {
		$snpFeature->setName($infoVal);
	    }

#	    # if this is the "VP" bitfield, decode it
#             or don't; it turns out VP basically duplicates the other INFO tags
#	    if ($infoKey eq "VP") {
#		my $bitfieldHashref = decode_bitfield($infoVal);
#		foreach my $bitfield (keys(%{$bitfieldHashref})) {
#		    my $def = GUS::Community::Utils::dbSnpBits::define_bitfield($bitfield);
#		    print "      $bitfield ";
#		    print "= " . $bitfieldHashref->{$bitfield}
#		    if GUS::Community::Utils::dbSnpBits::has_value($bitfield);
#		    print " ($def)";
#		    print " (BITFIELD)\n";
#		}
#	    }

	}
	$snpFeature->setDescription($infoString);
	$snpFeature->submit();

	unless ( ($recordCount++) % 1000) {
	    $self->undefPointerCache();
	    $self->log("$recordCount records loaded")
		if $self->getArg('verbose');
	}
    }
    $self->log("loaded $recordCount records");
}

# getSequenceId
#
# find the na_sequence_id for the given chromosome name
sub getSequenceId {
    my ($self, $chromosome) = @_;

    unless ($seqHash{$chromosome}) {

	my $externalNASequence = GUS::Model::DoTS::ExternalNASequence
	    ->new( {
		"chromosome" => $chromosome,
		   } );

	if (!$externalNASequence->retrieveFromDB()) {

	    # couldn't find it with that name -- remove the prefix "chr" if present
	    if ($chromosome =~ /^chr(.*)$/) {
		$externalNASequence->setChromosome($1);
	    }

	    if (!$externalNASequence->retrieveFromDB()) {
		# couldn't find that either -- insert
		# $externalNASequence->setChromosome($chromosome); # use unabbreviated chromosome name
		$self->log("adding new sequence record for chromosome \"$chromosome\"")
		    if $self->getArg('verbose');
		$externalNASequence->setSequenceVersion("1");
		$externalNASequence->submit();
	    }
	}
	$seqHash{$chromosome} = $externalNASequence->getId();
    }
    return $seqHash{$chromosome}
}

# getDbRefId
#
# find the db_ref_id for the given info message
sub getDbRefId {
    my ($self, $vcf, $infoKey) = @_;

    unless ($infoHash{$infoKey}) {

	my $dbRef = GUS::Model::SRes::DbRef
	    ->new( {
		"primary_identifier" => $infoKey,
		"external_database_release_id" => $self->{extDbRlsId},
		   } );

	if (!$dbRef->retrieveFromDB()) {
	    my %headerHash = %{$vcf->get_header_line(key=>'INFO', ID=>$infoKey)->[0]};
	    my $description = $headerHash{Description};
	    $dbRef->setRemark($description);
	    $dbRef->submit();
	}
	$infoHash{$infoKey} = $dbRef->getId();
    }

    return $infoHash{$infoKey}
}

# ----------------------------------------------------------------------
sub undoTables {
  my ($self) = @_;

  return ('DoTS.SnpFeature', 'DoTS.NALocation', 'DoTS.ExternalNASequence', 'SRes.DbRef', 'DoTS.DbRefNAFeature');
}

sub define_dbSnp_bitfield {
    my ($id) = @_;

    my %bitfieldDef = (
	clinical	 => "SNP is Clinical(LSDB,OMIM,TPA,Diagnostic)",
	precious	 => "SNP is Precious(Clinical,Pubmed Cited)",
	provisional_tpa	 => "Provisional Third Party Annotation(TPA)(currently rs from PHARMGKB who will give pheotype data).",
	pubmed	 => "Links exist to PubMed Central article",
	sra	 => "Links exist to Short Read Archive",
	organism_db_link	 => "Has OrganismDBLink (Ex. Jackson Lab for mouse)",
	mgc_clone	 => "From MGC clone (~20K rs set from specific submitter handle/ batch_id)",
	trace_archive	 => "Links exist to Trace Archive",
	assembly_archive	 => "Links exist to Assembly Archive",
	entrez_geo	 => "Links exist to Entrez GEO",
	probe_db	 => "Links exist to ProbeDB",
	entrez_gene	 => "Links exist to Entrez Gene",
	entrez_sts	 => "Links exist to Entrez STS",
	has_structure	 => "Has 3D structure SNP3D table",
	submitter_link_out	 => "Has SubmitterLinkOut From SNP->SubSNP->Batch.link_out",
	has_other_snp	 => "Has other SNP with exactly the same set of mapped positions on NCBI refernce assembly.",
	has_assembly_conflict	 => "Has Assembly conflict. This is for weight 1 and 2 SNP that maps to different chromosomes on different assemblies.",
	is_assembly_specific	 => "Is Assembly specific. This bit is 1 if the SNP only maps to one assembly.",
	weight	 => "Weight on NCBI reference assembly. (0 = unmapped, 1 = 1, 2 = 2, 3 = 3 or more).",
	stop_loss	 => "Has STOP-Loss: A coding region variation where one allele in the set changes the encoded STOP CODON (TER). FxnClass = 43",
	frameshift	 => "Has non-synonymous frameshift: A coding region variation where one allele in the set changes all downstream amino acids. FxnClass = 44",
	missense	 => "Has non-synonymous missense: A coding region variation where one allele in the set changes protein peptide. FxnClass = 42",
	stop_gain	 => "Has STOP-Gain: A coding region variation where one allele in the set changes to STOP codon (TER). FxnClass = 41",
	has_ref	 => "Has reference: A coding region variation where one allele in the set is identical to the reference sequence. FxnCode = 8",
	has_syn	 => "Has synonymous: A coding region variation where one allele in the set does not change the encoded amino acid. FxnCode = 3",
	utr_3	 => "In 3' UTR: Location is in an untranslated region (UTR). FxnCode = 53",
	utr_5	 => "In 5' UTR: Location is in an untranslated region (UTR). FxnCode = 55",
	acceptor_ss	 => "In acceptor splice site. FxnCode = 73",
	donor_ss	 => "In donor splice-site. FxnCode = 75",
	intron	 => "In Intron. FxnCode = 6",
	region_3	 => "In 3' gene region. FxnCode = 13",
	region_5	 => "In 5' gene region. FxnCode = 15",
	in_gene	 => "In gene segment. Defined as sequence intervals covered by a gene ID but not having an aligned transcript. FxnCode = 11",
	is_mutation	 => "Is mutation (journal citation, explicit fact): a low frequency variation that is cited in journal and other reputable sources.",
	is_validated	 => "Is Validated. This bit is set if the SNP has 2+ minor allele count based on frequency or genotype data.",
	maf_all_pops	 => ">5% minor allele frequency in each and all populations.",
	maf_some_pops	 => ">5% minor allele frequency in 1+ populations",
	marker_high_density	 => "Marker is on high density genotyping kit (50K density or greater). The SNP may have phenotype associations present in dbGaP.",
	in_haplotype_tagging_set	 => "In Haplotype tagging set",
	genotypes_available	 => "Genotypes available. The SNP has individual genotype (in SubInd table).",
	has_mesh	 => "Has MeSH is linked to a disease.",
	clinical_assay	 => "Variation is interrogated in a clinical diagnostic assay",
	has_tf	 => "Has transcription factor",
	lsdb	 => "Submitted from a locus-specific database.",
	dbgap_significant	 => "Has p-value <= 10^-3 in a dbGaP study association test",
	dbgap_lod_score	 => "Has LOD score # 2.0 in a dbGaP study genome scan",
	third_party_annot	 => "Microattribution/third-party annotation(TPA:GWAS,PAGE)",
	omim	 => "Has OMIM/OMIA",
	is_suspect	 => "Is suspect. The variants are paralogous sequence differences. (added 01/19/11 ver 5.4) val=64",
	is_somatic	 => "Variation is somatic, not germline. The variation was detected in a somatic tissue (e.g. cancer tumor). The variation is not known to exist in heritable DNA.",
	contig_allele_not_present	 => "Contig allele not present in SNP allele list. The reference sequence allele at the mapped position is not present in the SNP allele list, adjusted for orientation.",
	withdrawn	 => "Is Withdrawn by submitter If one member ss is withdrawn by submitter, then this bit is set. If all member ss' are withdrawn, then the rs is deleted to SNPHistory.",
	cluster_no_overlap	 => "Rs cluster has non-overlapping allele sets. True when rs set has more than 2 alleles from different submissions and these sets share no alleles in common.",
	strain_specific	 => "Is a strain-specific fixed difference",
	genotype_conflict	 => "Has Genotype Conflict Same (rs, ind), different genotype. N/N is not included.",
	tgp_2010_production	 => "TGP 2010 production",
	tgp_validated	 => "TGP Validated",
	tgp_2010_pilot	 => "TGP 2010 pilot",
	tgp_2009_pilot	 => "TGP 2009 pilot",
	hm_phase_3_genotyped	 => "HapMap Phase 3 genotyped: filtered, non- redundant. (VCF: PH3)",
	hm_phase_2_genotyped	 => "HapMap Phase 2 genotyped",
	hm_phase_1_genotyped	 => "HapMap Phase 1 genotyped",
	version	 => "Bitmap schema version. Versions increment as integer value",
	var_class	 => "Variation class",
	);

    return ($bitfieldDef{$id});
}

sub dbSnp_bitfield_has_value {
    my ($id) = @_;

    my %hasValue = (
	weight	 => 1,
	version	 => 1,
	var_class	 => 1,
	);

    return ($hasValue{$id});
}

1;