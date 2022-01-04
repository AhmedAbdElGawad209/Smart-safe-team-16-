/*
 * AsmFile2.asm
 *
 *  Created: 12/28/2021 5:00:31 AM
 *   Author: gemy
 */ 
.macro init_stack

ldi		r16,LOW(RAMEND)  ;first address of stack segmant 
out		SPL,r16
ldi		r16,HIGH(RAMEND) 
out		SPH,r16
.endmacro 