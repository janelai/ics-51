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
    	j exit1
    
    incomparable:
    	li $v0, -1
    	j exit1

    exit1:
    	jr $ra


arrayCompare:
    
    move $s0, $a0  # $s0 = array 1
    move $s1, $a1  # $s1 = array 2
    move $s2, $a2  # $s2 = len
    
    li $t0, 0
    move $t1, $s0
    move $t2, $s1
    
    # check if arrays are the same
    li $t0, 0  # $t0 = counter
    move $t1, $s0  # array 1
    move $t2, $s1  # array 2
    ifequal:
    	beq $t0, $s2, isequal  # if length is exceeded, all ints have been checked for equality and the array is equal
    	lw $t4, ($t1)
    	lw $t5, ($t2)
    	bne $t4, $t5, notequal
    	beq $t4, $t5, continueequal
    	continueequal:
    	addi $t1, $t1, 4  # increment index of arrays
    	addi $t2, $t2, 4
    	addi $t0, $t0, 1  # increment counter
    	j ifequal
    	
    notequal:
    	li $t0, 0  # $t0 = counter
    	li $t3, 0  # $t3 = nonzero counter
    	li $t6, 0  # $t6 = zeroes counter
    	move $t1, $s0  # array 1
    	move $t2, $s1  # array 2
    	
    	checkdiffs:
    		beq $t0, $s2, finishcheckdiffs # if counter == len, stop
    		lw $t4, ($t1)
    		lw $t5, ($t2)
    		beq $t4, $t5, checkifzeroes  # if $t4 == $t5, check if both are zero
    		bne $t4, $t5, notzeroes
    		notzeroesfinish:
    		addi $t1, $t1, 4  # increment index of arrays
    		addi $t2, $t2, 4
    		addi $t0, $t0, 1  # increment counter
    		j checkdiffs
    
    checkifzeroes:  # if both are zeroes, add to zero counter. else, add to nonzero counter
    	beqz $t4, addzeroes
    	bnez $t4, notzeroes
    
    notzeroes:
    	addi $t3, $t3, 1  # add to nonzero counter
    	j notzeroesfinish
    	
    addzeroes:
    	addi $t6, $t6, 1
    	j notzeroesfinish
    
    finishcheckdiffs:
    	beq $t3, $s2, dontmatch
    	bne $t3, $s2, zeroesmatch
    	
    dontmatch:  # array is unequal and zeroes don't match positions
    	li $v0, 0
    	j exit2
    	
    zeroesmatch:
    	li $v0, 2
    	j exit2
    	
    isequal:
    	li $v0, 1
    	j exit2
    	
    exit2:
    	jr $ra

##################################
# Part 2 Functions
##################################

charHistogram:
    
    move $s0, $a0  # str
    move $s1, $a1  # array
    li $t0, 0  # space counter
    move $t2, $s0  # move str to $t2
    
    li $t5, 0  # loop counter
    li $t6, 0
    move $t7, $s1  # array
    resetarray:
    	beq $t5, 26, loopchars
    	sw $t6, ($t7)
    	addi $t7, $t7, 4
    	addi $t5, $t5, 1
    	j resetarray
    
   loopchars:  # loop through entire string char by char
    	lb $t1, ($t2)
    	beqz $t1, calculatetotal
    	beq $t1, 0x20, addspace  # if char is a space, add to the space counter
    	bge $t1, 'a', checkiflowercase  # 'a' if char is lowercase, change to uppercase
    	donechecking:
    	bge $t1, 'A', checkifuppercase
    	doneadding:
	addi $t2, $t2, 1
    	j loopchars
    
    addtoarray:
    	addi $t3, $t1, -65  # difference from starting letter A
    	sll $t3, $t3, 2  # find new address to get letter
    	add $t3, $t3, $s1
    	lw $t4, ($t3)  # load current integer at char value
    	addi $t4, $t4, 1  # increment by 1
    	sw $t4, ($t3)  # store integer back at array index
	j doneadding
    
    checkifuppercase:
    	ble $t1, 'Z', addtoarray 
    	bgt $t1, 'Z', doneadding 
    	
    checkiflowercase:
    	ble $t1, 'z', changetouppercase
    	bgt $t1, 'z', donechecking
    	
    changetouppercase:
    	addi $t1, $t1, -32
    	j donechecking
    	
    addspace:
    	addi $t0, $t0, 1
    	j doneadding
    	
    calculatetotal:
    	li $t5, 0  # loop counter
    	li $t6, 0  # sum ints
    	move $t7, $s1  # array
    	sumints:
    		beq $t5, 26, exit3
    		lw $t8, ($t7)
    		#li $v0, 1
    		#move $a0, $t8
    		#syscall
    		add $t6, $t6, $t8
    		addi $t7, $t7, 4
    		addi $t5, $t5, 1
    		j sumints
    	
    exit3:
    	move $v0, $t0
    	move $v1, $t6
    	jr $ra


