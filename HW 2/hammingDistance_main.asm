.include "hw2_laije.asm"

.globl main

# Data Section
.data
#str1: .asciiz "ICS51 Rules!!!"
#str2: .asciiz "ics51 rules!!!"
str1: .asciiz "0!!!"
str2: .asciiz "01!0"
strLabel1: .asciiz " hammingDistance("
comma: .asciiz ", "
strLabel2: .asciiz ") returned "
endl: .asciiz "\n"

# Program 
.text
main:

    # load the arguments
    la $a0, str1
    la $a1, str2

    # call the function
    jal hammingDistance

    # save the return values
    move $t8, $v0

    #print label
    la $a0, strLabel1
    li $v0, 4
    syscall

    #print argument value
    la $a0, str1
    syscall

    #print comma
    la $a0, comma
    syscall

    #print argument value
    la $a0, str2
    syscall

    #print label2
    la $a0, strLabel2
    syscall

    #print return value1
    move $a0, $t8
    li $v0, 1
    syscall

    #print closing 
    la $a0, endl
    li $v0, 4
    syscall
 
    #quit program
    li $v0, 10
    syscall

