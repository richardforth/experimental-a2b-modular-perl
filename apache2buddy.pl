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
	'nonews' => \$config{NONEWS},
	'bbcode' => \$config{BBCODE}
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
my $NOCOLOR = $config{NOCOLOR};
my $NOINFO = $config{NOINFO};
my $NOWARN = $config{NOWARN};
my $REPORT = $config{REPORT};
my $LIGHTBG = $config{LIGHTBG};
my $NOOK = $config{NOOK};
my $NOHEADER = $config{NOHEADER};
my $NOCHKPID = $config{NOCHKPID};
my $SKIPMAXCLIENTS = $config{SKIPMAXCLIENTS};
my $SKIPPHPFATAL = $config{SKIPPHPFATAL};
my $SKIPUPDATES = $config{SKIPUPDATES};
my $NOCHKOS = $config{NOCHKOS};
my $NONEWS = $config{NONEWS};
my $BBCODE = $config{BBCODE};

############################################
#  SET UP COLOR SCHEMES                    #
############################################

our $RED;
our $GREEN;
our $YELLOW;
our $BLUE;
our $PURPLE;
our $CYAN;
our $WHITE;
our $ENDC = "\033[0m"; # reset the terminal color
our $BOLD;
our $ENDBOLD; # This is for the BBCODE [/b] tag
our $UNDERLINE;
our $ENDUNDERLINE; # This is for BBCODE [/u] tag

if ($NOCOLOR) {
	$RED = ""; # SUPPRESS COLORS
	$GREEN = ""; # SUPPRESS COLORS
	$YELLOW = ""; # SUPPRESS COLORS
	$BLUE = ""; # SUPPRESS COLORS
	$PURPLE = ""; # SUPPRESS COLORS
	$CYAN = ""; # SUPPRESS COLORS
	$WHITE = ""; # SUPPRESS COLORS
	$ENDC = ""; # SUPPRESS COLORS
	$BOLD = ""; # SUPPRESS COLORS
	$ENDBOLD = ""; # SUPPRESS COLORS
	$UNDERLINE = ""; # SUPPRESS COLORS
	$ENDUNDERLINE = ""; # SUPPRESS COLORS
} elsif ($LIGHTBG) {
	$RED = "\033[1m"; # bold all the things!
	$GREEN = "\033[1m"; # bold all the things!
	$YELLOW = "\033[1m"; # bold all the things!
	$BLUE = "\033[1m"; # bold all the things!
	$PURPLE = "\033[1m"; # bold all the things!
	$CYAN = "\033[1m";  # bold all the things!
	$WHITE = "\033[1m";  # bold all the things!
	$BOLD = "\033[1m"; # Default to ANSI codes.     
	$ENDBOLD = "\033[0m"; # Default to ANSI codes.     
	$UNDERLINE = "\033[4m"; # Default to ANSI codes.     
	$ENDUNDERLINE = "\033[0m"; # Default to ANSI codes.     
	$ENDC = "\033[0m"; # Default to ANSI codes
} elsif ($BBCODE) {
	$RED = "[color=#FF0000]"; # 
	$GREEN = "[color=#0000FF]"; # Make GREEN appear as BLUE, as green looks horrid on forums, hard to read. 
	$YELLOW = "[color=#000000]"; # Make YELLOW appear as a black default. 
	$BLUE = "[color=#0000FF]"; # 
	$PURPLE =  "[color=#000000]"; # Make PURPLE appear as a black default. 
	$CYAN =  "[color=#000000]"; # Make CYAN appear as a black default.
	$WHITE =  "[color=#000000]"; # Make WHITE appear as a black default.
	$BOLD = "[b]"; # 
	$ENDBOLD = "[/b]"; # 
	$UNDERLINE = "[u]"; # 
	$ENDUNDERLINE = "[/u]"; # 
	$ENDC = "[/color]"; # 
} else {
	$RED = "\033[91m"; # Default to ANSI codes.
	$GREEN = "\033[92m"; # Default to ANSI codes. 
	$YELLOW = "\033[93m"; # Default to ANSI codes. 
	$BLUE = "\033[94m"; # Default to ANSI codes.  
	$PURPLE = "\033[95m"; # Default to ANSI codes.     
	$CYAN = "\033[96m"; # Default to ANSI codes.     
	$WHITE = "\033[97m"; # Default to ANSI codes.     
	$BOLD = "\033[1m"; # Default to ANSI codes.     
	$ENDBOLD = "\033[0m"; # Default to ANSI codes.     
	$UNDERLINE = "\033[4m"; # Default to ANSI codes.     
	$ENDUNDERLINE = "\033[0m"; # Default to ANSI codes.     
	$ENDC = "\033[0m"; # Default to ANSI codes
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
	Box::crit($BOLD, $RED, $ENDC);
	print "${RED}Sorry, you need to be root to run this script${ENDC}.\nExiting.\n\n";
	exit 1;
}
if ( ! $NOINFO )  { 
	Box::info($BOLD, $BLUE, $ENDC);
	Messaging::important($YELLOW, $ENDC, "Done")
}
