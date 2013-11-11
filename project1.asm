.data
firstmsg: .asciiz "Please enter the irreducible polynomial in hex:\n"
secondmsg: .asciiz "Please enter B in row major order:\n"
finalmsg: .asciiz "\nThe product matrix C is:\n\n"
newline: .asciiz "\n"
spacer: .asciiz " "
result: .space 8
	.asciiz "\n"
B11: .space 10
B12: .space 10
B13: .space 10
B14: .space 10
B21: .space 10
B22: .space 10
B23: .space 10
B24: .space 10
B31: .space 10
B32: .space 10
B33: .space 10
B34: .space 10
B41: .space 10
B42: .space 10
B43: .space 10
B44: .space 10
polynomial: .space 50
inputspace: .space 10

# size of the field is not variable any more, it is fixed at 8

.text
# t5, t6 - used in calculating the power of 2
# ^^^^ NO LONGER NEEDED, it is directly 256
# t9 - the temporary answer to an element of C as it is being calculated
# t4 - to access from and store B/C
# t5 - counter for input
# s6 - 2
# s7 - 3

main:
	li $s6, 2
	li $s7, 3

	la $a0, firstmsg
	li $v0, 4
	syscall
	
	li $v0, 8
	la $a0,polynomial
	li $a1, 20
	syscall
	
	li $a1, 1
	li $a2, 16
	jal hextodecimal
	move $s4, $v0
 	# s4 contains the irreducible polynomial as a hex number
	and $s4, $s4, 255
	# s4 now has the irreducible polynomial without highest term
 	
 	la $a0, secondmsg
	li $v0, 4
	syscall
	
	li $a1, 10
	
	li $v0, 8
	la $a0,B11
	syscall
	li $v0, 8
	la $a0,B12
	syscall
	li $v0, 8
	la $a0,B13
	syscall
	li $v0, 8
	la $a0,B14
	syscall
	
	li $v0, 8
	la $a0,B21
	syscall
	li $v0, 8
	la $a0,B22
	syscall
	li $v0, 8
	la $a0,B23
	syscall
	li $v0, 8
	la $a0,B24
	syscall
	
	li $v0, 8
	la $a0,B31
	syscall
	li $v0, 8
	la $a0,B32
	syscall
	li $v0, 8
	la $a0,B33
	syscall
	li $v0, 8
	la $a0,B34
	syscall
	
	li $v0, 8
	la $a0,B41
	syscall
	li $v0, 8
	la $a0,B42
	syscall
	li $v0, 8
	la $a0,B43
	syscall
	li $v0, 8
	la $a0,B44
	syscall
	
	##################
	
	la $a0, finalmsg
	li $v0, 4
	syscall
	
	##################
	
	li $t9, 0
	
	la $a0, B11
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B21
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B31
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B41
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, spacer
	syscall
	
	#####################3
	
	li $t9, 0
	
	la $a0, B12
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B22
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B32
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B42
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, spacer
	syscall
	
	#####################3
	
	li $t9, 0
	
	la $a0, B13
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B23
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B33
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B43
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, spacer
	syscall
	
	#####################3
	
	li $t9, 0
	
	la $a0, B14
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B24
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B34
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B44
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	##################
	##################
	
	li $t9, 0
	
	la $a0, B11
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B21
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B31
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B41
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, spacer
	syscall
	
	#####################3
	
	li $t9, 0
	
	la $a0, B12
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B22
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B32
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B42
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, spacer
	syscall
	
	#####################3
	
	li $t9, 0
	
	la $a0, B13
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B23
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B33
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B43
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, spacer
	syscall
	
	#####################3
	
	li $t9, 0
	
	la $a0, B14
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B24
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B34
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B44
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	##################
	##################
	
	li $t9, 0
	
	la $a0, B11
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B21
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B31
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B41
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, spacer
	syscall
	
	#####################3
	
	li $t9, 0
	
	la $a0, B12
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B22
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B32
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B42
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, spacer
	syscall
	
	#####################3
	
	li $t9, 0
	
	la $a0, B13
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B23
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B33
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B43
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, spacer
	syscall
	
	#####################3
	
	li $t9, 0
	
	la $a0, B14
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B24
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B34
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B44
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	##################
	##################
	
	li $t9, 0
	
	la $a0, B11
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B21
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B31
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B41
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, spacer
	syscall
	
	#####################3
	
	li $t9, 0
	
	la $a0, B12
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B22
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B32
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B42
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, spacer
	syscall
	
	#####################3
	
	li $t9, 0
	
	la $a0, B13
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B23
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B33
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B43
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, spacer
	syscall
	
	#####################3
	
	li $t9, 0
	
	la $a0, B14
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B24
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	la $a0, B34
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	
	la $a0, B44
	jal hextodecimal
	move $s1, $v0
	move $s2, $s1
	jal multiplication
	move $s1, $t9
	move $s2, $t6
	xor $t9, $s1, $s2
	
	move $t2, $t9
	jal decimaltohex
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	########################
	
