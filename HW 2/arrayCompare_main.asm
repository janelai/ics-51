.include "hw2_laije.asm"

.globl main

# Data Section
.data
array1: .word -1,2,0,88
array2: .word -1,2,0,88
len: .word 4

strLabel1: .asciiz "Function returned: "
endline: .asciiz "\n"

# Program 
.text
main:

    # load the arguments
    la $a0, array1
    la $a1, array2
    la $a2, len
    lw $a2, 0($a2)

    # call the function
    jal arrayCompare

    # save the return value
    move $t8, $v0

    #print label
    la $a0, strLabel1
    li $v0, 4
    syscall

    #print return value
    move $a0, $t8
    li $v0, 1
    syscall

    #print newline
    la $a0, endline
    li $v0, 4
    syscall

    #quit program
    li $v0, 10
    syscall

