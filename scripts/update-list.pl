#!/usr/bin/perl

# This is a prototype script to update Module::Phalanx100 from the
# list in Bundle::Phalanx100.  Use at your own risk!

require 5.006;

use strict;
use warnings;

use constant CPAN_MIRROR => 'ftp://ftp.cpan.org/pub/CPAN/';
# use constant CPAN_MIRROR => 'ftp://cpan.etla.org/pub/CPAN/';
use constant PACKAGES_FILE => '02packages.details.txt.gz';

use Archive::Tar;
use Carp;
use File::Copy;
use File::Spec;
use File::Temp   'tempdir';
use IO::File;
use LWP::Simple;
use Parse::CPAN::Packages;
use Sort::Versions;

our $VERSION = '0.01_01';
$VERSION = eval $VERSION;

my $WorkPath = tempdir( CLEANUP => 1 );
my $ModList  = File::Spec->catfile($WorkPath, PACKAGES_FILE);

{
  # Bug? LWP::Simple::getstore does not seem to work
  my $rc = mirror(CPAN_MIRROR.'modules/'.PACKAGES_FILE, $ModList);
  if (is_error($rc)) {
    croak "Failed to download module list to $ModList\n";
  }
}

my $Packages = Parse::CPAN::Packages->new($ModList);

# Get the latest version from CPAN. The downside is that developer
# releases do not show up in the bundle, so we use the default latest
# release.

my $Latest   = "S/SM/SMPETERS/Bundle-Phalanx-0.06_02.tar.gz";

my $Bundle = $Packages->latest_distribution("Bundle-Phalanx");
unless ($Bundle) {
  croak "Bundle-Phalanx not found in distributions";
}

if (versioncmp($Bundle->version, '0.06_02') > 0) {
  $Latest = $Bundle->prefix;
}

my $BundleFile = 
  File::Spec->catfile($WorkPath, (File::Spec->splitpath($Latest))[-1]);

{
  my $rc = mirror(CPAN_MIRROR.'authors/id/'.$Latest, $BundleFile);
  if (is_error($rc)) {
    croak "Unable to download $Latest\n";
  }
}

my $Extracted = File::Spec->catfile($WorkPath, 'Phalanx100.pm');
{
  my $tar   = Archive::Tar->new($BundleFile,1);
  my @files = grep /Phalanx100\.pm$/, $tar->list_files();

  croak "Unable to determine which file we need from the archive\n"
    if (@files != 1);

  unless ($tar->extract_file( $files[0], $Extracted)) {
    croak "Unable to extract file from archive";
  }
}

my @ModuleList = ( );
{
  my $fh     = new IO::File($Extracted)
    || croak "Unable to open file $Extracted";

  my $in_contents = 0;
  while (my $line = <$fh>) {
    chomp($line);
    if ($line =~ /^\=head1 (.+)/) {
      $in_contents = ($1 eq 'CONTENTS');
    }
    else {
      if ($in_contents) {
	if ($line) {
	  my @fields = split /\s+/, $line;
	  push @ModuleList, $fields[0];
	}
      }
    }
  }

  $fh->close;
}


{
  copy('../lib/Module/Phalanx100.pm', '../lib/Module/Phalanx100.pm.orig'); 

  my $fi = new IO::File('<../lib/Module/Phalanx100.pm.orig');
  my $fo = new IO::File('>../lib/Module/Phalanx100.pm');

  my $line;
  do {
    $line = <$fi>;
    print $fo $line;
  } while ($line !~ /^__DATA__/);

  foreach my $module (@ModuleList) {
    my $m = $Packages->package($module);
    if (defined $m) {
      my $d = $m->distribution;
      print $fo join("\t", $m->package, $d->dist), "\n";
    } else {
      carp "Cannot handle module $module\n";
    }
  }

  close $fi;
  close $fo;
}
