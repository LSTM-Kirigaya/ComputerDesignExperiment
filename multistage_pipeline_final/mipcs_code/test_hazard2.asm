# test  Hazard Detection Unit2, which is mainly load-use

addi  $t0, $zero, 0x1001     # addr
sll   $t0, $t0, 16
addi  $s1, $zero, 1000       # s1 = 0x3e8
addi  $s2, $zero, 8          # s2 = 8

sw    $s1, 0($t0)
addi  $s1, $zero, 12	     # s1 = 12
lw    $s1, 0($t0)	         # s1 = 0x3e8
srlv  $s3, $s1, $s2	         # s3 = 0x3