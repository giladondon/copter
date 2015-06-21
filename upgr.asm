; ===========================
; Programmer: Gilad Barak
; Name of Procedure: copter
; Date: 2/4/2015
; ==================================================
; paints copter softly up by 10d
; ONLY CALL WHEN COPTER NEEDS TO BE TAKEN UP
; ==================================================
; INPUT: non
; OUTPUT: non
; ======================================
; Uses and restore value of registers:
; 				CX DX
; ======================================
proc upgr
	push cx ;Saves value of cx
	push dx ;Saves value of dx
	mov cx, 10d ;Runs loop 10 times
putPixelUp:
	DrawImage blackD,xCopter,y,wCopter,hCopter
	mov dx, [copterY]
	add dx, cx ;So it'll paint every pixel on the way
	mov [y], dx
	DrawImage copterDraw,xCopter,y,wCopter,hCopter
	loop putPixelUp
	pop dx ;Restores value of dx
	pop cx ;Restores value of cx
	ret
endp upgr


