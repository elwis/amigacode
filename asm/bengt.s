����                                        ;*** Copperlist ***
;Customchip reg
INTENA = $9A	;interrupt-enable-reg
DMACON = $96	;DMA-control reg
COLOR00 = $180 	;Color palette register 0

;Copper reg

COP1LC = $80	;address of 1.
COP2LC = $84	;address of 2.
COPJMP1 = $88 	;Jump to Copper 1
COPJMP2 = $8a	;Jump to 2

;CIA-A register A (mouse key)
CIAAPRA = $BFE001

;Exec library Base offsets
OpenLibrary = -30-522	;Libname, Version/a1,d0
Forbid = -30-102
Permit = -30-108
AllocMem = -30-168	;Byte Size Requirements/d0,d1
FreeMem = -30-180 	;Memoery Block, Byte Size/a1,d0

;graphics base
StartList = 38

;other labels
Execbase = 4
Chip = 2	;request chip-RAM

;** initialize program **
;Request memory for Copper List
Start:
	move.l Execbase,a6
	moveq  #Clsize,d0	;set param for AllocMem
	moveq  #chip, d1	;ask for chip-RAM
	jsr    AllocMem(a6)	;request memory
	move.l d0,CLadr		;address of RAM-area
	beq.s  Ende		;Error -> End

; copy Copperlist to CLadr
	lea    CLstart, a0
	move.l CLadr,a1
	moveq  #CLsize-1,d0	;set Loop value
CLcopy:
	move.b (a0)+,(a1)+	;copy copperlist byte for byte
	dbf    d0,CLcopy

;** Main program **

	jsr   forbid(a6)	;Task switching off
	lea   $dff000,a5	;basic address of register to A5
	move.w #$03a0,dmacon(a5)	;DMA offn
	move.l CLadr,cop1lc(a5)	;address of Copperlist to COP1LC
	clr.w copjmp1(a5)	;Load copperlist in program counter

;Switch Copper DMA
	move.w #$8280,dmacon(a5)
	;wait for left mouse
Wait: btst #6,ciaapra	;Bit test
	bne.s Wait	;done? else continue

;** End program **
;Restore old copper
	move.l #GRname,a1	;set param for OpenLibrary
	clr.l	d0
	jsr	OpenLibrary(a6)	;Graphics lib open
	move.l	d0,a4		;Address of Graphic base
	move.l	StartList(a4),cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w #$83e0,dmacon(a5)	;all JMA on
	jsr	permit(a6)	;task-switching on
	;Free memory of copperlist
	move.l CLadr,a1		;set param for freemem
	moveq	#CLsize,d0
	jsr	FreeMem(a6)	;memory freed
	Ende:	clr.l d0	;error flag erased
	rts			;end program

;Variables
Cladr:	dc.l 0
;Constants
GRname: dc.b "graphics.library",0
 align				;even for other assemblers

;Copperlist
CLstart:
	dc.w color00,$0000
	dc.w $640f,$fffe
	dc.w color00,$0f00
	dc.w $BE0f,$fffe
	dc.w color00,$0fb0
	dc.w $ffff,$fffe
CLend:

CLsize = CLend -CLstart
end
;End of program


