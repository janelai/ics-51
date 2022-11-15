# Jane Lai
# laije

.data
err_string: .asciiz "Array does not contain any values\n"

.text
findStats:

	li $s1, 0  # $s1 = counter for evens
	li $s2, 0  # $s2 = counter for negs
	li $s3, 2  # $s3 = evens modulo check
	li $s4, 0  # $s4 = counter
	move $s0, $a0  # $s0 = nums array
	
	beq $a1, $zero, emptyArray
	
	check:
		beq $s4, $a1, done  # $a1 = size of array
		
		sll $t1, $s4, 2
		add $t1, $t1, $s0
		lw $t0, ($t1)
		
		blt $t0, $zero, incrementNegs
		continue1:
		div $t0, $s3
		mfhi $t2  # move remainder from hi register
		beq $t2, $zero, incrementEvens
		continue2:
		
		addi $s4, $s4, 1 # increment counter
		
		j check
	
	incrementEvens:
		addi $s1, $s1, 1
		j continue2
	incrementNegs:
		addi $s2, $s2, 1
		j continue1
		
	emptyArray:
		li $s1, -1
		li $s2, -1
		j done
	done:
		# (evens, negs)
		move $v0, $s1
		move $v1, $s2
		jr $ra
	
