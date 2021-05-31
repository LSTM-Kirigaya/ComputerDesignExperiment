addi $s1,$zero,1
addi $s2,$zero,2
jal  test1
addi $s3,$zero,1
j end

test1:
addi $s4,$s1,1
jr   $ra

end: