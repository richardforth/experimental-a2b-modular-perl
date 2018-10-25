package Box;

sub debug {
	print "[ ${BOLD}${BLUE}??${ENDC} ] "; 
}

sub advisory {
	print "[ $BOLD${YELLOW}\@\@${ENDC} ] "; 
}

sub info {
	my ($BLUE, $BOLD, $ENDC) = @_;
	print "[ ${BOLD}${BLUE}--${ENDC} ] ";
}

sub ok {
	print "[ ${BOLD}${GREEN}OK${ENDC} ] ";
}

sub warn {
	print "[ ${BOLD}${YELLOW}>>${ENDC} ] ";
}

sub crit {
	my ($RED, $BOLD, $ENDC) = @_;
	print "[ ${BOLD}${RED}!!${ENDC} ] ";
}

1;
