	.data
msg0:	.asciiz "Enter irreducible polynomial (use caps)\n"
msg1:	.asciiz "Enter matrix row wise,Matrix A 2 hex characters for each element (use caps) \n"
msgB:	.asciiz "Enter matrix row wise,Matrix B 2 hex characters for each element (use caps) \n"
msg2:	.asciiz "The result C is: \n"
tab:	.asciiz "\t"
newl:	.asciiz "\n"

mat_A:	.word 2,3,1,1,1,2,3,1,1,1,2,3,3,1,1,2
mat_B:	.space 64


hex:	.space 8


result: .space 2
	.asciiz "\t"
		
	.text
	
main:

	li $v0,4
	la $a0,msg0
	syscall	
	
	la $a0,hex		
	li $a1,7
	li $v0,8
	syscall

	li $a1,3
	la $a2,hex	
	jal hex_dec	
	move $s3,$v0		#irr_pol stored in s3

	li $v0,4
	la $a0,msg1
	syscall

	li $t0,16
	la $t1,mat_A
	la $t2,mat_B
	jal storing
	b end


storing:
        addi $sp,$sp,-4
	sw $ra 0($sp)
input_loop:
	la $a0,hex		
	li $a1,7
	li $v0,8
	syscall
	
	li $a1,2
	la $a2,hex
        addi $sp,$sp,-4
	sw $t2 0($sp)
	jal hex_dec
	lw $t2, 0($sp)
	addi $sp,$sp,4
	sw $v0,($t1)
	sw $v0,($t2)
	addi $t1,$t1,4
	addi $t2,$t2,4
	addi $t0,$t0,-1
	bnez $t0,input_loop
	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra

end:	
        li $v0,4
	la $a0,msg2
	syscall	
			
mat_mult:
	la $t5,mat_A
	la $t6,mat_B

	li $t0,0
	li $t1,0		#represents row
mult_out_l:
	li $t2,0		#represents column		
mult_in_l:		
	
	li $t8,0		#result of current multiplication
	sll $t3,$t1,4
	add $t3,$t3,$t5
	
	sll $t4,$t2,2
	add $t4,$t4,$t6
	
	move $a3,$s3
	li $a0,8
	## multiplying and adding four times
	lw $a1,0($t3)
	lw $a2,0($t4)

	jal mult_
	
	move $a1,$v0
	move $a2,$t8
	
	jal add_
	
	move $t8,$v0
	##
	lw $a1,4($t3)
	lw $a2,16($t4)

	jal mult_
	
	move $a1,$v0
	move $a2,$t8
	
	jal add_
	
	move $t8,$v0
	##
	lw $a1,8($t3)
	lw $a2,32($t4)
	
	jal mult_
	
	move $a1,$v0
	move $a2,$t8
	
	jal add_
	
	move $t8,$v0	
	##
	lw $a1,12($t3)
	lw $a2,48($t4)
	
	jal mult_
	
	move $a1,$v0
	move $a2,$t8
	
	jal add_
	
	move $t8,$v0	
	##
	
	move $a2,$t8
	la $a1,result
	
	jal dec_hex
	
	li $v0,4
	la $a0,result
	syscall	
	
	li $v0,4
	la $a0,tab
	syscall	
	
	addi $t2,$t2,1
	addi $t0,$t0,4
	blt $t2,4,mult_in_l

	li $v0,4
	la $a0,newl
	syscall	

	addi $t1,$t1,1
	blt $t1,4,mult_out_l



	li $v0,10
	syscall

		#SR for conversion of hex to dec - dec result in $v0	
			
hex_dec:
	addi $sp,$sp,-12
	sw $t1 0($sp)
	sw $t3 4($sp)
	sw $t4 8($sp)


	move $v0,$zero	
	move $t3,$a1		#count in $a1
	move $t4,$a2		#address in $a2
	
h1dec:	lbu $t1,($t4)
	ble $t1,57,num_1

char_1:	addi $t1,$t1,-7

num_1:	addi $t1,$t1,-48
	
	rol $v0,$v0,4
	or $v0,$v0,$t1
	addi $t4,$t4,1
	addi $t3,$t3,-1
	bnez $t3,h1dec	
	

	lw $t1 0($sp)
	lw $t3 4($sp)
	lw $t4 8($sp)
	addi $sp,$sp,12	
	jr $ra

		#SR for dec to hex

dec_hex:
	addi $sp,$sp,-16
	sw $t0,0($sp)
	sw $t1,4($sp)
	sw $t2,8($sp)
	sw $t4,12($sp)
	move $t1,$a1		# address of mem location in $a1
	move $t0,$a2		# dec number in $a2
	rol $t0,$t0,24
	li $t4,2
conv_l:	rol $t0,$t0,4		
	and $t2,$t0,15
	ble $t2,9,num_c
	add $t2,$t2,7
num_c:	add $t2,$t2,48	
	sb $t2,($t1)
	add $t1,$t1,1
	add $t4,$t4,-1
	bnez $t4,conv_l	

	lw $t0,0($sp)
	lw $t1,4($sp)
	lw $t2,8($sp)
	lw $t4,12($sp)
	addi $sp,$sp,16
	
	jr $ra
	
	#SR for  mult
	
mult_:				#multiplication
	addi $sp,$sp,-44
	sw $t0,0($sp)	
	sw $t1,4($sp)
	sw $t2,8($sp)
	sw $t3,12($sp)
	sw $t4,16($sp)
	sw $s1,20($sp)
	sw $s2,24($sp)
	sw $s3,28($sp)
	sw $s4,32($sp)
	sw $s5,36($sp)
	sw $s7,40($sp)
	
	move $s0,$a0		#size of log field
	move $s1,$a1		#n1
	move $s2,$a2		#n2
	move $s3,$a3		#irr_pol
				
	li $t0,0		#count			
	li $t1,0		#non reduced result in t1

mul_l:	ror $t2,$s2,$t0
	andi $t2,$t2,1
	beq $t2,0,mul_z	
	rol $t3,$s1,$t0		
	xor $t1,$t3,$t1	
mul_z:		
	addi $t0,$t0,1
	bne $t0,16,mul_l
	
	move $s4,$t1		#storing multiplication answer in s4 so that t1 is free to use
	
reduce:				#reducing the answer 
	
	li $t0,31		#current reduction index
	move $v0,$s4		#v0 is final reduced result of mult 
	
red_l:	ror $t1,$v0,$t0
	andi $t1,$t1,1			
	beq $t1,0,red_z
	sub $t3,$t0,$s0		#subtracting gives the shift required for irr pol to reach the current index
	rol $t2,$s3,$t3
	xor $v0,$v0,$t2		#reducing the index to 0
red_z:																
	addi $t0,$t0,-1
	bge $t0,$s0,red_l																
	
	lw $t0,0($sp)	
	lw $t1,4($sp)
	lw $t2,8($sp)
	lw $t3,12($sp)
	lw $t4,16($sp)
	lw $s1,20($sp)
	lw $s2,24($sp)
	lw $s3,28($sp)
	lw $s4,32($sp)
	lw $s5,36($sp)
	lw $s7,40($sp)
	addi $sp,$sp,44
	
	jr $ra

	#SR for add

add_:
	xor $v0,$a1,$a2
	jr $ra
	
