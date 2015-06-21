; ===========================
; Programmer: Gilad Barak
; Name of Procedure: copter
; Date: 2/4/2015
; ==================================================
; puts a dot (made of 4 pixels) in given location.
; X is constant (80d) and Y depends on main program
; ==================================================
; INPUT: push copterY
; OUTPUT: non
; ======================================
; Uses and restore value of registers:
; 		BP BX AX CX DX
; ======================================
proc copter
	push bp ;Saves value of BP
	mov bp, sp ;Uses bp for stack
	push bx ;Saves value of BX
	push ax ;Saves value of AX
	push cx ;Saves value of CX
	push dx ;Saves value of DX
	mov dx, [bp+4] ;Y position of new copter to be drawn
	mov cx, copterX
	mov bh, 0h
	mov al, White
	mov ah, 0ch
	int 10h ;AL = Color, BH = Page Number, CX = x, DX = y
	dec cx ;To paint one pixel back on X
	int 10h
	inc dx ;To paint one pixel back on X, one pixel higher on Y
	int 10h
	inc cx ;To paint one pixel higher on Y
	int 10h
	pop dx ;Restores value of DX
	pop cx ;Restores value of CX
	pop ax ;Restores value of AX
	pop bx ;Restores value of BX
	pop bp ;Restores value of BP
	ret 2
endp copter


