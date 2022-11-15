# Jane Lai
# laije

# DO NOT INCLUDE the helper file here - include it in your main file
.data
print_trib: .asciiz "trib: "
print_newline: .asciiz "\n"
print_paren: .asciiz "("
print_theses: .asciiz ")"
print_comma: .asciiz ", "
print_commanospace: .asciiz ","
print_counter: .asciiz "counter is: "
print_jobswap1: .asciiz "\ncalled jobSwap inside jobCompare\n"
print_jobswap2: .asciiz "\ncalled jobSwap after everything\n"
print_swapped: .asciiz "\nswapped: "
print_pivotvalue: .asciiz "\npivot value (array[high]): "
print_i: .asciiz "\ni: "
print_j: .asciiz "\nj: "
print_currentj: .asciiz "\ncurrent j is: "
print_arrayj: .asciiz "\narray[j]: "
print_jobcompare: .asciiz "\njobCompare(array[j], pivot_value): "
print_hi: .asciiz "hi"
print_len: .asciiz "len = "
print_profit: .asciiz "profit = "
print_maxprofit: .asciiz "max profit = "
print_donelastnon: .asciiz "done last non"
print_lastnonconflict: .asciiz "lastnonconflictjob: "
print_doneaddmax: .asciiz "done add max"
print_donefindmax: .asciiz "done find max"
print_pivot: .asciiz "Pivot value: "
inquicksort: .asciiz "in quick sort"
arr: .asciiz "\narr: "
len: .asciiz "\nlen: "
lo: .asciiz "\nlo: "
hi: .asciiz "\nhi: "

.text

##################################
# Part 1 Functions
##################################

trib:
    addi $sp, $sp, -16
    sw $a0, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $ra, 12($sp)
    move $s0, $a0  # $s0 = n
    
    # prints
    li $v0, 4
    la $a0, print_trib
    syscall
    li $v0, 1
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, print_newline
    syscall
    
    # base cases
    beqz $s0, return_zero
    beq $s0, 1, return_zero
    beq $s0, 2, return_one
    
    # recursive w/ n-3, n-2, n-1
    addi $a0, $s0, -3
    jal trib
    move $s1, $v0  # $s1 = return sum
    addi $a0, $s0, -2
    jal trib
    addi $a0, $s0, -1
    add $s1, $s1, $v0
    jal trib
    add $v0, $v0, $s1
    add $s1, $s1, $v0
    j done_trib
    
    return_zero:
    	li $v0, 0
    	j done_trib
    	
    return_one:
    	li $v0, 1
    	j done_trib
    	
    done_trib:
    	lw $a0, 0($sp)
    	lw $s0, 4($sp)
    	lw $s1, 8($sp)
    	lw $ra, 12($sp)
    	addi $sp, $sp, 16
    	jr $ra


