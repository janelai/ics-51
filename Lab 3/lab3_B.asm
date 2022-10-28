# Your full name
# Netid

.text
playPacman:
	# Your code here
	# Delete this line
    li $v0, -222

	jr $ra


.data
# Declare your global variables here
Str_eaten: .asciiz "Ate String: "
Str_pelletCnt: .asciiz "\nCurrent pellet count is: "
Str_gameover: .asciiz "Game Over! Pacman died eating:"
Str_win: .asciiz "You Win!\n"
Str_newline: .asciiz "\n"
