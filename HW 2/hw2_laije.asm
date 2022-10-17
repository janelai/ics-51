# Jane Lai
# laije

.text

##################################
# Part 1 Functions
##################################

hammingDistance:
    
    li $s0, 0  # $s0 = difference counter
    move $s1, $a0  # $s1 = starting address of string 1
    move $s2, $a1  # $s2 = starting address of string 2
    
    # get length of string 1
    li $t0, 0  # $t0 = length of string 1
    move $t2, $s1  # $t2 = current address of string 1
    
    lengthof1:
    	lb $t3, ($t2)  # load contents of address $t2 into $t3
    	beqz $t3, donewithlengthof1  # if null terminator is reached, break
    	addi $t2, $t2, 1  # increment address
    	addi $t0, $t0, 1  # increment length counter
    	j lengthof1
    donewithlengthof1:
    
    # get length of string 2
    li $t1, 0  # $t1 = length of string 1
    move $t2, $s2
    lengthof2:
    	lb $t3, ($t2)  # load contents of address $t2 into $t3
    	beqz $t3, donewithlengthof2  # if null terminator is reached, break
    	addi $t2, $t2, 1  # increment address
    	addi $t1, $t1, 1  # increment length counter
    	j lengthof2
    donewithlengthof2:
    
    bne $t0, $t1, incomparable  # if lengths of strings 1 and 2 are unequal, return -1
    
    # calculate the hamming distance
    # $t0 = length of strings
    li $t2, 0  # counter
    move $t4, $s1  # move starting addresses for both strings
    move $t5, $s2
    li $t8, 0  # hamming distance
    
    calculate:
    	beq $t2, $t0, donecalculating
    	lb $t6, ($t4)
    	lb $t7, ($t5)
    	bne $t6, $t7, addcounter
    	continuecounter:
	addi $t4, $t4, 1  # increment addresses
	addi $t5, $t5, 1
    	addi $t2, $t2, 1  # increment counter
    	j calculate
    	
    addcounter:  # add to hamming distance counter
    	li $v0, 11
    	addi $t8, $t8, 1
    	j continuecounter
    	
    donecalculating:
    	move $v0, $t8
    	j exit
    
    incomparable:
    	li $v0, -1
    	j exit

    exit:
    	jr $ra

arrayCompare:
    
    
    
    exit:
    	jr $ra

##################################
# Part 2 Functions
##################################

charHistogram:
    # your code goes here

    # remove these lines. Only added to run testing main
    li $v0, 77 
    li $v1, 77

    jr $ra

charApperance:
    # your code goes here

    # remove this line. Only added to run testing main
    li $v0, 77

    jr $ra

##################################
# Part 3 Functions
##################################

cInStrings:
    # your code goes here

    # remove these lines. Only added to run testing main
    li $v0, 2233 
    li $v1, 2233

    jr $ra

splitString:
    # your code goes here

    # remove these lines. Only added to run testing main
    li $v0, 2233 
    li $v1, 2233

    jr $ra
