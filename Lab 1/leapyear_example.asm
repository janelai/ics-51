# Check for leap year. Keep prompting for years until the user enters a leap year.
# In Gregorian Calendar: "A year is a leap year if it is divisible by 4 with 
# the exception of century years that are not divisible by 400" 
# Also, this calendar was adopted in 1582, so the entered year must be >= 1582.
# That is:  if (year % 4 != 0) then ordinary_year 
#           else if (year % 100 == 0) and (year % 400 != 0) then ordinary_year
#           else leap_year

.data 
year:    	.word 0 
prompt:  	.asciiz "Enter year: " 
leap_msg: 	.asciiz " is a leap year\n" 
ord_msg:		.asciiz " is an ordinary year\n" 
err_msg:		.asciiz "You must enter a year after 1582.\n"

.text 
.globl main

error: 
	li $v0, 4
	la $a0, err_msg
	syscall
	
main: 
	li $v0, 4 
	la $a0, prompt 
	syscall                # print a prompt

	li $v0, 5 
	syscall                # read an integer 
	
	li $t1, 1582
	blt $v0, $t1, error
	
	# not an error
	
	# if ( year % 4 != 0)
	li $t1, 4
	div $v0, $t1	# hi = year % 4
	mfhi $t1
	bne $t1, $0, ordinary_year
	
	# if (year %100 != 0) -> leap year
	li $t1, 100
	div $v0, $t1	# hi = year % 100
	mfhi $t1
	bne $t1, $0, leap_year
	
	# if (year %400 == 0) -> ordinary year
	li $t1, 400
	div $v0, $t1	# hi = year % 400
	mfhi $t1
	bne $t1, $0, ordinary_year
		
leap_year:		
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, leap_msg
	syscall									
					
	j done		
	
	    
ordinary_year:
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, ord_msg
	syscall
	
done:      
	# terminate program
	li $v0, 10
	syscall