charApperance:

    move $s0, $a0  # string
    li $s1, 0  # final returned int
    move $t1, $s0  # string
    
    loopstring:
    	lb $t2, ($t1)
    	beqz $t2, exit4
    	# change char to uppercase if applicable
    	bge $t2, 'A', checkifup
    	blt $t2, 'A', notaletter
    	cont:  #  finish changing char
    	li $t3, 0
    	addi $t3, $t2, -65  # difference from A (ie. A:0, B:1, C:2)
    	li $t4, 1
    	sllv $t4, $t4, $t3  # shift $t4 (1) left by $t3 many bits
    	or $s1, $s1, $t4  # or with sum
    	notaletter:  # non-letters jump to here and are not added
    	addi $t1, $t1, 1
    	j loopstring
 
   checkifup:
   	ble $t2, 'Z', cont  # already uppercase
   	bgt $t2, 'Z', checkiflower1
   
   checkiflower1:
   	blt $t2, 'a', notaletter
   	bge $t2, 'a', checkiflower2
   	
   checkiflower2:
   	ble $t2, 'z', changetoup
   	bgt $t2, 'z', notaletter
   
   changetoup:
   	addi $t2, $t2, -32
    	j cont
    
    exit4:
    	move $v0, $s1
    	jr $ra

##################################
# Part 3 Functions
##################################

cInStrings:
   li $t0, 0  # iteration counter
   li $t9, 0  # char counter
   li $t8, 0  # word counter
   move $s0, $a0  # array
   move $s1, $a1  # len
   move $s2, $a2  # char
   move $t3, $s0  # move array to $t3
   
   # if len <= 0, exit with (-1, -1)
   ble $s1, $zero, exiterror
   
   # change char into uppercase
   bge $s2, 'A', checkifupper
   blt $s2, 'A', continue
   
   checkifupper:
   	ble $s2, 'Z', continue  # already uppercase
   	bgt $s2, 'Z', checkiflowercase1
   
   checkiflowercase1:
   	blt $s2, 'a', continue  # not a letter
   	bge $s2, 'a', checkiflowercase2
   	
   checkiflowercase2:
   	ble $s2, 'z', changetoupper
   	bgt $s2, 'z', continue  # not a letter
   
   changetoupper:
   	addi $s2, $s2, -32
    	j continue
   
   continue:
   
   # store the lowercase version of char
   move $s3, $s2
   addi $s3, $s3, 32
   
   li $t3, 0
   li $t4, 0
   li $t5, 0
   move $t3, $s0

   print_all_strs:
    	li $t7, 0  # if char in string flag
    	beq $t0, $s1, exit5
    	lw $t4, ($t3)
    	print_str:
    		lb $t5, ($t4)
    		beqz $t5, done_with_str
    		beq $t5, $s2, add_letter_counter
    		beq $t5, $s3, add_letter_counter
    		done_adding_letter_counter:
    		addi $t4, $t4, 1
    		j print_str
    	done_with_str:
    	bne $t7, $zero, add_word_counter
    	done_adding_word_counter:
    	addi $t3, $t3, 4
    	addi $t0, $t0, 1
    	j print_all_strs
    	
   add_word_counter:  # count how many words the char occurs in
    	addi $t8, $t8, 1
    	j done_adding_word_counter
	
   add_letter_counter:
    	addi $t9, $t9, 1  # add to letter counter
    	addi $t7, $t7, 1  # if $t7 != 0, char was in string
    	j done_adding_letter_counter
   
   exiterror:
   	li $v0, -1
   	li $v1, -1
   	jr $ra
     
   exit5:
        move $v0, $t8
        move $v1, $t9
    	jr $ra

splitString:
    
    move $s0, $a0  # array
    move $s1, $a1  # n, number of 32-bit words in array (guaranteed to be >= 1)
    move $s2, $a2  # str
    move $s3, $a3  # delim
    
    # handle invalid inputs
    blt $s3, 0x00, invalidinput
    bgt $s3, 0x7F, invalidinput
    lb $t0, ($s2)
    beqz $t0, invalidinput
    
    # reset array to all zeroes
    li $t5, 0  # loop counter
    li $t9, 0
    move $t7, $s0  # array
    resetarr:
    	beq $t5, $s1, donereseting
    	sw $t9, ($t7)
    	addi $t7, $t7, 4
    	addi $t5, $t5, 1
    	j resetarr

    donereseting:
    
    li $t0, 0
    move $t0, $s2  # str
    li $t2, 0  # counter towards n
    li $t5, 0
    move $t5, $s0  # array
    li $t6, 0  # address holder

    move $t9, $t0  # starting address of str
    sw $t9, ($t5)  # store starting address of str at first index of array
    
    # iterate through string
    stringiterator:
    	lb $t1, ($t0)
    	beqz $t1, calculatereturns
    	beq $t1, $s3, delimfound
    	sb $t1, ($t0)
    	donewithdelim:
    	addi $t0, $t0, 1
    	j stringiterator

    delimfound:
    	addi $t2, $t2, 1  # add to counter towards n
    	bgt $t2, $s1, donewithdelim  # max delims (n) reached
    	sb $zero, ($t0)
    	move $t8, $t0  # current address of str
    	addi $t8, $t8, 1  # current address of str + 1
    	addi $t5, $t5, 4
    	sw $t8, ($t5)  # store that address at next array index
    	j donewithdelim

    invalidinput:
    	li $v0, -1
    	li $v1, -1
    	jr $ra
    	
    calculatereturns:
    	addi $t2, $t2, 1  # add one more string after the last delim
    	bgt $t2, $s1, returnmax  # if $t2 > n, the string was not completely tokenized
    	ble $t2, $s1, returncount
    	
    returnmax:
    	move $v0, $s1
    	li $v1, -1
    	jr $ra
    	
    returncount:
    	move $v0, $t2
    	li $v1, 0
    	jr $ra
