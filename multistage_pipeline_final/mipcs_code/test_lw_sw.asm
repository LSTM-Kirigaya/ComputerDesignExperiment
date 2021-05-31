.data
word : .word 0x8fffffff 0x6eeeeeee 0x21110000
half : .half 0x8bbb 0x6ccc 0x2111
byte : .byte 0x8a 0x7e 0x32

.text

# load base addr
lui   $at,         0x00001001
ori   $t0, $at,    0x00000000

addi  $t1, $zero,  8

lw    $s0, 0($t0)
lw    $s1, 4($t0)
lw    $s2, 8($t0)

sw    $t1, 0($t0)
sw    $t1, 4($t0)
sw    $t1, 8($t0)

# load base addr
lui   $at,         0x00001001
ori   $t0, $at,    0x0000000c

addi  $t1, $zero,  8

lh    $s0, 0($t0)
lh    $s1, 2($t0)
lh    $s2, 4($t0)

sh    $t1, 0($t0)
sh    $t1, 2($t0)
sh    $t1, 4($t0)

# load base addr
lui   $at,         0x00001001
ori   $t0, $at,    0x00000012

addi  $t1, $zero,  8

lb    $s0, 0($t0)
lb    $s1, 1($t0)
lb    $s2, 2($t0)

sb    $t1, 0($t0)
sb    $t1, 1($t0)
sb    $t1, 2($t0)
