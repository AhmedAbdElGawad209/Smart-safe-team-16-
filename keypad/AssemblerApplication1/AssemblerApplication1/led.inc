.macro	store
ldi	r16,@0
	out	PORTC,r16
	ldi	r18,@0
	adiw	Y,1
	st	Y,r18
	/*
	nop
	ldi r16,2
	mov	r0,r16
	;adiw	Z,1
	spm
	*/

	
	
	.endmacro