package Messaging;

sub important {
	my ($YELLOW, $ENDC, $MESSAGE) = @_;
	print "${YELLOW}** $MESSAGE **${ENDC}\n";
}



1;
