#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long qw(:config no_ignore_case bundling pass_through);

use lib 'mods';
require ColorSchemes;


my $BBCODE;
my $LIGHTBG;
my $NOCOLOR;
my $VERBOSE;

GetOptions(
	'bbcode|b' => \$BBCODE,
	'light-term|L' => \$LIGHTBG,
	'nocolor|n' => \$NOCOLOR,
	'verbose|v' => \$VERBOSE
);


our %colors;
if ($NOCOLOR) {
	%colors = ColorSchemes::getNone() 
} elsif ($LIGHTBG) {
	%colors = ColorSchemes::getLight() 
} elsif ($BBCODE) {
	%colors = ColorSchemes::getBBCode() 
} else {
	%colors = ColorSchemes::getAnsi() 
}

foreach my $key ( keys %colors ) {
	print "$colors{$key}$key => $colors{$key}\n";
}

print "$colors{YELLOW} ** Done **$colors{ENDC}\n";

