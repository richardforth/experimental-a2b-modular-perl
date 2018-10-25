package Defaults;
use strict;
use warnings;

sub set {
	my %config  = (
		help => 0,
		lightbg => 0,
		port => 80,
		pid => 0,
		VERBOSE => 0,
		NOCOLOR => 0,
		NONEWS => 0,
		NOINFO => 0,
		NOOK => 0,
		NOWARN => 0,
		REPORT => 0,
		NOHEADER => 0,
		NOCHKPID => 0,
		NOCHKOS => 0,
		SKIPMAXCLIENTS => 0,
		SKIPPHPFATAL => 0,
		SKIPUPDATES => 0,
		BBCODE => 0
	);
	return %config;
}

1;
