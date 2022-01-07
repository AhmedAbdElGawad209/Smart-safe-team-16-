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
	ldi r16,0xff		;make PORT C pin all output 
	out DDRC,r16		
	;pin0	=	relay
	;pin1	=	buzz
	;pin2	=	led green
	;pin3	=	led blue
	;pin4	=	led red

	ldi	r16,0			;make PORT A pin all input
	out	DDRA,r16
	;pin0	=	sensor_open
	;pin1	=	sensor_alarm
	;pin7	=	bleutooth state  (INPUT)

	;cbi	DDRD,7			;pin7 in PORTD input for bleutooth state pin 	
;................................................................................................
;............................keypad.......................................................
	ldi r16,0x0f			;first 4pins (ROWS) input ... last 4pins (COLS) output
	out DDRB,r16
;................................................................................................

start:
	ldi	r16,0			;all pins LOW
	out DDRC,r16
;wait untill bleutooth connected...............................................		
	connect:
		sbi		PORTC,4				;HIGH Red Led
		sbis	PINA,7
		rjmp	connect
;................................................................................................
	write	welcome				;write elkhazna gahza llsho3'l
	sbi		PORTC,4				;HIGH Red Led
	sbi		PORTC,3 			;HIGH blue Led
	sbi		PORTC,2				;HIGH green Led
	delay	100
;................................................................................................
;............................keypad.......................................................
	read_id						;start reading id
;...............................................................................
;........check if khatar .......................................................
	sbis	PINA,0
	rjmp	khataar				;khatar................
;...............................................................................
;........no khatar .......................................................
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
;........ckecking id .......................................................
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
;..................................................................................
;........wait for response from owner .......................................................
	ldi	r16,8					;HIGH blue led
	out PORTC,r16		

	read	r16					;read bleutooth (wait untill user tell me what shoud i do)
;..................................................................................
;........take order  .......................................................
	cpi	r16,'1'					;'1' means allow
	brne	a
	rjmp	allow	
a:				
	cpi	r16,'2'					;'2' means reject
	brne	b
	rjmp	reject
b:
	rjmp	alarm				;otherwise	 alarm 
;..................................................................................	
reject:
;blink buzz & red led...............
	delay	500
	ldi	r17,3					;loop 3 times
	loopr:
	ldi	r16,0b00010010			;HIGH
	out PORTC,r16
	delay	700
	ldi	r16,0					;LOW
	out PORTC,r16
	delay	700
	dec	r17
	brne	loopr
	delay	2500
	rjmp	start						;return to start
;..................................................................................
alarm:
;blink buzz & red led (quickly)...............
	delay	500
	ldi	r17,8					;loop 8 times
	loopa:
	ldi	r16,0b00010010			;HIGH
	out PORTC,r16
	delay	200
	ldi	r16,0					;LOW
	out PORTC,r16
	delay	200
	dec	r17
	brne	loopa
	delay	2500
	rjmp	start						;return to start
;..................................................................................
allow:
	delay	500
	write	pass						;request the owner password
	delay	100

	read	r16							;read the first character of the password
	read	r17							;read the second character of the password
	read	r18							;read the third character of the password
	read	r19							;read the fourth character of the password
;the password is "0000"...................................................................................
	cpi	r16,'0'							;alarm if any digit of entered password	is mistake
	brne	c							
	cpi	r17,'0'
	brne	c							
	cpi	r18,'0'
	brne	c
	cpi	r19,'0'
	breq	correct
c:
	rjmp	alarm

correct:		
;correct password.............................................................
	delay	200
	ldi	r16,0b00000110					;HIGH buzz & green led
	out PORTC,r16
	delay	800
	cbi	PORTC,1							;LOW buzz only

	sbi	PORTC,0							;HIGH relay		(open the khazna)
	delay	500							;for 0.5 second
	cbi	PORTC,0							;LOW relay

	delay	1000
	write	open						;tell the owner that khazna is opened

	lock:									
	sbis	PINA,1						;wait untill khazna be closed
	rjmp	lock

	delay	100
	write	close						;tell the owner that khazna is closed

	cbi	PORTC,2							;LOW green led
	delay	2500
	delay	2500
	rjmp	start
;..................................................................................
khataar:
	
	write	khatar

	ldi	r17,10
	loopk:
	ldi	r16,0b00011110			;HIGH	all (buzz,green,red,blue)
	out PORTC,r16
	delay	200
	ldi	r16,0					;LOW	all (buzz,green,red,blue)
	out PORTC,r16
	delay	200
	dec	r17
	brne	loopk	

	in	r18,UDR
	cpi	r18,'A'
	breq	d
	rjmp	khataar
d:
	delay	2500
	rjmp	start	
;............................................................................................................................
;	declaring all strings ................................................................
	;(\n = 0x0d)
	unknown:	.db		0x0d,"Unknown person",0x00				;writing in program memory
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
;............................................................................................................................
	