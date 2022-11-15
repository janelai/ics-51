.include "lab4_D_netid.asm"

.globl main
.text
main:


	la $a0, myList
	la $a1, length
    lw $a1, 0($a1)
	jal printMovieList

    li $v0, 11
    li $a0, '\n'
    syscall

  	la $a0, myList
	la $a1, length
    lw $a1, 0($a1)
    li $a2, 1     # The Godfather
    li $a3, 30
    addi $sp, $sp, -4
    li $t0, 10
    sw $t0, 0($sp)
    jal changeVotes

	la $a0, myList
	la $a1, length
    lw $a1, 0($a1)
	jal printMovieList

	li $v0, 10
	syscall

.data
myList: .word title0, 0x0011007F, 0x00000794
        .word title1, 0x00000046, 0x000307B4
        .word title2, 0x36B70043, 0x000207E6
        
length: .word 3

title0: .asciiz "Fantasia"
title1: .asciiz "The Godfather"
title2: .asciiz "Morbius"


