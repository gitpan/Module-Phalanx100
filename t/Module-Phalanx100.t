#!/usr/bin/perl

use Test::More tests => 3+146;

use_ok('Module::Phalanx100', '0.02');

my @dists = Module::Phalanx100->dists();
ok(@dists,        "dists != 0");

ok(!Module::Phalanx100->dists('Foo::Bar::Bo::Baz'));

foreach my $d (@dists) {
  ok(Module::Phalanx100->dists($d), "$d");
}

__DATA__
Foo::Bar::Bo::Baz
