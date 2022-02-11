	.arch armv8-a
	.text

// print function is complete, no modifications needed
    .global	print
print:
      stp    x29, x30, [sp, -16]! //Store FP, LR.
      add    x29, sp, 0
      mov    x3, x0
      mov    x2, x1
      ldr    w0, startstring
      mov    x1, x3
      bl     printf
      ldp    x29, x30, [sp], 16
      ret

startstring:
	.word	string0

    .global	towers
towers:
   /* Save calllee-saved registers to stack */
stp x29, x30, [sp, -32]!
str x25, [sp, -16]!	//temp
str x24, [sp, -16]!     //peg
str x23, [sp, -16]!     //steps
str x22, [sp, -16]!     //goal
str x21, [sp, -16]!     //start
str x20, [sp, -16]!     //numDiscs

mov x20, x0
mov x21, x1
mov x22, x2
   
   /* Save a copy of all 3 incoming parameters to callee-saved registers */



if:
 cmp x20, #2
 bge else
  

   /* Compare numDisks with 2 or (numDisks - 2)*/
   /* Check if less than, else branch to else */
   
   /* set print function's start to incoming start */
	mov x0, x21

   /* set print function's end to goal */
	mov x1, x22

   /* call print function */
	bl print

   /* Set return register to 1 */
	mov x0, #1   

   /* branch to endif */

	b endif
else:
   /* Use a callee-saved varable for temp and set it to 6 */
 
	mov x25, #6

   /* Subract start from temp and store to itself */
   
	sub x25, x25, x21

   /* Subtract goal from temp and store to itself (temp = 6 - start - goal)*/

	sub x25, x25, x22

   /* subtract 1 from original numDisks and store it to numDisks parameter */

	sub x20, x20, #1

   /* Set end parameter as temp */

	mov x0, x20  //numDisc

	mov x1, x21  //start

	mov x2, x25  //goal

	bl towers

	mov x23, x0   

/* Call towers function */
   /* Save result to callee-saved register for total steps */
   
   /* Set numDiscs parameter to 1 */

	mov x0, #1

   /* Set start parameter to original start */
   
	mov x1, x21

   /* Set goal parameter to original goal */

	mov x2, x22

   /* Call towers function */
   
	bl towers

   /* Add result to total steps so far */
	
	add x23, x23, x0   

   /* Set numDisks parameter to original numDisks - 1 */

	mov x0, x20

   /* set start parameter to temp */

	mov x1, x25

   /* set goal parameter to original goal */

	mov x2, x22

   /* Call towers function */
   
	bl towers

   /* Add result to total steps so far and save it to return register */

	add x23, x23, x0

	mov x0, x23
endif:
   /* Restore Registers */
   
	ldr x20, [sp], 16
	ldr x21, [sp], 16
	ldr x22, [sp], 16
	ldr x23, [sp], 16
	ldr x24, [sp], 16
	ldr x25, [sp], 16
	ldp x29, x30, [sp], 32
ret

//Function main is complete, no modifications needed
    .global	main
main:
      stp    x29, x30, [sp, -32]!
      add    x29, sp, 0
      ldr    w0, printdata 
      bl     printf
      ldr    w0, printdata + 4
      add    x1, x29, 28
      bl     scanf
      ldr    w0, [x29, 28] /* numDisks */
      mov    x1, #1 /* Start */
      mov    x2, #3 /* Goal */
      bl     towers
      mov    w4, w0
      ldr    w0, printdata + 8
      ldr    w1, [x29, 28]
      mov    w2, #1
      mov    w3, #3
      bl     printf
      mov    x0, #0
      ldp    x29, x30, [sp], 16
      ret
end:

printdata:
	.word	string1
	.word	string2
	.word	string3

string0:
	.asciz	"Move from peg %d to peg %d\n"
string1:
	.asciz	"Enter number of discs to be moved: "
string2:
	.asciz	"%d"
	.space	1
string3:
	.ascii	"\n%d discs moved from peg %d to peg %d in %d steps."
	.ascii	"\012\000"
