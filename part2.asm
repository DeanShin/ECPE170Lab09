	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# Main function
#-------------------------------------------------------------------
main:
	# Initialize registers
	# s0 = A
	# s1 = B
	# s2 = C
	# s3 = Z
	lw $s0, A # Reg $s0 = A
	lw $s1, B # Reg $s1 = B
	lw $s2, C # Reg $s2 = C
	lw $s3, Z # Reg $s3 = Z

	# If statement

	# Process A > B || C < 5
	# t0 = 5
	bgt $s0, $s1, If 	# If A > B, then jump to If.
	li $t0, 5 			# $t0 = 5
	blt $s2, $t0, If 	# or, if C < 5, then jump to If.

	# Process A > B && (C + 1 == 7)
	# t0 = C + 1
	# t1 = 7
	ble $s0, $s1, Else 	# If A <= B, then jump to Else
	addi $t0, $s2, 1 	# $t0 = C + 1
	li $t1, 7 			# $t1 = 7
	bne $t0, $t1, Else  # If (C + 1) != 7, then jump to Else

	j ElseIf			# If we got here, A > B && C + 1 == 7.

	If:
		li $s3, 1 # Z = 1
		j EndIf # Jump to EndIf
	ElseIf:
		li $s3, 2 # Z = 2
		j EndIf # Jump to EndIf
	Else:
		li $s3, 3 # Z = 3
		j EndIf # Jump to EndIf
	EndIf:


	# Switch statement
	# t0 = 1
	li $t0, 1			# $t0 = 1
	beq $s3, $t0, Case1 # If Z = 1, then go to case 1
	# t0 = 2
	li $t0, 2			# $t0 = 2
	beq $s3, $t0, Case2 # If Z = 2, then go to case 1
	j Default			# Otherwise, go to Default.

	Case1:
		li $s3, -1		# Z = -1
		j EndSwitch 	# Break
	Case2:
		li $s3, -2		# Z = -2
		j EndSwitch 	# Break
	Default:
		li $s3, 0		# Z = 0
		j EndSwitch 	# Break
	EndSwitch:

	# Store variables back in memory.
	la $t0, A # $t0 = Address of A
	sw $s0, 0($t0) # Store A in memory
	la $t0, B # $t0 = Address of B
	sw $s1, 0($t0) # Store B in memory
	la $t0, C # $t0 = Address of C
	sw $s2, 0($t0) # Store C in memory
	la $t0, Z # $t0 = Address of Z
	sw $s3, 0($t0) # Store D in memory

	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit


# Data section
#-------------------------------------------------------------------
	.data # Mark the start of the data section

	A: .word 10 # Initialize A as 10
	B: .word 15 # Initialize B as 15
	C: .word 6 # Initialize C as 6
	Z: .word 0 # Initialize Z as 0