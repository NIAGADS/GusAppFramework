

package GUS::PluginMgr::GusApplication;
@ISA = qw( GUS::PluginMgr::Plugin );

use strict;
#use vars (%SIG);
use CBIL::Util::EasyCsp;

use GUS::PluginMgr::Plugin;
use GUS::PluginMgr::Args::ArgList;

use GUS::Model::Core::Algorithm;
use GUS::Model::Core::AlgorithmImplementation;
use GUS::Model::Core::AlgorithmInvocation;
use GUS::Model::Core::AlgorithmParamKey;
use GUS::Model::Core::AlgorithmParam;
use GUS::Model::GusRow;

use constant FLAG_DEBUG => 0;

# ----------------------------------------------------------------------

# [name, default (or null if reqd), comment]
my @properties =
(
 ["md5sum",         "",  "full path of md5sum executable (for check summing)"],
);

sub new {
   my $Class = shift;
   my $Args = shift;

   my $self = bless {}, $Class;

   $self->initialize({requiredDbVersion => '3.5',
                      cvsRevision       => '$Revision$',
                      name              => ref($self),
                      easyCspOptions    => {},
                      usage             => ""
                     });

   my $configFile = "$ENV{GUS_HOME}/config/gus.config";

   $self->userError("Config file $configFile does not exist.  This file should have been installed during the GUS Installation.") unless -e $configFile;

   $self->{propertySet}= CBIL::Util::PropertySet->new($configFile, \@properties, 1);

   $self->initName(ref $self);
   $self->initMd5Executable($self->{propertySet}->getProp('md5sum'));

   return $self
}

# ----------------------------------------------------------------------

# what is the run mode
sub getMode       { $_[0]->{__gus__plugin__mode} }
sub setMode       { $_[0]->{__gus__plugin__mode} = $_[1]; $_[0] }

# ----------------------------------------------------------------------

sub findAlgorithm {
   my $Self = shift;
   my $PlugIn = shift;

   my $alg_gus = GUS::Model::Core::Algorithm->new({ name => $PlugIn->getName });
   $alg_gus->retrieveFromDB;

   $PlugIn->initAlgorithm($alg_gus->getId ? $alg_gus : undef)
}

# ----------------------------------------------------------------------

sub findImplementation {
   my $Self = shift;
   my $PlugIn = shift;

   my $implementation = $Self->findSomeImplementation($PlugIn);
   $PlugIn->initImplementation($implementation) if $implementation;

   $PlugIn->logVerbose('DEBUG', ref $implementation) if FLAG_DEBUG;
}

sub findSomeImplementation {
   my $Self = shift;
   my $PlugIn = shift;

   my $pluginNm = $PlugIn->getName;
   my $cvsRevision = $PlugIn->getCVSRevision;

   # can either be done in +create/+update mode as ga or in +run mode as plugin
   my $sql = <<SQL;
    SELECT *
      FROM Core.AlgorithmImplementation
     WHERE executable = '$pluginNm'
       AND cvs_revision    = '$cvsRevision'
SQL

   my $imps = $PlugIn->sql_get_as_hash_refs($sql);

   if (scalar @$imps == 0) {
     $Self->registerPlugin($PlugIn, $sql);  # try registering

     # try again
     $imps = $PlugIn->sql_get_as_hash_refs($sql);
     $Self->error("Failed registering plugin $pluginNm $cvsRevision")
       if scalar @$imps != 1;
   }

   elsif ( scalar @$imps > 1 ) {
     $Self->tooManyImpsError($imps);
   }

   elsif ($Self->getArgs->{commit} &&
	    $imps->[0]->{EXECUTABLE_MD5} ne $PlugIn->getCheckSum()) {
     $Self->wrongChecksumError($PlugIn);
   }

   return $Self->makeImplementation($PlugIn, $imps->[0]);
}

sub registerPlugin {
  my ($self, $plugin) = @_;

  my $pluginNm = $plugin->getName;

  my $sql = "select * from core.algorithmimplementation where executable = '$pluginNm'";
  my $imps = $plugin->sql_get_as_hash_refs($sql);

  my $gaCmd;
  if ($pluginNm eq "GUS::PluginMgr::GusApplication") {
    $gaCmd = "ga +meta --commit";
  } else {
    $gaCmd = "ga +update $pluginNm --commit";
    $gaCmd = "ga +create $pluginNm --commit" if (scalar @$imps == 0);
  }
  $self->runRegisterCmd($gaCmd, $pluginNm);
}

sub runRegisterCmd {
  my ($self, $gaCmd, $pluginName) = @_;

  $self->log("-------- Registering $pluginName -------------");
  system($gaCmd);
  my $status = $? >> 8;
  $self->error("Failed running '$gaCmd' with stderr:\n $!") if ($status);
  $self->log("-----------------------------------");
}

sub tooManyImpsError {
  my ($self, $imps, $plugin) = @_;

  my $pluginNm = $plugin->getName;
  my $cvsRevision = $plugin->getCVSRevision;

  my $err = "Found more than one Core.AlgorithmImplementation for exe=$pluginNm cvsRev=$cvsRevision:\n";

  foreach (@$imps) {
    $err .= "  algimp_id:$_->{ALGORITHM_IMPLEMENTATION_ID}  md5:$_->{EXECUTABLE_MD5}  rev:$_->{CVS_REVISION}  tag:$_->{CVS_TAG}\n";
  }
  $self->userError($err);
}

