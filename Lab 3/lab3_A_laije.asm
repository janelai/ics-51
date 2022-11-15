# Jane Lai
# laije

.data
ate_ghost: .asciiz "GHOST! "
ate_pellet: .asciiz "PELLET! "
ate_ghostkill: .asciiz "GHOST KILL! "
ate_str: .asciiz "Ate "
ate_newline: .asciiz "\n"
ag: .asciiz "add ghost"
str_letter: .asciiz "\nstr letter (MOST IMPORTANT JKDSFHKKSKDFJHSDKAF): "
ghost_letter: .asciiz "ghost letter: "
pellet_letter: .asciiz "pellet letter: "
ie: .asciiz "now if else\n"
one: .asciiz "\n(eatPellet == 1), numPellets++, print(\"PELLET!\")\n"
two: .asciiz "\n(eatGhost == 1 && numPellets > 0), numPellets--, ghosts_eaten++, print(\"GHOST!\")\n"
three: .asciiz "\n(eatGhost == 1), print(\"GHOST KILL!\")\n"
numpellets: .asciiz "num pellets: "
ghostseaten: .asciiz "ghosts eaten: "

.text
pacmanEatsString:

	addi $sp $sp, -12  # allocate 12 bytes for 3 params
	#sw $a0, 0($sp)  # str
	#sw $a1, 4($sp)  # ghost_str
	#sw $a2, 8($sp)  # pellet_str
	sw $a3, ($sp)  # numpellets
	sw $s1, 4($sp)  # prev $s1
	sw $s2, 8($sp)  # prev $s2
	move $t7, $a0  # str
	move $s1, $a1
	move $t8, $a1  # ghost_str
	move $s2, $a2
	move $t9, $a2  # pellet_str
	
	li $t3, 0  # ghosts_eaten
	li $t4, 0  # eatghost
	li $t5, 0  # eatpellet

	traverse_str:
		lb $t0, ($t7)  # for each letter in str
		#li $v0, 4
		#la $a0, str_letter
		#syscall
		#li $v0, 11
		#move $a0, $t0
		#syscall
		#li $v0, 4
		#la $a0, ate_newline
		#syscall
		beq $t0, '\0', end_traverse  # if str ends, break
		traverse_ghost:
			move $t8, $s1
			continue_ghost:
			lb $t1, ($t8)  # for each letter in ghost_str
			#li $v0, 4
			#la $a0, ghost_letter
			#syscall
			#li $v0, 11
			#move $a0, $t1
			#syscall
			#li $v0, 4
			#la $a0, ate_newline
			#syscall
			beq $t1, '\0', end_ghost  # if ghost_str ends, break
			beq $t1, $t0, add_ghost  # $t0 = letter in str
			addi $t8, $t8, 1
			j continue_ghost
			add_ghost:
				#li $v0, 4
				#la $a0, ag
				#syscall
				addi $t4, $t4, 1
				j end_ghost
		end_ghost:
		
		traverse_pellets:  # for each letter in ghost_str
			move $t9, $s2
			continue_pellets:
			lb $t2, ($t9)  # if ghost_str ends, break
			#li $v0, 4
			#la $a0, pellet_letter
			#syscall
			#li $v0, 11
			#move $a0, $t2
			#syscall
			#li $v0, 4
			#la $a0, ate_newline
			#syscall
			beq $t2, '\0', end_pellets
			beq $t2, $t0, add_pellets
			addi $t9, $t9, 1
			j continue_pellets
			add_pellets:
				addi $t5, $t5, 1
				j end_pellets
		end_pellets:
		bge $t4, 1, fix_ghost
		bge $t5, 1, fix_pellets
		j if_else
		
		fix_ghost:
			li $t4, 1
			j if_else
		fix_pellets:
			li $t5, 1
			j if_else
		
		# if else conditions
		if_else:
		beq $t5, 1, if_pellets  # if (eatPellet == 1), numPellets++
		beq $t4, 1, if_if  # if (eatGhost == 1 && numPellets > 0), numPellets--, ghosts_eaten++;
		not_both:
		beq $t4, 1, if_ghost  # if (eatGhost == 1), return
		done:
		li $v0, 4
		la $a0, ate_str
		syscall
		li $v0, 11
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, ate_newline
		syscall
		j continue
		
		if_pellets:
		li $v0, 4
		la $a0, one
		syscall
		#li $v0, 4
		#la $a0, numpellets
		#syscall
		#li $v0, 1
		#lw $a0, ($sp)
		#syscall
		lw $t6, ($sp)  # numpellets++
		addi $t6, $t6, 1
		sw $t6, ($sp)
		li $v0, 4
		la $a0, ate_pellet  # print pellet
		syscall
		j done
		
		if_if:
		lw $t6, ($sp)
		bgt $t6, $zero, if_both
		j not_both
		
		if_both:
		li $v0, 4
		la $a0, two
		syscall
		addi $t6, $t6, -1  # numpellets--
		sw $t6, ($sp)
		addi $t3, $t3, 1  # ghosts_eaten++
		li $v0, 4
		la $a0, ate_ghost  # print ghost
		syscall
		j done
		
		if_ghost:
		li $v0, 4
		la $a0, three
		syscall
		li $v0, 4
		la $a0, ate_ghostkill
		syscall
		li $v0, 4
		la $a0, ate_str  # print ate
		syscall
		li $v0, 11
		move $a0, $t0 # print char
		syscall
		li $v0, 4
		la $a0, ate_newline
		syscall
		move $v0, $t3
		li $v1, -1
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		addi $sp, $sp, 12
		jr $ra
		
		continue:
		li $t4, 0
		li $t5, 0
		addi $t7, $t7, 1
		j traverse_str
		
	end_traverse:
		move $v0, $t3
		lw $t6, 12($sp)
		move $v1, $t6
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		addi $sp, $sp, 12
		jr $ra

