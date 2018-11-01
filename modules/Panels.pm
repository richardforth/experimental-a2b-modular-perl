package Panels;

my %panels;

$panels{cpanel} = 0;
$panels{cpanel_version} = 0;
$panels{cpanel} = 1 if -d "/usr/local/cpanel";
if ($panela{cpanel}) {
	$panels{cpanel_version} = `cat /usr/local/cpanel/version` if (-f "/usr/local/cpanel/version");
}

$panels{plesk} = 0;
$panels{plesk_version} = 0;
$panels{plesk} = 1 if -d "/usr/local/psa";
if ($panela{plesk}) {
	$panels{plesk_version} = `cat /usr/local/psa/version` if (-f "/usr/local/psa/version");
}

$panels{virtualmin} = 0;
$panels{virtualmin_version} = 0;
$panels{virtualmin} = 1 if -f "/usr/sbin/virtualmin";
if ($panela{virtualmin}) {
	$panels{virtual_version} = `/usr/sbin/virtualmin info | grep "virtualmin version" | awk -F":" '{ print \$2}'` if (-f "/usr/sbin/virtualmin");
}

sub getPanels {
	return %panels;
}

1;
