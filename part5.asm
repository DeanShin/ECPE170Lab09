	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# Main function
#-------------------------------------------------------------------
main:
	# Initialize variables
	# Mapping:
	# s0 = &string
	# s1 = i
	# s2 = result
	la $s0, string  # s0 = pointer to string
	li $s1, 0 		# s1 = i
	la $s2, result	# s2 = pointer to result pointer
	lw $s2, 0($s2)  # s2 = result pointer
	
	# Obtain string from user
	move $a0, $s0 	# Provide memory address of string input buffer
	li $a1, 256		# Provide length of string buffer (256)
	li $v0, 8		# Select syscall for read_string
	syscall			# Read a string from the user

	# While loop
	WHILE_START:
		add $t0, $s0, $s1		# t0 = &string[i]	
		lb $t1, 0($t0)			# t1 = string[i]
		li $t2, 0				# t2 = ascii for '\0'
		beq $t1, $t2, WHILE_END	# exit while loop if string[i] == '\0'

		# If statement
		li $t2, 101				# t2 = ascii for 'e'
		bne $t1, $t2, ENDIF		# don't process if statement if string[i] != 'e'

		IF:
			move $s2, $t0		# result = &string[i]
			j WHILE_END			# break;
		ENDIF:

		addi $s1, $s1, 1		# i++
		j WHILE_START
	WHILE_END:


	# If statement
	beq $s2, $zero, ELSE_2 	# Go to else if result == NULL
	IF_2:
		la $a0, msg1	# Load msg1 for print
		li $v0, 4		# Select syscall for print_string
		syscall			# Print "First match at address "

		move $a0, $s2	# Load result pointer for print
		li $v0, 1		# Select syscall for print_int
		syscall			# Print result pointer

		la $a0, endl	# Load endl for print
		li $v0, 4		# Select syscall for print_string
		syscall			# Print "\n"

		la $a0, msg2	# Load msg2 for print
		li $v0, 4		# Select syscall for print_string
		syscall			# Print "The matching character is "

		lb $a0, 0($s2)	# Load character stored at result for print
		li $v0, 11		# Select syscall for print_char
		syscall			# Print character stored at result

		la $a0, endl	# Load endl for print
		li $v0, 4		# Select syscall for print_string
		syscall			# Print "\n"
		j ENDIF_2
	ELSE_2:
		la $a0, msg3	# Load msg3 for print
		li $v0, 4		# Select syscall for print_string
		syscall			# Print "No match found\n"
		j ENDIF_2
	ENDIF_2:

	# Update result in memory.
	la $t0, result	# t0 = pointer to result pointer
	sw $s2, 0($t0)  # s2 = result pointer

	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit

# Data section
#-------------------------------------------------------------------
	.data # Mark the start of the data section

	string: .space 256  # Initialize space for 256 characters in memory.
	result: .word 0		# Initialize result pointer in memory.
	msg1: .asciiz "First match at address "
	msg2: .asciiz "The matching character is "
	msg3: .asciiz "No match found\n"
	endl: .asciiz "\n"