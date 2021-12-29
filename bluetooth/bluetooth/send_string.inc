.macro write

ldi	ZL,LOW(2*@0)			; load Z pointer with
ldi	ZH,HIGH(2*@0)


puts:	lpm	r16,Z+				; load character from pmem
	cpi	r16,0x00				; check if null
	breq	puts_end

	puts_wait:
	sbis UCSRA,UDRE			; wait for empty transmit buffer
	rjmp	puts_wait

	out	UDR,r16			; transmit character
	rjmp	puts

	puts_end:
	nop
	.endmacro