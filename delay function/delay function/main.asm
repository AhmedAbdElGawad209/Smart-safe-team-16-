;
; delay function.asm
;
; Created: 24/12/2021 09:45:13 م
; Author : AbdElGawad
;


; Replace with your application code

;#define F_CPU 1000000U
	.include "m32def.inc"
	.include "set stack.inc"
	.include "delay_function.inc"
	.def	mask 	= r16		; mask register
	.def	ledR 	= r17
	
	.cseg
	.org 	0x00
	init_stack
	
	clr	ledR			; clear led register
	ldi	mask,(1<<PINB0)		; load 00000001 into mask register
	out	DDRC,mask

	start:
	;	eor	ledR,mask		; toggle PINB0 in led register
	ldi	r16,0x01
	out	PORTC,r16

	delay 1000
	ldi	r16,0
	out	PORTC,r16
	delay	1000

	rjmp    start	