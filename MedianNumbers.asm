# MedianNumbers.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#

.data

enter_next: .asciiz "Enter the next number:\n"
response: .asciiz "Median: "
.align 4
numbers: .space 12
newline: .asciiz "\n"

.text

main:
	#s0 is the array counter
	move $s0, $zero

input_loop:
	li $v0, 4
	la $a0, enter_next
	syscall

	li $v0, 5
	syscall

	sw $v0, numbers($s0)
	
	addiu $s0, $s0, 4
	addi $t0, $zero, 12
	beq $s0, $t0, find_median_start
	j input_loop

find_median_start:
	la $s0, numbers

	#compare [0] and [1]
	lw $t0, 0($s0)
	lw $t1, 4($s0)
	slt $t2, $t1, $t0 
	sll $t2, $t2, 1
	
	#compare [0] and [2]
	lw $t0, 0($s0)
	lw $t1, 8($s0)
	slt $t3, $t1, $t0
	or $t2, $t2, $t3
	
	#if $t2 is 0, both [1] and [2] are less
	beq $t2, $zero, find_median_two_less

	#if $t2 is 3, both [1] and [2] are more
	addi $t3, $zero, 3
	beq $t2, $t3, find_median_two_more

	#otherwise first one's median
	lw $s1, 0($s0)
	j print_median

find_median_two_less:
	#greater of [1] and [2]
	lw $t0, 4($s0)
	lw $t1, 8($s0)
	slt $t2, $t0, $t1

	#[2] is bigger
	beq $t2, $zero, find_median_last

	#otherwise second one's median
	lw $s1, 4($s0)
	j print_median

find_median_two_more:
	#lesser of [1] and [2]
	lw $t0, 4($s0)
	lw $t1, 8($s0)
	slt $t2, $t1, $t0

	#[2] is less
	beq $t2, $zero, find_median_last

	#otherwise second one's median
	lw $s1, 4($s0)
	j print_median

find_median_last:
	lw $s1, 8($s0)

print_median:
	li $v0, 4
	la $a0, response
	syscall

	li $v0, 1
	move $a0, $s1
	syscall

	li $v0, 4
	la $a0, newline
	syscall

exit:
	li $v0, 10
	syscall

