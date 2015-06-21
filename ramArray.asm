; ===========================
; Programmer: Gilad Barak
; Name of Procedure: ramArray
; Date: 3/4/2015
; ==================================================
; Randomize values (0-3) into a 64 bit array
; [bp+4] stands for offset of array needs random (64 bytes)
; =========================================================
; INPUT: offset of array(64 bytes)
; OUTPUT: array made of values (0-3)
; =========================================================
; Uses and restore value of registers:
; 			AX CX BX BP
; ======================================
proc ramArray
	push bp ;save value of bp
	mov bp, sp
	push bx ;save value of bx
	push cx ;save value of cx
	push ax ;save value of ax
	mov bx, [bp+4] ;offset of array
	mov cx, 64d
random:
	xor ax, ax ; ax => 0
	in al, 40h ;Get system time
	and ax, 11b ;Random 0-3
	mov [byte ptr bx], al ;Insert cell in array
	inc bx ;Continue to next cell
	loop random
	pop ax ;Restore value of ax
	pop cx ;Restore value of cx
	pop bx ;Restore value of bx
	pop bp ;Restore value of bp
	ret 2 
endp ramArray