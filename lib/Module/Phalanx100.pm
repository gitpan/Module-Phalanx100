=head1 NAME

Module::Phalanx100 - list of Phalanx 100 modules

=head1 SYNOPSIS

  use Module::Phalanx100;

  @dists = Module::Phalanx100->dists;
  if (Module::Phalanx100->dists('HTML-Parser')) {
    ...
  }

  @mods  = Module::Phalanx100->modules();
  $dist = Module::Phalanx100->modules('HTML::Parser');


=head1 DESCRIPTION

This module returns a list of Phalanx 100 distributions and modules,
to be used with other applications which need this information.

This list comes from the Phalanx Project web site at
L<http://qa.perl.org/phalanx> and L<Bundle::Phalanx100>.

=head1 SEE ALSO

  Bundle::Phalanx100

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

use vars qw($VERSION %PhalanxDists %PhalanxModules);

use Tie::IxHash;

$VERSION = '0.03';

%PhalanxDists   = ( );
%PhalanxModules = ( );

sub import {
  my $class = shift;
  my $ver = shift || 0;
  die "incompatible version", if ($ver > $VERSION);

  tie %PhalanxDists,   'Tie::IxHash';
  tie %PhalanxModules, 'Tie::IxHash';

  while (my $line = <DATA>) {
    $line =~ s/\s+$//;
    if ($line) {
      my ($module, $dist) = split /\s+/, $line;
      $PhalanxDists{ $dist }     = -1;
      $PhalanxModules{ $module } = $dist;
    }
  }
  die "no distros" unless (keys %PhalanxDists);
}

sub dists {
  my $class = shift;
  if (my $dist = shift) {
    return $PhalanxDists{ $dist };
  }
  else {
    return (keys %PhalanxDists);
  }
}

sub modules {
  my $class = shift;
  if (my $mod = shift) {
    return $PhalanxModules{ $mod };
  }
  else {
    return (keys %PhalanxModules);
  }
}


1;

