; ===========================
; Programmer: Gilad Barak
; Name of Procedure: checkCop
; Date: 16/4/2015
; ==================================================
; Compares copter to ring and exits program if copter
; is lower than the ring
; ==================================================
; INPUT:non
; OUTPUT: non
; ======================================
; Uses and restore value of registers:
; 				AX
; ======================================
proc checkCop
	push ax ;Save value of ax
	mov ax, [copterY]
	add ax, 15d
	cmp ax, [lowBoarderCopter] ;If the copter in lower or at the same height as the ring
	jae endGame ;Exit program
	pop ax ;Restore value of ax
	ret ;return to program
endGame:
	pop ax ;Restore value of ax
	jmp exit ;exit game
endp checkCop


