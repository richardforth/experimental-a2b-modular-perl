package ColorSchemes;

my %nocolor = (
	RED => "",
	GREEN => "",
	YELLOW => "",
	BLUE => "",
	PURPLE => "",
	CYAN => "",
	WHITE => "",
	ENDC => "",
	BOLD => "",
	ENDBOLD => "",
	UNDERLINE => "",
	ENDUNDERLINE => ""
);

my %light = (
	RED => "\033[1m",
	GREEN => "\033[1m",
	YELLOW => "\033[1m",
	BLUE => "\033[1m",
	PURPLE => "\033[1m",
	CYAN => "\033[1m",
	WHITE => "\033[1m",
	BOLD => "\033[1m",
	ENDBOLD => "\033[0m",
	UNDERLINE => "\033[4m",
	ENDUNDERLINE => "\033[0m",
	ENDC => "\033[0m"
);

my %bbcode = (
	RED => "[color=#FF0000]",
	GREEN => "[color=#0000FF]",
	YELLOW => "[color=#000000]",
	BLUE => "[color=#0000FF]",
	PURPLE =>  "[color=#000000]",
	CYAN =>  "[color=#000000]",
	WHITE =>  "[color=#000000]",
	BOLD => "[b]",
	ENDBOLD => "[/b]",
	UNDERLINE => "[u]",
	ENDUNDERLINE => "[/u]",
	ENDC => "[/color]"
);

my %ansi = (
	RED => "\033[91m",
	GREEN => "\033[92m",
	YELLOW => "\033[93m",
	BLUE => "\033[94m",
	PURPLE => "\033[95m",
	CYAN => "\033[96m",
	WHITE => "\033[97m",
	BOLD => "\033[1m",
	ENDBOLD => "\033[0m",
	UNDERLINE => "\033[4m",
	ENDUNDERLINE => "\033[0m",
	ENDC => "\033[0m"
);

sub getNone {
	return %nocolor;
}

sub getBBCode {
	return %bbcode;
}

sub getLight {
	return %bbcode;
}

sub getAnsi {
	return %ansi;
}

1;
