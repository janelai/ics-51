.include "hw2_laije.asm"

.globl main

# Data Section
.data
#array: .word  str_abc, str_hello, str_b, str_foo, str_boo 
#len: .word 5
#c: .byte 'o'

array: .word  str_1, str_2, str_3
len: .word 3
c: .byte 'A'

strLabel1: .asciiz "Function returned: ("
comma: .asciiz ", "
paren: .asciiz ")\n"

#str_foo: .asciiz "FOO"
#str_hello: .asciiz "HeLLO!"
#str_abc: .asciiz "Abc"
#str_b: .asciiz "b"
#str_boo: .asciiz "Boo"

str_1: .asciiz "AAA"
str_2: .asciiz "a"
str_3: .asciiz "Jane"


# Program 
.text
main:
    # load the value into the argument register
    la $a0, array
    la $a1, len
    lw $a1, 0($a1)
    la $a2, c
    lb $a2, 0($a2)

    # call the function
    jal cInStrings

    # save the return value
    move $t8, $v0
    move $t9, $v1

    # print string
    li $v0, 4
    la $a0, strLabel1
    syscall

    #print first return value
    move $a0, $t8
    li $v0, 1
    syscall

    #print comma
    la $a0, comma
    li $v0, 4
    syscall

    #print second return value
    move $a0, $t9
    li $v0, 1
    syscall

    #print closing paren
    la $a0, paren
    li $v0, 4
    syscall

    # Exit the program
    li $v0, 10
    syscall
