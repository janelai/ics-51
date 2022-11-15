.include "lab4_B_netid.asm"

.globl main
.text
main:


	la $a0, myarray
	la $a1, numRows
    lw $a1, 0($a1)
	la $a2, numCols
    lw $a2, 0($a2)
	la $a3, k
    lw $a3, 0($a3)
	jal colSum  

    # save the return value
    move $s0, $v0
    
    # print string
    li $v0, 4
    la $a0, sum_str
    syscall

    # print return value
    li $v0, 1
    move $a0, $s0
    syscall

    # print newline
    li $v0, 4
    la $a0, newline
    syscall


	li $v0, 10
	syscall

.data
myarray: .word 10,20,30,40,50,60,70,80,90,100
         .word 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010

#set to [2][10], try [4][5], [5][4], [4][4], [2][4]
# or any combination of row*cols less than 20 for the given array
numRows: .word 5
numCols: .word 4
k: .word  3

sum_str: .asciiz "Sum of column 3 is "
newline: .asciiz "\n"
