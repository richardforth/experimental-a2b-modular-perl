package Messaging;

sub important {
	my ($NOINFO, $YELLOW, $ENDC, $MESSAGE) = @_;
	if ( ! $NOINFO ) {
		print "${YELLOW}** $MESSAGE **${ENDC}\n";
	}
}



1;