sub wrongChecksumError {
  my ($self, $plugin) = @_;

  my $pluginNm = $plugin->getName;
  my $cvsRevision = $plugin->getCVSRevision;

  my $run = "ga +update $pluginNm";
  $run = "ga +meta" if $pluginNm =~ /GusApplication/;
  $self->userError("The md5 checksum of ${pluginNm}'s executable file (cvs revision $cvsRevision) doesn't match the md5 checksum in the database for that plugin and revision. IE, the plugin has been changed but not commited and updated.  Please:
                   - cvs commit the plugin file
                   - use the build system to install it
                   - run '$run --commit'\nAborting");
}


sub makeImplementation {
  my ($self, $plugin, $impInfo) = @_;

  my $imp = GUS::Model::Core::AlgorithmImplementation
    ->new({
	   algorithm_implementation_id => $impInfo->{ALGORITHM_IMPLEMENTATION_ID}
	  });
  if (!$imp->retrieveFromDB) {
    CBIL::Util::Disp::Display($impInfo);
    $self->error("findSomeImplementation failed retrieving from db");
  }
  return $imp;
}


# ----------------------------------------------------------------------

sub parseAndRun {
   my $Self = shift;
   my $Args = shift;

   my $ga_mode_str;
   my $plugin_class_str;

   # no arguments; we can't do anything.
   if (scalar @$Args == 0) {
      ;
   }

   # first argument is a reporter
   elsif ($Args->[0] =~ /::Plugin::Report::/) {
      $ga_mode_str = 'report';
      $plugin_class_str = shift @$Args;
   }

   # first argument begins with a '+'; this is new mode.
   elsif ($Args->[0] =~ /^\+(.+)/) {

      # save the matched mode name and toss the cla
      $ga_mode_str      = $1;
      shift @$Args;

      # grab the plugin class name
      $plugin_class_str = shift @$Args unless $Args->[0] =~ /^-/;
   }


   # first argument begins with a '-'; this the old mode, show help
   elsif ($Args->[0] =~ /^-/) {
      ;
   }

   # new mode with implied +run.
   else {

      # run-mode
      $ga_mode_str = 'run';

      # get plugin class name from the end of the cla list
      $plugin_class_str = shift @$Args;
   }

   if (defined $ga_mode_str) {
      $Self->setMode($ga_mode_str);
      $Self->doMajorMode($plugin_class_str)
   } else {
      $Self->showUsage;
   }
}

# ----------------------------------------------------------------------

sub showUsage {
   my $Self = shift;

   print <<USAGE;

ga runs a plugin in one of the possible modes.

ga [<mode>] <plugin-class-name> [<options>]

  <mode> is one of +run, +history, +create, or +update.  The default value is +run.
  <options> is a list of --option value pairs
  <plugin-class-name> is the name of the plugin to process.

  +run     - run the plugin so it can perform its algorithm.

  +meta    - create Core.Algorithm and Core.AlgorithmImplementation for self.

  +create  - create rows for Core.Algorithm and Core.AlgorithmImplementation.

  +update  - create a new Core.AlgorithmImplementation for and existing
             Core.Algorithm.

  +history - list any Core.Algorithm, Core.AlgorithmImplementation, and
             CoreAlgorithmInvocation rows for the plugin.

For example,

  ga GUS::Supported::Plugin::InsertGusXml --file my_new_data.xml --commit

The legal options depend on the mode and plugin.  To get help use a command like this:

  ga +update --help

  ga GUS::Supported::Plugin::InsertGusXml --help

USAGE

}

# ----------------------------------------------------------------------

sub newFromPluginName {
   my $Self = shift;
   my $PluginClass = shift;               # plugin-class name

   my $require_p = "{require $PluginClass; $PluginClass->new }";
   my $plugin = eval $require_p;

   $Self->error($@) if $@;

   $plugin->initName($PluginClass);
   $plugin->initMd5Executable($Self->{propertySet}->getProp('md5sum'));
   return $plugin;
}

# Reads parameter key/value pairs from a file.  Tries a bunch of
# different places and names.
sub getConfig {
   my ($self) = @_;

   if (!$self->{config}) {
      my $cla = $self->getArgs();
      $self->{config} = GUS::Supported::GusConfig->new($cla->{gusconfigfile});
   }

   $self->{config};
}

# ----------------------------------------------------------------------
# A dispatcher for main running modes.
# ----------------------------------------------------------------------

sub doMajorMode {
   my $Self = shift;
   my @A = @_;

   my @modes    = qw( meta create update history run report );
   my $modes_rx = '^('. join('|',@modes). ')$'; # ' this quote is for emacs highlighting

   if ($Self->getMode =~ /$modes_rx/) {

      # make method name and run
      my $method = 'doMajorMode_'. ucfirst lc $Self->getMode;
      $Self->$method(@A);
   }

   # bad mode or mood
   else {
      $Self->userError($Self->getMode() . " is not a supported mode; should be one of" . join(', ', @modes));
   }

}

# ----------------------------------------------------------------------
# Create info for self
# ----------------------------------------------------------------------

#! GA
sub doMajorMode_Meta {
   my $Self = shift;

   my $ecd = { %{$Self->getGlobalEasyCspOptions} };
   my $cla = CBIL::Util::EasyCsp::DoItAll($ecd,$Self->getUsage) || die "\n";

   $Self->initArgs($cla);

   # connect to the database
   $Self->connect_to_database($Self);

   # what versions does the plugin want?
   $Self->_check_database_version_requirements($Self);

   # create/find a Core.Algorithm, Core.AlgorithmImplementation, and Core.AlgorithmInvocation
   my $alg_go = GUS::Model::Core::Algorithm
   ->new({ name        => 'GA-Plugin',
           description => 'GUS application framework for plugins'
         });
   $alg_go->retrieveFromDB;

   my $name = $Self->getName();
   my $cvsRevision = $Self->getCVSRevision();

   my $sql =
   "SELECT *
     FROM Core.AlgorithmImplementation
     WHERE executable = '$name'
     AND cvs_revision    = '$cvsRevision'";

   my $imps = $Self->sql_get_as_hash_refs($sql);

   if (scalar(@$imps) !=0) {
      print STDERR "Error: $name with CVS revision $cvsRevision is already registered.  You don't need to do a +meta.\n";
      exit 0;
   }

   my $imp_go = GUS::Model::Core::AlgorithmImplementation
   ->new({ cvs_revision   => $Self->getCVSRevision,
           executable     => $Self->getName,
           executable_md5 => $Self->getCheckSum,
           description    => $Self->getRevisionNotes,
         });
   $imp_go->setParent($alg_go);

   my $now = $Self->getDb->getDateFunction();
   my $inv_go = GUS::Model::Core::AlgorithmInvocation->new({ start_time  => $now,
                                                             end_time    => $now,
                                                             cpus_used   => 1,
                                                             result      => 'meta',
                                                           });
   $inv_go->setParent($imp_go);

   $Self->set_defaults($alg_go);
   print $alg_go->toXML(2);
   $alg_go->submit;
   print $alg_go->toXML(2);

   # update with invocation's newly set id and resubmit
   $alg_go->setRowAlgInvocationId($inv_go->getId);
   $imp_go->setRowAlgInvocationId($inv_go->getId);
   $inv_go->setRowAlgInvocationId($inv_go->getId);

   $alg_go->setGlobalNoVersion(1);
   $alg_go->submit;

}


# ----------------------------------------------------------------------
# Run the plugin
# ----------------------------------------------------------------------

sub doMajorMode_Run {
   my $Self        = shift;
   my $PluginClass = shift;

   $Self->doMajorMode_RunOrReport($PluginClass, 1);
}

sub doMajorMode_Report {
   my $Self        = shift;
   my $PluginClass = shift;

   $Self->doMajorMode_RunOrReport($PluginClass, 0);
}

sub doMajorMode_RunOrReport {
   my $Self        = shift;
   my $PluginClass = shift;
   my $Run         = shift;

   my $pu = $Self->newFromPluginName($PluginClass);

   # connect to the database
   $Self->connect_to_database($pu);
   $Self->initDb($pu->getDb());

   $pu->setOracleDateFormat('YYYY-MM-DD HH24:MI:SS');

   my $argsHash;
   if ($pu->getArgsDeclaration) {
      my $argDecl = [@{$pu->getArgsDeclaration()},
                     @{$Self->getStandardArgsDeclaration()}
                    ];

      my ($argList, $help) = GUS::PluginMgr::Args::ArgList->new
      ($argDecl, 'ga ' . ref($pu), $pu);

      if ($help eq 'text') {
         $pu->printDocumentationText($argList->formatConcisePod(),
                                     $argList->formatLongPod());
         exit(0);
      }
      if ($help eq 'html') {
         $pu->printDocumentationHTML($argList->formatConcisePod(),
                                     $argList->formatLongPod());
         exit(0);
      }
      $argsHash = $argList->getArgsValueHash();
   } else {
      # get command line arguments from combined CBIL::Util::EasyCsp options structure
      my $ecd = {
                 %{$Self->getGlobalEasyCspOptions},
                 %{$pu->getEasyCspOptions},
                };
      $argsHash = CBIL::Util::EasyCsp::DoItAll($ecd,$pu->getUsage) || die "\n";
   }

   # what versions does the plugin want?
#   $Self->connect_to_database($Self);

   $Self->_check_database_version_requirements($pu);

   $pu->initArgs($argsHash);
   $Self->initArgs($argsHash);

   $pu->getDb()->setVerbose($Self->getArg('sqlVerbose'));

   # get the algorithm
   $Run && $Self->findAlgorithm($pu);

   # get PI's version to find the AlgorithmImplementation.
   $Run && $Self->findImplementation($pu);

   # the application context
   $Run && $Self->openInvocation($pu);
   
   # this acts like a java final block.  clean up and show a stack trace.
   { local

   $SIG{__DIE__} = sub {
     my ($err) = @_;

     require Carp;
     
     die "\nERROR:\n$err\nSTACK TRACE:\n" . Carp::longmess() . "\n";
   };

   eval {
      my $resultDescrip;

      $pu->logArgs();
      $Run && $pu->logCommit();
      $Run && $pu->logAlgInvocationId();

      # include the args for legacy plugins
      $resultDescrip = $pu->run({ cla      => $pu->getCla,
                                  self_inv => $pu->getSelfInv,
                                });
      if (!$pu->getResultDescr()) {
         $pu->setResultDescr($resultDescrip);
      }
      $Self->logAlert("RESULT", $pu->getResultDescr());
      $pu->logCommit();
   };}

   my $err = $@;

   $Run && $Self->closeInvocation($pu, $err);

   die $err if $err;
}

# ----------------------------------------------------------------------

#! GA
sub doMajorMode_Create {
   my $Self = shift;
   my $PluginClass = shift;

   $Self->create_or_update_implementation(0,$PluginClass)
}

# ----------------------------------------------------------------------

#! GA
sub doMajorMode_Update {
   my $Self = shift;
   my $PluginClass = shift;

   $Self->create_or_update_implementation(1,$PluginClass)
}

# ----------------------------------------------------------------------

#! GA
sub doMajorMode_History {
   my $Self        = shift;
   my $PluginClass = shift;

   my $p = $Self->newFromPluginName($PluginClass);
   my $plugin_name_s = $p->getName;

   # command line arguments
   my $usg = "reports history of Core tables for plug-in $plugin_name_s";
   my %ecd = ((
               map {($_->{o},$_)}
               (
               )
              ),

              # global options -- are they needed ?
              %{$Self->getGlobalEasyCspOptions}
             );
   my $cla = CBIL::Util::EasyCsp::DoItAll(\%ecd,$usg) || die "\n";
   $Self->initArgs($cla);

   # do preps
   $Self->connect_to_database($Self);

   my $q = $Self->getQueryHandle;

   # what algorithm
   my $alg_sql = "select * from Core.Algorithm where name = '$plugin_name_s'";

   # what implementations
   my $imp_sql = <<SQL;
    select *
      from Core.AlgorithmImplementation
     where algorithm_id = ?
     order by algorithm_implementation_id
SQL

   # what parameters
   my $par_sql = <<SQL;
    select *
      from Core.AlgorithmParamKey     k
         , Core.AlgorithmParamKeyType t
     where k.algorithm_implementation_id = ?
       and k.algorithm_param_key_type_id = t.algorithm_param_key_type_id
     order by algorithm_param_key
SQL

   # how many invocations
   my $inv_n_sql = <<SQL;
    select count(algorithm_invocation_id)
      from Core.AlgorithmInvocation
     where algorithm_implementation_id = ?
SQL

   # what about invocations
   my $inv_sql = <<SQL;
    select *
      from Core.AlgorithmInvocation
     where algorithm_implementation_id = ?
SQL

   # what parameter values
   my $val_sql = <<SQL;
    select *
      from Core.AlgorithmParam    p
         , Core.AlgorithmParamKey k
     where p.algorithm_invocation_id = ?
       and p.algorithm_param_key_id  = k.algorithm_param_key_id
     order by k.algorithm_param_key, order_num
SQL

   # ......................................................................

   my $sh       = $q->prepareAndExecute($alg_sql);
   my $imp_sh   = $q->prepare($imp_sql);
   my $par_sh   = $q->prepare($par_sql);
   my $inv_n_sh = $q->prepare($inv_n_sql);
   my $inv_sh   = $q->prepare($inv_sql);
   my $val_sh   = $q->prepare($val_sql);

   my $algs_n = 0;
   while (my $alg_h = $sh->fetchrow_hashref) {

      # just to see if we got any.
      $algs_n++;

      # show columns for this algorithm
      $Self->logData('ALG',
                     ( map { $alg_h->{$_} } qw(ALGORITHM_ID NAME DESCRIPTION) ),
                    );

      # get implementations
      $imp_sh->execute($alg_h->{ALGORITHM_ID});
      while (my $imp_h = $imp_sh->fetchrow_hashref) {

         # get count of invocations
         $inv_n_sh->execute($imp_h->{ALGORITHM_IMPLEMENTATION_ID});
         my ($inv_n) = $inv_n_sh->fetchrow_array;
         $inv_n_sh->finish;

         # show columns for this implementation
         $Self->logData('IMP',
                        #$alg_h->{ALGORITHM_ID},
                        ( map {$imp_h->{$_}} qw(ALGORITHM_IMPLEMENTATION_ID CVS_REVISION CVS_TAG)),
                        $inv_n,
                        ( map {$imp_h->{$_}} qw(EXECUTABLE EXECUTABLE_MD5 MODIFICATION_DATE DESCRIPTION)),
                       );

         # get parameter definitions
         $par_sh->execute($imp_h->{ALGORITHM_IMPLEMENTATION_ID});
         while (my $par_h = $par_sh->fetchrow_hashref) {
            $par_h->{IS_LIST_VALUED} = $par_h->{IS_LIST_VALUED} ? 'list  ' : 'scalar';
            $Self->logData('PRMKEY',
                           #$alg_h->{ALGORITHM_ID},
                           #( map {$imp_h->{$_}} qw(ALGORITHM_IMPLEMENTATION_ID VERSION)),
                           sprintf('%8.8s %s : %-24.24s %s',
                                   map {$par_h->{$_}}
                                   qw(TYPE IS_LIST_VALUED ALGORITHM_PARAM_KEY DESCRIPTION)
                                  ),
                          );
         }
         $par_sh->finish;

         # details of invocations
         $inv_sh->execute($imp_h->{ALGORITHM_IMPLEMENTATION_ID});
         while (my $inv_h = $inv_sh->fetchrow_hashref) {
            $Self->logData('INV',
                           #$alg_h->{ALGORITHM_ID},
                           #$imp_h->{ALGORITHM_IMPLEMENTATION_ID},
                           ( map {$inv_h->{$_}} qw(ALGORITHM_INVOCATION_ID START_TIME END_TIME RESULT COMMENT_STRING)),
                          );

            # values of parameters
            $val_sh->execute($inv_h->{ALGORITHM_INVOCATION_ID});
            while (my $val_h = $val_sh->fetchrow_hashref) {
               $Self->logData('PARVAL',
                              sprintf('%24.24s', $val_h->{ALGORITHM_PARAM_KEY}),
                              ( map {$val_h->{$_}} qw(ORDER_NUM STRING_VALUE))
                             );
            }
            $val_sh->finish;

         }
         $inv_sh->finish;

      }                         # eo implementations 
      $imp_sh->finish;

   }                            # eo  algorithms
   $sh->finish;

   # say something if we found no Algorithms
   if ($algs_n <= 0) {
      $Self->logData('INFO', 'No Core.Algorithms were found for this plugin');
   }
}

# ----------------------------------------------------------------------
# SUPPORT methods
# ----------------------------------------------------------------------

#! GA
sub create_or_update_implementation {
   my $Self = shift;
   my $U = shift;               # allow update?
   my $PluginClass = shift;               # plugin class name

   # verbs of various forms for what we are doing
   my $what = $U ? 'updates' : 'creates';
   my $What = ucfirst $what;

   # get any remaining arguments
   # ......................................................................

   my $usg = "$what GUS::Model::Core::Algorithm-related entries for a plugin.";
   my %ecd = (
              %{$Self->getGlobalEasyCspOptions},
              ( map {($_->{o},$_)}
                ( { h => "just survery what would be done",
                    t => 'boolean',
                    o => 'Survey',
                  },
                ) )
             );
   CBIL::Util::Disp::Display(\%ecd) if FLAG_DEBUG;
   my $cla = CBIL::Util::EasyCsp::DoItAll(\%ecd,$usg) || die "\n";
   $Self->initArgs($cla);

   # do preps
   $Self->connect_to_database($Self);
   $Self->findImplementation($Self);

   # create plugin
   my $pu = $Self->newFromPluginName($PluginClass);
   $pu->initArgs($cla);

   # what versions does the plugin want?
   $Self->_check_database_version_requirements($pu);

   # make an algorithminvocation for self
   # ......................................................................

   my $alg_inv_gus = GUS::Model::Core::AlgorithmInvocation
   ->new({ algorithm_implementation_id => $Self->getImplementation->getId,
           start_time                  => $Self->getDb->getDateFunction(),
           end_time                    => $Self->getDb->getDateFunction(),
           cpus_used                   => 1,
           cpu_time                    => 0,
           result                      => 'pending',
           comment_string              => substr($cla->{comment},0,255),
         });
   $Self->initAlgInvocation($alg_inv_gus);
   $Self->set_defaults($alg_inv_gus);

   # things we might need.
   # ......................................................................

   # terse access to plugin name since we use it all the time
   my $plugin_name_s = $pu->getName;

   # check to see if Algorithm with this name already exists.
   # ......................................................................

   my $alg_h;
   $Self->findAlgorithm($pu);
   my $alg_gus = $pu->getAlgorithm;
   my $cvsRevision = $pu->getCVSRevision;

   # we want to create a new Algorithm
   if ($U ) {

      if (!$alg_gus) {
         print STDERR "Error:   You are trying to update $plugin_name_s, but it has not been registered with the databae.  Please use 'ga +create $plugin_name_s [--commit]' instead.\n";
         exit 0;
      }
      my $sql =
      "SELECT *
       FROM Core.AlgorithmImplementation
       WHERE executable = '$plugin_name_s'
       AND cvs_revision    = '$cvsRevision'";

      my $imps = $Self->sql_get_as_hash_refs($sql);

      if (scalar(@$imps) !=0) {
         print STDERR "Error:   $plugin_name_s with CVS revision $cvsRevision is already registered.  You don't need to do a +update.\n";
         exit 0;
      }
   } else {

      # algorithm already exists; tell user about it.
      if ($alg_gus) {
         print STDERR join("\n",
                           "$plugin_name_s is already registered.",
                           "Use '+update' if you need to register a new version."
                          ), "\n";
         #      $Self->doMajorMode_History($PluginClass);
         exit 0;
      }

      # gather the attributes we need and make sure everything checks out first 
      else {

         my $description = $pu->getUsage;
         if (not defined $description) {
            print STDERR "You have not overridden the getUsage method in your plugin.\n";
            exit 0;
         }

         $alg_h = { name        => $plugin_name_s,
                    description => $description,
                  };
      }
   }

   # implementation data
   # ......................................................................,


   my $imp_description = $pu->getRevisionNotes;

   use Sys::Hostname;
   my $host = hostname();

   # AlgorithmParamKeys
   my $apkt_cache = $Self->load_AlgorithmParamKeyType_cache;
   CBIL::Util::Disp::Display($apkt_cache, '$apkt_cache') if FLAG_DEBUG;
   my $pu_ecd     = {
                     %{$Self->getGlobalEasyCspOptions},
                     %{$pu->getEasyCspOptions},
                    };

   CBIL::Util::Disp::Display($pu_ecd, '$pu_ecd') if FLAG_DEBUG;
   my @bad_types;
   foreach my $ecd (values %$pu_ecd) {
      my $apkt_id = $apkt_cache->{lc(substr($ecd->{t},0,3))};
      if (defined $apkt_id) {
         $ecd->{APKT_ID} = $apkt_id;
      } else {
         push(@bad_types, $ecd);
      }
   }
   if (scalar @bad_types) {
      foreach my $ecd (@bad_types) {
         print STDERR "'$ecd->{t}' is not a legal param type for option $ecd->{o}.\n";
      }
      exit 0;
   }

   # start making objects
   # ......................................................................

   my $alg_imp_h = { cvs_revision        => $cvsRevision,
                     description         => $imp_description,
                     executable          => $pu->getName,
                     executable_md5      => $pu->getCheckSum,
                   };
   my @apks = map { {
      algorithm_param_key         => $_->{o},
      algorithm_param_key_type_id => $_->{APKT_ID},
      is_list_valued              => $_->{l} || 0,
      description                 => $_->{h},
   }
                 } values %$pu_ecd;

   if ($cla->{Survey}) {
      CBIL::Util::Disp::Display($alg_h,     '$alg_h: ');
      CBIL::Util::Disp::Display($alg_imp_h, '$alg_imp_h: ');
      CBIL::Util::Disp::Display(\@apks,     '\@apks: ');
   } else {
      $alg_gus = GUS::Model::Core::Algorithm->new($alg_h) if $alg_h;
      my $alg_imp_gus = GUS::Model::Core::AlgorithmImplementation->new($alg_imp_h);
      $alg_imp_gus->setParent($alg_gus);
      foreach my $apk (sort {
         lc $a->{algorithm_param_key} cmp lc $b->{algorithm_param_key}
      } @apks) {
         my $apk_gus = GUS::Model::Core::AlgorithmParamKey->new($apk);
         $apk_gus->setParent($alg_imp_gus);
      }
      $alg_gus->submit;
      $Self->logData('INFO', "Plugin $plugin_name_s registered with cvs revision '$cvsRevision'");
      $Self->logData('INFO', "...Just kidding: you didn't --commit")
      unless ($Self->getArgs->{commit});
   }
}


# ----------------------------------------------------------------------

sub set_defaults {
   my $Self = shift;
   my $OtherPlugIn = shift;

   my $cla = $Self->getArgs;

   CBIL::Util::Disp::Display($cla, 'cla:'.  ref$Self) if FLAG_DEBUG;

   # global parameters
   $OtherPlugIn->setCommitOff()     unless $Self->getArg('commit');
   $OtherPlugIn->setDebuggingOn()   if $Self->getArg('debug');

   # default values for GUS overhead columns
   $OtherPlugIn->setDefaultAlgoInvoId($Self->getArg('algoinvo'));

   my $user    = $Self->getUser();
   my $userId  = $Self->sql_translate('Core.UserInfo', 'user_id', 'login', $user);
   die "No row Core.UserInfo has a login = '$user'.  This value was found in the userName= property of your .gus.properties file.  Please be sure it is correct and has been registered in the database" unless defined $userId;

   my $group   = $Self->getGroup();
   my $groupId = $Self->sql_translate('Core.GroupInfo', 'group_id', 'name',$group);
   die "No row in Core.GroupInfo has a name = '$group'.  This value was found in the group= property of your .gus.properties file.  Please be sure it is correct and has been registered in the database" unless defined $groupId;

   my $project = $Self->getProject();
   my $projectId = $Self->sql_translate('Core.ProjectInfo',
                                        'project_id',
                                        'name',$project);
   die "No row in Core.ProjectInfo has name = $project'.  This value was found in the project= property of your .gus.properties file.  Please be sure it is correct and has been registered in the database" unless defined $projectId;

   $OtherPlugIn->setDefaultUserId($userId);
   $OtherPlugIn->setDefaultGroupId($groupId);
   $OtherPlugIn->setDefaultProjectId($projectId);
}

# ----------------------------------------------------------------------

sub getUser {
   my $Self = shift;

   my $cla = $Self->getArgs;
   $cla->{user}? $cla->{user} : $Self->getConfig()->getUserName();

}

sub getGroup {
   my $Self = shift;

   my $cla = $Self->getArgs;
   $cla->{group}? $cla->{group} : $Self->getConfig()->getGroup();

}

sub getProject {
   my $Self = shift;

   my $cla = $Self->getArgs;
   $cla->{project}? $cla->{project} : $Self->getConfig()->getProject();

}

#! GA
sub load_AlgorithmParamKeyType_cache {
   my $Self = shift;

   my $RV;

   # if we don't have a db handle use these that I copied from the DB.
   if (not defined $Self->getQueryHandle) {
      $RV = { 'str' => 0,
              'flo' => 1,
              'int' => 2,
              'ref' => 3,
              'boo' => 4,
              'dat' => 5,
            };
   }

   # we have a db query handle, go for it.
   else {
      my $sql = 'select algorithm_param_key_type_id, type from Core.AlgorithmParamKeyType';
      my $types = $Self->sql_get_as_array_refs($sql);
      foreach (@$types) {
         $RV->{lc(substr($_->[1],0,3))} = $_->[0];
      }
   }

   # RETURN
   $RV
}

# ----------------------------------------------------------------------
# Opens invocation structure.

# SOON: when alg inv. gets new 'status' attribute, this will set it to 'running'
sub openInvocation {
   my $Self = shift;
   my $PlugIn = shift;          # the plugin

   my $cla = $PlugIn->getArgs;

   # get implementation pointer for self.
   # ........................................

   my $alg_inv_gus = GUS::Model::Core::AlgorithmInvocation
   ->new({
          algorithm_implementation_id => $PlugIn->getImplementation->getId,
          start_time                  => $PlugIn->getDb->getDateFunction(),
          end_time                    => $PlugIn->getDb->getDateFunction(),
          cpus_used                   => 1,
          cpu_time                    => 0,
          result                      => 'pending',
          comment_string              => substr($cla->{comment},0,255),
         });
   $PlugIn->initAlgInvocation($alg_inv_gus);

   $Self->set_defaults($alg_inv_gus);
   $alg_inv_gus->submit();
   $alg_inv_gus->setDefaultAlgoInvoId($alg_inv_gus->getId);

   # set parameter values in the DB.
   # ......................................................................

   # get children, then make a hash of algorithm_param_key => object
   my @param_keys = 
   $PlugIn->getImplementation->getChildren('GUS::Model::Core::AlgorithmParamKey',1);
   my %key_to_obj = map { ($_->getAlgorithmParamKey,$_) } @param_keys;

   # note whether we had any problems.
   my @any_bad;

   # process each actual parameter
   #CBIL::Util::Disp::Display($cla, '$cla');
   #CBIL::Util::Disp::Display([sort keys %key_to_obj], '[sort keys %key_to_obj');

   foreach my $param_name (sort keys %$cla) {

      # skip CBIL::Util::EasyCsp options which we do not record.
      next if $param_name =~ /(debug|verbose|veryVerbose|sqlVerbose|usage|help|helpHTML)/;

      # get the Core.AlgorithmParamKey object
      my $apk_go      = $key_to_obj{$param_name};

      # this param is expected
      if (defined $apk_go) {

         # find out what type this param is
         my $apkt_go         = $apk_go->getParent('GUS::Model::Core::AlgorithmParamKeyType',1);
         if ($apkt_go) {

            my $type            = $apkt_go->getType;

            # get a list of its values (list or not originally)
            my $typed_value_key = $type.'_value';
            my $param_value     = $cla->{$param_name};
            my @values = ref $param_value ? @$param_value : ($param_value);

            # process each value for param in (posible) list.  Note that we
            # store value in string_value as well as its native type.
            for (my $v_i = 0; $v_i < @values; $v_i++) {
               my $ap_h = { algorithm_param_key_id  => $apk_go->getId,
                            string_value            => $values[$v_i],
                            $typed_value_key        => $values[$v_i],
                            order_num               => $v_i,
                            algorithm_invocation_id => $PlugIn->getAlgInvocation->getId,
                            is_default              => 0,
                          };
               my $ap_go = GUS::Model::Core::AlgorithmParam->new($ap_h);
               $ap_go->submit;
            }
         } else {
            $PlugIn->error("No Core.AlgorithmParamKeyType");
         }
      }

      # an unexpected parameter, let the user know.
      else {
         $PlugIn->error("The plugin is declaring an argument named '$param_name', but that argument was not present when the plugin was last registered.  

Perhaps you need to do a 'ga +update " . $PlugIn->getName() . " --commit'

If you are developing the plugin, you may need to check it in to the repostory and do a build before running ga update.\n");
      }
   }
   $PlugIn->initIrrelevantCounts();
}

# ----------------------------------------------------------------------

# SOON: when alg inv. gets new 'status' attribute, this will set it to
# 'succeeded' or 'failed' based on $failmsg;

sub closeInvocation {
   my $Self   = shift;
   my $PlugIn = shift;

   my $failmsg;

   $PlugIn->setResultDescr($failmsg) if $failmsg; # until we add an errmsg attribute

   $PlugIn->getAlgInvocation->setGlobalNoVersion(1);
   $PlugIn->getAlgInvocation->setResult($PlugIn->getResultDescr);
   $PlugIn->getAlgInvocation->setEndTime($PlugIn->getAlgInvocation->getDatabase()->getDateFunction());
   $PlugIn->getAlgInvocation->submit(1);

   ##logout
   $Self->disconnect_from_database($PlugIn);

   return undef;
}

# ----------------------------------------------------------------------
# Sets up a standard minimal connect to the database.  Initializes the
# db and dbh attributes.

sub connect_to_database {
   my $Self = shift;
   my $PlugIn = shift;          # active plugins

   my $config      = $Self->getConfig();

   my $login       = $Self->getConfig->getDatabaseLogin();
   my $password    = $Self->getConfig->getDatabasePassword();
   my $core        = $Self->getConfig->getCoreSchemaName();
   my $dbiDsn      = $Self->getConfig->getDbiDsn();
   my $oraDfltRbs  = $Self->getConfig->getOracleDefaultRollbackSegment();

   $PlugIn->initDb(new GUS::ObjRelP::DbiDatabase($dbiDsn,
                                                 $login,$password,
                                                 0,0,1,
                                                 $core,
                                                 $oraDfltRbs));
   # return self.
   $Self
}

sub disconnect_from_database {
   my $Self   = shift;
   my $PlugIn = shift;

   $PlugIn->getDb()->logout();
}


# ----------------------------------------------------------------------
# Private functions
# ----------------------------------------------------------------------

sub _check_database_version_requirements {
    my $Self = shift;
    my $PlugIn = shift;

    my $version = $PlugIn->getRequiredDbVersion();
    my $sql     = "select max(version) from Core.DatabaseVersion";
    my $sh      = $Self->getQueryHandle->prepare($sql);
    
    $sh->execute();
    my $dbVersion;
    ($dbVersion) = $sh->fetchrow_array;
    if ( $dbVersion == $version ) {
	return;
    }

    my $errMsg = "Database version does not match required version for Plugin.\n";
    $errMsg .= "Database Version: $dbVersion    Plugin Version: $version\n";
    $Self->error($errMsg);
}

sub getStandardArgsDeclaration {
   [
    booleanArg({name  => 'commit',
                descr => 'Actualy commit changes to the database',
                reqd  => 0,
                default=> 0,
               }),

    booleanArg({ name     => 'debug',
                 descr    => 'output extra debugging information to verify correct operation',
                 reqd     => 0,
                 isList   => 0,
                 default  => 0,
               }),

    booleanArg({ name     => 'sqlVerbose',
                 descr    => 'Use this flag to switch on a log of SQL statements executed by Perl object layer.',
                 reqd     => 0,
                 isList   => 0,
                 default  => 0,
               }),

    booleanArg({ name     => 'verbose',
                 descr    => 'Use this flag to enable output of logVerbose messages from the plugin.',
                 reqd     => 0,
                 isList   => 0,
                 default  => 0,
               }),

    booleanArg({ name     => 'veryVerbose',
                 descr    => 'Use this flag to enable output of logVeryVerbose and logVerbose messages from the plugin.',
                 reqd     => 0,
                 isList   => 0,
                 default  => 0,
               }),

    stringArg({name  => 'user',
               descr => 'Set the user name in new or changed rows with this GUS user name (from Core.UserInfo table) [default is value in gus config file]',
               reqd  => 0,
               default=> undef,
               constraintFunc=>undef,
               isList=>0,
              }),
    stringArg({name  => 'group',
               descr => 'Set the group name in new or changed rows with this GUS group name (from Core.GroupInfo table) [default is value in gus config file]',
               reqd  => 0,
               default=> undef,
               constraintFunc=>undef,
               isList=>0,
              }),
    stringArg({name  => 'project',
               descr => 'set the project name in new or changed rows with this GUS project name (from Core.Project table) [default is value in gus config file]',
               reqd  => 0,
               default=> undef,
               constraintFunc=>undef,
               isList=>0,
              }),
    stringArg({name  => 'comment',
               descr => 'Set Core.AlgorithmInvocation.comment with this comment',
               reqd  => 0,
               default=> undef,
               constraintFunc=>undef,
               isList=>0,
              }),
    integerArg({name  => 'algoinvo',
                descr => 'Use this algorithm invocation id in the event that a new algorithm invocation id cannot be generated automatically',
                reqd  => 0,
                default=> 1,
                constraintFunc=>undef,
                isList=>0,
               }),
    fileArg   ({name  => 'gusconfigfile',
                descr => 'The gus config file to use [note: the default is your $GUS_CONFIG_FILE]',
                reqd  => 0,
                default=> "$ENV{GUS_CONFIG_FILE}",
                constraintFunc=> undef,
                isList=>0,
                mustExist=> 1,
                format => 'GUS config file format',
               }),

   ];
}

sub getGlobalEasyCspOptions {
   my $Self = shift;

   my $RV =
   {
    map {($_->{o},$_)}
    (
     { h => 'actually commit changes to database',
       t => 'boolean',
       o => 'commit',
     },

     { h => 'Use this flag to switch on a log of SQL statements executed by Perl object layer.',
       t => 'boolean',
       o => 'sqlVerbose',
     },

     { h => 'Use this flag to enable output of logVeryVerbose and logVerbose messages from the plugin.',
       t => 'boolean',
       o => 'veryVerbose',
     },

     { h => 'set the user name in new or changed rows with this GUS user name (from Core.UserInfo table) [default is value in gus config file]',
       t => 'string',
       o => 'user',
     },

     { h => 'set the group name in new or changed rows with this GUS group name (from Core.GroupInfo table) [default is value in gus config file]',
       t => 'string',
       o => 'group',
     },

     { h => 'set the project name in new or changed rows with this GUS project name (from Core.Project table) [default is value in gus config file]',
       t => 'string',
       o => 'project',
     },

     { h => 'use this algorithm invocation id in the event that a new algorithm invocation id cannot be generated automatically',
       t => 'integer',
       d => 1,
       o => 'algoinvo',
     },

     { h => 'set Core.AlgorithmInvocation.comment with this comment',
       t => 'string',
       o => 'comment',
     },

     { h => 'the gus config file to use [default is $GUS_CONFIG_FILE]',
       t => 'string',
       o => 'gusconfigfile',
       d => "$ENV{GUS_CONFIG_FILE}"
     },
    )
   };

   # RETURN
   return $RV
}

1;


