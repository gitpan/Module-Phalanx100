use Module::Build;

my $build = Module::Build->new
    (
     module_name => 'Module::Phalanx100',
     license => 'perl',
     requires => {
       'perl'                       => '5.004',
     },
     recommends => {
     },
     build_requires => {
       'Test'                       => 0,
     },
     create_makefile_pl => 'traditional',
     create_readme      => 1,
     dist_author        => 'Robert Rothenberg <rrwo at cpan.org>',
     sign               => 1,
);

$build->create_build_script;
