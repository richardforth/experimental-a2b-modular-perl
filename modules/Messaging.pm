package Messaging;

sub important {
	my ($YELLOW, $ENDC, $MESSAGE) = @_;
	print "${YELLOW}** $MESSAGE **${ENDC}\n";
}

sub critical {
	my ($RED, $ENDC, $MESSAGE) = @_;
	print "${RED}CRITICAL ERROR: $MESSAGE${ENDC}\n";
}



1;
