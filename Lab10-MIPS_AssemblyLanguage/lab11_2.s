.data
arraya: .space 60
arrayb: .space 60

.text
.globl main
main:      li $v0,5
           syscall
           move $s0,$v0
           move $a0,$v0
           addi $s0,$s0,-1
           addi $t0,$0,0
           addi $t3,$0,0
           la $a2,arraya
           la $a3,arrayb
loop:      addi $t0,$t0,1
           li $v0,6
           syscall
           swc1 $f0,0($a2)
           addi $a2,$a2,4
           beq $t0,$a0,nextloop
           j loop
nextloop:  addi $t3,$t3,1
           li $v0,6
           syscall
           swc1 $f0,0($a3)
           addi $a3,$a3,4
           beq $t3,$a0,multiply
           j nextloop
multiply:  addi $t0,$0,0
           la $a2,arraya
           lwc1 $f1,0($a2)
           la $a3,arrayb
           lwc1 $f2,0($a3)
           addi $a2,$a2,4
           addi $a3,$a3,4
           mul.s $f3,$f1,$f2
           beq $a0,1,print
loop2:     addi $t0,$t0,1
           lwc1 $f1,0($a2)
           addi $a2,$a2,4
           lwc1 $f2,0($a3)
           addi $a3,$a3,4
           mul.s $f4,$f1,$f2
           add.s $f3,$f3,$f4
           beq $t0,$s0,print
           j loop2
print:     li $v0,2
           mov.s $f12,$f3
           syscall
           jr $ra
           
