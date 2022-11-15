# Jane Lai
# laije

.data
swap_str: .asciiz "Swap! "
with_str: .asciiz " with "
endl: .asciiz "\n"
array_size: .asciiz "Size of array: "
no_swap: .asciiz "No swap! "
#nums: .word  -1, -11, 66, 100, 22, 20, -1    # Modify this to test other cases
#nums: .word  1, 2, 3, 4, 5, 6, 7    # Modify this to test other cases
nums: .word  7, 6, 5, 4, 3, 2, 1  # Modify this to test other cases
N: .word 7 # Modify this to test other cases

.text

mainB:
	la $a0, N
	lw $a0, 0($a0)
	la $a1, nums
	jal gnomeSort
	move $s0, $v0  # move $v0 to $s0 to save return value
	li $v0, 10
	syscall
	
gnomeSort:
	li $s1, 0  # $s1 = counter
	move $s0, $a1  # $s0 = nums array
	move $s2, $a0  # $s2 = size of array
	addi $s3, $s2, -1  # $s3 = size of array - 1
	
	sortingloop:

		beq $s1, $s2, donesorting  # stop sorting when index reaches 1 below array size
		beq $s1, $zero, addfromzero
		
		sll $t3, $s1, 2
		add $t3, $t3, $s0
		lw $t0, ($t3)  # $t0 = num in nums[i]
		
		addi $t4, $t3, -4
		lw $t1, ($t4)  # $t1 = num in nums[i-1]
		
		bge $t0, $t1, addindex  # if nums[i] >= nums[i-1], i++
		blt $t0, $t1, swap  # if nums[i] < nums[i-1], swap
		cont:
		j sortingloop
	
addfromzero:
	addi $s1, $s1, 1
	j cont
	
swap:
	# print swap message
	li $v0, 4
	la $a0, swap_str
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, with_str
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	
	move $t2, $t0  # $t2 = nums[i]
	sll $t5, $s1, 2
	add $t5, $t5, $s0  # $t5 = address of nums[i]
	sw $t1, ($t5)  # nums[i] = nums[i-1]
	addi $t6, $t5, -4  # $t6 = address of nums[i-1]
	sw $t2, ($t6)  # nums[i-1] = $t2
	addi $s1, $s1, -1  # index--
	j cont
	
addindex:
	addi $s1, $s1, 1
	j cont

donesorting:
	move $v0, $s0
	jr $ra
