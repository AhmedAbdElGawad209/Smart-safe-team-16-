;	including all libraries................................................
.include	"m32def.inc"			;atmega32	library
.include	"delay_function.inc"
.include	"set stack.inc"
.include	"compare.inc"
.include	"keypad.inc"
.include	"initUART.inc"
.include	"send_string.inc"
.include	"receive_char.inc"
;................................................................................................
.dseg
.org	SRAM_START

id:	.byte	20
;................................................................................................
.cseg
.org	0x00

	init_stack			;initialize stack by calling its macro
	init_UART			;initialize	UART (bleutooth)
;................................................................................................
;declaring i/o pins ....................................................
	ldi r16,0x7f		;make PORT C pin 0-6 output 
	out DDRC,r16		;except pin 7 input (bleutooth state)
	;pin0	=	relay
	;pin1	=	buzz
	;pin2	=	led green
	;pin3	=	led blue
	;pin4	=	led red
	;pin7	=	bleutooth state  (INPUT)
	ldi	r16,0			;all pins LOW
	out DDRC,r16
;............................keypad.......................................................
	ldi r16,0x0f			;first 4pins (ROWS) input ... last 4pins (COLS) output
	out DDRB,r16
;................................................................................................

start:
;	wait untill bleutooth connected...................	
	connect:
		sbi		PORTC,4				;HIGH Red Led
		sbis	PINC,7
		rjmp	connect
;................................................................................................
	delay	400
	write	welcome				;write elkhazna gahza llsho3'l
	sbi		PORTC,4				;HIGH Red Led
	sbi		PORTC,3 			;HIGH blue Led
	sbi		PORTC,2				;HIGH green Led
	delay	100

	read_id						;start reading id
;...............................................................................
	nop							;no operation	(used for syncronyzation)
	delay	500
	ldi	r16,2					;blink buzzer   (teet teet)
	out PORTC,r16
	delay	200
	ldi	r16,0
	out PORTC,r16
	delay	200
	ldi	r16,2
	out PORTC,r16
	delay	200
	ldi	r16,0
	out PORTC,r16
	delay	200
;...............................................................................
	is	1,2,3,4					;check if it is the id of "ahmed" 
	breq	is_ahmed			;true, write ahmed
	is	5,6,7,8					;false, check if it is the id of "gemy" and so on ......
	breq	is_gemy	
	is	1,4,7,8
	breq	is_sara

	write	unknown				;if it is not known id  
	rjmp	try					;write is trying to open ..........
is_ahmed:
	write	ahmed
	rjmp	try
is_gemy:
	write	gemy
	rjmp	try
is_sara:
	write	sara
	rjmp	try
try:
	write trying

	ldi	r16,8					;HIGH blue led
	out PORTC,r16		

	read	r16					;read bleutooth (wait untill user tell me what shoud i do)

	out	PORTC,r16
	delay	2000

	rjmp	start
	
	
	;rjmp	start

;	declaring all strings ................................................................

	;(\n = 0x0d)
	unknown:	.db		0x0d,"Unknown person",0x00
	ahmed:		.db		0x0d,"ahmed ",0x00
	gemy:		.db		0x0d,"gemy",0x00
	sara:		.db		0x0d,"sara",0x00
	do3aa:		.db		0x0d,"do3a2 ",0x00
	aya:		.db		0x0d,"aya ",0x00
	trying:		.db		" is trying to open the khazna",0x0d,0x0d,"what should i do?!",0x0d,0x0d,0x00

	welcome:	.db		0x0d,"elkhazna gahza llsho3'l.....!",0x0d,0x00
	khatar:		.db		0x0d,"elkhazna f 5attaaaaaaaaaaaaaar....!!!!!",0x0d,0x00
	pass:		.db		0x0d,"enter the password....!",0x0d,0x00
	open:		.db		0x0d,"elkhazna etfat7e ",0x0d,0x00
	close:		.db		0x0d,"elkhazna et2flt",0x0d,0x00
;................................................................................................................................	

	