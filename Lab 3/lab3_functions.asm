# DO NOT MODIFY THIS FILE
# TREAT THIS FILE AS A BLACK BOX. ASSUME YOU DO NOT SEE THIS CODE
.data 
stats_label1: .asciiz "Pacman has eaten "
stats_label2: .asciiz " strings & "
stats_label3: .asciiz " ghosts.\n"



.text
printStats:
	move $t0, $a0
	move $t1, $a1
	li $t3, 4
	li $t4, 1

	la $t2, stats_label1
	move $v0, $t3
	move $a0, $t2
	syscall	

	move $a0, $t0
	move $v0, $t4	
	syscall

	la $t5, stats_label2
	move $v0, $t3
	move $a0, $t5
	syscall

	move $a0, $t1
	move $v0, $t4	
	syscall

	la $t6, stats_label3
	move $v0, $t3
	move $a0, $t6
	syscall

	jr $ra

#################################################

inString:
	li $v0, 0
	move $t6, $a0
	move $a0, $a1
inString_loop:
	lb $t8, 0($a0)
	beq $0, $t8, inString_done
	move $t7, $t8
	beq $t6, $t7, inString_found
	addi $a0, $a0, 1
	j inString_loop
inString_found:
	li $v0, 1
inString_done:
	jr $ra	
