# Homework 1
# Name: Jane Lai
# Net ID: laije
.globl main

.data
err_string: .asciiz "\nERROR"
prompt_type: .asciiz "Number (1) or String (a/A)? "
prompt_string: .asciiz "Enter a string (max 100 chars): "
prompt_number: .asciiz "Enter a number: "
prompt_length: .asciiz "Length of string: "
prompt_space: .asciiz "# of spaces: "   
prompt_digit: .asciiz "# of digits: "
prompt_symbols: .asciiz "# of symbols: "
prompt_numtype: .asciiz "Signed Magnitude (0), 1's Complement (1)? "
prompt_signedmagnitude: .asciiz "Signed Magnitude: "
prompt_onescomplement: .asciiz "1's Complement: "
prompt_twoscomplement: .asciiz "2's Complement: "
prompt_xor: .asciiz "XOR: "
prompt_firstbyte: .asciiz "1st byte: "
prompt_secondbyte: .asciiz "2nd byte: "
prompt_thirdbyte: .asciiz "3rd byte: "
prompt_proceedtotoggle: .asciiz "Proceeding to toggle: "
.align 2
	new_line: .asciiz "\n"
	buffer: .space 102
	space: .asciiz " "


.text
main:
    
    	# Ask user for their input type (int or str)
    	li $v0, 4
    	la $a0, prompt_type
    	syscall
 
    	# Retrieve and verify the input from the user
    	li $v0, 12
    	syscall
    	move $s0, $v0
    	li $t0, '1' # Add '1' to temporary register
    	li $t1, 'a' # Add 'a' to temporary register
    	li $t2, 'A' # Add 'A' to temporary register
    	
    	# If input is '1', prompt user for an integer (positive, negative, or zero)
    	beq $s0, $t0, enterInt
    	
    	# If input is 'a' or 'A', prompt user for a string
    	beq $s0, $t1, enterString
    	beq $s0, $t2, enterString
    	
    	# Else, print error string and exit
    	bne $s0, $t0, exitError
    	
    	enterInt:
    		li $v0, 4
    		la $a0, new_line
    		syscall
    		la $a0, prompt_number
    		syscall
    		li $v0, 5
    		syscall
    		move $s1, $v0
    		
    		# Print entered integer in binary form
    		li $v0, 35
    		move $a0, $s1
    		syscall

    		# Prompt the user to enter a number representation
    		whileInputInvalid:
    			li $v0, 4
    			la $a0, new_line
    			syscall
    			la $a0, prompt_numtype
    			syscall
    		
 			# Keep prompting while input is not 0 or 1
 			li $v0, 5
 			syscall
 			beq $v0, $zero, printTypes
 			beq $v0, 1, printTypes
 			j whileInputInvalid
 		
 		printTypes:
 			move $s3, $v0  # Move input to temporary register
 		
 			# If input is 0, print the signed magnitude
 			# If input is 1, print the 1's complement
 			beq $s3, $zero, signedMagnitude
 			beq $s3, 1, onesComplement
 		
 		Endif:
 		
 		# Print the 2's complement
 		# If the number is >= 0, do nothing
 		# Else, flip the bits and add 1
 		sgt $t1, $s1, $zero
 		beq $t1, $zero, negativeTwos
 		beq $t1, 1, positiveTwos
 		
 		negativeTwos:
 			subu $s4, $zero, $s1  # negate the negative value (so that it's positive)
 			nor $s4, $s4, $zero  # flip the bits
 			#addiu $s4, $s4, 1  # add 1

 			li $v0, 4
    			la $a0, new_line
    			syscall
    			#la $a0, prompt_twoscomplement
    			#syscall
 			li $v0, 1
 			move $a0, $s4
 			syscall
 			b	continueXOR
 			
 		positiveTwos:
 			li $v0, 4
    			la $a0, new_line
    			syscall
    			li $v0, 1
    			move $a0, $s1
 			syscall
 			b	continueXOR
 		
 		continueXOR:
 		# XOR UValue and ModValues and print
 		li $t6, 2
 		xor $s5, $s3, $s1
 		
 		#div $s5, $t6
 		#mfhi $t2
 		#mflo $t3
 		#add $s6, $t2, $t3
 		#move $s6, $t2
 		li $v0, 4
 		la $a0, new_line
 		syscall
    		#la $a0, prompt_xor
    		#syscall
 		li $v0, 35
 		move $a0, $s5
 		syscall
 		li $v0, 4
 		la $a0, space
 		syscall
 		
 		# Find number of 1s
 		li $s6, 0  # $s6 stores the number of 1s
 		j	iterate
 		
 		iterate:
 			andi $t2, $s5, 1  # AND xor number with 1 to find out if bit is 1
 			add $s6, $s6, $t2
 			srl $s5, $s5, 1
 			beq $t0, $zero, exitIteration
 			j	iterate
 		exitIteration:
 		
 		li $v0, 1
 		move $a0, $s6
 		syscall
 		li $v0, 4
 		la $a0, new_line
 		syscall
 		j	Exit
    		
    	signedMagnitude:
 		#li $v0, 4
 		#la $a0, prompt_signedmagnitude
 		#syscall
 		# Print binary representation of signed magnitude
 		# If the number is >= 0, do nothing and return binary
 		# Else, flip the bits using nor
 		sgt $t1, $s1, $zero
 		beq $t1, $zero, negativeSigned
 		beq $t1, 1, positiveSigned
 		
 		negativeSigned:
 			# TODO
 			subu $s3, $zero, $s1  # negate the negative value (so that it's positive)
 			addiu $s3, $s3, 0x80000000  # add signed bit to the front
 			li $v0, 35
 			move $a0, $s3
 			syscall 
 			li $v0, 4
 			la $a0, new_line
    			syscall
 			li $v0, 39  # Print neg signed magnitude designated format
 			syscall
			b	Endif
		
 		positiveSigned: # do nothing if number is positive (since positive numbers do not change in signed and 1's) and just return binary
 			li $v0, 35
 			move $s3, $s1
 			move $a0, $s3
 			syscall
 			li $v0, 4
 			la $a0, new_line
    			syscall
 			li $v0, 39
 			move $a0, $s3
 			syscall
 			b	Endif  # Print pos signed magnitude designated format (syscall 39)
 		
 	onesComplement:
    		#li $v0, 4
 		#la $a0, prompt_onescomplement
 		#syscall
 		
 		# Print binary representation of 1's complement
 		# If the number is >= 0, do nothing and return binary
 		# Else, flip the bits of the number's positive ver using nor
 		sgt $t1, $s1, $zero
 		beq $t1, $zero, negativeOnes
 		beq $t1, 1, positiveOnes
 		
 		negativeOnes:
 			sub $s3, $zero, $s1  # negate the negative value (so that it's positive)
 			nor $s3, $s3, $zero  # flip the bits
 			li $v0, 35
 			move $a0, $s3
 			syscall
 			li $v0, 4
 			la $a0, new_line
    			syscall
 			li $v0, 38  # Print neg 1's complement designated format
 			move $a0, $s3
 			syscall
			b	Endif
			
 		positiveOnes:  # do nothing if number is positive (since positive numbers do not change in signed and 1's) and just return binary
 			li $v0, 35
 			move $s3, $s1
 			move $a0, $s3
 			syscall
 			li $v0, 4
 			la $a0, new_line
    			syscall
 			li $v0, 38  # Print pos 1's complement designated format (syscall 38)
 			move $a0, $s3
 			syscall
 			b	Endif
 		
 	enterString:
    		li $v0, 4
    		la $a0, new_line
    		syscall
    		la $a0, prompt_string
    		syscall
    		li $v0, 8
    		la $a0, buffer  # Load byte space into the address
    		li $a1, 102
    		move $s0, $a0  # Save string to $s0
    		syscall
    		
    		# Display inputted string
    		la $a1, buffer
    		#li $v0, 4
    		#syscall
		
		# $s3 = count, $s4 = num_spaces, $s5 = num_digits, $s6 = num_symbols
		# $t1 = char, $t2 = '\n', $t3 = 0x20 (space), $t4 = new offset

    		li $t2, '\n'
    		li $t3, 0x20
    		
		add $a1, $a1, $t4  # Add offset since can't be immediately added in lb
		
		while:
			lb $t1, ($a1)  # Load byte
			beq $t1, $t2, end  # If equal to newline terminator, end
			bne $t1, $t2, addCount  # Else, add to char count
			finishCount:
			
			beq $t1, $t3, addSpace  # If space, add to space count
			finishSpace:
			
			li $t5, 0x30  # Lower hex range for digit
			li $t6, 0x39  # Upper hex range for digit
			sge $t7, $t1, $t5  # If within the hex range for 0-9, add to digit count
			sle $t8, $t1, $t6
			beq $t7, 1, confirmDigit
			bne $t7, 1, finishDigit
			confirmDigit:
				beq $t8, 1, addDigit
				bne $t8, 1, finishDigit
				b	finishDigit
			finishDigit:
			
			confirmSymbol0:
				li $t5, 0x21  # Lower hex range for symbol pt 1
				li $t6, 0x2F  # Upper hex range for symbol pt 1
				sge $t7, $t1, $t5  # If within the 1st hex range, add to symbol count
				sle $t8, $t1, $t6
				beq $t7, 1, confirmSymbol1
				bne $t7, 1, confirmSymbol2
				b	finishSymbol
				confirmSymbol1:
					beq $t8, 1, addSymbol
					bne $t8, 1, confirmSymbol2
					b	finishSymbol
			confirmSymbol2:
				li $t5, 0x3A  # Lower hex range for symbol pt 2
				li $t6, 0x40  # Upper hex range for symbol pt 2
				sge $t7, $t1, $t5  # If within the 2nd hex range, add to symbol count
				sle $t8, $t1, $t6
				beq $t7, 1, confirmSymbol3
				bne $t7, 1, confirmSymbol4
				b	finishSymbol
				confirmSymbol3:
					beq $t8, 1, addSymbol
					bne $t8, 1, confirmSymbol4
					b	finishSymbol
			confirmSymbol4:
				li $t5, 0x5B  # Lower hex range for symbol pt 3
				li $t6, 0x60  # Upper hex range for symbol pt 3
				sge $t7, $t1, $t5  # If within the 3rd hex range, add to symbol count
				sle $t8, $t1, $t6
				beq $t7, 1, confirmSymbol5
				bne $t7, 1, confirmSymbol6
				b	finishSymbol
				confirmSymbol5:
					beq $t8, 1, addSymbol
					bne $t8, 1, confirmSymbol6
					b	finishSymbol
			confirmSymbol6:
				li $t5, 0x7B  # Lower hex range for symbol pt 3
				li $t6, 0x7E  # Upper hex range for symbol pt 3
				sge $t7, $t1, $t5  # If within the 3rd hex range, add to symbol count
				sle $t8, $t1, $t6
				beq $t7, 1, confirmSymbol7
				bne $t7, 1, finishSymbol
				b	finishSymbol
				confirmSymbol7:
					beq $t8, 1, addSymbol
					bne $t8, 1, finishSymbol
					b	finishSymbol
			finishSymbol:
			
			li $t4, 1
			add $a1, $a1, $t4  # Add offset since can't be immediately added in lb
			j	while
		end:
		j	printEverything

		addCount:
			addi $s3, $s3, 1
			b	finishCount
		addSpace:
			addi $s4, $s4, 1
			b	finishSpace
		addDigit:
			addi $s5, $s5, 1
			b	finishDigit
		addSymbol:
			addi $s6, $s6, 1
			b	finishSymbol
			
    		# Print length of string, # of spaces, # of digits, # of symbols
    		printEverything:
    		
    		li $v0, 4
    		la $a0, prompt_length
    		syscall
    		li $v0, 1
    		move $a0, $s3
    		syscall
    		
    		li $v0, 4
    		la $a0, new_line
    		syscall
    		la $a0, prompt_space
    		syscall
    		li $v0, 1
    		move $a0, $s4
    		syscall
    		
    		li $v0, 4
    		la $a0, new_line
    		syscall
    		la $a0, prompt_digit
    		syscall
    		li $v0, 1
    		move $a0, $s5
    		syscall
    		
    		li $v0, 4
    		la $a0, new_line
    		syscall
    		la $a0, prompt_symbols
    		syscall
    		li $v0, 1
    		move $a0, $s6
    		syscall
    		
    	# Toggle all letters
    	# li $t2, '\n'
    	li $t4, 0
    	la $a1, buffer
    	add $a1, $a1, $t4
    	li $v0, 4
    	la $a0, new_line
    	syscall
    	
    	j	whileToggle
    	
    	whileToggle:
    		lb $t1, ($a1)  # Load byte
		beq $t1, $t2, endToggle  # If equal to newline terminator, end
		
		li $t5, 0x41  # Lower hex range for uppercase
		li $t6, 0x5A  # Upper hex range for uppercase
		sge $t7, $t1, $t5  # If within the hex range for uppercase, toggle to lower
		sle $t8, $t1, $t6
		beq $t7, 1, confirmToggleToLower
		bne $t7, 1, noToggleToLower
		confirmToggleToLower:
			beq $t8, 1, toggleToLower
			bne $t8, 1, noToggleToLower
		noToggleToLower:	
		li $t5, 0x61  # Lower hex range for lowercase
		li $t6, 0x7A  # Upper hex range for lowercase
		sge $t7, $t1, $t5  # If within the hex range for lowercase, toggle to upper
		sle $t8, $t1, $t6
		beq $t7, 1, confirmToggleToUpper
		bne $t7, 1, finishToggle
		confirmToggleToUpper:
			beq $t8, 1, toggleToUpper
			bne $t8, 1, finishToggle
		
		toggleToLower:
			addi $t1, $t1, 32
			b	finishToggle
		toggleToUpper:
			addi $t1, $t1, -32
			b	finishToggle
		
		finishToggle:
		li $v0, 11
		move $a0, $t1
		syscall	
		li $t4, 1
		add $a1, $a1, $t4  # Add offset since can't be immediately added in lb
		
		j	whileToggle
		
	endToggle:
		li $v0, 4
		la $a0, new_line
		syscall
    		j	Exit
 		
    	exitError:
    		li $v0, 4
    		la $a0, err_string
    		syscall
    		li $v0, 10
    		syscall
    	
    	Exit:
    		# Quit the program
		li $v0, 10
    		syscall
