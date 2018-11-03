package Math

sub round {
	my ( $value ) = @_;

	# add five thousandths
	$value = $value + 0.005;

	# truncate the result
	$value = sprintf("%.2f", $value);
	return $value;
}	


1;
