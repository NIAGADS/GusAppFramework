#!/usr/bin/perl

package GUS::Pipeline::MakeTaskDirs;


##############################################################################
# Subroutines for creating directories used to control Liniac DistribJob Tasks
#
# Supported tasks (for now) are:
#  RepeatMaskTask, BlastSimilarityTask, BlastMatrixTask
#
# The directories are created on the local machine with the expectation that 
# they will be copied to the liniac server.  They use $serverPath and
# $nodePath to describe the root paths on the liniac server and nodes.
#
# The main work done is the formatting of the controller.prop and task.prop
# files required by Liniac DistribJob Tasks
# 
# Directories created look like this:
# $localPath/$pipelineName/TASK/$datasetName/input/
#   controller.prop
#   task.prop
#
##############################################################################

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(makeRMDir makeGenomeDir makeMatrixDir makeSimilarityDir makeControllerPropFile);

use strict;
use Carp;
use CBIL::Util::Utils;

sub makeRMDir {
    my ($datasetName, $pipelineName, $localPath, $serverPath, $nodePath, 
	$taskSize, $rmOptions, $dangleMax, $rmPath) = @_;
    
    my $localBase = "$localPath/$pipelineName/repeatmask/$datasetName";
    my $serverBase = "$serverPath/$pipelineName/repeatmask/$datasetName"; 
    my $inputDir = "$localBase/input";
    &runCmd("mkdir -p $inputDir");
    &makeControllerPropFile($inputDir, $serverBase, 2, $taskSize, 
			    $nodePath, 
			    "DJob::DistribJobTasks::RepeatMaskerTask");
    my $seqFileName = "$serverPath/$pipelineName/seqfiles/$datasetName.fsa"; 
    &makeRMTaskPropFile($inputDir, $seqFileName, $rmOptions, $rmPath,$dangleMax);
}

sub makeGenomeDir {
    my ($queryName, $targetName, $pipelineName, $localPath, $serverPath,$liniacServer,
	$nodePath, $taskSize, $gaOptions, $gaBinPath, $localGDir, $serverGDir) = @_;
    my $localBase = "$localPath/$pipelineName/genome/$queryName-$targetName";
    my $serverBase = "$serverPath/$pipelineName/genome/$queryName-$targetName";
    my $inputDir = "$localBase/input";
    &runCmd("mkdir -p $inputDir");
    &makeControllerPropFile($inputDir, $serverBase, 2, $taskSize, 
			    $nodePath, 
			    "DJob::DistribJobTasks::GenomeAlignTask");
    my $seqFileName = "$serverPath/$pipelineName/repeatmask/$queryName/master/mainresult/blocked.seq";
    my $serverInputDir = "$serverBase/input";
    &makeGenomeTaskPropFile($inputDir, $serverInputDir, $seqFileName, $gaOptions, $gaBinPath,
			    $localGDir, $serverGDir);
    &makeGenomeParamsPropFile($inputDir . '/params.prop', $serverGDir . '/11.ooc');
    &makeTargetListFile($inputDir . '/target.lst', $serverGDir,$liniacServer);
}

sub makeMatrixDir {
    my ($queryName, $subjectName, $pipelineName, $localPath, $serverPath, 
	$nodePath, $taskSize, $blastBinPath) = @_;
    
    my $localBase = "$localPath/$pipelineName/matrix/$queryName-$subjectName";
    my $serverBase = "$serverPath/$pipelineName/matrix/$queryName-$subjectName"; 
    my $inputDir = "$localBase/input";
    &runCmd("mkdir -p $inputDir");
    &makeControllerPropFile($inputDir, $serverBase, 2, $taskSize, 
			    $nodePath, 
			    "DJob::DistribJobTasks::BlastMatrixTask");
    my $dbFileName = "$serverPath/$pipelineName/repeatmask/$subjectName/master/mainresult/blocked.seq"; 
    my $seqFileName = "$serverPath/$pipelineName/repeatmask/$queryName/master/mainresult/blocked.seq"; 
    &makeBMTaskPropFile($inputDir, $blastBinPath, $seqFileName, $dbFileName);
}

sub makeSimilarityDir {
    my ($queryName, $subjectName, $pipelineName, $localPath, $serverPath, 
	$nodePath, $taskSize, $blastBinPath,
	$dbName, $dbPath, $queryFileName, $regex, $blast, $blastParams) = @_;
    
    my $localBase = "$localPath/$pipelineName/similarity/$queryName-$subjectName";
    my $serverBase = "$serverPath/$pipelineName/similarity/$queryName-$subjectName";
    my $inputDir = "$localBase/input";
    my $blastParamsFile = "$inputDir/blastParams";

    &runCmd("mkdir -p $inputDir");
    &makeControllerPropFile($inputDir, $serverBase, 1, $taskSize, 
			    $nodePath, "DJob::DistribJobTasks::BlastSimilarityTask");
    my $dbFileName = "$dbPath/$dbName"; 
    my $seqFileName = "$serverPath/$pipelineName/seqfiles/$queryFileName";
    &makeBSTaskPropFile($inputDir, $blastBinPath, $seqFileName, $dbFileName, 
			$regex, $blast, "blastParams");

    open(F, ">$blastParamsFile");
    print F "$blastParams\n";
    close(F);
}

sub makeControllerPropFile {
    my ($inputDir, $baseDir, $slotsPerNode, $taskSize, $nodePath, 
	$taskClass) = @_;

    open(F, ">$inputDir/controller.prop") 
	|| die "Can't open $inputDir/controller.prop for writing";

    print F 
"masterdir=$baseDir/master
inputdir=$baseDir/input
nodedir=$nodePath
slotspernode=$slotsPerNode
subtasksize=$taskSize
taskclass=$taskClass
nodeclass=DJob::DistribJob::BprocNode
restart=no
";
    close(F);
}

sub makeRMTaskPropFile {
    my ($inputDir, $seqFileBasename, $rmOptions, $rmPath, $dangleMax) = @_;

    open(F, ">$inputDir/task.prop") 
	|| die "Can't open $inputDir/task.prop for writing";

    print F 
"rmPath=$rmPath
inputFilePath=$seqFileBasename
trimDangling=y
rmOptions=$rmOptions
dangleMax=$dangleMax
";
    close(F);
}

sub makeGenomeTaskPropFile {
    my ($inputDir, $serverInputDir, $seqFileName, $gaOptions, $gaBinPath, $dbPath, $serverDir) = @_;

    my $targetListFile = "$inputDir/target.lst";
    my $serverTargetListFile = "$serverInputDir/target.lst";

    &makeGenomeTargetListFile($dbPath, $targetListFile, $serverDir);

    open(F, ">$inputDir/task.prop")
	|| die "Can't open $inputDir/task.prop for writing";
    print F
"gaBinPath=$gaBinPath
targetListPath=$serverTargetListFile
queryPath=$seqFileName
";
    close(F);
}

sub makeGenomeTargetListFile {
    my ($dbPath, $targetListFile, $serverGenomeDir) = @_;

    opendir(DB, $dbPath);
    my @files = readdir(DB);
    my @fa_files = grep(/\.(fa|fasta)/i, @files);
    closedir(DB);

    open(F, ">$targetListFile") || die "Can't open $targetListFile for writing";

    foreach (@fa_files) { print F $serverGenomeDir . '/' . $_ . "\n"; }
    close(F);
}

sub makeGenomeParamsPropFile {
    my ($paramsPath, $oocFile) = @_;

    open(F, ">$paramsPath") || die "Can't open $paramsPath for writing";
    print F
"mask=lower
ooc=$oocFile
";
    close(F);
}

sub makeTargetListFile {
  my ($targetListFile,$genomeDir,$liniacServer,) = @_;

  my @genome;

  #open (F, ">$targetListFile") || die "Can't open $targetListFile for writing";

  my $cmd = "ssh -2 $liniacServer 'ls ${genomeDir}/*\.fa' > $targetListFile";

  `$cmd`;

  my $status = $? >> 8;
  &confess("Failed with status $status running '$cmd'") if ($status);
  #opendir (DIR, $genomeDir) || die "Can't open $genomeDir to get file names";

  #while (defined (my $file = readdir DIR)) {
  #  print F "$file\n" if ($file =~ /\.fa/);
  #}

  #closedir (DIR);
  #close(F);
}

sub makeBMTaskPropFile {
    my ($inputDir, $blastBinDir, $seqFilePath,  $dbFileName) = @_;

    open(F, ">$inputDir/task.prop") 
	|| die "Can't open $inputDir/task.prop for writing";

    print F 
"blastBinDir=$blastBinDir
dbFilePath=$dbFileName
inputFilePath=$seqFilePath
";
    close(F);
}

sub makeBSTaskPropFile {
    my ($inputDir, $blastBinDir, $seqFilePath,  $dbFileName, 
	$regex, $blast, $blastParamsFile) = @_;

    open(F, ">$inputDir/task.prop") 
	|| die "Can't open $inputDir/task.prop for writing";

    print F 
"blastBinDir=$blastBinDir
dbFilePath=$dbFileName
inputFilePath=$seqFilePath
dbType=p
regex='$regex'
blastProgram=$blast
blastParamsFile=$blastParamsFile
";
    close(F);
}
