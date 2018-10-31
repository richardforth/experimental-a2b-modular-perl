package Banners;

sub Heading {
	my ($colorstart, $ENDC, $message) = @_;
	my $hrline = "#" x length($message);
	print ${colorstart} . $hrline . ${ENDC} . "\n";
	print $message . "\n";
	print ${colorstart} . $hrline . ${ENDC} ."\n";
}

1;
