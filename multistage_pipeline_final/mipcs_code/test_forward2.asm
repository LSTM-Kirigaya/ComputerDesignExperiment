# test forward unit2
addi  $s1, $zero, 1		# s1 = 1
addi  $s2, $zero, 2		# s2 = 2
add   $s3, $s1  , $s2		# s3 = 3

sub   $s1, $zero, $s1		# s1 = -1									
sub   $s3, $s1  , $s2		# s3 = -3
