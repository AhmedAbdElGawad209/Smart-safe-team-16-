/*
 * AsmFile1.asm
 *
 *  Created: 12/23/2021 3:44:30 AM
 *   Author: gemy
 */ 
 //initialize ADC
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
   in   r2, ADCH

rjmp mainloop