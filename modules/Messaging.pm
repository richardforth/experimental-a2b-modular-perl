package Messaging;

sub important {
	if ( ! $NOINFO ) {
		print "\n${YELLOW}** IMPORTANT MESSAGE **\nImportant messages go here.${ENDC}\n";
	}
}



1;
