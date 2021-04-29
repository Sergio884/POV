.include"m8535def.inc"
.def dat =r16
ldi dat,low(RAMEND)
out spl,dat
ldi dat,high(RAMEND)
out sph,dat
ser dat
out ddra,dat
out portb, dat
out ddrc,dat

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

otro:
	in dat,pinb
	andi dat,$0F
	rcall ddat
	sbi portc,1 
	cbi portc,0
	out porta,dat
	rcall delay
	out porta,zh

	in dat,pinb
	andi dat,$F0
	swap dat
	rcall ddat
	sbi portc,0
	cbi portc,1
	out porta,dat
	rcall delay
	out porta,zh
	rjmp otro
ddat:
	ldi zl,20
	add zl,dat
	ld dat,z
	ret

delay:
	ret

	ldi r17,2
	ldi r18, 74
L1:
	dec r18
	brne L1
	dec r17
	brne L1
	nop
	ret

	
