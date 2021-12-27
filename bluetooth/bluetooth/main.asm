;
; bluetooth.asm
;
; Created: 27/12/2021 07:44:33 ص
; Author : AbdElGawad
;


; Replace with your application code
.include	"m32def.inc"
.include  "delay_function.inc"

.cseg
.org	 0x00
.equ	baud	= 9600			; baudrate
	.equ	bps	= 103	; baud prescale

	...

	ldi	r16,LOW(bps)			; load baud prescale
	ldi	r17,HIGH(bps)			; into r17:r16

	rcall	initUART

	;start:
	ldi	r16,'a'				; load char 'a' into r16
	rcall	putc
	;delay 1000 
	;rjmp	start


	putc:	lds	r17,UCSRA			; load UCSR0A into r17
	sbrs	r17,UDRE			; wait for empty transmit buffer
	rjmp	putc				; repeat loop

	sts	UDR,r16			; transmit character

	ret







	initUART:
	sts	UBRRL,r16			; load baud prescale
	sts	UBRRH,r17			; to UBRR0

	ldi	r16,(1<<RXEN)|(1<<TXEN)	; enable transmitter
	sts	UCSRB,r16			; and receiver

	lds r16,UCSRC
	ori r16,(3<<UCSZ0)
	sts UCSRC,r16

	ret