inputdone:
 	
 	li $v0, 10
 	syscall
 	
 	###########################
 	# addition sub-routine, arguments in decimal in $s1 and $s2, sum as decimal in s4
	
addition:
	xor $s4, $s1, $s2 #s4 contains the answer in decimal
	move $t2, $s4

	
	jr $ra
	
	###########################
	
	###########################
	# DECIMALTOHEX SUB-ROUTINE, argument as decimal in $t2, answer as hex in space result
	
decimaltohex:
	li $t0,2
	la $t3,result
	rol $t2, $t2, 24
loop:
	rol $t2,$t2,4         ### start with leftmost and rotate to leftmost
	and $t1,$t2,15
	ble $t1,9,print
	
	add $t1,$t1,7
	
print:
	add $t1,$t1,48
	sb $t1,($t3)
	add $t3,$t3,1
	add $t0,$t0,-1
	bnez $t0,loop
 	
 	jr $ra
 	
 	#########################

	############################
	# HEXTODECIMAL SUB-ROUTINE, argument as hex in a0, result as decimal in v0
hextodecimal:
	addi $t7, $zero, 0
	
convertloop:
	lb $t0, ($a0)
	beq $t0, 10, error
	beqz $t0, error
	li $t1, 0x30
	li $t2, 0x39
	blt $t0, $t1, error
	bgt $t0, $t2, a2f
	add $t0, $t0, -0x30
	
multing:
	mult $t7, $a2
	mflo $t7
	add $t7, $t7, $t0

	add $a0, $a0, 1
	b convertloop
	
a2f:
	li $t1, 0x41
	li $t2, 0x46
	blt $t0, $t1, error
	bgt $t0, $t2, error
	add $t0, $t0, -0x37
	
	b multing

error:
	move $v0, $t7
	jr $ra
	
	############################

	############################
	# MULTPLICATION SUB-ROUTINE, arugments in s1, s2, answer as decimal in t6
multiplication:
# s1 - a, s2 - b, t6 - p
	
done:
	
	li $t6, 0 # t6 is the value of p, final answer
	
	# t7 and t8 are used as temporaries in the following loop
multloop:
	beqz $s1, finished
	beqz $s2, finished
	
	and $t7, $s2, 1
	beqz $t7, nochangeinp
	
	xor $t6, $t6, $s1
	
nochangeinp:
	srl $s2, $s2, 1 # shift right b by 1
	
	srl $t8, $s1, 7 # n-1 = 7, because problem statement uses GF(2^8)
	sll $s1, $s1, 1 #shift left a by 1
	and $s1, $s1, 255 # this restricts a to 8 bits
	beqz $t8, nochangeina
	
	xor $s1, $s1, $s4

nochangeina:
	b multloop
	
finished:
	jr $ra
