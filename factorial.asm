# Factorial.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#

# Assembly (NON-RECURSIVE) version of:
#   int n, fn=1;
#   cout << "Enter the number:\n";
#   cin >> n;
#   for (int x = 2; x <= n; x++) {
#       fn = fn * x;
#   }
#   cout << "Factorial of " << x << " is:\n" << fn << "\n";
#
.data

prompt: .asciiz "Enter a number:\n"
response_a: .asciiz "Factorial of "
response_b: .asciiz " is:\n"
newline: .asciiz "\n"

#Text Area (i.e. instructions)
.text
main:
	li $v0, 4
	la $a0, prompt
	syscall

	li $v0, 5
	syscall

	#original/limit
	move $s0, $v0
	#multiplicand
	addi $s1, $zero, 2
	#result
	addi $s2, $zero, 1

factorial:
	bgt $s1, $s0, print_response

	mult $s1, $s2
	mflo $s2

	addi $s1, $s1, 1

	j factorial

print_response:
	li $v0, 4
	la $a0, response_a
	syscall

	li $v0, 1
	move $a0, $s0
	syscall

	li $v0, 4
	la $a0, response_b
	syscall

	li $v0, 1
	move $a0, $s2
	syscall

	li $v0, 4
	la $a0, newline
	syscall

exit:
	li $v0, 10
	syscall
