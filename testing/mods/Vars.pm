package Vars;

my %config = (
	a => "apples",
	b => "pears"
);

sub get {
	return %config;
}

1;
