.include "lab3_A_laije.asm"
.include "lab3_B_laije.asm"
.include "lab3_functions.asm"

.globl main

.data
strings: .word str_hello, str_b, str_foo, str_xyz, str_world, str_123, str_bar, str_help, str_abc
n: .word 9
pellet: .asciiz "HeLRO!"
ghost: .asciiz "A@b"


str_foo: .asciiz "FOO"
str_bar: .asciiz "BARRRR"
str_hello: .asciiz "HeLLO!"
str_world: .asciiz "@! wOrLd $!&"
str_abc: .asciiz "Abc"
str_xyz: .asciiz "XXyZ"
str_123: .asciiz "123"
str_b: .asciiz "b"
str_help: .asciiz "HELP! HELP! HELP!"

.text
main:
	la $a0, strings
	la $t0, n
	lw $a1, 0($t0)
	la $a2, pellet
	la $a3, ghost
	jal playPacman

	li $v0, 10
	syscall
