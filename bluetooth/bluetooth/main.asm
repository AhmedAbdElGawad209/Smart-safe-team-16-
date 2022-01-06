;
; bluetooth.asm
;
; Created: 27/12/2021 07:44:33 ص
; Author : AbdElGawad
;


; Replace with your application code
;#define	F_CPU	8000000U

.include	"m32def.inc"
.include  "delay_function.inc"
.include  "initUART.inc"
.include "send_string.inc"
.include "receive_char.inc"

.cseg
.org	 0x00



	init_UART


	
	/*
	write myStr
	
	delay 1000
	 
	 write hello
	 delay 1000
	*/
	ldi	r16,0xff
	out	DDRC,r16
	ldi	r16,0
	out	PORTC,r16
	start:

	;ldi	r16,1
	;out	PORTC,r16
	
	ldi	r16,1
	out	DDRC,r16
	out	PORTC,r16
	write	hello
	
	delay 1000
	/*
	ldi	r16,0
	out	PORTC,r16
	 write	myStr
	 
	 delay 1000
	 */
	 
	 read	r18

	 out	PORTC,r18
	 delay	1000
	

	
	rjmp	start

	; (\n=0x0d)
	myStr:	.db	"elkhazna gahza llsho3'l...! ",0x0d,0x00		
	hello:  .db "ahmed",0x00