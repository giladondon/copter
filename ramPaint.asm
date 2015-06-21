; ===========================
; Programer: Gilad Barak
; Name of Procedure: ramPaint
; Date: 3/4/2015
; ==================================================
; Draws current ring on screen.
; [bp+14] stands for Y of first pixel ring.
; [bp+12] stands for offset of random array
; [bp-2] stands for Xring
; [bp-4] stands for Yring
; =========================================================
; INPUT: 2.offset of random array, 1.Y of first pixel ring
; OUTPUT: non
; =========================================================
; Uses and restore value of registers:
; 			AX CX DX BX BP
; ======================================
proc ramPaint
	jmp conu
lowBoard:
	push ax
	mov ax, [bp-4]
	mov [lowBoarderCopter], ax
	pop ax
	jmp contl
conu:
	push cx ;Saves value of cx
	push dx ;Saves value of dx
	push bx ;Saves value of bx
	push di
	push ax ;Saves value of ax
	push bp ;Saves value of bp
	mov bp, sp
	sub sp, 4d ;In order to creat room for 2 local variables
	mov al, [byte ptr bp+16] ;Y of first pixel ring
	mov ah, 00h
	mov [bp-4], ax ;First local variable (Yring)
	mov [word ptr bp-2], 0h ;Seconde local varibles (Xring) equals to zero at the begining
	mov bx, [bp+14] ;offset of random array
	add bx, 16d
	mov di, [bp+14]
	mov cx, 64d
putLedge:
	push cx ;Saves value of cx for loop usage (putLedge)
	mov cx, 5d
	cmp bx, di
	je lowBoard
contl:
	cmp [byte ptr di], 2d ;2 in the array means ring is going down
	je upper ;Takes ring down
	cmp [byte ptr di], 1d ;1 in the array means ring is going up
	je lower ;Takes ring up
	jmp stay ;if 0 or 3 array stays in same Y
upper:
	mov dx, [bp-4] ;Yring
	push cx ;Save value of cx used for interupt
	mov cx, [bp-2] ;Xring
	mov bh, 0h ;Page
	mov al, 1010b ;Color green
	mov ah, 0ch
	int 10h ;Paints pixel to screen
	call Grass
	inc [word ptr bp-2] ;increase Xring
	inc [word ptr bp-4] ;increase Yring
	pop cx ;Restore cx for loop usage (upper)
	loop upper
	pop cx ;Restore cx for loop usage (putLedge)
	inc di ;Continue to next cell in array
	loop putLedge
	jmp ERamPaint
lower:
	mov dx, [bp-4] ;Yring
	push cx ;Save value of cx used for interupt
	mov cx, [bp-2] ;Xring
	mov bh, 0h ;Page
	mov al, 1010b ;Color white
	mov ah, 0ch
	int 10h ;Paints pixel to screen
	call Grass
	inc [word ptr bp-2] ;increase Xring
	dec [word ptr bp-4] ;decrease Yring
	pop cx ;Restore cx for loop usage (lower)
	loop lower
	pop cx ;Restore cx for loop usage (putLedge)
	inc di ;Continue to next cell in array
	loop putLedge
	jmp ERamPaint
stay:
	mov dx, [bp-4] ;Yring
	push cx ;Save value of cx used for interupt
	mov cx, [bp-2] ;Xring
	mov bh, 0h ;Page
	mov al, 1010b ;Color white
	mov ah, 0ch 
	int 10h ;Paints pixel to screen
	call Grass
	inc [word ptr bp-2] ;increase Xring
	pop cx ;Restore cx for loop usage (stay)
	loop stay
	pop cx ;Restore cx for loop usage (putLedge)
	inc di ;Continue to next cell in array
	loop putLedge 
	jmp ERamPaint
ERamPaint:
	add sp, 4d ;Delete room of local variables
	pop bp ;Restore value of bp
	pop ax ;Restore value of ax
	pop di
	pop bx ;Restore value of bx
	pop dx ;Restore value of dx
	pop cx ;Restore value of cx
	ret 4
endp ramPaint