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

.cseg
.org	 0x00



	init_UART


	start:
	
	write myStr
	
	delay 1000
	 
	 write hello
	 delay 1000
	

	rjmp	start



	myStr:	.db	"elkhazna gahza llsho3'l...!",0x00
	hello:  .db "ahmed",0x00