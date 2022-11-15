# Hello, World! - First Program
.data
Greeting: .asciiz "Hello, World!\n"
.text
.globl _start
_start:
	# Print the string
	li $v0, 4
	la $a0, Greeting
	syscall
	
	# Exit the program
	li $v0, 10
	syscall