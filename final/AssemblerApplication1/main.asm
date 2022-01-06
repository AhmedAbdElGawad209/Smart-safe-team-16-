;
; keypad.asm
;
; Created: 01/01/2022 10:13:08 ص
; Author : AbdElGawad
;


; Replace with your application code
.include	"m32def.inc"
.include	"delay_function.inc"
.include	"set stack.inc"
.include	"compare.inc"
.include	"keypad.inc"
.include	"initUART.inc"
.include	"send_string.inc"
.include	"receive_char.inc"

	.dseg
	.org	SRAM_START

id:	.byte	20


	.cseg
	.org	0x00

	init_stack
	init_UART
	

	ldi r16,0b11111111    
	out DDRC,r16
;............................keypad.......................................................
	ldi r16,0x0f			;first 4pins (ROWS) input .   last 4pins (COLS) output
	out DDRB,r16
	ss:
	
	
		read_id
	nop
	delay	500
	ldi	r16,1
	out PORTC,r16
	delay	200
	ldi	r16,0
	out PORTC,r16
	delay	200
	ldi	r16,1
	out PORTC,r16
	delay	200
	ldi	r16,0
	out PORTC,r16
	delay	200

	is	1,2,3,4
	brne	noo
	;write	hello

	rjmp	ss
	noo:
	write	hello1
	
	rjmp	ss

	unknown:	.db		0x0d,"Unknown person",0x00
	ahmed:		.db		0x0d,"ahmed ",0x00
	gemy:		.db		0x0d,"gemy",0x00
	sara:		.db		0x0d,"sara",0x00
	do3aa:		.db		0x0d,"do3a2 ",0x00
	aya:		.db		0x0d,"aya ",0x00
	;(\n = 0x0d)
	trying:		.db		" is trying to open the khazna",0x0d,0x0d,"what should i do?!",0x0d,0x0d,0x00

	welcome:	.db		0x0d,"elkhazna gahza llsho3'l.....!",0x0d,0x00
	khatar:		.db		0x0d,"elkhazna f 5attaaaaaaaaaaaaaar....!!!!!",0x0d,0x00
	pass:		.db		0x0d,"enter the password....!",0x0d,0x00
	open:		.db		0x0d,"elkhazna etfat7e ",0x0d,0x00
	close:		.db		0x0d,"elkhazna et2flt",0x0d,0x00
	hello1:		.db		"noo",0x00

	