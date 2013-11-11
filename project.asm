.data
array1 :  .space 100
array2 :  .space 100
array3 :  .space 100
number: .space 10
openingmsg: .asciiz "Please choose which operation you want to perform on two given matrices:\n 1. Multiplication \n 2. Addition \n 3. Square Root \n 4. Square of a Matrix \n 5. Roots of a Polynomial\n"
newline: .asciiz "\n"
input_array1: .asciiz "Please give an array A for the asked operation to perform\n"
input_array2: .asciiz "Please give an array B for the asked operation to perform\n" 
#Multiplication operation usage messages

.text

main:
# Registers Usage:
# $t0 is used to store the option value.

#### Closing registers usage message


# opening msg used to find out which operation to be performed 
la $a0,openingmsg
li $v0, 4
syscall

# takes the input(option value) from the user 
li $v0,5
syscall
move $t0,$v0 # $t0 is used to store the option value.

beq $t0,1,Multiplication
beq $t0,2,Addition
beq $t0,3,Square_Root
beq $t0,4,Square
beq $t0,5,Root_find
b end


end:

li $v0,10
syscall

###########################################

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

###########################################
get_array:
    li $v0,8
    la $a0,number
    syscall
    jal hextodecimal
    sw $v0,($a2)
    addi $a2,$a2,4
    addi $t6,$t6,1
    blt $t6,16,get_array
    jr $ra




###########################################
store_arrays:
	li $a1, 10
	la $a0,input_array1
	li $v0, 4
	syscall
	la $a2,array1
	addi $t6,$zero,0
	jal get_array


	la $a0,input_array2
	li $v0, 4
	syscall
	la $a2,array2
	addi $t6,$zero,0
	jal get_array
	jr $ra
####################################################

####################################################
store_array:
	li $a1, 10
	la $a0,input_array1
	li $v0, 4
	syscall
	la $a2,array1
	addi $t6,$zero,0
	jal get_array
	jr $ra
####################################################

####################################################

Multiplication:
	jal store_arrays
	b end

#######################################################
Addition:
	jal store_arrays
	b end

#######################################################
Square_Root:
	jal store_array
	b end


#######################################################
Square:
	jal store_array
	b end

#######################################################
Root_find:
	jal store_array
	b end
