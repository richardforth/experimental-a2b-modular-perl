#!/usr/bin/perl

eval "use diagnostics; 1"  or die("\n[ FATAL ] Could not load the Diagnostics module.\n\nTry:\n\n      sudo apt-get install perl-modules\n\nThen try running this script again.\n\n");
use Getopt::Long qw(:config no_ignore_case bundling pass_through);
use strict;
use warnings;

# Import modules for use here
use lib 'modules';
require Syschecks;

if ( ! Syschecks::isRoot() ) {
	print "Sorry, you need to be root to run this script.\nExiting.\n\n";
	exit 1;
}

print "So far so good...\n\n";

print "Done";
