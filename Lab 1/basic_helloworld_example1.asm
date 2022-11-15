# Hello world
.text
.globl main
main:	
	# Print a greeting on the screen
	li $v0, 4
	la $a0, greeting
	syscall
	
	# display the prompt
	addi $v0, $0, 4
	la $a0, prompt1
	syscall
	
	# read integer 
	li $v0, 5
	syscall
	
	# compute new age
	li $t0, 5
	add $t1, $v0, $t0
	
	#print label for new age
	addi $v0, $0, 4
	la $a0, output1
	syscall
	
	# print new age
	li $v0, 1
	move $a0, $t1   # add $a0, $t0, $0
	syscall
	
	# Terminate the program
	li $v0, 10
	syscall
	
.data
greeting: .asciiz "Hello World\n"
prompt1: .asciiz "Enter your age: "
output1: .asciiz "Your age in 5 years is "
