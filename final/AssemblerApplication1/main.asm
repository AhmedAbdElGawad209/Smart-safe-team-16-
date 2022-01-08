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
	ldi r16,0xff		;make PORT A pin all output 
	out DDRA,r16		
	;pin0	=	relay
	;pin1	=	buzz
	;pin2	=	led green
	;pin3	=	led blue
	;pin4	=	led red

	ldi	r16,0			;make PORT C pin all input
	out	DDRC,r16
	;pin0	=	sensor_open
	;pin1	=	sensor_alarm
;................................................................................................
;............................keypad.......................................................
	ldi r16,0x0f			;first 4pins (ROWS) input ... last 4pins (COLS) output
	out DDRB,r16
;................................................................................................
ldi	r17,0
start:
	
	ldi	r18,0

	ldi	r16,0			;all pins LOW
	out PORTA,r16
;wait untill bleutooth connected...............................................		
	connect:
		sbi		PORTA,4				;HIGH Red Led
		sbrc	r17,0
		rjmp	p
		sbis	PINC,1
		rjmp	khataar				;khatar................

		p:
		delay	100
		sbis UCSRA, RXC
		rjmp	connect
		in	r18,UDR
		cpi	r18,'A'
		breq	s
		rjmp	connect
s:
	ldi	r17,0
	delay	1000
;................................................................................................
	write	welcome				;write elkhazna gahza llsho3'l
	sbi		PORTA,4				;HIGH Red Led
	sbi		PORTA,3 			;HIGH blue Led
	sbi		PORTA,2				;HIGH green Led
	delay	100
;................................................................................................
;............................keypad.......................................................
	ldi	r17,0
	read_id						;start reading id
;...............................................................................
	sbrc	r17,0
	rjmp	stop

;........check if khatar .......................................................
	sbis	PINC,1
	rjmp	khataar				;khatar................
;...............................................................................
;........no khatar .......................................................
	nop							;no operation	(used for syncronyzation)
	delay	2000
	sbi	PORTA,1					;blink buzzer   (teet teet)
	delay	150
	cbi	PORTA,1
	delay	150
	sbi	PORTA,1
	delay	150
	cbi	PORTA,1
	delay	150
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
	out PORTA,r16		

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
	out PORTA,r16
	delay	600
	ldi	r16,0					;LOW
	out PORTA,r16
	delay	600
	dec	r17
	brne	loopr
	delay	2500
	write	rejected
	write	would
	rjmp	start						;return to start
;..................................................................................
alarm:
;blink buzz & red led (quickly)...............
	delay	500
	ldi	r17,12					;loop 8 times
	loopa:
	ldi	r16,0b00010010			;HIGH
	out PORTA,r16
	delay	150
	ldi	r16,0					;LOW
	out PORTA,r16
	delay	150
	dec	r17
	brne	loopa
	delay	2500
	write	alarmed
	write	would
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
	brne	c
		
	rjmp	correct
c:	
	delay	1000
	write	wrong
	ldi	r17,12					;loop 8 times
	loopc:
	ldi	r16,0b00010010			;HIGH
	out PORTA,r16
	delay	150
	ldi	r16,0					;LOW
	out PORTA,r16
	delay	150
	dec	r17
	brne	loopc

	delay	1000
	write	would
	rjmp	start

correct:		
;correct password.............................................................
	delay	500
	ldi	r16,0b00000110					;HIGH buzz & green led
	out PORTA,r16
	delay	800
	cbi	PORTA,1							;LOW buzz only
	delay	2000
	sbi	PORTA,0							;HIGH relay		(open the khazna)
	delay	500							;for 0.5 second
	cbi	PORTA,0							;LOW relay

	delay	1000
	write	open						;tell the owner that khazna is opened

	lock:									
	sbis	PINC,0						;wait untill khazna be closed
	rjmp	lock

	delay	100
	write	close						;tell the owner that khazna is closed

	cbi	PORTA,2							;LOW green led
	delay	2500
	write	would
	rjmp	start
;..................................................................................
khataar:
	ldi	r18,0

	write	khatar

	ldi	r17,20
	loopk:
	ldi	r16,0b00011110			;HIGH	all (buzz,green,red,blue)
	out PORTA,r16
	delay	150
	ldi	r16,0					;LOW	all (buzz,green,red,blue)
	out PORTA,r16
	delay	150
	dec	r17
	brne	loopk	
	delay	100
	sbis UCSRA, RXC
	rjmp	khataar
	in	r18,UDR
	cpi	r18,'B'
	breq	d
	rjmp	khataar
d:
	ldi	r17,1
	delay	1500
	write	stoped
	write	would
	;delay	2500
	rjmp	start	

stop:
	delay	500
	write	stoped
	write	would
	rjmp	start
;............................................................................................................................
;	declaring all strings ................................................................
	;(\n = 0x0a)
	unknown:	.db		0x0a,"Unknown person",0x00				;writing in program memory
	ahmed:		.db		0x0a,"Ahmed ",0x00
	gemy:		.db		0x0a,"Gemy",0x00
	sara:		.db		0x0a,"Sara",0x00
	do3aa:		.db		0x0a,"Do3a2 ",0x00
	aya:		.db		0x0a,"Aya ",0x00
	trying:		.db		" is trying to open the khazna",0x0a,0x0a,"what should i do?!",0x0a,0x0a,0x00

	welcome:	.db		0x0a,"elkhazna gahza llsho3'l.....!",0x0a,0x00
	khatar:		.db		0x0a,"elkhazna f 5attaaaaaaaaaaaaaar....!!!!!",0x0a,0x00
	pass:		.db		0x0a,"enter the password....!",0x0a,0x00
	open:		.db		0x0a,"elkhazna etfat7e ",0x0a,0x00
	close:		.db		0x0a,"elkhazna et2flt",0x0a,0x00

	wrong:		.db		0x0a,"Wrong password..!!!",0x0a,0x00
	alarmed:	.db		0x0a,"Done alarmed..!",0x0a,0x00
	rejected:	.db		0x0a,"Done rejected..! ",0x0a,0x00	
	stoped:		.db		0x0a,"Done stoped..! ",0x0a,0x00
	would:		.db		0x0a,"Would you like to start again ?..",0x0a,"press start.....!",0x0a,0x00
;................................................................................................................................	
;............................................................................................................................
	