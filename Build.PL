use Module::Build;

my $build = Module::Build->new
    (
     module_name => 'Module::Phalanx100',
     license => 'perl',
     requires => {
       'perl'                       => '5.004',
       'Tie::IxHash'                => 0,
     },
     recommends => {
       'Archive::Tar'               => 0,
       'Carp'                       => 0,
       'File::Copy'                 => 0,
       'File::Spec'                 => 0,
       'File::Temp'                 => 0,
       'IO::File'                   => 0,
       'LWP::Simple'                => 0,
       'Parse::CPAN::Packages'      => 0,
       'Sort::Versions'             => 0,
     },
     build_requires => {
       'Test::More'                => 0,
     },
     create_makefile_pl => 'traditional',
     create_readme      => 1,
     dist_author        => 'Robert Rothenberg <rrwo at cpan.org>',
     sign               => 1,
);

$build->create_build_script;
