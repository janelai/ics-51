.include "lab4_C_netid.asm"

.globl main
.text
main:


	la $a0, myarray
	la $a1, numRows
    lw $a1, 0($a1)
	la $a2, numCols
    lw $a2, 0($a2)
	la $a3, r1
    lw $a3, 0($a3)

	la $t0, c1
    lw $t0, 0($t0)
	la $t1, r2
    lw $t1, 0($t1)
	la $t2, c2
    lw $t2, 0($t2)

	addi $sp, $sp, -12
	sw $t0, 8($sp)
	sw $t1, 4($sp)
	sw $t2, 0($sp)
	jal diff  
	
	move $a0, $v0
	li $v0, 1
	syscall

	# move stack back
    addi $sp, $sp, 12

	li $v0, 10
	syscall

.data
myarray: .word 10,20,30,40,50,60,70,80,90,100, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010

#set to [2][10], try [4][5], [5][4], [4][4], [2][4]
# or any combination of row*cols less than 20 for the given array
numRows: .word 5
numCols: .word 4

r1: .word 2  
c1: .word 1
r2: .word 4 
c2: .word 0
