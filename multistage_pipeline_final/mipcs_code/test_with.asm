test_addi:
add   $s1, $0, 0
add   $s2, $0, 0
add   $s0, $0, 100
addi  $s3, $1, -100

test_addiu:
addiu $s4, $s0, -1000

test_andi:
andi  $s5, $s0, 1010

test_ori:
ori   $s1, $s2, 100

test_xori:
xori  $s5, $s2, 100

test_sltiu:
sltiu $s4, $s5, 100

test_add:
add   $s1, $s2, $s3
 
test_addu:
add   $s1, $s1, $s2

test_sub:
sub   $s1, $s2, $s3

test_subu:
subu  $s3, $s2, $s2

test_and:
and   $s4, $s5, $s2

test_or:
or    $s2, $s3, $s1

test_nor:
nor   $s2, $s3, $s4

test_xor:
xor   $s4, $s3, $s2

test_slt:
slt   $s0, $s2, $s3

test_sltu:
sltu  $s1, $s3, $s5

save_test_result:
addi  $s6, $0,  0x1001
sll   $s6, $s6, 16

sw    $s0, 0($s6)
sw    $s1, 4($s6)
sw    $s2, 8($s6)
sw    $s3, 12($s6)
sw    $s4, 16($s6)
sw    $s5, 20($s6)

addi 	$t0, $0, 0xffffffff

addi  $t1, $0,  0x1001
sll   $t1, $t1, 16

sw	$t0, 0($t1)

addi	$t1, $t1, 4

sh	$t0, 0($t1)

addi	$t1, $t1, 4

sb	$t0, 0($t1)

lw	$t2, 0($t1)

addi	$t1, $t1, 4

sw	$t2, 0($t1)		

lh	$t2, 0($t1)

addi	$t1, $t1, 4

sw	$t2, 0($t1)	

lhu	$t2, 0($t1)

addi	$t1, $t1, 4

sw	$t2, 0($t1)	

lb	$t2, 0($t1)

addi    $t1, $t1, 4

sw	$t2, 0($t1)		

lbu	$t2, 0($t1)

addi	$t1, $t1, 4

sw	$t2, 0($t1)	

lui	$t3, 0xffff

addi	$t1, $t1, 4

sw	$t2, 0($t1)	

sll	$t3, $t3, 2

addi	$t1, $t1, 4

sw	$t3, 0($t1)	

sra	$t3, $t3, 2

addi	$t1, $t1, 4

sw	$t3, 0($t1)	

srl	$t3, $t3, 2

test_j:
addi    $t2, $0, 60

addi	$t2, $t2, 60

beq     $t2, 120, test_beq

bne     $t2, 180, test_j

sw	$t3, 0($t1)

test_beq:
jal     test_jal

j       end

test_jal:
jr      $ra


end: