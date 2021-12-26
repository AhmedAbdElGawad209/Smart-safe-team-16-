;
; AssemblerApplication1.asm
;
; Created: 26/12/2021 09:37:51 م
; Author : AbdElGawad
;


; Replace with your application code
.include "m32def.inc"
.cseg 
.org 0x00

start:
;DDRB = 0b00000001  
ldi r16,0b00000001
out DDRB,r16  ;DDRB = 0b00000001
out PORTB , r16   ;PORTB = 0b00000001
rjmp  start