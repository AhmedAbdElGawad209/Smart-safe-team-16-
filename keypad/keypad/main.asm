;
; keypad.asm
;
; Created: 01/01/2022 10:13:08 ص
; Author : AbdElGawad
;


; Replace with your application code
.include	"m32def.inc"
.include	"store number.inc"
.include	"delay_function.inc"
	.dseg
	.org	SRAM_START
id:	.byte	10

	.cseg
	.org	0x00

	

	ldi XL,LOW(id)
	ldi XH,HIGH(id)

	ldi r16,0b11111111    ;first 4 input .   last 4 output
	out DDRC,r16
	start:
	ldi r16,0x0f
	out DDRB,r16			
	ldi r16,0xff
	out PORTB,r16
	
	
	cbi	PORTB,0

	sbic	PINB,PINB4
	rjmp	next1
	ldi	r16,0b00000011
	out	PORTC,r16

next1:
	sbic	PINB,PINB5
	rjmp	next2
	ldi	r16,0b00001111
	out	PORTC,r16

next2:
	sbic	PINB,PINB6
	rjmp	next3
	ldi	r16,0b00011010
	out	PORTC,r16

next3:
	sbic	PINB,PINB7
	rjmp	start
	ldi	r16,0b01110011
	out	PORTC,r16

rjmp  start
	

/*
	ldi r16,0b00010000		; power Coloump 1
	out PORTB,r16
	delay	10
	in r16,PORTB
	delay	10
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
	delay	10
	
	in r16,PORTB
	delay	10
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
	delay	10
	
	in r16,PORTB
	delay	10
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
	delay	10
	
	in r16,PORTB
	delay	10
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
	*/
