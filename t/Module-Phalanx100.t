#!/usr/bin/perl

use Test::More tests => 305;
use strict;

use_ok('Module::Phalanx100', '0.03');

my @dists = Module::Phalanx100->dists();
ok(@dists > 100, "dists != 0");

ok(!Module::Phalanx100->dists('Foo-Bar-Bo-Baz'));

for my $i (1..100) { # first 100 distros
  ok(Module::Phalanx100->dists($dists[$i])==-1);
}

my @mods = Module::Phalanx100->modules();
ok(@mods > @dists);

ok(!Module::Phalanx100->modules('Foo::Bar::Bo::Baz'));

for my $i (1..100) { # first 100 distros
  ok(Module::Phalanx100->modules($mods[$i]));
  ok(Module::Phalanx100->dists( Module::Phalanx100->modules($mods[$i]) )==-1);
}


__DATA__
Foo::Bar::Bo::Baz Foo-Bar-Bo-Baz

