	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# Main function
#-------------------------------------------------------------------
main:
	# Initialize variables
	# s0 = &A
	# s1 = &B
	# s2 = C
	# s3 = i
	la $s0, A  # s0 = pointer to A
	la $s1, B  # s1 = pointer to B
	li $s2, 12 # s2 = C = 12
	li $s3, 0  # s3 = i = 0

	# For loop
	li $t0, 5  # t0 = 5
	li $t1, 4  # t1 = 4
	FOR_START:
		bge $s3, $t0, FOR_END 	# if i >= 5, then exit for loop.
		
		mul $t2, $s3, $t1     	# t2 = i * 4

		add $t3, $s1, $t2		# t3 = &B[i]
		lw $t3, 0($t3)			# t3 = B[i]
		add $t3, $t3, $s2		# t3 = B[i] + C

		add $t4, $s0, $t2		# t4 = &A[i]
		sw $t3, 0($t4)			# A[i] = B[i] + C

		addi $s3, $s3, 1 	  	# i++
		j FOR_START
	FOR_END:

	addi $s3, $s3, -1	# i--

	# While loop
	li $t0, 0  # t0 = 0
	li $t1, 4  # t1 = 4
	WHILE_START:
		blt $s3, $t0, WHILE_END # if i is not >= 0, then jump to WHILE_END.
		mul $t2, $s3, $t1     	# t2 = i * 4
		add $t2, $s0, $t2		# t2 = &A[i]
		lw $t3, 0($t2)			# t3 = A[i]
		add $t3, $t3, $t3		# t3 = 2 * A[i]
		sw $t3, 0($t2)			# A[i] = 2 * A[i]
		addi $s3, $s3, -1		# i--
		j WHILE_START			# loop
	WHILE_END:

	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit

# Data section
#-------------------------------------------------------------------
	.data # Mark the start of the data section

	A: .space 20 	   # Initialize 20 bytes (5 words) for array A.
	B: .word 1 2 3 4 5 # Initialize B as {1,2,3,4,5};