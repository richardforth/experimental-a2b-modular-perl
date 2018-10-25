#!/usr/bin/perl

eval "use diagnostics; 1"  or die("\n[ FATAL ] Could not load the Diagnostics module.\n\nTry:\n\n      sudo apt-get install perl-modules\n\nThen try running this script again.\n\n");
use Getopt::Long qw(:config no_ignore_case bundling pass_through);
use strict;
use warnings;

# Import modules for use here
use lib 'modules';
require Box;
require Defaults;
require Help;
require Messaging;
require Syschecks;

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
	'nocolor|n' => \$config{NOCOLOR},
	'noinfo|N' => \$config{NOINFO},
	'nowarn|W' => \$config{NOWARN},
	'report|r' => \$config{REPORT},
	'light-term|L' => \$config{LIGHTBG},
	'no-ok|K' => \$config{NOOK},
	'noheader|H' => \$config{NOHEADER},
	'no-check-pid|P' => \$config{NOCHKPID},
	'skip-maxclients' => \$config{SKIPMAXCLIENTS},
	'skip-php-fatal' => \$config{SKIPPHPFATAL},
	'skip-updates' => \$config{SKIPUPDATES},
	'skip-os-version-checki|O' => \$config{NOCHKOS},
	'nonews' => \$config{NONEWS}
);

# check for invalid options, bail if we find any and print the usage output
if ( @ARGV > 0 ) {
	Box::crit(); print " Invalid option: ";
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
if ( ! $config{NOCOLOR} ) {
	if ( ! $config{LIGHTBG} ) {
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
if ( $config{help} eq 1 || $config{port} eq 0 ) {
	Help::usage();
	exit;
}

## Check we are root, otherwise we dont have enough privileges to check all the things.
if ( ! Syschecks::isRoot($BLUE, $BOLD, $ENDC) ) {
	Box::crit($RED, $BOLD, $ENDC); print "${RED}Sorry, you need to be root to run this script${ENDC}.\nExiting.\n\n";
	exit 1;
}

Box::info($BLUE, $BOLD, $ENDC); Messaging::important($config{NOINFO}, $YELLOW, $ENDC,  "Done");
