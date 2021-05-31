# author : Yaning Li
# integate : Zhelong Huang
addi    $s1, $zero, 1       # s1 = s1 + 1    = 0x0000_0001
addi    $s2, $zero, 2       # s2 = s2 + 2    = 0x0000_0002
addi    $s1, $zero, 3       # s1 = s1 + 3    = 0x0000_0003
addi    $s2, $zero, 4       # s2 = s2 + 4    = 0x0000_0004
addiu   $s1, $zero, 5       # s1 = s1 + 5    = 0x0000_0005
addiu   $s2, $zero, 6       # s2 = s2 + 6    = 0x0000_0006
# for block
addiu   $s3, $zero, 1
addiu   $s3, $zero, 1
addiu   $s3, $zero, 1

add     $s3, $s1,   $s2     # s3 = 5 + 6     = 0x0000_000b
addu    $s3, $s1,   $s2     # s3 = 5 + 6     = 0x0000_000b
sub     $s3, $s2,   $s1     # s3 = 6 - 5     = 0x0000_0001
subu    $s3, $s2,   $s1     # s3 = 6 - 5     = 0x0000_0001
and     $s3, $s1,   $s2     # s3 = 5 & 6     = 0x0000_0004
or      $s3, $s1,   $s2     # s3 = 5 | 6     = 0x0000_0007
nor     $s3, $s1,   $s2     # s3 = ~(5 | 6)  = 0xffff_fff8
xor     $s3, $s1,   $s2     # s3 = 5 ^ 6     = 0x0000_0003
slt     $s3, $s1,   $s2     # s3 = (s1 < s2) = 0x0000_0001
slt     $s3, $s2,   $s1     # s3 = (s2 < s1) = 0x0000_0000
sltu    $s3, $s1,   $s2     # s3 = (s1 < s2) = 0x0000_0001
sltu    $s3, $s2,   $s1     # s3 = (s2 < s1) = 0x0000_0000

andi    $s3, $s1,   3       # s3 = s1 & 3    = 0x0000_0001
ori     $s3, $s1,   2       # s3 = s1 | 2    = 0x0000_0007
xori    $s3, $s2,   3       # s3 = s2 ^ 3    = 0x0000_0005
slti    $s3, $s2,   1       # s3 = (s2 < 1)  = 0x0000_0000
sltiu   $s3, $s2,   9       # s3 = (s2 < 9)  = 0x0000_0001
sll     $s3, $s1,   2       # s3 = s1 << 2   = 0x0000_0014
srl     $s3, $s2,   1       # s3 = s2 >> 1   = 0x0000_0003

lui     $s4, 32768          # s4 = {32768, {161'b0}} = 0x8000_0000
lui     $s4, 32768
lui     $s4, 32768
lui     $s4, 32768

sra     $s3, $s4,   4       # s3 = s4 >> 4   = 0xf800_0000

sllv 	$s3, $s2, $s1	    # s3 = GPR[s2] << GPR[s1]
srlv    $s3, $s2, $s1
srav	$s3, $s2, $s1

mult    $s1, $s2
multu   $s1, $s2
div     $s2, $s1
divu    $s2, $s1

mthi    $s1
mtlo    $s2
mfhi    $s3
mflo    $s3
