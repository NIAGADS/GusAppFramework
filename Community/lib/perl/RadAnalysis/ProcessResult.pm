package GUS::Community::RadAnalysis::ProcessResult;

use strict;

use GUS::Community::RadAnalysis::RadAnalysisError;

use GUS::Community::FileTranslator;

#--------------------------------------------------------------------------------

sub new {
  my ($class) = @_;

  bless {_array_table => undef,
         _result_file => [],
         _xml_translator => undef,
         _result_view => undef,
         _array_design_name => undef,
         _protocol => undef,
         _param_values => {},
         _translator_function_args => {},
         _logical_groups => [],
        }, $class;
}

#--------------------------------------------------------------------------------

sub isValid {
  my ($self) = @_;

  my $resultFile = $self->getResultFile();
  my $resultView = $self->getResultView();
  my $protocol = $self->getProtocol();
  my $logicalGroups = $self->getLogicalGroups();


  unless($resultView) {
    GUS::Community::RadAnalysis::InputError->new("ResultView was not defined")->throw();;
  }

  unless($resultFile) {
    GUS::Community::RadAnalysis::InputError->new("Result file was not defined")->throw();;
  }

  unless(scalar(@$logicalGroups) > 0) {
    GUS::Community::RadAnalysis::InputError->new("No Logical Groups were defined")->throw();;
  }

  unless($protocol) {
    GUS::Community::RadAnalysis::InputError->new("Protocol was not defined")->throw();;
  }

  return 1;
}

#--------------------------------------------------------------------------------

sub getArrayDesignName {$_[0]->{array_design_name}}
sub setArrayDesignName {$_[0]->{array_design_name} = $_[1]}

#--------------------------------------------------------------------------------

sub getArrayTable {$_[0]->{_array_table}}
sub setArrayTable {
  my ($self, $arrayTable) = @_;

  unless($arrayTable eq 'RAD.Spot' || $arrayTable eq 'RAD.ShortOligoFamily') {
    GUS::Community::RadAnalysis::InputError->new("ArrayTable [$arrayTable] is not an allowed value")->throw();;
  }

  $self->{_array_table} = $arrayTable;
}

#--------------------------------------------------------------------------------

sub getResultFile {$_[0]->{_result_file}}
sub setResultFile {
  my ($self, $file) = @_;

  unless(-e $file) {
    GUS::Community::RadAnalysis::InputError->new("File [$file] does not exist")->throw();;
  }
  $self->{_result_file} = $file;
}

#--------------------------------------------------------------------------------
# TODO... For checking, should we retrieve these from the DB??
sub getResultView {$_[0]->{_result_view}}
sub setResultView {
  my ($self, $view) = @_;

  my $allowed = ['RAD::DataTransformationResult',
                 'RAD::ArrayStatTwoConditions', 
                 'RAD::PaGE',
                 'RAD::SAM',
                 'RAD::DifferentialExpression',
                 'RAD::ExpressionProfile',
                ];

  foreach(@$allowed) {
    $self->{_result_view} = $view if($view eq $_);
  }

  unless($self->getResultView()) {
    GUS::Community::RadAnalysis::InputError->new("View [$view] is not a valid subclass of AnalysisResult")->throw();;
  }
}

#--------------------------------------------------------------------------------

sub getXmlTranslator {$_[0]->{_xml_translator}}
sub setXmlTranslator {
  my ($self, $xmlTranslator) = @_;

  unless($xmlTranslator =~ /\.xml$/) {
    $xmlTranslator = $ENV{GUS_HOME} . "/config/" . $xmlTranslator . ".xml";
  }

  unless(-e $xmlTranslator) {
    GUS::Community::RadAnalysis::InputError->new("Xml File [$xmlTranslator] does not exist")->throw();;
  }

  $self->{_xml_translator} = $xmlTranslator
}

#--------------------------------------------------------------------------------

sub getTranslatorFunctionArgs {$_[0]->{_translator_function_args}}
sub addToTranslatorFunctionArgs {
  my ($self, $hashRef) = @_;

  my $functionArgs = $self->getTranslatorFunctionArgs();

  foreach(keys %$hashRef) {
    if($functionArgs->{$_}) {
      print STDERR "WARNING:  Will Overwrite Multiple FileTranslator Function Arg for Parameter [$_]\n";
    }
    $functionArgs->{$_} = $hashRef->{$_};
  }
}

#--------------------------------------------------------------------------------

sub getProtocol {$_[0]->{_protocol}}
sub setProtocol {
  my ($self, $protocol) = @_;

  unless(ref($protocol) eq 'GUS::Model::RAD::Protocol') {
    GUS::Community::RadAnalysis::InputError->new("Expected RAD::Protocol but found: ". ref($protocol))->throw();;
  }

  $self->{_protocol} = $protocol
}

#--------------------------------------------------------------------------------

