package Syschecks;
use strict;
use warnings;

require Box;

sub isRoot {
	my ($BLUE, $BOLD, $ENDC) = @_;
	my $uid = `id -u`;
	chomp($uid);

	Box::info($BLUE, $BOLD, $ENDC); print "UID of user is: ".$uid."\n";

	if ( $uid ne '0' ) {
		# return False
		return 0;
	} else {
		# return True
		return 1;
	}
}

1;
