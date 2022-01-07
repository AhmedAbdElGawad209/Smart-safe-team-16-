.macro	is
	cpi	r23,@0
	brne	no
	cpi	r22,@1
	brne	no
	cpi	r21,@2
	brne	no
	cpi	r20,@3
	brne	no
	SEZ							;set zero flag
	rjmp	end
no:
	CLZ							;clear zero flag
end:
	nop
.endmacro