
/*
 ============================================================================
 Name        : binomial_asm
 Author      : Roisin Mitchell
 Version     : 01
 Description :
 ============================================================================
 */
	.globl   binomial_asm
    .p2align 2
	.type    binomial_asm,%function



/////////////////////////////////
//   **Factorial Subroutine**   //
////////////////////////////////
fact_asm:
		mov		x9, #1 //Loading valuye 1 to x9 for use in multiplication
		b		loop_check


loop_check:
		cmp		x0, xzr
		b.eq	fact_result
		b		loop

loop:
		mul		x9, x9, x0 //multipies value in x0 to x9
		sub		x0,	x0,	#1 // subtracts 1 from x0 value
		b		loop_check //loop and compare again

fact_result:
		mov		x0, x9
		br		x30




/////////////////////////////////
//   **Binomial subroutine**   //
////////////////////////////////
binomial_asm:

		cmp		x0, #0 // n<0
		blt		returnNeg1

		cmp		x1, #0 // r<0
		blt		returnNeg1

		cmp		x0, #10 //r>10
		bgt		returnNeg1

		cmp		x0, x1 //n<r
		blt		returnNeg1

		cbz		x0, return1 //n==0
		cbz		x1, return1 //r==0


		b		main

returnNeg1:
		mov		x0, #-1
		br 		x30

return1:
		mov		x0, #1
		br		x30

main:
		// saving return address
		sub 	SP, SP, #32 // Stack pointer up by 32 bits to allocate space for variables on the stack
		str 	X30, [SP, #0] //return address
		str 	X11, [SP, #8] //numerator
		str 	X12, [SP, #16] //denom1
		str 	X13, [SP, #24] //denom2

		//Initialising variables to 0
		mov		x11, #0
		mov		x12, #0
		mov		x13, #0
		mov		x14, #0
		mov		x15, x0 //preserving value in x0



		//numerator = factorial_c (n);
		// Sending x0 to fact_asm unaltered
		bl		fact_asm
		mov		x11, x0 //storing numerator result retruned on x0



		//denom1 = factorial_c (n-r);
		sub		x0, x15, x1
		bl		fact_asm
		mov		x12, x0 //stroing denom1 result



		//denom2 = factorial_c (r);
		mov		x0, x1
		bl		fact_asm
		mov		x13, x0 //storing denom2 result


		mul		x14, x12, x13 //(denom1 * denom2)
		b		divide

divide:
		mov		x15, #0 //reusing temp register for final return result (Coefficient)

		//coefficient = numerator / (denom1 * denom2)
		sdiv	x15, x11, x14
		b		return


return:
		mov 	x0, x15 //Moving coefficient calculation result to x0 to be returned to caller

		//Loading registers back from stack
		ldr		X13, [SP, #24]
		ldr		X12, [SP, #16]
		ldr		X11, [SP, #8]
		ldr 	X30, [SP, #0]

		//resetting stack to 0
		add 	SP, SP, #32


		br x30



