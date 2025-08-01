;***********************************
; Take CONTROL of the hardware
;***********************************
    IFND        TAKEOVER_I
TAKEOVER_I  SET 1

;*******************************
;   CONSTANTS
;*******************************

; DMACON reguster settings
                 ;5432109876543210
DMASET       equ %1000001000000000 
    ENDC
