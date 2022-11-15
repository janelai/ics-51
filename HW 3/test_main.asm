.include "hw3_helpers.asm"
.include "hw3_laije.asm"

.data 
# DATA GOES HERE
result_eggdrop: .asciiz "Return value of eggDrop: "
result_jobtimes: .asciiz "Return values of getJobTimes: "
newline: .asciiz "\n"
comma: .asciiz ","
array1: .word 0x22240005, 0x040F0010, 0x30320009, 0x07080003, 0x040A0010, 0x05060005, 0x07180003
result_jobpartition: .asciiz "Return value of jobPartition: "
array2: .word 0x06130064, 0x203200C8
result_maxprofit: .asciiz "Return value of findMaxProfit: "
array3: .word 0x01060006, 0x02050005, 0x05070005, 0x06080003
result_quicksort: .asciiz "Return value of jobQuicksort: "
result_weighted: .asciiz "Return value of weightedScheduling: "

.globl main
.text
main:

# CODE GOES HERE

	# trib
	#li $a0, 1
	#jal trib
	
	# eggDrop
	#li $a0, 2
	#li $a1, 6
	#jal eggDrop
	#move $t0, $v0
	#li $v0, 4
	#la $a0, result_eggdrop
	#syscall
	#li $v0, 1
	#move $a0, $t0
	#syscall
	
	#li $v0, 4
	#la $a0, newline
	#syscall
	
	# getjobtimes
	#li $a0, 0xff9f2020
	#jal getJobTimes
	#move $t0, $v0
	#move $t1, $v1
	#li $v0, 4
	#la $a0, result_jobtimes
	#syscall
	#li $v0, 1
	#move $a0, $t0
	#syscall
	#li $v0, 4
	#la $a0, comma
	#syscall
	#li $v0, 1
	#move $a0, $t1
	#syscall
	#li $v0, 4
	#la $a0, newline
	#syscall
	
	# jobpartition
	#la $a0, array1
	#li $a1, 7  # len
	#li $a2, 0  # low
	#li $a3, 6  # high
	#jal jobPartition
	#move $t0, $v0
	#li $v0, 4
	#la $a0, result_jobpartition
	#syscall
	#li $v0, 1
	#move $a0, $t0
	#syscall
	
	# jobquicksort
	#la $a0, array3
	#li $a1, 4
	#li $a2, 0
	#li $a3, 3
	#jal jobQuicksort
	#move $t0, $v0
	#li $v0,4
	#la $a0, result_quicksort
	#syscall
	#li $v0, 1
	#move $a0, $t0
	#syscall
	
	# findmaxprofit
	#la $a0, array2
	#li $a1, 2
	#jal findMaxProfit
	#move $t0, $v0
	#li $v0, 4
	#la $a0, result_maxprofit
	#syscall
	#li $v0, 1
	#move $a0, $t0
	#syscall
	
	# weightedscheduling
	la $a0, array3
	li $a1, 4
	jal weightedScheduling
	move $t0, $v0
	li $v0, 4
	la $a0, result_weighted
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	
	j end

end:
	li $v0, 10
	syscall
