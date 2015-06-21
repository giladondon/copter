; ===========================
; Programmer: Gilad Barak
; Name of Procedure: copter
; Date: 7/5/2015
; ==================================================
; Paints a given bitmap in given location
; [bp+4] stands for bitmap height
; [bp+6] stands for bitmap width
; [bp+8] stands for bitmap y
; [bp+10] stands for bitmap x
; [bp+12] stands for bitmap offset
; ==================================================
; INPUT: pushing to stack 1.bitmap offset 2.bitmap x
;							3.bitmap y 4.bitmap width
;								5.bitmap height
; OUTPUT: Loads bitMap to screen
; ======================================
; Uses and restore value of registers:
; 				CX DX
; ======================================
proc drawBitmap
	push bp ;Save value of bp
	mov bp,sp
	push ax ;Save value of ax
	push cx ;Save value of cx
	push dx ;Save value of dx
	push bx ;Save value of bx
	push si ;Save value of si
	
	mov si, [bp+12] ;bitmap offset
	mov dx, [bp+8] ;bitmap y
	mov cx, [bp+4] ;bitmap height
	mov bx, [bp+10] ;bitmap x
	
outerBitmap:
	push cx
	mov cx, [bp+6]
innerBitmap:
	push cx
	mov cx,bx
	inc bx
	mov al,[byte ptr ds:si]
	inc si
	mov ah,0Ch
	int 10h ;write pixel from bitmap to screen
	pop cx
	loop innerBitmap
	
	sub bx, [bp+6]
	inc dx ;increase y after starting a new line
	pop cx
	loop outerBitmap
	
	
	;restore following registers:
	pop si
	pop bx
	pop dx
	pop cx
	pop ax
	
	pop bp
	ret 10
endp drawBitmap