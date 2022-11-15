.text
.globl main

main:
# Code & Instructions defined here
	li $v0, 10
	syscall
	
.data
# Global Variables defined here
memory: .space 5  

int_array: .word 1,2,3,4,5,6   # int_array[6] = {1,2,3,4,5,6}
byte_array: .byte 'a','b','c','d','e','f'  # char byte_array[6] = {'a','b','c','d','e','f'"}

string: .ascii "abcdef"    # 6 bytes
string2: .asciiz "ABCDEF"  # 7 bytes
string3: .asciiz "!@#"
