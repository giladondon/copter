; ===========================
; Programmer: Gilad Barak
; Name of Procedure: grass
; Date: 8/5/2015
; ==================================================
; [bp-2] stands for Xring
; [bp-4] stands for Yring
; ==================================================
; INPUT: cx = Xring
;		 dx = Yring
; OUTPUT: completes current spot to ground
; ======================================
; Uses and restore value of registers:
; 				AX
; ======================================
proc Grass
	push ax
	push bx
	push cx
	push dx
	push bp
	mov bp, sp
	sub sp, 4d
	mov [bp-2], cx ;Xring
	mov [bp-4], dx ;Yring
	mov ax, 200d
	sub ax, dx
	mov cx, ax
	mov dx, [bp-4] ;Yring
delDown:
	push cx
	mov cx, [bp-2]
	inc dx
	mov bh, 0h ;Page
	mov al, 1010b ;Color grean
	mov ah, 0ch
	int 10h ;Paints pixel to screen
	pop cx
	loop delDown
	mov dx, [bp-4]
	mov cx, 5d
delUp:
	push cx
	mov cx, [bp-2]
	dec dx
	mov bh, 0h ;Page
	mov al, 00h ;Color black
	mov ah, 0ch
	int 10h ;Paints pixel to screen
	pop cx
	loop delUp
	add sp, 4d
	pop bp
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp Grass


