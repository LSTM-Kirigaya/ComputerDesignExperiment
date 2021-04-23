# data
.data
v : .word 4 3 1 6 2 5           # v is the beginning of a array, whose storage type is a word(four bytes)
    
# code
.text
.globl main
# main parameter:
# $s0 -> v
# $s1 -> n
# $s2 -> i
# $s3 -> j

main:
    la      $s0, v                  # assign base address of v to $a0 (first parameter) 
    addiu   $s1, $zero, 6           # assign 6 to the second parameter, which means the number of the array v
    addi    $s2, $zero, 0           # int i = 0, save i to $s2 and j to $s3

loop1:          # first layer of loop
    slt     $t0, $s2,   $s1         # t0 == 1 if $s2(i) < $s1(n) else t0 == 0
    beq     $t0, $zero, skip1       # if t0 == 0, which means i >= n, we skip out loop1
    addi    $s3, $zero, 0           # int j = 0

loop2:          # second layer of loop
    sub     $t0, $s1,   $s2   
    addi    $t1, $zero, 1
    sub     $t0, $t0,   $t1         # save n - i - 1 to $t0
    slt     $t1, $s3,   $t0         # t1 == 1 if $s3(j) < $t0(n - i - 1) else t1 == 0
    beq     $t1, $zero, skip2       # if t1 == 0, which means j >= n - i - 1, we skip out loop2

    sll     $t2, $s3,   2           # base address shamt of v[j]
    add     $t2, $s0,   $t2	     # base address of v[j]
    lw      $t0, 0($t2)             # v[j]
    lw      $t1, 4($t2)             # v[j + 1]
    slt     $t3, $t1, $t0           # t3 == 1 if $t1(v[j + 1]) < $t0(v[j]) else t3 == 0
    beq     $t3, $zero, continue    # if t3 == 0, we don't need to do the swap, continue
    add     $t4, $t0, $zero         # temp = a[j]
    add     $t0, $t1, $zero         # a[j] = a[j + 1]
    add     $t1, $t4, $zero         # a[j + 1] = temp
    sw      $t0, 0($t2)
    sw      $t1, 4($t2)

continue:
    addi    $s3, $s3,  1            # j ++
    j       loop2

skip2:          # skip out loop2
    addi    $s2, $s2,  1            # i ++
    j       loop1

skip1:          # skip out loop1
    