.include "lab3_A_netid.asm"
.include "lab3_functions.asm"

.data 
str: .asciiz "Pacman loses wah-wah :("   # Lose on '-'
ghost_str: .asciiz "boo-boo"
pellet_str: .asciiz "m:"

num_ghosts: .asciiz "NumGhostsEaten: "
num_pellets: .asciiz "NumPelletsRemaining: "
lose_str: .asciiz "YOU LOSE!\n"
newline: .asciiz "\n"

.globl main
.text
main:
    la $a0, str
	la $a1, ghost_str
	la $a2, pellet_str
	li $a3, 0
	jal pacmanEatsString

	move $t9, $v0
	move $t8, $v1

	li $v0, 4
	la $a0, num_ghosts
	syscall

	li $v0, 1
	move $a0, $t9
	syscall

    li $v0, 4
    la $a0, newline
    syscall

	bltz $t8, lost

	li $v0, 4
	la $a0, num_pellets
	syscall

	li $v0, 1
	move $a0, $t8
	syscall

    li $v0, 4
    la $a0, newline
    syscall
	j end

lost:

    li $v0, 4
    la $a0, lose_str
    syscall
end:
	li $v0, 10
	syscall
