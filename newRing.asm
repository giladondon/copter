; ===========================
; Programmer: Gilad Barak
; Name of Procedure: ramArray
; Date: 4/4/2015
; ==================================================
; Shifts values of array.
; Puts random value (0-3) in last byte of array.
; [bp+4] stands for offset of array.
; =========================================================
; INPUT: offset of array (64 bytes)
; OUTPUT: same array values shifted left in new array. Random
; value in last adress of array.
; =========================================================
; Uses and restore value of registers:
; 			AX CX BX BP
; ======================================
proc newRing
	push bp ;Saves value of bp
	mov bp, sp
	push bx ;Saves value of bx
	push cx	;Saves value of cx
	push ax ;Saves value of ax
	mov bx, [bp+4] ;offset of array goes in bx
	inc bx ;starts at array[1]
	mov cx, 63d
; ================================================
; shiftsValue loops 63 times, shifts values back.
shiftValues:
	mov al, [byte ptr bx] ;value of current byte in al
	mov [byte ptr bx-1], al ;copies value of current value (al) to 1 byte behind
	inc bx ;Continues to next adress byte
	loop shiftValues ;loop back until array [63]
	xor ax,ax ; 0 => ax
	in al, 40h 
	and al, 11b ;Random value 0-3 => al
	mov [byte ptr bx-1], al ;Random value 0-3 into last byte (array[63])
	pop ax ;Restores value of ax
	pop cx ;Restores value of cx
	pop bx ;Restores value of bx
	pop bp ;Restores value of bp
	ret 2
endp newRing