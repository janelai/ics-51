# for(int i = 0; i < new_size; i++)
# { 
#   int j = i*3;
#   new[i] = sum(old[j], old[j+1], old[j+2]);
# }
#
# int sum(int x, int y, int z)
# {
#    return x + y + z;
# }
#
.data
old: 	  .word 10, 20, -30, 100, 50, 40, 100, 200, -350
new: 	  .space 12	# space for 3 integers 
new_size: .word 3

.text
.globl main
# $a0, x
# $a1, y
# $a2, z
# leaf function
sum:
	add $t0, $a0, $a1 # x+y
	add $v0, $t0, $a2 # (x+y)+z
	jr $ra

main:
	li $s0, 0  # i
	lw $s1, new_size # 3
	
	la $s2, new
	la $s3, old
	
for_loop:
	bge $s0, $s1, done
	li $t0, 3
	mul $t0, $s0, $t0   # j in $t0
	
	sll $t0, $t0, 2  # j *4 = # bytes for index i
	
	add $t1, $s3, $t0
	lw $a0, 0($t1)	# old[j]
	lw $a1, 4($t1)  # old[j+1]
	lw $a2, 8($t1)  # old[j+2]
	
	jal sum
	# $v0 holds the return value of sum
	
	#new[i]
	sll $t0, $s0, 2    # i * 4 = # bytes for new
	add $t0, $t0, $s2  # address of new[i]
	sw $v0, 0($t0)
	
	addi $s0, $s0, 1
	j for_loop
	
done:
	li $v0, 10
	syscall



