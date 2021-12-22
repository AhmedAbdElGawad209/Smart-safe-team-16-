;
; set led (gemmy).asm
;
; Created: 12/22/2021 5:18:18 PM
; Author : gemy
;


; Replace with your application code


	.include "m32def.inc"

	.cseg
	.org 	0x00
	ldi	r16,0b00000001		; load 00000001 into register 16
        out     DDRB,r16		; write register 16 to DDRB
        out     PORTB,r16		; write register 16 to PORTB

loop:	rjmp    loop	
