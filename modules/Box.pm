package Box;

sub debug {
	my ($BOLD, $BLUE, $ENDC) = @_;
	print "[ ${BOLD}${BLUE}??${ENDC} ] "; 
}

sub advisory {
	my ($BOLD, $YELLOW, $ENDC) = @_;
	print "[ ${BOLD}${YELLOW}\@\@${ENDC} ] "; 
}

sub info {
	my ($BOLD, $BLUE, $ENDC) = @_;
	print "[ ${BOLD}${BLUE}--${ENDC} ] ";
}

sub ok {
	my ($BOLD, $GREEN, $ENDC) = @_;
	print "[ ${BOLD}${GREEN}OK${ENDC} ] ";
}

sub warn {
	my ($BOLD, $YELLOW, $ENDC) = @_;
	print "[ ${BOLD}${YELLOW}>>${ENDC} ] ";
}

sub crit {
	my ($BOLD, $RED, $ENDC) = @_;
	print "[ ${BOLD}${RED}!!${ENDC} ] ";
}

1;
