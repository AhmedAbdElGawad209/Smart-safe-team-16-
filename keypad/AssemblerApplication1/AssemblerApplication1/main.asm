;
; keypad.asm
;
; Created: 01/01/2022 10:13:08 ص
; Author : AbdElGawad
;


; Replace with your application code
.include	"m32def.inc"
.include	"delay_function.inc"
.include	"led.inc"
.include	"set stack.inc"
.include	"compare.inc"
.include	"keypad.inc"
;include	"delay_function.inc"

	.dseg
	.org	SRAM_START

id:	.byte	20


	.cseg
	.org	0x00

	init_stack
	

	ldi r16,0b11111111    
	out DDRC,r16
;............................keypad.......................................................
	ldi r16,0x0f			;first 4pins (ROWS) input .   last 4pins (COLS) output
	out DDRB,r16
	ss:

		read_id
	nop

	is	1,2,3,4
	brne	noo
	ldi	r16,0b00000110
	out	PORTC,r16
	nop
	ldi	r19,0
	rjmp	ss
	noo:
	ldi	r16,0b00000111
	out	PORTC,r16
	nop
	ldi	r19,0
	rjmp	ss


