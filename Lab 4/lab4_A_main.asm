.include "lab4_A_netid.asm"

.globl main
.text
main:

    # load the argument registers
    la $a0, myarray
    la $a1, rows
    lw $a1, 0($a1)
    la $a2, cols
    lw $a2, 0($a2)

    # call the function
    jal LgstPwr2

    # save the return value
    move $s0, $v0
    move $s1, $v1

    # print string
    li $v0, 4
    la $a0, position_str
    syscall

    # print return value
    li $v0, 1
    move $a0, $s0
    syscall

    # print string
    li $v0, 4
    la $a0, comma
    syscall

    # print return value
    li $v0, 1
    move $a0, $s1
    syscall

    # print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit the program
    li $v0, 10
    syscall

.data

#set to [2][10], try [4][5], [5][4], [4][4], [2][4]
# or any combination of row*cols less than 20 for the given array
rows: .word 2
cols: .word 10

# only integers are accessible for (row*col) == 20
myarray: .word 10, 45, 120, 54, 16, 73, 100, 11, 235, 45, 99, 84, 300, 2, 14, 67, 25, 128, 64, 12 
#  junk numbers in space after array. Should never touch!!
         .word 0xBEEFCAFE, 0xBEEFCAFE, 0xBEEFCAFE, 0xBEEFCAFE, 0xBEEFCAFE, 0xBEEFCAFE 

position_str: .asciiz "Max Power of 2 value found at position: "
comma: .asciiz ", "
newline: .asciiz "\n"
