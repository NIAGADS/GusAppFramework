package GUS::Community::Plugin::InsertGoRelationships;

@ISA = qw(GUS::PluginMgr::Plugin);

use strict;

use GUS::PluginMgr::Plugin;

use GUS::Model::SRes::OntologyTerm;
use GUS::Model::SRes::OntologyTermType;
use GUS::Model::SRes::OntologyRelationship;

my $ontologyTermTypeId;

my $argsDeclaration =
  [
   stringArg({ name           => 'extDbRlsName',
	       descr          => 'external database release name for the GO ontology',
	       reqd           => 1,
	       constraintFunc => undef,
	       isList         => 0,
	     }),

   stringArg({ name           => 'extDbRlsVer',
	       descr          => 'external database release version for the GO ontology. Must be equal to the data-version of the GO ontology as stated in the oboFile',
	       reqd           => 1,
	       constraintFunc => undef,
	       isList         => 0,
	     }),

   fileArg({ name           => 'relationshipFile',
	     descr          => 'A tab-delimited file containing GO term relationships',
	     reqd           => 1,
	     mustExist      => 1,
	     format         => 'tab-delimited',
	     constraintFunc => undef,
	     isList         => 0,
	   }),

  ];

my $purpose = <<PURPOSE;
Insert GO relationships from a tab-delimited file.
PURPOSE

my $purposeBrief = <<PURPOSE_BRIEF;
Insert GO relationships from a tab-delimited file.
PURPOSE_BRIEF

my $notes = <<NOTES;
NOTES

my $tablesAffected = <<TABLES_AFFECTED;
SRes.OntologyTermType, SRes.OntologyRelationship
TABLES_AFFECTED

my $tablesDependedOn = <<TABLES_DEPENDED_ON;
SRes.OntologyTerm, SRes.OntologySynonym
TABLES_DEPENDED_ON

my $howToRestart = <<RESTART;
Just reexecute the plugin; Relationships which alread exist will not be duplicated.
RESTART

my $failureCases = <<FAIL_CASES;
FAIL_CASES

my $documentation =
  { purpose          => $purpose,
    purposeBrief     => $purposeBrief,
    notes            => $notes,
    tablesAffected   => $tablesAffected,
    tablesDependedOn => $tablesDependedOn,
    howToRestart     => $howToRestart,
    failureCases     => $failureCases
  };

sub new {
  my ($class) = @_;
  $class = ref $class || $class;

  my $self = bless({}, $class);

  $self->initialize({ requiredDbVersion => 4.0,
		      cvsRevision       => '$Revision$',
		      name              => ref($self),
		      argsDeclaration   => $argsDeclaration,
		      documentation     => $documentation
		    });

  return $self;
}

sub run {
  my ($self) = @_;

  my $extDbRlsName = $self->getArg('extDbRlsName');
  my $extDbRlsVer = $self->getArg('extDbRlsVer');

  my $extDbRlsId = $self->getExtDbRlsId($extDbRlsName, $extDbRlsVer);

  $self->_loadRelationships($extDbRlsId);
}


sub _loadRelationships {

    my ($self, $extDbRlsId) = @_;

    warn "loading relationships";
    my $relCount;
    my $relationshipFile = $self->getArg('relationshipFile');
    open(RELATIONSHIPS, "<$relationshipFile") or $self->error("Couldn't open '$relationshipFile': $!\n");
    while (<RELATIONSHIPS>) {
	chomp;
	my ($childName, $childId, $parentName, $parentId, $relation) = split /\t/;

	# warn "childName=\"$childName\"; childId=\"$childId\"; parentName=\"$parentName\"; parentId=\"$parentId\"; relation=\"$relation\"\n"
	    # if !($relCount % 10);

	my $parentTerm = $self->_retrieveOntologyTerm($parentId, undef, undef, undef,
						      undef, undef, $extDbRlsId);
	my $childTerm = $self->_retrieveOntologyTerm($childId, undef, undef, undef,
						      undef, undef, $extDbRlsId);
	my $predicate = $self->_retrieveRelationshipPredicate($relation, $extDbRlsId);

	my $ontologyRelationship =
	    GUS::Model::SRes::OntologyRelationship->new({
		subject_term_id   => $childTerm->getOntologyTermId(),
		predicate_term_id => $predicate->getOntologyTermId(),
		object_term_id    => $parentTerm->getOntologyTermId(),
							});

	$ontologyRelationship->submit();
	unless ($relCount++ % 500) {
	    warn "Processed $relCount relationships\n";
	    $self->undefPointerCache();
	}
    }
}


sub _retrieveRelationshipPredicate {

  my ($self, $type, $extDbRlsId) = @_;

  my $predicateTerm = GUS::Model::SRes::OntologyTerm->new({
    name                         => $type,
    ontology_term_type_id        => $self->_getOntologyTermTypeId('relationship'),
    external_database_release_id => $extDbRlsId,
  });

  $predicateTerm->submit()
    unless ($predicateTerm->retrieveFromDB());

  return $predicateTerm;
}

sub _retrieveOntologyTerm {

  my ($self, $id, $name, $def, $comment, $synonyms, $isObsolete, $extDbRlsId) = @_;

  my $ontologyTerm = GUS::Model::SRes::OntologyTerm->new({
    source_id                    => $id,
    ontology_term_type_id        => $self->_getOntologyTermTypeId('class'),
    external_database_release_id => $extDbRlsId,
  });

  unless ($ontologyTerm->retrieveFromDB()) {
      $ontologyTerm->setName("Not yet available");
    }

  # some of these may not actually yet be available, if we've been
  # called while building a relationship:

  $ontologyTerm->setName($name) if length($name);
  $ontologyTerm->setDefinition($def) if length($def);
  $ontologyTerm->setNotes($comment) if length($comment);
  $ontologyTerm->setIsObsolete(1) if ($isObsolete && $isObsolete eq "true");

  $self->_setOntologyTermSynonyms($ontologyTerm, $synonyms, $extDbRlsId) if $synonyms;

  $ontologyTerm->submit();

  return $ontologyTerm;
}

sub _getOntologyTermTypeId {

  my ($self, $name) = @_;

  if (!$ontologyTermTypeId) {
    my $ontologyTermType = GUS::Model::SRes::OntologyTermType->new({
      name                         => $name,
    });

    $ontologyTermType->submit()
      unless ($ontologyTermType->retrieveFromDB());

    $ontologyTermTypeId = $ontologyTermType->getOntologyTermTypeId();
  }

  return ($ontologyTermTypeId);
}

sub undoTables {
  my ($self) = @_;

  return ('SRes.OntologyRelationship',
	 );
}
