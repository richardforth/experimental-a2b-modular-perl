package SystemFacts;

my %system_facts;

require System;

$system_facts{ip_address} = System::get_ip();
$system_facts{hostname} = System::get_hostname();
$system_facts{availableram} = System::get_ram();

sub getFacts {
	return %system_facts;
}

1;
