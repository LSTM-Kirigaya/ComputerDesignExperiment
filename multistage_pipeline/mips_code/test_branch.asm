# author : Yaning Li
addi   $s1, $zero, 1
addi   $s2, $zero, 2
addi   $s3, $zero, 1
addi   $t1, $zero, 1
addi   $t1, $zero, 1
addi   $t1, $zero, 1
addi   $t1, $zero, 1
addi   $t1, $zero, 1
beq    $s1, $s2,   test1    # not
addi   $t1, $zero, 2
addi   $t1, $zero, 2
addi   $t1, $zero, 2

back1:
addi   $t1, $zero, 3
addi   $t1, $zero, 3
addi   $t1, $zero, 3
beq    $s1, $s3,   test2    # yes
addi   $t1, $zero, 3
addi   $t1, $zero, 3
addi   $t1, $zero, 3

back2:
addi   $t1, $zero, 4
addi   $t1, $zero, 4
addi   $t1, $zero, 4
bne    $s1, $s2,   test3    # yes
addi   $t1, $zero, 4
addi   $t1, $zero, 4
addi   $t1, $zero, 4

back3:
addi   $t1, $zero, 5
addi   $t1, $zero, 5
addi   $t1, $zero, 5
bne    $s1, $s3,   test4    # no
addi   $t1, $zero, 5
addi   $t1, $zero, 5
addi   $t1, $zero, 5

back4:
j end
addi   $t1, $zero, 6
addi   $t1, $zero, 6
addi   $t1, $zero, 6

test1:
addi   $s4, $s1,   1
j      back1
addi   $t1, $zero, 0
addi   $t1, $zero, 0
addi   $t1, $zero, 0


test2:
addi   $s4, $s1,   1
j      back2
addi   $t1, $zero, 0
addi   $t1, $zero, 0
addi   $t1, $zero, 0


test3:
addi   $s4, $s1,   1
j      back3
addi   $t1, $zero, 0
addi   $t1, $zero, 0
addi   $t1, $zero, 0

test4:
addi   $s4, $s1,   1
j      back4
addi   $t1, $zero, 0
addi   $t1, $zero, 0
addi   $t1, $zero, 0

end: