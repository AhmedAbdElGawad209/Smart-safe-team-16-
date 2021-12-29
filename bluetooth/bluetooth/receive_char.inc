.macro read

	wait:
; Wait for data to be received
sbis UCSRA, RXC
rjmp wait

; Get and return received data from buffer
in @0, UDR

.endmacro