__DATA__
Test::Harness	Test-Harness
Test::Builder	Test-Simple
Test::Builder::Tester	Test-Builder-Tester
Sub::Uplevel	Sub-Uplevel
Test::Exception	Test-Exception
Test::Tester	Test-Tester
Test::NoWarnings	Test-NoWarnings
Test::Tester	Test-Tester
Pod::Escapes	Pod-Escapes
Pod::Simple	Pod-Simple
Test::Pod	Test-Pod
YAML	YAML
Cwd	PathTools
Archive::Tar	Archive-Tar
Module::Build	Module-Build
Devel::Symdump	Devel-Symdump
Pod::Coverage	Pod-Coverage
Test::Pod::Coverage	Test-Pod-Coverage
Compress::Zlib	Compress-Zlib
IO::Zlib	IO-Zlib
Archive::Zip	Archive-Zip
Archive::Tar	Archive-Tar
Storable	Storable
Digest::MD5	Digest-MD5
URI	URI
HTML::Tagset	HTML-Tagset
HTML::Parser	HTML-Parser
LWP	libwww-perl
IPC::Run	IPC-Run
CPANPLUS	CPANPLUS
DBI	DBI
DBD::mysql	DBD-mysql
GD	GD
MIME::Base64	MIME-Base64
Net::SSLeay	Net_SSLeay.pm
Net::LDAP	perl-ldap
XML::Parser	XML-Parser
Apache::ASP	Apache-ASP
CGI	CGI.pm
Date::Manip	DateManip
DBD::Oracle	DBD-Oracle
DBD::Pg	DBD-Pg
Digest::SHA1	Digest-SHA1
Digest::HMAC	Digest-HMAC
Digest::MD5	Digest-MD5
HTML::Tagset	HTML-Tagset
HTML::Template	HTML-Template
Net::Cmd	libnet
Mail::Mailer	MailTools
MIME::Body	MIME-tools
Net::DNS	Net-DNS
Time::HiRes	Time-HiRes
URI	URI
Apache::DBI	Apache-DBI
Apache::Session	Apache-Session
Apache::Test	Apache-Test
AppConfig	AppConfig
App::Info	App-Info
Authen::PAM	Authen-PAM
Authen::SASL	Authen-SASL
BerkeleyDB	BerkeleyDB
Bit::Vector	Bit-Vector
Carp::Clan	Carp-Clan
Chart::Bars	Chart
Class::DBI	Class-DBI
Compress::Zlib::Perl	Compress-Zlib-Perl
Config::IniFiles	Config-IniFiles
Convert::ASN1	Convert-ASN1
Convert::TNEF	Convert-TNEF
Convert::UUlib	Convert-UUlib
CPAN	CPAN
Crypt::CBC	Crypt-CBC
Crypt::DES	Crypt-DES
Crypt::SSLeay	Crypt-SSLeay
Data::Dumper	Data-Dumper
Date::Calc	Date-Calc
DateTime	DateTime
DBD::DB2	DBD-DB2
DBD::ODBC	DBD-ODBC
DBD::SQLite	DBD-SQLite
DBD::Sybase	DBD-Sybase
Device::SerialPort	Device-SerialPort
Digest::SHA	Digest-SHA
Encode	Encode
Event	Event
Excel::Template	Excel-Template
Expect	Expect
ExtUtils::MakeMaker	ExtUtils-MakeMaker
File::Scan	File-Scan
File::Spec	PathTools
File::Tail	File-Tail
File::Temp	File-Temp
GD::Graph	GDGraph
GD::Text	GDTextUtil
Getopt::Long	Getopt-Long
HTML::Mason	HTML-Mason
Image::Size	Image-Size
IMAP::Admin	IMAP-Admin
Inline	Inline
IO	IO
IO::All	IO-All
IO::Socket::SSL	IO-Socket-SSL
IO::String	IO-String
IO::Stringy	IO-stringy
XML::SAX2Perl	libxml-perl
Mail::Audit	Mail-Audit
Mail::ClamAV	Mail-ClamAV
Mail::Sendmail	Mail-Sendmail
Math::Pari	Math-Pari
MD5	MD5
MIME::Lite	MIME-Lite
Module::Build	Module-Build
MP3::Info	MP3-Info
DBD::mSQL	Msql-Mysql-modules
Net::Daemon	Net-Daemon
Net::FTP::Common	Net-FTP-Common
Net::Ping	Net-Ping
Net::Server	Net-Server
Net::SNMP	Net-SNMP
Net::SSH::Perl	Net-SSH-Perl
Net::Telnet	Net-Telnet
OLE::Storage_Lite	OLE-Storage_Lite
Params::Validate	Params-Validate
Parse::RecDescent	Parse-RecDescent
Cwd	PathTools
Image::Magick	PerlMagick
RPC::PlServer	PlRPC
Pod::Parser	Pod-Parser
POE	POE
SNMP	SNMP
SOAP::Lite	SOAP-Lite
Spreadsheet::ParseExcel	Spreadsheet-ParseExcel
Spreadsheet::WriteExcel	Spreadsheet-WriteExcel
Spreadsheet::WriteExcelXML	Spreadsheet-WriteExcelXML
Storable	Storable
Template	Template-Toolkit
Term::ReadKey	TermReadKey
Term::ReadLine::Perl	Term-ReadLine-Perl
Text::Iconv	Text-Iconv
Date::Parse	TimeDate
Time::Timezone	Time-modules
Unicode::String	Unicode-String
Unix::Syslog	Unix-Syslog
Verilog::Parser	Verilog-Perl
WWW::Mechanize	WWW-Mechanize
XML::DOM	XML-DOM
XML::Generator	XML-Generator
XML::LibXML	XML-LibXML
XML::NamespaceSupport	XML-NamespaceSupport
XML::SAX	XML-SAX
XML::Simple	XML-Simple
XML::Writer	XML-Writer
