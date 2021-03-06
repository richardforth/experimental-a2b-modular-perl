#!/usr/bin/perl

eval "use diagnostics; 1"  or die("\n[ FATAL ] Could not load the Diagnostics module.\n\nTry:\n\n      sudo apt-get install perl-modules\n\nThen try running this script again.\n\n");
use Getopt::Long qw(:config no_ignore_case bundling pass_through);
use strict;
use warnings;

# Import modules for use here
use lib 'modules';
require Banners;
require ColorSchemes;
require Defaults;
require Help;
require Messaging;
require System;

########################
# Set Defaults         #
########################
our %config  = Defaults::set();

########################
# GATHER CMD LINE ARGS #
########################

# grab the command line arguments, and update the config accordingly
GetOptions(
	'help|h' => \$config{help},
	'port|p:i' => \$config{port},
	'pid:i' => \$config{pid},
	'verbose|v' => \$config{VERBOSE},
	'noinfo|N' => \$config{NOINFO},
	'nowarn|W' => \$config{NOWARN},
	'report|r' => \$config{REPORT},
	'no-ok|K' => \$config{NOOK},
	'noheader|H' => \$config{NOHEADER},
	'no-check-pid|P' => \$config{NOCHKPID},
	'skip-maxclients' => \$config{SKIPMAXCLIENTS},
	'skip-php-fatal' => \$config{SKIPPHPFATAL},
	'skip-updates' => \$config{SKIPUPDATES},
	'skip-os-version-checki|O' => \$config{NOCHKOS},
	'nonews' => \$config{NONEWS},
);

# check for invalid options, bail if we find any and print the usage output
if ( @ARGV > 0 ) {
	#Box::crit();
	print " Invalid option: ";
	foreach (@ARGV) {
		print $_." ";
	}
	print "\n";
	Help::usage();
	exit;
}

if ( $config{REPORT} ) {
	$config{NOHEADER} = 1;
	$config{NOINFO} = 1;
	$config{NONEWS} = 1;
	$config{NOWARN} = 1;
	$config{NOOK} = 1;
	$config{SKIPMAXCLIENTS} = 1;
	$config{SKIPPHPFATAL} = 1;
	$config{SKIPUPDATES} = 1;
}

# NOW CREATE SHORTCUTS FOR THE OPTIONS NOW THEY ARE SET IN STONE
my $help = $config{help};
my $port = $config{port};
my $pid = $config{pid};
my $VERBOSE = $config{VERBOSE};
my $NOINFO = $config{NOINFO};
my $NOWARN = $config{NOWARN};
my $REPORT = $config{REPORT};
my $NOOK = $config{NOOK};
my $NOHEADER = $config{NOHEADER};
my $NOCHKPID = $config{NOCHKPID};
my $SKIPMAXCLIENTS = $config{SKIPMAXCLIENTS};
my $SKIPPHPFATAL = $config{SKIPPHPFATAL};
my $SKIPUPDATES = $config{SKIPUPDATES};
my $NOCHKOS = $config{NOCHKOS};
my $NONEWS = $config{NONEWS};

############################################
#  SET UP COLOR SCHEMES                    #
############################################
#our %colors;
#if ($NOCOLOR) {
#	%colors = ColorSchemes::getNone() 
#} elsif ($LIGHTBG) {
#	%colors = ColorSchemes::getLight() 
#} elsif ($BBCODE) {
#	%colors = ColorSchemes::getBBCode() 
#} else {
#	%colors = ColorSchemes::getAnsi() 
#}
#our $RED = $colors{RED};
#our $GREEN = $colors{GREEN};
#our $YELLOW = $colors{YELLOW};
#our $BLUE = $colors{BLUE};
#our $PURPLE = $colors{PURPLE};
#our $CYAN = $colors{CYAN};
#our $WHITE = $colors{WHITE};
#our $ENDC = $colors{ENDC};
#our $BOLD = $colors{BOLD};
#our $ENDBOLD = $colors{ENDBOLD};
#our $UNDERLINE = $colors{UNDERLINE};
#our $ENDUNDERLINE = $colors{ENDUNDERLINE};

#########################
## BEGIN MAIN EXECUTION #
#########################

## if the user has added the help flag, or if they have defined a port  
if ( $help eq 1 || $port eq 0 ) {
	Help::usage();
	exit;
}

## SHOW MAIN BANNER
my $servername = System::get_hostname();
my $ipaddr = System::get_ip();
my $headerstring = "apache2buddy.pl report for $servername ($ipaddr)";
Banners::Heading($headerstring);

## Run preflight checks
require PreFlightChecks;
my %results = PreFlightChecks::getResults();

## CHECK WE ARE RUNNING AS ROOT
## Check we are root, otherwise we dont have enough privileges to check all the things.
if ( ! $results{isroot} ) {
	Messaging::critical("Need to be root to run this script, exiting...");
	#exit 1
}

foreach my $key  (keys %results) {
	print "$key => $results{$key}\n";
}

## GATHER FACTS
require SystemFacts;
my %sysfacts = SystemFacts::getFacts();
foreach my $key (keys %sysfacts) {
	print "$key => $sysfacts{$key}\n";
}

require ApacheFacts;
my %apachefacts = ApacheFacts::getFacts();
foreach my $key (keys %apachefacts) {
	print "$key => $apachefacts{$key}\n";
}


## get panels
require Panels;
my %panels = Panels::getPanels();
foreach my $key (sort {$a cmp $b} keys %panels) {
	print "$key => $panels{$key}\n";
}


Messaging::info("Done");
