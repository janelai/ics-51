# Jane Lai
# laije

.data

str_total: .asciiz "Total: "
str_print: .asciiz "magnets("
str_comma: .asciiz ","
str_paren: .ascii ")"      # "nifty" - Do you know why?
str_newline: .asciiz "\n"
str_equals1: .asciiz "\nindex = 1\n"
str_gtN: .asciiz "\nindex > N\n"
str_leN: .asciiz "\nindex <= N\n"
str_totals: .asciiz "\ntotal = "
str_index_minus1: .asciiz "\nindex - 1 = "
str_index_minus1_times3: .asciiz "\n3 * (index - 1) = "
str_prevtotal: .asciiz "\nprev total = "

.text
magnets:
    ####################
    # Add prologue here
    ####################
    start:
    	addi $sp, $sp, -16  # allocate frame = 16 bytes
    	sw $a0, 4($sp)  # index
    	sw $a1, 8($sp)  # N
    	sw $a2, 12($sp)  # total
    	sw $ra, 0($sp)  # save return address
    	move $t0, $a0  # index
    	move $t1, $a1  # N
    	move $t2, $a2  # total
    	#addi $t0, $a0, 1  # calculate index+1 and save to stack
    	#li $v0, 4
    	#la $a0, str_newline
    	#syscall
    	li $v0, 4
    	la $a0, str_print
    	syscall
    	li $v0, 1
    	move $a0, $t0
    	syscall
    	li $v0, 4
    	la $a0, str_comma
    	syscall
    	li $v0, 1
    	move $a0, $t1
    	syscall
    	li $v0, 4
    	la $a0, str_comma
    	syscall
    	li $v0, 1
    	move $a0, $t2
    	syscall
    	li $v0, 4
    	la $a0, str_paren
    	syscall
    	lw $t8, 4($sp)  # index
    	lw $t9, 8($sp)  # N
    	beq $t8, 1, index_is_1
    	bgt $t8, $t9, magnets_done  # base case
    	ble $t8, $t9, index_le_N
    		

    index_is_1:
    	#li $v0, 4
    	#la $a0, str_equals1
    	#syscall
    	lw $t0, 4($sp)  # move index from stack
    	addi $t0, $t0, 1  # add 1 to it
    	sw $t0, 4($sp)  # store index back to stack
    	move $a0, $t0  # move index+1 from stack to update first arg
    	li $a2, 1
    	jal magnets
    	#lw $t0, 0($sp)
    	#addi $sp $sp, -16
    	lw $a2, 12($sp)
	lw $a1, 8($sp)
	lw $a0, 4($sp)
	lw $ra, 0($sp)
    	addi $sp, $sp, 16
    	jr $ra
    	
    index_le_N:
    	#li $v0, 4
    	#la $a0, str_leN
    	#syscall
    	lw $t0, 4($sp)  # index (working)
    	lw $t5, 4($sp)  # index (const)
    	lw $t2, 12($sp)  # prev total
    	#move $t0, $s0
    	#move $t5, $s0
    	# move $t1, $s0  # index
    	# lw $t0, 0($sp)
    	addi $t0, $t0, -1
    	add $t9, $t0, $t0
    	add $t0, $t0, $t9  # $t0 = (index-1)*3
    	#li $v0, 4
    	#la $a0, str_index_minus1_times3
    	#syscall
    	#li $v0, 1
    	#move $a0, $t0
    	#syscall
    	#li $v0, 4
    	#la $a0, str_prevtotal
    	#syscall
    	#li $v0, 1
    	#move $a0, $t2
    	#syscall
    	add $t2, $t2, $t0 # total = total+3*(index-1)
    	lw $t0, 4($sp)  # move index from stack
    	addi $t0, $t0, 1  # add 1 to it
    	sw $t0, 4($sp)  # store index back to stack
    	move $a0, $t0
    	# lw $t0, 0($sp)
    	#li $v0, 4
    	#la $a0, str_totals
    	#syscall
    	#li $v0, 1
    	#move $a0, $t2
    	#syscall
    	#sw $t0, 4($sp)
    	#sw $t5, 4($sp)
    	move $a2, $t2
    	jal start
    	#addi $sp $sp, -16
    	lw $a2, 12($sp)
	lw $a1, 8($sp)
	lw $a0, 4($sp)
	lw $ra, 0($sp)
    	addi $sp, $sp, 16
    	jr $ra
    	

magnets_done:
    	li $v0, 4
    	la $a0, str_total
    	syscall
    	li $v0, 1
    	move $a0, $t2
    	syscall
    	li $v0, 4
    	la $a0, str_newline
    	syscall
    	lw $ra, 0($sp)
	#lw $s0, 4($sp)
	#lw $s1, 8($sp)
	#lw $s2, 12($sp)
    	addi $sp $sp, 16
	jr $ra

