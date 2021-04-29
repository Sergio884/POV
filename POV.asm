.include"m8535def.inc"
.def data =r16
ldi data,low(RAMEND)
out spl,data
ldi data,high(RAMEND)
out sph,data
ser data
out ddra,data
out portb, data
out ddrc,data

	ldi r20,$3F
	ldi r21,$06
	ldi r22,$5b
	ldi r23,$4f
	ldi r24,$66
	ldi r25,$6d
	ldi r26,$7d
	ldi r27,$27
	ldi r28,$7f
	ldi r29,$6f
	clr zh

cambio:
	
	in data,pinb;Asignar en data lo que hay en el Puerto B
	andi data,$0F;enmascarar el nible alto del data

	rcall ddata ;llamamos a ddata
	/*Con estas dos lineas asignamos un 1 en el puerto C y un 0*/
	sbi portc,1 
	cbi portc,0
	/*Mostramos en el puerto A lo que hay en data*/
	out porta,data
	/*llamamos a nuestro delay*/
	rcall retraso
	/*asignamos en el puerto A, lo que hay en la bandera Zh*/
	out porta,zh

	in data,pinb;Asignar en data lo que hay en el Puerto B
	andi data,$F0;enmascarar el nible bajo del data
	swap data ; hacemos un swap para pasar el nible alto al bajo
	
	rcall ddata;;llamamos a ddata
	/*Con estas dos lineas asignamos un 0 en el puerto C y un 1*/
	sbi portc,0
	cbi portc,1
	/*Mostramos en el puerto A lo que hay en data*/
	out porta,data
	/*llamamos a nuestro delay*/
	rcall retraso
	/*asignamos en el puerto A, lo que hay en la bandera Zh*/
	out porta,zh

	rjmp cambio;regresamos al inicio de cambio
ddata:
	ldi zl,20;asignamos en zl un 20
	add zl,data;Sumamos lo que hay en data
	ld data,z ; asignamos lo que hay en la bandera z en data
	ret
	/*Estas funciones nos ayudaran a agregar un delay de 996 ciclos a 1Mhz*/
retraso:
	ret

	ldi r18,2
	ldi r19, 74
L1:
	dec r19
	brne L1
	dec r18
	brne L1
	nop
	ret

	
