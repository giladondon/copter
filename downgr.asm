; ===========================
; Programmer: Gilad Barak
; Name of Procedure: copter
; Date: 2/4/2015
; ==================================================
; paints copter softly down by 10d
; ONLY CALL WHEN COPTER NEEDS TO BE TAKEN DOWN
; ==================================================
; INPUT: non
; OUTPUT: non
; ======================================
; Uses and restore value of registers:
; 				CX DX
; ======================================
proc downgr
	push cx ;Saves value of cx
	push dx ;Saves value of dx
	mov cx, 5d ;Runs loop 10 times
putPixelDown:
	DrawImage blackD,xCopter,y,wCopter,hCopter
	mov dx, [copterY]
	sub dx, cx ;So it'll paint every pixel on the way
	mov [y], dx
	DrawImage copterDraw,xCopter,y,wCopter,hCopter
	loop putPixelDown
	pop dx ;Restores value of dx
	pop cx ;Restores value of cx
	ret
endp downgr


