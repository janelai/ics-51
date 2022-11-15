# Jane Lai
# laije

.include "lab2_A_laije.asm"  # Change this to your file
.include "lab2_B_laije.asm"  # Change this to your file

.data
#array: .word 40 # 10* 4 bytes per integer
#ints: .word 10
.align 2
.word 0xABCD,0xEFAB,0xCDEF  # Data in memory so you can see where the array stops
prompt_input: .asciiz "Enter a value: "
there_are: .asciiz "There are "
evens: .asciiz " even values.\n"
negs: .asciiz " negative values.\n"
sorted: .asciiz "Sorted:\n"
new_line: .asciiz "\n"
first_num: .asciiz "First num from part B: "
num_from_B: .asciiz "Num from B: "
index: .asciiz "Index: "
array: .word 40 # 10* 4 bytes per integer
ints: .word 10
.globl main
.text

main:

	li $s0, 0
	li $s1, 10
	la $s2, ints
	la $a0, array
	li $s3, 0  # counter
	
	userinput:
		beq $s0, $s1, partA
		li $v0, 4
		la $a0, prompt_input
		syscall
		li $v0, 5
		syscall
		sw $v0, ($s2)
		addi $s2, $s2, 4
		addi $s0, $s0, 1
		j userinput
	
	partA:	
		la $s2, ints
		move $a0, $s2
		li $a1, 10
		jal findStats
		move $s0, $v0  # move evens
		move $s1, $v1  # move negs
	
		# print evens
		li $v0, 4
		la $a0, there_are
		syscall
		li $v0, 1
		move $a0, $s0
		syscall
		li $v0, 4
		la $a0, evens
		syscall
		
		# print negs
		li $v0, 4
		la $a0, there_are
		syscall
		li $v0, 1
		move $a0, $s1
		syscall
		li $v0, 4
		la $a0, negs
		syscall
	
	partB:
		la $s2, ints
		move $a1, $s2
		li $a0, 10
		jal gnomeSort
		move $s4, $v0  # nove return value from gnomeSort to $s4
		li $s3, 0  # counter
		
		# print "Sorted: "
		li $v0, 4
		la $a0, sorted
		syscall
		
		# print sorted ints in array
		whileloop:
			beq $s3, $s1, finish
			sll $t1, $s3, 2  # increment index by 4 bytes
			add $t1, $t1, $s4  # get new address
			lw $t0, ($t1)  # load word in that address to $t0
			li $v0, 1
			move $a0, $t0
			syscall
			li $v0, 4
			la $a0, new_line
			syscall
			addi $s3, $s3, 1
			j whileloop
	
	finish:	
		li $v0, 10
		syscall
