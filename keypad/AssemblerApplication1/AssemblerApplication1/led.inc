.macro	store

	ldi	r18,@0
	adiw	Y,1
	st	Y,r18
	
	.endmacro