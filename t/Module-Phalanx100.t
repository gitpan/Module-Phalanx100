#!/usr/bin/perl

use Test;
BEGIN { plan tests => 4 };
use Module::Phalanx100 0.01;
ok(1);

my @dists = Module::Phalanx100->dists();
ok(@dists);
ok(@dists == 146);

ok(Module::Phalanx100->dists('YAML'));

__DATA__
*
