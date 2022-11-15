.include "hw2_netid.asm"   # change netid

.globl main

.data
myStr: .asciiz "EbB"
src_str: .asciiz "str: "
function_str: .asciiz "Function Returns: "
end_str: .asciiz "\n"

.text
main:
    li $v0, 4
    la $a0, src_str
    syscall

    la $a0, myStr
    syscall

    li $v0, 11
    li $a0, '\n'
    syscall

    # load argument and call function
    la $a0, myStr	# address of src
    jal charApperance

    # save the return values
    move $t0, $v0 

    #print out the return values
    li $v0, 4
    la $a0, function_str
    syscall

    move $a0, $t0   
    li $v0, 1
    syscall

	li $a0, ' '
	li $v0, 11
	syscall

	move $a0, $t0
    li $v0, 35
    syscall

    li $v0, 4
    la $a0, end_str
    syscall

	# check the modified dst array values in the memory - or write loop here to print out the array

    li $v0, 10
    syscall
