package Syschecks;
use strict;
use warnings;

require Box;

sub isRoot {
	my $uid = `id -u`;
	chomp($uid);

	if ( $uid ne '0' ) {
		# return False
		return 0;
	} else {
		# return True
		return 1;
	}
}

1;
