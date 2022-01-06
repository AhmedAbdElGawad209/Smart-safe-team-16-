.macro	read_id
;............................keypad.......................................................
clear:
	ldi	YL,LOW(id)
	ldi	YH,HIGH(id)
	ldi	r18,0
	st	Y,r18
	ldi	r19,0
startk:			
	ldi r16,0x01			;HIGH row 1
	out PORTB,r16
	nop
	sbis	PINB,PINB4		;check col 1
	rjmp	next1
	rcall	hold
	ldi	r18,1
	adiw	Y,1
	st	Y,r18	
	inc	r19
next1:
	sbis	PINB,PINB5		;check col 2
	rjmp	next2
	rcall	hold
	ldi	r18,2
	adiw	Y,1
	st	Y,r18
	inc	r19
next2:
	sbis	PINB,PINB6		;check col 3
	rjmp	next3
	rcall	hold
	ldi	r18,3
	adiw	Y,1
	st	Y,r18
	inc	r19
next3:
	sbis	PINB,PINB7		;check col 4
	rjmp	next4
	rcall	hold
	ldi	r18,'A'
	adiw	Y,1
	st	Y,r18
	inc	r19
next4:
	ldi r16,0x02				;;HIGH row 2
	out PORTB,r16
	nop
	sbis	PINB,PINB4		;check col 1
	rjmp	next5
	rcall	hold
	ldi	r18,4
	adiw	Y,1
	st	Y,r18
	inc	r19
next5:
	sbis	PINB,PINB5		;check col 2
	rjmp	next6
	rcall	hold
	ldi	r18,5
	adiw	Y,1
	st	Y,r18
	inc	r19
next6:		
	sbis	PINB,PINB6		;check col 3
	rjmp	next7
	rcall	hold
	ldi	r18,6
	adiw	Y,1
	st	Y,r18
	inc	r19
next7:
	sbis	PINB,PINB7		;check col 4
	rjmp	next8
	rcall	hold
	ldi	r18,'B'
	adiw	Y,1
	st	Y,r18
	inc	r19
next8:
	ldi r16,0x04			;HIGH row 3
	out PORTB,r16
	nop
	sbis	PINB,PINB4		;check col 1
	rjmp	next9
	rcall	hold
	ldi	r18,7
	adiw	Y,1
	st	Y,r18
	inc	r19
next9:
	sbis	PINB,PINB5		;check col 2
	rjmp	next10
	rcall	hold
	ldi	r18,8
	adiw	Y,1
	st	Y,r18
	inc	r19
next10:
	sbis	PINB,PINB6		;check col 3
	rjmp	next11
	rcall	hold
	ldi	r18,9
	adiw	Y,1
	st	Y,r18
	inc	r19
next11:
	sbis	PINB,PINB7		;check col 4
	rjmp	next12
	rcall	hold
	rjmp	clear
next12:
	ldi r16,0x08				;HIGH row 4
	out PORTB,r16
	nop
	sbis	PINB,PINB4		;check col 1
	rjmp	next13
	rcall	hold
	ldi	r18,'*'
	adiw	Y,1
	st	Y,r18
	inc	r19
next13:
	sbis	PINB,PINB5		;check col 2
	rjmp	next14
	rcall	hold
	ldi	r18,0
	adiw	Y,1
	st	Y,r18
	inc	r19
next14:
	sbis	PINB,PINB6		;check col 3
	rjmp	next15
	rcall	hold
	rjmp	check
next15:
	sbis	PINB,PINB7		;check col 4
	rjmp	startk
	rcall	hold
	ldi	r18,'D'
	adiw	Y,1
	st	Y,r18
	inc	r19
rjmp  startk

hold:
	ldi	r16,2
	out	PORTC,r16
	in	r16,PINB
	sbrc	r16,4
	rjmp hold
	sbrc	r16,5
	rjmp hold
	sbrc	r16,6
	rjmp hold
	sbrc	r16,7
	rjmp hold
	ldi	r16,0
	out	PORTC,r16
	ret

check:
	cpi	r19,4
	brne	a
	rcall	set_id	
a:
delay	500
ldi	r16,2
out	PORTC,r16
delay	500
ldi	r16,0
out	PORTC,r16
delay	500
ldi	r16,2
out	PORTC,r16
delay	500
ldi	r16,0
out	PORTC,r16
delay	500
rjmp	clear

set_id:
	nop
	adiw	Y,1
	nop
	ld	r20,-Y
	ld	r21,-Y
	ld	r22,-Y
	ld	r23,-Y
	nop
.endmacro
;..............................................................................................................