eggDrop:    
    addi $sp, $sp, -24
    sw $ra, ($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    move $s0, $a0  # $s0 = nEggs
    move $s1, $a1  # $s1 = kFloors
    
    # prints
    li $v0, 4
    la $a0, print_paren
    syscall
    li $v0, 1
    move $a0, $s0  # nEggs
    syscall
    li $v0, 4
    la $a0, print_commanospace
    syscall
    li $v0, 1
    move $a0, $s1  # kFloors
    syscall
    li $v0, 4
    la $a0, print_theses
    syscall
    li $v0, 4
    la $a0, print_newline
    syscall
    
    # base cases
    beqz $s1, return_kfloors
    beq $s1, 1, return_kfloors
    beq $s0, 1, return_kfloors
    
    li $s3, 0x7FFFFFFF  # $s3 = min
    li $s4, 1  # counter i from 1 to kFloors inclusive
    
    res:
    	# move arguments to eggDrop
    	addi $a0, $s0, -1  # nEggs-1
    	addi $a1, $s4, -1  # i-1
    	jal eggDrop
    	move $s2, $v0  # first argument result of eggDrop
 	move $a0, $s0  # nEggs
 	li $t5, 0  # negate i temporarily
 	sub $t5, $zero, $s4  # -i
 	add $a1, $s1, $t5  # kFloors-i
 	jal eggDrop
 	move $t4, $v0  # second argument result of eggDrop
 	
    	# move results of eggDrop to arguments of max
    	move $a0, $s2
    	move $a1, $t4
    	jal max
    	li $t2, 0  # $t2 = res
    	move $t2, $v0  # move result of max to res
    	blt $t2, $s3, min_eq_res
    	done_min_eq_res:
    	beq $s4, $s1, done_res
    	addi $s4, $s4, 1  # increment counter i
    	j res
    
    return_kfloors:
    	move $v0, $s1
    	j done_eggs
    	
    min_eq_res:
    	li $s3, 0
    	move $s3, $t2  # min = res
    	j done_min_eq_res
    	
    done_res:
    	addi $v0, $s3, 1
    	j done_eggs
    	
    done_eggs:
    	lw $ra, ($sp)
    	lw $s0, 4($sp)
    	lw $s1, 8($sp)
    	lw $s2, 12($sp)
    	lw $s3, 16($sp)
    	lw $s4, 20($sp)
    	addi $sp, $sp, 24
    	jr $ra


##################################
# Part 2 Functions
##################################

getJobTimes: 
    move $t0, $a0  # $t0 = job word
    li $t1, 0  # start time
    li $t2, 0  # finish time  
    
    srl $t1, $t0, 16  # shift right until start/finish time
    andi $t2, $t1, 0xFF  # get last 2 bits (finish time)
    srl $t1, $t1, 8  # shift right once more (start time)
    move $v0, $t1
    move $v1, $t2
    jr $ra


jobPartition:    
    addi $sp, $sp, -28
    sw $ra, ($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
    
    move $s0, $a0  # array
    move $s1, $a1  # len
    move $t2, $a2  # low
    move $s3, $a3  # high
    
    # return one conditions
    blt $t2, $zero, return_neg_one
    bge $t2, $s1, return_neg_one
    blt $s3, $zero, return_neg_one
    bge $s3, $s1, return_neg_one
    
    move $t5, $s0  # pivot_value (array[high])
    li $t4, 0  # counter to high
    get_array_high:
    	beq $t4, $s3, done_get_array_high
    	addi $t5, $t5, 4
    	addi $t4, $t4, 1
    	j get_array_high
    done_get_array_high:
    
    lw $s5, ($t5)  # s5 holds pivot_value
    #li $v0, 4
    #la $a0, print_pivotvalue
    #syscall
    #li $v0, 1
    #move $a0, $s5
    #syscall
    
    addi $s2, $t2, -1  # int i is in s2
    #li $v0, 4
    #la $a0, print_i
    #syscall
    #li $v0, 1
    #move $a0, $s2
    #syscall
    move $s4, $t2  # int j is in s4
    
    jobpart:
    	#li $v0, 4
    	#la $a0, print_currentj
    	#syscall
    	#li $v0, 1
    	#move $a0, $s4
    	#syscall
    	beq $s4, $s3, done_jobpart
    	
    	move $t7, $s0  # array
    	li $t8, 0  # counter to j
    	get_array_j:
    		beq $t8, $s4, done_get_array_j
    		addi $t7, $t7, 4
    		addi $t8, $t8, 1
    		j get_array_j
    	done_get_array_j:
    	
    	lw $t7, ($t7)  # array[j]
    	#li $v0, 4
    	#la $a0, print_arrayj
    	#syscall
    	#li $v0, 1
    	#move $a0, $t7
    	#syscall
    	move $a0, $t7  # value at array[j]
    	move $a1, $s5  # pivot_value
    	jal jobCompare  # jobCompare(array[j], pivot_value)
    	move $t9, $v0
    	#li $v0, 4
    	#la $a0, print_jobcompare
    	#syscall
    	#li $v0, 1
    	#move $a0, $t9
    	#syscall
    	
    	bnez $t9, swap  # if jobCompare
    	beqz $t9, finish_swap
    	
    	swap:
    		addi $s2, $s2, 1  # i++
    		#li $v0, 4
    		#la $a0, print_i
    		#syscall
    		#li $v0, 1
    		#move $a0, $s2
    		#syscall
    		move $a0, $s0
    		move $a1, $s1
    		move $a2, $s2
    		move $a3, $s4
    		jal jobSwap  # jobSwap(array, len, i, j)
    		
    		#li $v0, 4
    		#la $a0, print_jobswap1
    		#syscall
    		j finish_swap
    	
    	finish_swap:
    	addi $s4, $s4, 1
    	j jobpart
    
    done_jobpart:
    move $a0, $s0
    move $a1, $s1
    addi $a2, $s2, 1
    move $a3, $s3
    jal jobSwap  # jobSwap(array, len, i+1, high)
    
    #li $v0, 4
    #la $a0, print_newline
    #syscall
    #li $t1, 0
    #move $t3, $s0
    #loop:
    #	beq $t1, $s1, done
    #	lw $t4, ($t3)
    #	li $v0, 1
    #	move $a0, $t4
    #	syscall
    #	li $v0, 4
    #	la $a0, print_comma
    #	syscall
    #	addi $t3, $t3, 4
    #	addi $t1, $t1, 1
    #	j loop
    #done:
    
    #li $v0, 4
    #la $a0, print_jobswap2
    #syscall
    
    
    j exiting
    
    return_neg_one:
    	lw $ra, ($sp)
    	lw $s0, 4($sp)
    	lw $s1, 8($sp)
    	lw $s2, 12($sp)
    	lw $s3, 16($sp)
    	lw $s4, 20($sp)
    	lw $s5, 24($sp)
    	addi $sp, $sp, 28
    	li $v0, 0
    	li $v0, -1
    	jr $ra
    	
    exiting:
    	li $v0, 0
    	move $t2, $s2
    	lw $ra, ($sp)
    	lw $s0, 4($sp)
    	lw $s1, 8($sp)
    	lw $s2, 12($sp)
    	lw $s3, 16($sp)
    	lw $s4, 20($sp)
    	lw $s5, 24($sp)
    	addi $sp, $sp, 28
    	li $v0, 0
    	addi $v0, $t2, 1  # return (i+1)
    	jr $ra


jobQuicksort: 
    addi $sp, $sp, -24
    sw $ra, ($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    
    move $s0, $a0  # array
    move $s1, $a1  # len
    move $s2, $a2  # low
    move $s3, $a3  # high
    bge $s2, $s3, error  # if low >= high
    
    move $a0, $s0  # array
    move $a1, $s1  # len
    move $a2, $s2  # low
    move $a3, $s3  # high
    jal jobPartition
    move $s4, $v0  # s4 holds pivot
    
    bltz $s4, error
    
    li $v0, 4
    la $a0, print_pivot
    syscall
    li $v0, 1
    move $a0, $s4
    syscall
    li $v0, 4
    la $a0, print_newline
    syscall
    
    move $a0, $s0  # array
    move $a1, $s1  # len
    move $a2, $s2  # low
    addi $a3, $s4, -1  # pivot-1
    jal jobQuicksort
    
    move $a0, $s0  # array
    move $a1, $s1  # len
    addi $a2, $s4, 1  # pivot+1
    move $a3, $s3  # high
    jal jobQuicksort
    
    j finish_zero
    
    
    error:
    	lw $ra, ($sp)
    	lw $s0, 4($sp)
    	lw $s1, 8($sp)
    	lw $s2, 12($sp)
    	lw $s3, 16($sp)
    	lw $s4, 20($sp)
    	addi $sp, $sp, 24
    	li $v0, 0
    	li $v0, -1
    	jr $ra
    	
    finish_zero:
    	li $v0, 0
    	lw $ra, ($sp)
    	lw $s0, 4($sp)
    	lw $s1, 8($sp)
    	lw $s2, 12($sp)
    	lw $s3, 16($sp)
    	lw $s4, 20($sp)
    	addi $sp, $sp, 24
    	jr $ra


findMaxProfit:
    addi $sp, $sp, -20
    sw $ra, ($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    move $s0, $a0  # array
    move $s1, $a1  # len
    beq $s1, 1, finish_profit
    
    li $t2, 1  # counter to len
    move $t3, $s0  # array[len-1]
    get_array_len_minus1:
    	beq $t2, $s1, done_array
    	addi $t3, $t3, 4
    	addi $t2, $t2, 1
    	j get_array_len_minus1
    	
    done_array:
    lw $t3, ($t3)  # contents of array[len-1]
    andi $s3, $t3, 0xFFFF  # s3 holds int inclProfit = array[len-1].profit
    move $a0, $s0
    move $a1, $s1
    jal lastNonConflictJob  # lastNonConflictJob{array, len}
    move $s2, $v0  # s2 holds int i
    #li $v0, 4
    #la $a0, print_lastnonconflict
    #syscall
    #li $v0, 1
    #move $a0, $s2
    #syscall
    bne $s2, -1, add_max
    done_add_max:
    #li $v0, 4
    #la $a0, print_doneaddmax
    #syscall
    move $a0, $s0
    addi $a1, $s1, -1
    jal findMaxProfit  # findMaxProfit(array, len-1)
    move $t6, $v0  # t6 holds int exclProfit
    #li $v0, 4
    #la $a0, print_donefindmax
    #syscall
    
    # prints
    move $a0, $s3
    move $a1, $t6
    jal max
    move $t7, $v0  # found max(inclProfit, exclProfit)
    li $v0, 4
    la $a0, print_len
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    li $v0, 4
    la $a0, print_comma
    syscall
    li $v0, 4
    la $a0, print_maxprofit
    syscall
    li $v0, 1
    move $a0, $t7
    syscall
    li $v0, 4
    la $a0, print_newline
    syscall
    move $v0, $t7  # return max(inclProfit, exclProfit)
    j restore
    
    add_max:
    	move $a0, $s0
    	addi $a1, $s2, 1
    	jal findMaxProfit  # findMaxProfit(array, i+1)
    	move $t3, $v0
    	add $s3, $s3, $t3  # inclProfit +=
    	j done_add_max
    	
    finish_profit:
    	lw $t3, ($s0)
    	andi $t4, $t3, 0xFFFF
    	li $v0, 4
    	la $a0, print_len
    	syscall
    	li $v0, 1
    	move $a0, $s1
    	syscall
    	li $v0, 4
    	la $a0, print_comma
    	syscall
    	li $v0, 4
    	la $a0, print_profit
    	syscall
    	li $v0, 1
    	move $a0, $t4
    	syscall
    	li $v0, 4
    	la $a0, print_newline
    	syscall
    	move $v0, $t4
    	j restore
    	
    restore:
    	lw $s3, 16($sp)
    	lw $s2, 12($sp)
    	lw $s1, 8($sp)
    	lw $s0, 4($sp)
    	lw $ra, ($sp)
	addi $sp $sp, 20
	jr $ra
	

weightedScheduling:    
    addi $sp, $sp, -20
    sw $ra, ($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    
    move $s0, $a0  # array
    move $s1, $a1  # len
    move $s2, $zero  # low
    addi $s3, $s1, -1  # high
    
    move $a0, $s0  # array
    move $a1, $s1  # len
    move $a2, $s2  # low
    move $a3, $s3  # high
    jal jobQuicksort

    move $t0, $v0
    move $a0, $s0  # array
    move $a1, $s1  # len
    jal findMaxProfit
    move $t0, $v0

    lw $s3, 16($sp)
    lw $s2, 12($sp)
    lw $s1, 8($sp)
    lw $s0, 4($sp)
    lw $ra, ($sp)
    addi $sp $sp, 20
    li $v0, 0
    move $v0, $t0
    jr $ra
