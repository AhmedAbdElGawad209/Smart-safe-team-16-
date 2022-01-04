;
; keypad.asm
;
; Created: 01/01/2022 10:13:08 ص
; Author : AbdElGawad
;


; Replace with your application code
.include	"m32def.inc"
.include	"store number.inc"
	.dseg
	.org	SRAM_START
id:	.byte	10

	.cseg
	.org	0x00

	start:

	ldi XL,LOW(id)
	ldi XH,HIGH(id)
	ldi r16,0b11110000    ;first 4 input .   last 4 output
	out DDRB,r16
	ldi r16,0
	out PORTB,r16			; all LOW

	search:

	ldi r16,0b00010000		; power Coloump 1
	out PORTB,r16
	
	in r16,PORTB
	sbrc r16,0
	store_num	1
	sbrc r16,1
	store_num	4
	sbrc r16,2
	store_num	7
	sbrc r16,3
	store_num	'*'

	ldi r16,0b00100000		; power Coloump 2
	out PORTB,r16
	
	in r16,PORTB
	sbrc r16,0
	store_num	2
	sbrc r16,1
	store_num	5
	sbrc r16,2
	store_num	8
	sbrc r16,3
	store_num	0

	ldi r16,0b01000000		; power Coloump 3
	out PORTB,r16
	
	in r16,PORTB
	sbrc r16,0
	store_num	3
	sbrc r16,1
	store_num	6
	sbrc r16,2
	store_num	9
	sbrc r16,3
	store_num	'#'

	ldi r16,0b10000000		; power Coloump 4
	out PORTB,r16
	
	in r16,PORTB
	sbrc r16,0
	store_num	'A'
	sbrc r16,1
	store_num	'B'
	sbrc r16,2
	store_num	'C'
	sbrc r16,3
	store_num	'D'

	ld r16,-X
	cpi r16,'#'
	breq	id_entered
	adiw X,1

	jmp		search

	id_entered:
		
	ldi r16,0xff    ;first 4 input .   last 4 output
	out DDRC,r16
	ldi r16,1
	out PORTC,r16

	jmp start