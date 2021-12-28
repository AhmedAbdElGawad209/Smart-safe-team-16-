;
; set led (gemmy).asm
;
; Created: 12/22/2021 5:18:18 PM
; Author : gemy
;


; Replace with your application code


.include "m32def.inc"
	.cseg
	.org 	0x00



	ldi	   r17,0b00000001	; load 00000001 into register 16
	out    DDRA,r17
	ldi	   r16,0b00000001
	OUT    PORTA,r16		; write register 16 to PORTA
	ldi	   r31,0b11111111	
    out    DDRD,r31		; write register 16 to DDRA

   
	 ADCenable:
 
   ldi  r16, (1<<ADEN)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0)
   out  ADCSR, r16
// ADEN  - ADC enable
// ADPSx - prescaler
// ADSC  - start conversion

   ldi  r16, (1<<REFS0) //reference = AVCC (=VCC)
   out  ADMUX, r16
// REFS1:REFS0 - reference voltage (see datasheet)
// MUX2:MUX0   - channel select

;----------------------------------------------------------

mainloop:
.equ channel = 0 // ADC0

// read_adc
   ldi  r16, (1<<REFS0) | channel // set channel
   out  ADMUX, r16
   sbi  ADCSRA, ADSC              // start conversion

wait_for_conv_finished:
   sbic ADCSRA, ADSC  //bit ADSC goes low after conversion done         
   rjmp wait_for_conv_finished

  in   r1, ADCL
  OUT  PORTD,r1	
  in   r2, ADCH

rjmp mainloop

loop:	rjmp    loop	
