# test forward unit2
addi  $s1, $zero, 1		# s1 = 1
addi  $s2, $zero, 2		# s2 = 2
add   $s3, $s1  , $s2		# s3 = 3

sub   $s1, $zero, $s1		# s1 = -1									
sub   $s3, $s1  , $s2		# s3 = -3


addi  $s1, $zero, 30		# s1 = 30
addi  $s2, $zero, 2		# s2 = 2
mult  $s1, $s2			# {hi, lo} = 60

addi  $s1, $zero, 60		# s1 = 60
addi  $s2, $zero, 15		# s2 = 15
div   $s1, $s2			# {hi, lo} = {0, 4}


addi  $s1, $zero, 1		# s1 = 1
addi  $s1, $s1,   2		# s1 = 3
addi  $s1, $s1,   3		# s1 = 6

addi  $s1, $zero, 20		# s1 = 20
addi  $s2, $zero, 10		# s2 = 10
mult  $s1, $s2			# {hi, lo} = 200
mflo  $s1			# s1 = lo = 200
add   $s3, $s1, $s2		# s3 = s1 + s2 = 210