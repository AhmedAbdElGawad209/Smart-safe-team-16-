.macro	is
	cpi	r23,@0
	brne	no
	cpi	r22,@1
	brne	no
	cpi	r21,@2
	brne	no
	cpi	r20,@3
	brne	no
	SEZ
	rjmp	end
no:
	CLZ
end:
	nop
.endmacro