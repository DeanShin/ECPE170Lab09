# Main function
#-------------------------------------------------------------------

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

main:
	# Initialize registers
	# s0 = Z
	# s1 = i
	lw $s0, Z # Reg $s0 = Z
	lw $s1, i # Reg $s1 = i

	li $s1, 0 # i = 0

	# While statement
	WHILE_START:
		li $t0, 20 # t0 = 20
		bgt $s1, $t0, WHILE_END # if i > 20, break
		addi $s0, $s0, 1 # Z++
		addi $s1, $s1, 2 # i += 2
		j WHILE_START # Go back to top of while loop
	WHILE_END:

	# Do-while statement
	DO_WHILE_START:
		addi $s0, $s0, 1 # Z++
		li $t0, 100 # t0 = 100
		blt $s0, $t0, DO_WHILE_START
	DO_WHILE_END:

	# While statement #2
	WHILE_2_START:
		li $t0, 0 # t0 = 0
		ble $s1, $t0, WHILE_2_END # Opposite of i > 0. If i <= 0, then exit while loop.
		addi $s0, $s0, -1 # Z--
		addi $s1, $s1, -1 # i--
		j WHILE_2_START
	WHILE_2_END:

	# Store variables back in memory.
	la $t0, Z # $t0 = Address of Z
	sw $s0, 0($t0) # Store Z in memory
	la $t0, i # $t0 = Address of i
	sw $s1, 0($t0) # Store i in memory

	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit


# Data section
#-------------------------------------------------------------------
	.data # Mark the start of the data section

	Z: .word 2 # Initialize Z = 2
	i: .word 0 # Initialize i = 0