/*
 * AsmFile1.asm
 *
 *  Created: 12/28/2021 4:58:12 AM
 *   Author: gemy
 */ 
 .macro delay 
;push the 3 registers that we will use  
push r20 
push r24
push r25

.equ i = 2499    ;no. of iteration for the inner loop
ldi r20,@0/10		; the delay time entered by the user 

outerloop:										; outer loop
			ldi		r24,LOW(i)					; initialize itirators at the begining each time
			ldi		r25,HIGH(i) 

innerloop:
			sbiw	r24,1
			brne	innerloop					; loop (i) times

			dec		r20 
			brne	outerloop					; loop (r20) times

;pop the registers again
pop r25
pop r24
pop r20
.endmacro 