sub getLogicalGroups {$_[0]->{_logical_groups}}
sub addLogicalGroups {
  my $self = shift;

  foreach my $lg (@_) {
    if(ref($lg) eq 'GUS::Model::RAD::LogicalGroup') {
      push(@{$self->{_logical_groups}}, $lg);
    }
    else {
      GUS::Community::RadAnalysis::InputError->new("Expected RAD::LogicalGroup but found: ". ref($lg))->throw();;
    }
  }
}

#--------------------------------------------------------------------------------

sub getParamValues {$_[0]->{_param_values}}
sub addToParamValuesHashRef {
  my ($self, $hashRef) = @_;

  my $paramValues = $self->getParamValues();

  foreach(keys %$hashRef) {
    if($paramValues->{$_}) {
      print STDERR "WARNING:  Will Overwrite Multiple ParamValues for Parameter [$_]\n";
    }
    $paramValues->{$_} = $hashRef->{$_};
  }
}

#--------------------------------------------------------------------------------
# TODO:  QC Protocol params
sub writeAnalysisConfigFile {
  my ($self) = @_;

  my $configFile = $self->getResultFile() . ".cfg";
  open(OUT, "> $configFile") or die "Cannot open file $configFile for writing: $!";

  my ($sec,$min,$hour,$mday,$mon,$year) = localtime();
  my $analysisDate = sprintf('%4d-%02d-%02d', $year+1900, $mon+1, $mday);

  my $table = $self->getArrayTable();
  my $protocol = $self->getProtocol();
  my $paramValues = $self->getParamValues();
  my $logicalGroups = $self->getLogicalGroups();

  my $protocolId = $protocol->getId();

  my @protocolParams = $protocol->getChildren('RAD::ProtocolParam');

  my (@logicalGroupIds, @paramValues);

  my $paramIndex;
  foreach my $paramName (keys %$paramValues) {
    my $matchingParam = &findFromName(\@protocolParams, $paramName);
    my $paramId = $matchingParam->getId();

    my $value = $paramValues->{$paramName};

    $paramIndex ++;

    push(@paramValues, "protocol_param_id$paramIndex\t$paramId");
    push(@paramValues, "protocol_param_value$paramIndex\t$value");
  }

  for(my $i = 0; $i < scalar(@$logicalGroups); $i++) {
    my $lgId = $logicalGroups->[$i]->getId();
    my $index = $i + 1;

    push(@logicalGroupIds, "logical_group_id$index\t$lgId");
  }

  my $logicalGroupString = join("\n", @logicalGroupIds);
  my $protocolParamString = join("\n", @paramValues);

  my $simpleConfig = <<Config;
table\t$table
protocol_id\t$protocolId
$protocolParamString
analysis_date\t$analysisDate
$logicalGroupString
Config

  print OUT $simpleConfig;

  close OUT;

  return $configFile;
}

#--------------------------------------------------------------------------------


sub writeAnalysisDataFile {
  my ($self, $dbh) = @_;

  my $resultFile = $self->getResultFile();

  my $logFile = "$resultFile.log";

  if(my $xmlFile = $self->getXmlTranslator()) {
    my $dataFile = "$resultFile.data";

    my $functionArgs = $self->getTranslatorFunctionArgs();

    my $fileTranslator = eval { 
      GUS::Community::FileTranslator->new($xmlFile, $logFile);
    };

    if ($@) {
      GUS::Community::RadAnalysis::RadAnalysisError->
          new("The mapping configuration file '$xmlFile' failed the validation. Please see the log file $logFile")->throw();
    };

    return $fileTranslator->translate($functionArgs, $resultFile, $dataFile);
  }

  return $resultFile;
}

#--------------------------------------------------------------------------------

sub submit {
  my ($self) = @_;

  my $logicalGroups = $self->getLogicalGroups();
  my $protocol = $self->getProtocol();

  $protocol->submit();

  foreach(@$logicalGroups) {
    $_->submit();
  }
}

#--------------------------------------------------------------------------------
# UTIL
sub toString {
  my ($self) = @_;

  my $string;


  $string .= "ArrayTable:  " . $self->getArrayTable() ."\n";
  $string .= "ArrayDesignName:  " .$self->getArrayDesignName() ."\n";
  $string .= "ResultFile:  " .$self->getResultFile() ."\n";
  $string .= "ResultView:  " . $self->getResultView() ."\n";
  $string .= "XmlTranslator:  " . $self->getXmlTranslator() ."\n";

  $string .= "ParamValues\n    ". Dumper($self->getParamValues());

  $string .= "LogicalGroups\n    ";

  foreach(@{$self->getLogicalGroups()}) {
    $string .= $_->toString();

    foreach my $link ($_->getChildren("RAD::LogicalGroupLink")) {
      $string .= "LogicalGroupLink\n    ".$link->toString();
    }
  }

  $string .= "Protocol\n". $self->getProtocol()->toString();

  return $string;
}

#--------------------------------------------------------------------------------

sub findFromName {
  my ($ar, $name) = @_;

  foreach(@$ar) {
    return $_ if($_->getName eq $name);
  }
  GUS::Community::RadAnalysis::RadAnalysisError->new("Name [$name] not found in Array")->throw();
}



1;