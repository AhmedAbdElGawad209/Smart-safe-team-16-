.macro init_stack

ldi		r16,LOW(RAMEND)  ;first address of stack segmant 
out		SPL,r16
ldi		r16,HIGH(RAMEND) 
out		SPH,r16

.endmacro 