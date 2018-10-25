#!/usr/bin/perl

use strict;
use warnings;

our ($a, $b);
use lib 'mods';
require Vars;

my %config = Vars::get();

print "$config{a} and $config{b}\n";
