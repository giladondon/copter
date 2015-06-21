; ===========================
; Programmer: Gilad Barak
; Name of Procedure: checkCop
; Date: 16/4/2015
; ==================================================
; Delays program for some time
; ==================================================
; INPUT:non
; OUTPUT: non
; ======================================
; Uses and restore value of registers:
; 			AX DI BX DX CX
; ======================================
proc delay
	push di
	push ax
	push bx
	push dx
	push cx
	MOV DI, 2
	MOV AH, 0
	INT 1Ah
	MOV BX, DX
Del:
	MOV AH, 0
	INT 1Ah
	SUB DX, BX
	CMP DI, DX
	JA Del
	pop cx
	pop dx
	pop bx
	pop ax
	pop di
endp delay