.include "lab2_A_laije.asm"  # Change this to your file

.data
#nums: .word  -1, -11, 66, 100, 22, 20, -1    # Modify this to test other cases
#N: .word 7 # Modify this to test other cases
nums: .word  -3, -4, -7, -200    # Modify this to test other cases
N: .word 4 # Modify this to test other cases
  
#endl: .asciiz "\n"
return_string: .asciiz "Return values ("
comma_string: .asciiz ", "
end_string: .asciiz ")\n"

.globl main
.text
main:

    	# load the argument registers
    	la $a0, nums   
	la $a1, N
	lw $a1, 0($a1)
	
    	# call the function
    	jal findStats

	# save the return value (to call syscalls)
	move $t0, $v0

    	# print string
    	li $v0, 4
    	la $a0, return_string
    	syscall

    	# print string
    	li $v0, 1
    	move $a0, $t0
    	syscall


    # print string
    li $v0, 4
    la $a0, comma_string
    syscall
  
    # print return value
    move $a0, $v1
    li $v0, 1
    syscall

    # print string
    li $v0, 4
    la $a0, end_string
    syscall
    
    # Exit the program
    li $v0, 10
    syscall
