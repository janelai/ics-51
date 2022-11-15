# Jane Lai
# laije

.data
endl: .asciiz "\n"   # a string
prompt: .asciiz "enter an integer: "
.align 2 
str: .asciiz "stringA"

.globl main
.text
main:

	# Print label "str" on its own line
	li $v0, 4
	la $a0, str
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# Load the first 4 bytes (a word) of "str" into Register A
	la $a0, str
	lw $t0, 0($a0)
	
	# Print the value in Register A as an integer on its own line
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# Print the value in Register A in binary on its own line
	li $v0, 35
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# Print the value in Register A in hexadecimal on its own line
	li $v0, 34
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# Add 1 to the value in Register A, and store the result (a word) back into memory at label "str"	
	addi $t0, $t0, 1
	la $t1, str  # Load the address for label "str" into a temporary register
	sw $t0, 0($t1)
	
	# Print the modified label "str" on its own line
	li $v0, 4
	move $a0, $t1
	syscall
	la $a0, endl
	syscall
	
	# Print the string stored at label "prompt" asking user to enter an integer
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Read integer from user
	li $v0, 5
	syscall
	move $t2, $v0
	
	# If integer > 6, < 0, and Else conditions
	li $s0, 1  # Set $s0 to 1
	li $s1, 6  # Set $s2 to 6 to use to compare
	
	sle $t3, $t2, $s1  # $t3 stores if integer < 6
	sge $t4, $t2, $zero  # $t4 stores if integer > 0
	
	beq $t3, $t4, Else  # if $t3 and $t4 are equal (integer is < 6 && > 0), go to Else
	
	beq $t4, $zero, LessThan0  # if integer is less than 0, go to LessThan0
	bne $t4, $zero, GreaterThan0
	LessThan0:
		li $t2, 0
		b	Endif
	GreaterThan0:
		beq $t4, $s0, GreaterThan6  # if integer is greater than 6, go to GreaterThan6
		GreaterThan6:
			li $t2, 6
			b	Endif
		b	Endif
		
	# Otherwise, set Register B to the integer
	Else:
		b	Endif
	Endif:
	
	# Using load byte (lb), obtain the value of the ith character in str where is in Register B's integer and place it into Register C
	la $a0, str
	add $a0, $a0, $t2
	lb $t3, ($a0)
	
	# Print Register C on its own line
	li $v0, 11
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# XOR Register C with 32 and store the result in Register C
	li $s2, 32
	xor $t3, $t3, $s2
	
	# Print Register C on its own line
	li $v0, 11
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# Repeat the XOR again
	li $s2, 32
	xor $t3, $t3, $s2
	
	# Print Register C on its own line
	li $v0, 11
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# Quit the program
	li $v0, 10
	syscall
