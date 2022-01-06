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
;.include	"store number.inc"
;include	"delay_function.inc"

	.dseg
	.org	SRAM_START

var1:	.byte	100


	.cseg
	.org	0x00

	init_stack
	
	;ldi	ZL,LOW(var)
	;ldi	ZH,HIGH(var)

	;ldi XL,LOW(id)
	;ldi XH,HIGH(id)

	ldi r16,0b11111111    ;first 4 input .   last 4 output
	out DDRC,r16

	ldi r16,0x0f
	out DDRB,r16
	ldi	YL,LOW(var1)
	ldi	YH,HIGH(var1)

	ldi	r18,1
	ldi	r19,0
	start:
				
	ldi r16,0x01
	out PORTB,r16
	nop
	
	sbis	PINB,PINB4
	rjmp	next1
	ldi	r16,0b00000110
	out	PORTC,r16
	nop

next1:
	sbis	PINB,PINB5
	rjmp	next2
	rcall	led
	;rcall l1
	
next2:
	sbis	PINB,PINB6
	rjmp	next3
	rcall	l2

next3:
	sbis	PINB,PINB7
	rjmp	next4
	ldi	r16,0b01110011
	out	PORTC,r16
	nop
next4:
		ldi r16,0x02
	out PORTB,r16
	nop
	nop

	sbis	PINB,PINB4
	rjmp	next5
	ldi	r16,0b01100110
	out	PORTC,r16
	nop
next5:
	sbis	PINB,PINB5
	rjmp	next6
	ldi	r16,0b01101101
	out	PORTC,r16
	nop
next6:
	sbis	PINB,PINB6
	rjmp	next7
	ldi	r16,0b01111101
	out	PORTC,r16
	nop
next7:
	sbis	PINB,PINB7
	rjmp	next8
	ldi	r16,0b01110111
	out	PORTC,r16
	nop
next8:
		ldi r16,0x04
	out PORTB,r16
	nop
	nop
	sbis	PINB,PINB4
	rjmp	next9
	
	
	
	ldi	r16,0b00000111
	out	PORTC,r16
	nop
next9:
	sbis	PINB,PINB5
	rjmp	next10
	ldi	r16,0b01111111
	out	PORTC,r16
	nop
next10:
	sbis	PINB,PINB6
	rjmp	next11
	ldi	r16,0b01101111
	out	PORTC,r16
	nop
next11:
	sbis	PINB,PINB7
	rjmp	next12
	ldi	r16,0b01110011
	out	PORTC,r16
	nop
next12:
		ldi r16,0x08
	out PORTB,r16
	nop
	nop
	sbis	PINB,PINB4
	rjmp	next13
	ldi	r16,0b00000000
	out	PORTC,r16
	nop
next13:
	sbis	PINB,PINB5
	rjmp	next14
	ldi	r16,0b00111111
	out	PORTC,r16
	nop
next14:
	sbis	PINB,PINB6
	rjmp	next15
	ldi	r16,0b00000111
	out	PORTC,r16
	nop
next15:
	sbis	PINB,PINB7
	rjmp	start
	ldi	r16,0b01110011
	out	PORTC,r16
	nop
rjmp  start

l1:
ldi	r16,0b00000110
	out	PORTC,r16
	adiw	Y,1
	st	Y,r18
	/*
	nop
	ldi r16,2
	mov	r0,r16
	;adiw	Z,1
	spm
	*/

	
	ret

l2:
	ld	r16,Y
	out	PORTC,r16
	nop
	ret

	var:	.db		""
	;rjmp	next2
	/*
l2:
	ldi	r16,0b01001111
	out	PORTC,r16
	nop
	ret
l3:
	ldi	r16,0b01001111
	out	PORTC,r16
	nop
	ret
l4:
	ldi	r16,0b01001111
	out	PORTC,r16
	nop
	ret
l5:
	ldi	r16,0b01001111
	out	PORTC,r16
	nop
	ret
l6:
	ldi	r16,0b01001111
	out	PORTC,r16
	nop
	ret
l7:
	ldi	r16,0b01001111
	out	PORTC,r16
	nop
	ret
l8:
	ldi	r16,0b01001111
	out	PORTC,r16
	nop
	ret
l9:
	ldi	r16,0b01001111
	out	PORTC,r16
	nop
	ret
l0:
	ldi	r16,0b01001111
	out	PORTC,r16
	nop
	ret
	*/
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