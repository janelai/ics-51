.include "hw2_netid.asm"

.globl main

# Data Section
.data
array: .word -1,-1,-1,-1,-1
n: .word 5

str: .asciiz "University of California Irvine"
delim: .ascii " "

strLabel1: .asciiz "The # of tokens is "
strLabel2: .asciiz "\nThe status is "
newline: .asciiz "\n"


# Program 
.text
main:
    # load the value into the argument register
    la $a0, array
    la $a1, n
    lw $a1, 0($a1)
    la $a2, str
    la $a3, delim
    lb $a3, 0($a3)

    # call the function
    jal splitString

    # save the return values
    move $t9, $v0
    move $t8, $v1

    # print string
    li $v0, 4
    la $a0, strLabel1
    syscall

    # print return value
    li $v0, 1
    move $a0, $t9
    syscall

    # print string
    li $v0, 4
    la $a0, strLabel2
    syscall

    # print return value
    li $v0, 1
    move $a0, $t8
    syscall

    # print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Add a loop here to printout each of the strings at the address stored in array
    # or examine the MARS memory for str for correctness

    # Exit the program
    li $v0, 10
    syscall
