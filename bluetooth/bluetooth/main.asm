;
; bluetooth.asm
;
; Created: 27/12/2021 07:44:33 ص
; Author : AbdElGawad
;


; Replace with your application code
.include	"m32def.inc"
.include  "delay_function.inc"
.include  "initUART.inc"
.include "send_string.inc"
.include "receive_char.inc"

.cseg
.org	 0x00



	init_UART


	
	/*
	write myStr
	
	delay 1000
	 
	 write hello
	 delay 1000
	*/

	start:

	

	 

	read r18
	out DDRC,r18
	out PORTC,r18
	read r19
	out DDRA,r19
	out PORTA,r19

	
	rjmp	start
/*
	USART_Receive:
; Wait for data to be received
sbis UCSRA, RXC
rjmp USART_Receive
; Get and return received data from buffer
in r16, UDR
ret
*/
	myStr:	.db	"elkhazna gahza llsho3'l...!",0x00
	hello:  .db "ahmed",0x00