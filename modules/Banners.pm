package Banners;

sub Heading {
	my ($message) = @_;
	my $hrline = "#" x length($message);
	print $hrline . "\n";
	print $message . "\n";
	print $hrline . "\n";
}

1;
