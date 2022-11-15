.include "lab3_C_laije.asm"

.globl main
.text
main:

    # load the argument registers
    li $a0, 1  # index 
    li $a1, 5  # N
    li $a2, 0  # total

    # call the function
    li $s0, 55
    jal magnets

    # Exit the program
    li $v0, 10
    syscall

