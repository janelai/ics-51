# Your full name
# Netid

.data
ate_ghost: .asciiz "GHOST! "
ate_pellet: .asciiz "PELLET! "
ate_ghostkill: .ascii "GHOST KILL! "
ate_str: .asciiz "Ate "
ate_newline: .asciiz "\n"

.text
pacmanEatsString:
	# Your code here
	# Delete these lines
    li $v0, -678
    li $v1, -678

	jr $ra

