# test forward1 and left branch command
f1:
addi   $s1, $zero, 1
addi   $s2, $zero, 1
addi   $s3, $zero, 0
beq    $s1, $s2,   f3	# branch to f3

f2:
addi   $s1, $zero, -2
addi   $s3, $zero, 0
bltz   $s1, f4


f3:
addi   $s1, $zero, 1
addi   $s2, $zero, 2
addi   $s3, $zero, 0
bne    $s1, $s2,   f2

f4:
addi   $s1, $zero, -1
addi   $s3, $zero, 0
bltzal $s1, f5

final:
jr     $ra		# to f6

f5:
addi   $s1, $zero, -1
addi   $s3, $zero, 0
bgez   $s1, end		# no jump
addi   $s1, $zero, 1
addi   $s3, $zero, 0
blez   $s1, end		# no jump
bgtz   $s1, f6

j      end			# no exetable

f6:
addi   $s1, $zero, 1
addi   $s3, $zero, 0
bgezal $s1, final

end: