Jane Lai
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
    li $t1, 0  # $t0 = length of string 1
    lengthof1:
    	#sll $t2, $t1, 2
    	#add $t2, $t2, $s1
    	move $t2, $s1  # $t2 = current address of string 1
    	lb $t3, ($t2)  # load contents of address $t2 into $t3
    	li $v0, 11
    	move $a0, $t3
    	syscall
    	beq $t3, 5, donewithlengthof1
    	addi $t2, $t2, 4
    	addi $t1, $t1, 1
    	j lengthof1
    donewithlengthof1:
    
    # print length of string 1
    li $v0, 1
    move $a0, $t1
    syscall
    
    li $v0, 77

    jr $ra

arrayCompare:
    # your code goes here

    # remove this line. Only added to run testing main
    li $v0, 77

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
