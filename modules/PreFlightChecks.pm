package PreFlightChecks;

my %pfcs;


my $uid = `id -u`;
chomp($uid);
if ( $uid ne '0' ) {
	$pfcs{isroot} = 0;
} else {
	$pfcs{isroot} = 1;
}

1;

## check for pmap
my $pmap = `which pmap 2>/dev/null`;
chomp($pmap);
# make sure that pmap is available within our path
if ( $pmap !~ m/.*\/pmap/ ) { 
	$pfcs{pmap} = 0;
} else {
	$pfcs{pmap} = 1;
}

## check for netstst
my $netstat = `which netstat 2>/dev/null`;
chomp($netstat);
# make sure that netstat is available within our path
if ( $netstat !~ m/.*\/netstat/ ) { 
	$pfcs{netstat} = 0;
} else {
	$pfcs{netstat} = 1;
}

## check for php
my $php = `which php 2>/dev/null`;
chomp ($php);
if ( $php !~ m/.*\/php/ ) {
	$pfcs{php} = 0;
} else {
	$pfcs{php} = 1;
}

## check for apachectl
my $ac = `which apachectl 2>/dev/null`;
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
my $python = `which python 2>/dev/null`;
chomp ($python);
if ( $python !~ m/.*\/python/ ) {
	$pfcs{python} = 0;
} else {
	$pfcs{python} = 1;
}

sub getResults {
	return %pfcs;
}

1;
