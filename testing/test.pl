#!/usr/bin/perl

use strict;
use warnings;

use lib 'mods';
require Vars;

my %config = Vars::get();

print "$config{a} and $config{b}\n";
