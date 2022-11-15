# Jane Lai
# laije

.data
endl: .asciiz "\n"   # a string
prompt: .asciiz "enter an integer: "
num: .word 0x10
value: .word 0xAABBCCDD 

.globl main
.text
main:

	# Print string stored at the label "prompt" to ask user for an integer
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Read integer from user
	li $v0, 5
	syscall
	
	# Load the address for label "num" into Register A
	la $t0, num
	
	# Load the value stored in memory for label "num" (Register A) into Register B
	lw $t1, 0($t0)
	
	# Add the user's entered integer to the value loaded from label "num" (not the address)
	add $t2, $v0, $t1
	
	# Print sum as an integer on its own line (use label "endl")
	li $v0, 1
	move $a0, $t2
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# Modify the sum to be its negated value and place into Register C
	subu $t3, $zero, $t2
	
	# Print Register C on its own line
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# Negate the value in Register C, place it back int Register C, and store (sw) the value into memory at label "value"
	subu $t3, $zero, $t3
	la $t4, value  # Load the address for label "value" into a temporary register
	sw $t3, 0($t4)
	
	# Shift Register C by 1 bit to the left (sll)
	sll $t3, $t3, 1
	
	# Print Register C on its own line
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# Shift Register C by 1 bit to the left again
	sll $t3, $t3, 1
	
	# Print Register C on its own line
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# Shift Register C by 2 bits to the right (srl)
	srl $t3, $t3, 2
	
	# Print Register C on its own line
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# XOR Register C with itself
	xor $t3, $t3, $t3
	
	# Print Register C on its own line
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	# Quit the program
	li $v0, 10
	syscall
