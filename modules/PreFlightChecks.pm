package PreFlightChecks;

my %pfcs;

## check for pmap
my $pmap = `which pmap`;
chomp($pmap);
# make sure that pmap is available within our path
if ( $pmap !~ m/.*\/pmap/ ) { 
	$pfcs{pmap} = 0;
} else {
	$pfcs{pmap} = 1;
}

## check for netstst
my $netstat = `which netstat`;
chomp($netstat);
# make sure that netstat is available within our path
if ( $netstat !~ m/.*\/netstat/ ) { 
	$pfcs{netstat} = 0;
} else {
	$pfcs{netstat} = 1;
}

## check for php
my $php = `which php`;
chomp ($php);
if ( $php !~ m/.*\/php/ ) {
	$pfcs{php} = 0;
} else {
	$pfcs{php} = 1;
}

## check for apachectl
my $ac = `which apachectl`;
chomp ($ac);
if ( $ac !~ m/.*\/apachectl/ ) {
	$pfcs{apachectl} = 0;
	if ( $ac !~ m/.*\/apache2ctl/ ) {
		$pfcs{apache2ctl} = 0;
	} else {
		$pfcs{apache2ctl} = 1;
	}
} else {
	$pfcs{apachectl} = 1;
}

## check for python
my $python = `which python`;
chomp ($php);
if ( $php !~ m/.*\/python/ ) {
	$pfcs{python} = 0;
} else {
	$pfcs{python} = 1;
}

sub getResults {
	return %pfcs;
}

1;
