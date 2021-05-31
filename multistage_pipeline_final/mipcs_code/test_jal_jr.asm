addi $s1,$zero,1
addi $s2,$zero,2
lui $zero,0
lui $zero,0
lui $zero,0
lui $zero,0
lui $zero,0
jal test1
lui $zero,0
lui $zero,0
lui $zero,0
addi $s3,$zero,1
lui $zero,0
lui $zero,0
lui $zero,0
j end
lui $zero,0
lui $zero,0
lui $zero,0

test1:
addi $s4,$s1,1
jr $ra
lui $zero,0
lui $zero,0
lui $zero,0

end: