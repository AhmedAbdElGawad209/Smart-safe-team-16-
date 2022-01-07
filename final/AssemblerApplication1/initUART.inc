.macro init_UART

ldi	r16,12		; load baud rate  [(F_CPU/(BouadRate*8))-1]  (boudrate = 9600) (elvalue de mawgoda f eldatasheet)
ldi	r17,0

out UBRRH, r17							;UART baud rate register
out UBRRL, r16

;	double speed mode
sbi	UCSRA,U2X							;UART control statue register A

; Enable receiver and transmitter
ldi r16, (1<<RXEN)|(1<<TXEN)
out UCSRB,r16							;UART control statue register B

; Set frame format: 8data bit , 2stop bit
ldi r16, (1<<URSEL)|(1<<USBS)|(3<<UCSZ0)
out UCSRC,r16							;UART control statue register C

.endmacro
