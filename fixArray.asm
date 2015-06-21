; ===========================
; Programmer: Gilad Barak
; Name of Procedure: ramArray
; Date: 12/4/2015
; ==================================================
; Checks ring is in border
; If not changes ring values
; [bp+4] stands for offset of array.
; [bp+6] stands for Y of first pixel ring
; [bp-2] stands for current Y ring in order to check borders
; =============================================================
; INPUT: 1. Start Y pixel in ring 2. Offset of array (64 bytes)
; OUTPUT: Correct array values to fit inside border
; =============================================================
; Uses and restore value of registers:
; 			AX CX BX BP
; ======================================
proc fixArray
	push bp ;Save value of bp
	mov bp, sp
	sub sp, 2d ;Creat room for 1 local variable
	push ax ;Save value of ax
	push bx ;Save value of bx
	push cx ;Save value of cx
	mov ax, [bp+6] ;Y first pixel ring
	mov [bp-2], ax  ;Current Y Ring
	mov bx, [bp+4] ;offset of array
	mov cx, 64
fixing:
	cmp [byte ptr bx], 1d ;ring going up
	je taking
	cmp [byte ptr bx] ,2d ;ring going down
	je adding
conti:
	cmp [word ptr bp-2], 155d ;low boarder
	jae changeDown
	cmp [word ptr bp-2], 75d ;high border
	jbe changeUp
	jmp Eloop
changeDown:
	mov [byte ptr bx],1d ;Makes ring to go up in order to avoid skiping over low border
	mov ax, 10d
	sub [bp-2], ax ;Change current Y of ring to new value
	jmp Eloop
changeUp:
	mov [byte ptr bx],2d ;Makes ring to go down in order to avoid skiping over high border
	mov ax, 10d
	add [bp-2], ax ;Change current Y of ring to new value
	jmp Eloop
Eloop:
	inc bx ;Move to next cell in array
	loop fixing
	jmp Efix
adding:
	mov ax, 5d
	add [bp-2], ax ;Yi ring goes down
	jmp conti
taking:
	mov ax, 5d
	sub [bp-2], ax ;Y ring goes up
	jmp conti
Efix:
	pop cx ;Restore value of cx
	pop bx ;Restore value of bx
	pop ax ;Restore value of ax
	add sp, 2d ;Delete room of local variables
	pop bp ;Restore value of bp
	ret 4
endp fixArray