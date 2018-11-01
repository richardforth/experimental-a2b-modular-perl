package Help;

## print usage
sub usage {
	our $usage_output = <<'END_USAGE';
Usage: apache2buddy.pl [OPTIONS]
If no options are specified, the basic tests will be run.
	-h, --help		     Print this help message
	-p, --port=PORT		     Specify an alternate port to check (default: 80)
	    --pid=PID		     Specify a PID to bypass the "Multiple PIDS listening on port 80" error.
	-v, --verbose		     Use verbose output (this is very noisy, only useful for debugging)
	-H, --noheader		     Do not show header title bar.
	-N, --noinfo		     Do not show informational messages.
	-K, --no-ok	 	     Do not show OK messages.
	-W, --nowarn		     Do not show warning messages.
	-r, --report		     Implies -HNWK or --noinfo --nowarn --no-ok --noheader --skip-maxclients --skip-php-fatal --skip-updates
	-P, --no-check-pid	     DON'T Check the Parent Pid File Size (only use if desperate for more info, results may be skewed).
	    --skip-maxclients	     Skip checking in maxclients was hit recently, can be slow, especialy if you have large log files.
            --skip-php-fatal         Skip checking for PHP FATAL errors, can be slow, especialy if you have large log files.
            --skip-updates           Skip checking for package updates, can be slow or problematic, causing the script to hang.
	-O, --skip-os-version-check  Skips past the OS version check.
                                     Allows one to bypass EOL version showstopper but be mindful:
                                      skipping the os version check is not recommended as features may be 
                                      deprecated or removed and apache2buddy is not backward compatible 
                                      with end of life operating systems, this may cause errors and unpredictable 
                                      behaviour.
Key:
    [ -- ]  = Information
    [ @@ ]  = Advisory
    [ >> ]  = Warning
    [ !! ]  = Critical
END_USAGE

	print $usage_output;
}

1;
