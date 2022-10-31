main:
	li $t0, 1
	li $t1, 1
	
	nor $t2, $t0, $t1
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 10
	syscall