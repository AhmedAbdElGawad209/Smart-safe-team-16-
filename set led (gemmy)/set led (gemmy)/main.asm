;
; set led (gemmy).asm
;
; Created: 12/22/2021 5:18:18 PM
; Author : gemy
;


; Replace with your application code


.include "m32def.inc"
.include "set stack.inc"
.include "delay_function.inc"
.include "ADC.inc"
	.cseg
	.org 	0x00

	ldi	   r17,0b00000001	; load 00000001 into register 16
	out    DDRA,r17
	ldi	   r18,0b00000000
	OUT    PORTA,r18		; write register 16 to PORTA
	ldi	   r32,0b11111111	
    out    DDRD,r32		; write register 16 to DDRA

rjmp mainloop

loop:	rjmp    loop	
