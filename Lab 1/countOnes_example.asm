.text
.globl main

main:
# Code & Instructions defined here
	# $s0 = num
	li $s0, 0xf0f0f0f0
	# $s1 = counter
	add $s1, $0, $0
	# $t0 = position
	li $t0, 1
	# $t1 = i
	li $t1, 0

	li $t9, 32
	
loop:
	bge $t1, $t9, done
	and $s2, $s0, $t0	# $s2 = bit
	
	beqz $s2, end_if
		addi $s1, $s1, 1		# counter ++
	
end_if: 
	sll $t0, $t0, 1		# 000001 -> 000010 -> 000100
	addi $t1, $t1, 1		# i++
	j loop			# do the loop again

done:

	li $v0, 1	# print int
	move $a0, $s1
	syscall
	
	li $v0, 10
	syscall

.data
# Global Variables defined here


