=head1 NAME

Module::Phalanx100 - list of Phalanx 100 modules

=head1 SYNOPSIS

  use Module::Phalanx100;

  my @phalanx_dists = Module::Phalanx100->dists;

  if (Module::Phalanx100->dists('HTML-Parser')) {
    ...
  }

=head1 DESCRIPTION

This module returns a list of Phalanx 100 I<distributions>, to be used
with other applications which need this information.

This list comes from the Phalanx Project web site at
L<http://qa.perl.org/phalanx>.

It does not handle distribution verson numbers, or recognize if
modules are part of a specific distribution (L<Parse::CPAN::Packages>
can assist with that).

=head1 SEE ALSO

  Bundle::Phalanx

The following modules provide additional CPAN meta-data:

  Module::CoreList
  Parse::CPAN::Packages

The following modules provide dependency information:

  CPAN::Unwind
  Module::Info
  Module::Dependency
  Module::Depends
  Module::MakefilePL::Parse
  Module::PrintUsed
  Module::ScanDeps

Additional information can be found at the following web sites:

=over

=item *

The Phalanx Project L<http://qa.perl.org/phalanx>

=item *

CPANTS Testing Service L<http://cpants.dev.zsi.at>

=back

=head1 AUTHOR

Robert Rothenberg <rrwo at cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 by Robert Rothenberg

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut

package Module::Phalanx100;

use 5.004;
use strict;

use vars qw($VERSION @PhalanxDists);

$VERSION = '0.02';

@PhalanxDists = ( );

sub import {
  my $class = shift;
  my $ver = shift || 0;
  die "incompatible version", if ($ver > $VERSION);
  while (my $line = <DATA>) {
    $line =~ s/\s+$//;
    push @PhalanxDists, $line if ($line);
  }
  die "no distros" unless (@PhalanxDists);
}

sub dists {
  my $class = shift;
  if (@_) {
    my $dist = shift;
    return grep /^$dist$/, @PhalanxDists;
  }
  else {
    return @PhalanxDists;
  }
}

1;

__DATA__
Test-Builder-Tester 	
Test-Exception
Test-Harness
Test-NoWarnings
Test-Pod
Test-Pod-Coverage
Test-Reporter
Test-Simple
Test-Warn
CPANPLUS
DBD-mysql
DBI
GD
HTML-Parser
libwww-perl
MIME-Base64
Net_SSLeay.pm
perl-ldap
XML-Parser
The Next 20
Apache-ASP
Archive-Tar
Archive-Zip
CGI.pm
Compress-Zlib
DateManip
DBD-Oracle
DBD-Pg
DB_File
Digest
Digest-SHA1
Digest-HMAC
Digest-MD5
HTML-Tagset
HTML-Template
libnet
MailTools
MIME-tools
Net-DNS
PathTools
Time-HiRes
URI
Apache-DBI
Apache-Session
Apache-Test
AppConfig
App-Info
Authen-PAM
Authen-SASL
BerkeleyDB
Bit-Vector
Carp-Clan
Chart
Class-Accessor
Class-Data-Inheritable
Class-DBI
Class-Singleton
Class-Trigger
Class-WhiteHole
Compress-Zlib-Perl
Config-IniFiles
Convert-ASN1
Convert-TNEF
Convert-UUlib
CPAN
Crypt-CBC
Crypt-DES
Crypt-SSLeay
Data-Dumper
Date-Calc
DateTime
DBD-DB2
DBD-ODBC
DBD-SQLite
DBD-Sybase
Device-SerialPort
Digest-SHA
Encode
Event
Excel-Template
Expect
ExtUtils-MakeMaker
File-Scan
File-Tail
File-Temp
GDGraph
GDTextUtil
Getopt-Long
HTML-Mason
Ima-DBI
Image-Size
Inline
IO
IO-All
IO-Socket-SSL
IO-String
IO-stringy
IO-Zlib
IPC-Run
libxml-perl
Mail-Audit
Mail-ClamAV
Mail-Sendmail
Math-Pari
MIME-Lite
mod_perl
Module-Build
MP3-Info
Net-Daemon
Net-FTP-Common
Net-Ping
Net-Server
Net-SNMP
Net-SSH-Perl
Net-Telnet
OLE-Storage_Lite
Params-Validate
Parse-RecDescent
PerlMagick
PlRPC
PodParser
POE
SNMP
SOAP-Lite
Spreadsheet-ParseExcel
Spreadsheet-WriteExcel
Spreadsheet-WriteExcelXML
Storable
Template-Toolkit
TermReadKey
Term-ReadLine-Perl
Text-Iconv
TimeDate
Time-modules
Unicode-String
UNIVERSAL-moniker
Unix-Syslog
WWW-Mechanize
XML-DOM
XML-Generator
XML-LibXML
XML-NamespaceSupport
XML-SAX
XML-Simple
XML-Writer
YAML




