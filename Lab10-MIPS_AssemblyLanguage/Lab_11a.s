          .data
msg:      .asciiz ","


          .text
          .globl main
main:      li $v0, 5                  
           syscall                 #take n
           addi $a3,$v0,0
           addi $s0,$v0,0
           sll $t0,$a3,2
           li $v0, 9           # syscall code for sbrk (allocate heap memory)
           addi $a0,$t0,1
           syscall
           move $a1, $v0       #a1 is starting address of array(n+1 bytes) that stores the n fibonnaci numbers
           beq $a3,1,basecase1
           beq $a3,2,basecase2   
label:     addi $sp,$sp,-4
           sw $ra,0($sp)
           addi $sp,$sp,-4
           sw $a3,0($sp)        #store current n
           addi $a3,$a3,-1
           jal fib              #compute fib(n-1)
           sll $t0,$a3,2
           add $a1,$a1,$t0
           sw $v0,0($a1)         #store in array
           sub $a1,$a1,$t0
           addi $a3,$a3,-1
           jal fib              #compute fib(n-2)
           sll $t0,$a3,2
           add $a1,$a1,$t0
           sw $v0,0($a1)         #store in array
           sub $a1,$a1,$t0
           lw $a3,0($sp)         # add fib(n-1) and fib(n-2)
           addi $a3,$a3,-1
           sll $t6,$a3,2
           add $a1,$a1,$t6
           lw $t8,0($a1)
           add $t9,$0,$t8
           addi $a1,$a1,-4
           lw $t8,0($a1)
           add $t9,$t9,$t8
           addi $a1,$a1,8
           sw $t9,0($a1)        #store in array
           move $v0,$t9
           addi $a1,$a1,-4
           sub $a1,$a1,$t6
           addi $a3,$a3,1
           beq $a3,$s0,print    #if nth fibonnaci is calculated start printing
           lw $ra,4($sp)
           addi $sp,$sp,8
           jr $ra
fib:       li $t0,1
           li $t1,2
           beq $a3,$t0,basecase     #base case
           beq $a3,$t1,basecase     #base case
           j label
basecase:  li $v0,1
           jr $ra
print:     li $t5,0
loop:      addi $a1,$a1,4
           addi $t5,$t5,1
           li $v0,1
           lw $a0,0($a1)
           syscall
           beq $t5,$s0,exit         #if last number is printed don't print comma
           li $v0,4
           la $a0,msg
           syscall
           j loop
basecase1: li $v0,1
           addi $a0,$0,1
           syscall
           jr $ra
basecase2: li $v0,1
           addi $a0,$0,1
           syscall
           li $v0,4
           la $a0,msg
           syscall
           li $v0,1
           addi $a0,$0,1
           syscall
           jr $ra
exit:      lw $ra,4($sp)
           addi $sp,$sp,8
           jr $ra
