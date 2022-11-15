# Jane Lai
# laije

.data
# Declare your global variables here
Str_eaten: .asciiz "Ate String: "
Str_pelletCnt: .asciiz "\nCurrent pellet count is: "
Str_gameover: .asciiz "Game Over! Pacman died eating:"
Str_win: .asciiz "You Win!\n"
Str_newline: .asciiz "\n"
playing_pacman: .asciiz "playing pacman...\n"
a: .asciiz "a = "
com: .asciiz ", "
bs: .asciiz "b = "
ghost_str: .asciiz "\nghost str: "
pellet_str: .asciiz "\npellet str: "
curr_pellets: .asciiz "\ncurr pellets: "
curr_str: .asciiz "\ncurr str: "
hi: .asciiz "hi"

.text
playPacman:
	
	addi $sp $sp, -20
	sw $s0, ($sp)  # prev $s0
	sw $s1, 4($sp)  # prev $s1
	sw $a3, 8($sp)  # ghost str
	sw $a2, 12($sp)  # pellet str
	sw $ra, 16($sp)  # ra
	move $t0, $a1
	addi $t0, $t0, -1
	move $s0, $t0  # numStr - 1
	move $s1, $a0  # strings
	
	li $t2, 0  # total_ghosts
	li $t3, 0  # current_pellets
	li $t4, 0  # total_strings
	li $t7, 0
	li $t8, 0
	
	li $t5, 0  # counter to numStr
	move $t6, $s1  # strings
	
	#loop:
	#	beq $t5, $s0, go_str
	#	lw $t9, ($t6)
	#	move $t0, $t9
	#	li $v0, 4
	#	move $a0, $t0
	#	syscall
	#	addi $t6, $t6, 4
	#	addi $t5, $t5, 1
	#	j loop
	
	#li $t5, 0
	#li $t9, 0
	#move $t6, $s1
	
	go_str:
		beq $t5, $s0, str_done  # for strings[0] - strings[numStr-1]
		lw $t9, ($t6)  # load string at strings[index]
		li $t0, 0
		move $t0, $t9
		li $v0, 4
		la $a0, curr_str
		syscall
		li $v0, 4
		move $a0, $t9
		syscall
		li $v0, 4
		la $a0, ghost_str
		syscall
		li $v0, 4
		lw $a0, 8($sp)
		syscall
		li $v0, 4
		la $a0, pellet_str
		syscall
		li $v0, 4
		lw $a0, 12($sp)
		syscall
		li $v0, 4
		la $a0, curr_pellets
		syscall
		li $v0, 1
		move $a0, $t3
		syscall
		move $a0, $t9  # string
		lw $a1, 8($sp)  # ghost str
		lw $a2, 12($sp)  # pellet str
		move $a3, $t3  # current_pellets
		jal pacmanEatsString
		
		# result of calling pacmanEatsString
		move $t7, $v0
		move $t8, $v1
		li $v0, 4
		la $a0, a
		syscall
		li $v0, 1
		move $a0, $t7
		syscall
		li $v0, 4
		la $a0, com
		syscall
		li $v0, 4
		la $a0, bs
		syscall
		li $v0, 1
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str_newline
		syscall
		
		add $t2, $t2, $t7 # total_ghosts += a
		beq $t8, -1, game_over
		bne $t8, -1, continue_ate
		done_else:
		addi $t6, $t6, 4
		addi $t5, $t5, 1
		j go_str
	
	game_over:  # if b == -1
		li $v0, 4
		la $a0, Str_gameover  # Game Over! Pacman died eating s
		syscall
		li $v0, 11
		move $a0, $t6
		syscall
		j done_done
		
	continue_ate:
		move $t3, $t8  # current_pellets = b
		addi $t4, $t4, 1  # total_strings++
		li $v0, 4
		la $a0, Str_eaten
		syscall
		li $v0, 4
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, Str_newline  # Ate String: s Current pellet count is: current_pellets
		syscall
		li $v0, 4
		la $a0, Str_pelletCnt
		syscall
		li $v0, 1
		move $a0, $t3
		syscall
		j prints
	
	prints:
		move $a0, $t4  # total_strings
		move $a1, $t2  # total_ghosts
		jal printStats  # printStats(total_strings, total_ghosts)
		j done_else
		
	str_done:
		li $v0, 4
		la $a0, Str_win  # You Win!
		syscall
		j done_done
		
	done_done:
		lw $s0, ($sp)
		lw $s1, 4($sp)
		lw $ra, 16($sp)
		addi $sp, $sp, 20
		jr $ra
