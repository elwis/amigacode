;***************************
;   Take control of the Amiga
;****************************

;**************************************
;   INCLUDES
;**************************************

    incdir  "include"
    include "hw.i"
    include "funcdef.i"
    include "exec/exec_lib.i"
    include "graphics/graphics_lib.i"
    include "takeover.i"

;*************************************
;   VARIABLES
;*************************************

; string with name of graphics library
gfx_name    dc.b    "graphics.library",0,0
; base address of graphics.library
gfx_base    dc.l    0
;saved state of DMACON
old_dma dc.w    0

;*************************************
;   ROUTINES
;*************************************

;*************************************
;TaKES FULL CONTROL OF SYSTEM
;***************************************
    xdef    take_system
take_system:
    move.l  ExecBase,a6         ;nbase address of Exec
    jsr     _LVOForbid(a6)               ; disables O.S. multitasking
    jsr     _LVODisable(a6)              ; disables O.S. interrupts

    lea     gfx_name,a1         ;OpenLibrary takes 1 param, lib name in a1
    jsr     _LVOOldOpenLibrary(a6)       ; opens graphics.library
    move.l  d0,gfx_base         ;opens graphicslib, save base address in variable
    lea     CUSTOM,a5           ;a5 will always contain CUSTOM chips baseaddress $dff000

    move.w  DMACONR(a5),old_dma ;save state of DMA channels
    move.w  #$7fff,DMACON(a5)   ;disables all DMA channels
    move.w  #DMASET,DMACON(a5)  ;sets only dma channels we will use

    move.w     #0,FMODE(a5)                 ; sets 16 bit FMODE
    move.w     #$c00,BPLCON3(a5)            ; sets default value                       
    move.w     #$11,BPLCON4(a5)             ; sets default value
    
    rts

;******************************************
; Relase system to the OS again
;******************************************
    xdef    release_system
release_system:
    or.w    #$8000,old_dma      ; sets bit 15
    move.w  old_dma,DMACON(a5)      ; restore saved DMA
    
    move.l  ExecBase,a6         ; base address of Exec
    jsr     _LVOPermit(a6)      ; enable multitasking
    jsr     _LVOEnable(a6)      ; enable interrupts
    move.l  gfx_base,a1         ; base address of graphics lib
    jsr     _LVOCloseLibrary(a6)    ; close graphics lib
    rts

