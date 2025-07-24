;APS0000004F0000004F0000004F0000004F0000004F0000004F0000004F0000004F0000004F0000004F
init:
	move #$ac,d7   ;start y pos
	move #1, d6	;y add
***********************
mainloop:
wframe:
	cmp.b #$2c,$dff006
	bne wframe
	move.w #$000,$dff180
	
;------ frame loop start ----	
	add d6,d7	;add "1" to y pos

	cmp #$f0,d7	;bottom check
	blo ok1
	neg d6		;change direction
ok1:	
	cmp.b #$40,d7
	bhi ok2
	neg d6		;change dir

ok2:
	
waitras1:
	cmp.b $dff006,d7
	bne waitras1
	move.w #$fff,$dff180

waitras2:
	cmp.b $dff006,d7
	beq waitras2
        move.w #$126,$dff180
        
;------ frame loop end ------

	btst #6,$bfe001
	bne mainloop
	rts
