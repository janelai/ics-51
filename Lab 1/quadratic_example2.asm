# Ax^2 + Bx + C
# Hard code - global variables x, A, B, C
.text
.globl main

main:
# Code & Instructions defined here
    la $t0, x
    lw $t0, 0($t0)
	la $t1, A
	lw $t1, 0($t1)
	la $t2, B
	lw $t2, 0($t2)
	la $t3, C
	lw $t3, 0($t3)
	
	# Calculation
	mul $t4, $t0, $t0  # Reg[$t4] = Reg[$t0] * Reg[$t0], x^2
	mul $t4, $t4, $t1  # Reg[$t4] = Reg[$t4] * Reg[$t1], A*x^2
	
	mul $t2, $t2, $t0  # Reg[$t2] = Reg[$t2] * Reg[$t0], Bx
	add $t4, $t2, $t4  # Ax^2 + Bx
	
	add $t4, $t4, $t3  # Ax^2 + Bx + C
	
	# Print the result
	la $a0, ans
	li $v0, 4
	syscall
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
	
.data
# Global Variables defined here
x: .word 6
A: .word 3
B: .word 4
C: .word 5

ans: .asciiz "Answer: "
endl: .asciiz "\n"


