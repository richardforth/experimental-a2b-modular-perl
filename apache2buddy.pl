#!/usr/bin/perl

eval "use diagnostics; 1"  or die("\n[ FATAL ] Could not load the Diagnostics module.\n\nTry:\n\n      sudo apt-get install perl-modules\n\nThen try running this script again.\n\n");
use Getopt::Long qw(:config no_ignore_case bundling pass_through);
use strict;
use warnings;

# Import modules for use here
use lib 'modules';
require Help;
require Syschecks;

########################
# Set Defaults         #
########################
# if help is not asked for, we do not give it
our $help = "";

# by default, assume the terminal has dark background, eg putty 
our $LIGHTBG = 0;

# if no port is specified, we default to 80
our $port = 80;

# if no pid is specified, we default to 0
our $pid = 0;

# by default, do not use verbose output
our $VERBOSE = "";

# by default, use color output
our $NOCOLOR = 0;

# by default, show news messages 
our $NONEWS = 0;

# by default, show informational messages 
our $NOINFO = 0;

# by default, show ok messages 
our $NOOK = 0;

# by default, show warnings 
our $NOWARN = 0;

# by default, show full output 
our $REPORT = 0;

# by default, show header 
our $NOHEADER = 0;

# by default, check pid size 
our $NOCHKPID = 0;

# by default, check OS support
our $NOCHKOS = 0;

# add 'skip section' options...

# by default, do not skip maxclients check
our $SKIPMAXCLIENTS = 0;

# by default, do not skip php fatal errors check 
our $SKIPPHPFATAL = 0;

# by default, do not skip updates check 
our $SKIPUPDATES = 0;


########################
# GATHER CMD LINE ARGS #
########################

# grab the command line arguments
GetOptions(
	'help|h' => \$help,
	'port|p:i' => \$port,
	'pid:i' => \$pid,
	'verbose|v' => \$VERBOSE,
	'nocolor|n' => \$main::NOCOLOR,
	'noinfo|N' => \$NOINFO,
	'nowarn|W' => \$NOWARN,
	'report|r' => \$REPORT,
	'light-term|L' => \$LIGHTBG,
	'no-ok|K' => \$NOOK,
	'noheader|H' => \$NOHEADER,
	'no-check-pid|P' => \$NOCHKPID,
	'skip-maxclients' => \$SKIPMAXCLIENTS,
	'skip-php-fatal' => \$SKIPPHPFATAL,
	'skip-updates' => \$SKIPUPDATES,
	'skip-os-version-checki|O' => \$NOCHKOS,
	'nonews' => \$NONEWS
);

# check for invalid options, bail if we find any and print the usage output
if ( @ARGV > 0 ) {
	print "Invalid option: ";
	foreach (@ARGV) {
		print $_." ";
	}
	print "\n";
	Help::usage();
	exit;
}

if ( $REPORT ) {
	$NOHEADER = 1;
	$NOINFO = 1;
	$NONEWS = 1;
	$NOWARN = 1;
	$NOOK = 1;
	$SKIPMAXCLIENTS = 1;
	$SKIPPHPFATAL = 1;
	$SKIPUPDATES = 1;
}

# Declare constants such as ANSI COLOR schemes.
# TO SAVE CODE and thus also massively cut down on the file size, Ive decided to handle NOCOLOR here, 
# instead of on every single line where I need to print something. it seems much simpler and cleaner
# to print an empty string rather than an escape sequence, rather than doubling up on print() statements.
our $RED;
our $GREEN;
our $YELLOW;
our $BLUE;
our $PURPLE;
our $CYAN;
our $ENDC;
our $BOLD;
our $UNDERLINE;
if ( ! $NOCOLOR ) {
	if ( ! $LIGHTBG ) {
		$RED = "\033[91m";
		$GREEN = "\033[92m"; # Like a light green color, not good for light terminals, but perfect for dark, eg PuTTY, terminals.
		$YELLOW = "\033[93m"; # Like a yellow color, not good for light terminals, but perfect for dark, eg PuTTY, terminals.
		$BLUE = "\033[94m";
		$PURPLE = "\033[95m"; # technically its Magento... 
		$CYAN = "\033[96m"; # Like a light blue color, not good for light terminals, but perfect for dark, eg PuTTY, terminals.
	} else {
		$RED = "\033[1m"; # bold all the things!
		$GREEN = "\033[1m"; # bold all the things!
		$YELLOW = "\033[1m"; # bold all the things!
		$BLUE = "\033[1m"; # bold all the things!
		$PURPLE = "\033[1m"; # bold all the things!
		$CYAN = "\033[1m";  # bold all the things!
	}
	$ENDC = "\033[0m"; # reset the terminal color
	$BOLD = "\033[1m"; # what it says on the tin, you can double up eg make a bold red: ${BOLD}${RED}Something${ENDC}
	$UNDERLINE = "\033[4m"; # again you can double this one up.
} else {
	$RED = ""; # SUPPRESS COLORS
	$GREEN = ""; # SUPPRESS COLORS
	$YELLOW = ""; # SUPPRESS COLORS
	$BLUE = ""; # SUPPRESS COLORS
	$PURPLE = ""; # SUPPRESS COLORS
	$CYAN = ""; # SUPPRESS COLORS
	$ENDC = ""; # SUPPRESS COLORS
	$BOLD = ""; # SUPPRESS COLORS
	$UNDERLINE = ""; # SUPPRESS COLORS
}


#########################
## BEGIN MAIN EXECUTION #
#########################

## if the user has added the help flag, or if they have defined a port  
if ( $help eq 1 || $port eq 0 ) {
	Help::usage();
	exit;
}

## Check we are root, otherwise we dont have enough privileges to check all the things.
if ( ! Syschecks::isRoot() ) {
	print "Sorry, you need to be root to run this script.\nExiting.\n\n";
	exit 1;
}
print "Done";
