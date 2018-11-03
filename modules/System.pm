package System;

use POSIX;

sub get_hostname {
	our $hostname = `which hostname`;
        chomp($hostname);
        if ( $hostname eq '' ) {
                print "Cannot find the 'hostname' executable.";
                exit;
        } else {
                our $servername = `$hostname -f`;
                chomp($servername);
		return $servername;
        }
}


sub get_ip {
	our $curl = `which curl`;
	chomp ($curl);
	if ( $curl eq '' ) {
		print "Cannot find the 'curl' executable.";
		exit;
	} else {
		our $ip = `$curl -s myip.dnsomatic.com`;
		return $ip;
	}
}


sub get_ram {
	my $available_mem = `LANGUAGE=en_GB.UTF-8 free | grep \"Mem:\" | awk \'{ print \$2 }\'` / 1024;
	return floor($available_mem);
}	

1;
