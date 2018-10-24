package Syschecks;
use strict;
use warnings;

sub isRoot {
	my $uid = `id -u`;
	chomp($uid);

	print "UID of user is: ".$uid."\n";

	if ( $uid ne '0' ) {
		# return False
		return 0;
	} else {
		# return True
		return 1;
	}
}

1;
