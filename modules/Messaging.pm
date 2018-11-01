package Messaging;

sub info {
	my ($message) = @_;
	print "[ -- ] $message\n";
}

sub critical {
	my ($message) = @_;
	print "[ !! ] $message\n";
}

sub advice {
	my ($message) = @_;
	print "[ @@ ] $message\n";
}

sub warning {
	my ($message) = @_;
	print "[ >> ] $message\n";
}

1;
