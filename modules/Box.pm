package Box;

sub debug {
	print "[ ${BOLD}${BLUE}??${ENDC} ] "; 
}

sub advisory {
	print "[ ${BOLD}${YELLOW}\@\@${ENDC} ] "; 
}

sub info {
	my ($BOLD, $BLUE, $ENDC) = @_;
	print "[ ${BOLD}${BLUE}--${ENDC} ] ";
}

sub ok {
	print "[ ${BOLD}${GREEN}OK${ENDC} ] ";
}

sub warn {
	print "[ ${BOLD}${YELLOW}>>${ENDC} ] ";
}

sub crit {
	print "[ ${BOLD}${RED}!!${ENDC} ] ";
}

1;
