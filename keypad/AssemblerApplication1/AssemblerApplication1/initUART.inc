.macro init_UART

ldi	r16,103			; load baud rate  [(F_CPU/(BouadRate*16))-1]
ldi	r17,0

out UBRRH, r17
out UBRRL, r16

; Enable receiver and transmitter
ldi r16, (1<<RXEN)|(1<<TXEN)
out UCSRB,r16

; Set frame format: 8data, 2stop bit
ldi r16, (1<<URSEL)|(1<<USBS)|(3<<UCSZ0)
out UCSRC,r16

.endmacro
