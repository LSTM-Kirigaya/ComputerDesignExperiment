# author : Yaning Li
addi    $s1,   $zero, 1
addi    $s2,   $zero, 2
lui     $zero, 0

j       jaltest
lui     $zero, 0

back:
addi    $s3,   $zero, 1
lui     $zero, 0

jaltest:
addi    $s4,   $s1,   1
j       back
addi    $s1,   $s1,   0