# TREAT THIS FILE AS A BLACK BOX. ASSUME YOU DO NOT SEE THIS CODE

.text

max:                 
	move $v0, $a0
	bge $a0, $a1, _max_end
	move $v0, $a1
_max_end:
    jr $ra

jobSwap:
    beqz $a1, _jobSwap_end
	bltz $a2, _jobSwap_end
	bltz $a3, _jobSwap_end
	bge $a2, $a1, _jobSwap_end
	bge $a3, $a1, _jobSwap_end

	sll $a2, $a2, 2  
	sll $a3, $a3, 2  
	add $a2, $a0, $a2
	add $a3, $a0, $a3
	lw $a0, ($a2)
	lw $a1, ($a3)
	sw $a1, ($a2)
	sw $a0, ($a3)
_jobSwap_end:
	jr $ra


jobCompare:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a1, 4($sp)
	sw $s0, 8($sp)
	
	jal getJobTimes 
	move $s0, $v1

	lw $a0, 4($sp)
	jal getJobTimes
	move $t1, $v1
	li $v0, 0
	bge $s0, $t1, _jobCompare_end
	li $v0, 1
_jobCompare_end:
	lw $ra, 0($sp)
	lw $s0, 8($sp)
	addi $sp, $sp, 12
	jr $ra


lastNonConflictJob:
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)

	move $s2, $a0
	addi $s0, $a1, -1   
	sll $a0, $s0, 2     
	add $a0, $s2, $a0
	lw $a0, 0($a0)
	jal getJobTimes
	move $s1, $v0     
_lastNonConflictJob_loop:
	bltz $s0, _lastNonConflictJob_loop_done
	sll $a0, $s0, 2     
	add $a0, $s2, $a0
	lw $a0, 0($a0)
	jal getJobTimes
	blt $v1, $s1, _lastNonConflictJob_loop_done2
	addi $s0, $s0, -1
	j _lastNonConflictJob_loop
_lastNonConflictJob_loop_done:
	li $v0, -1
	j _lastNonConflictJob
_lastNonConflictJob_loop_done2:
	move $v0, $s0
	
_lastNonConflictJob:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16
	jr $ra
