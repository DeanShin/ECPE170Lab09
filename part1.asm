	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# Main function
#-------------------------------------------------------------------
main:
	# Initialize variables
	# t0 = A
	# t1 = B
	# t2 = C
	# t3 = D
	# t4 = E
	# t5 = F
	li $t0, 15 # Set $t0, which represents A, to 15.
	li $t1, 10 # Set $t1, which represents B, to 10.
	li $t2, 7 # Set $t2, which represents C, to 7.
	li $t3, 2 # Set $t3, which represents D, to 2.
	li $t4, 18 # Set $t4, which represents E, to 18.
	li $t5, -3 # Set $t5, which represents F, to -3.

	# Perform inner calculations
	add $t6, $t0, $t1 # $t6 = A + B
	sub $t7, $t2, $t3 # $t7 = C - D
	add $t8, $t4, $t5 # $t8 = E + F
	sub $t9, $t0, $t2 # $t9 = A - C

	# Perform middle calculations
	add $t0, $t6, $t7 # $t0 = (A + B) + (C - D)
	sub $t1, $t8, $t9 # $t1 = (E + F) - (A - C)

	# Perform outer calculation
	add $t0, $t0, $t1 # $t0 = ((A + B) + (C - D)) + ((E + F) - (A - C))

	la $t1, Z # t1 = address of Z
	sw $t0, 0($t1) # Store ((A + B) + (C - D)) + ((E + F) - (A - C)) in Z.

	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit

# Data section
#-------------------------------------------------------------------
	.data # Mark the start of the data section

	Z: .word 0 # Initialize space for a single integer in memory for Z.