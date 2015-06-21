; ===========================
; Programmer: Gilad Barak
; Name of Procedure: obs
; Date: 11/6/2015
; =============================================================
; deals all obstacles on screen, paints new and checks copter
; =============================================================
; INPUT: non
; OUTPUT: all obstacle maintaining
; ======================================
; Uses and restore value of registers:
; 				CX AX
; ======================================
proc obs
	push ax ;Save value of ax
	push cx ;Save value of cx
	DrawImage bObstacle,xObstacle,yObstacle,wObstacle,hObstacle ;Clear last obstacle
	sub [xObstacle], 5d ;Move obstacle on x
	DrawImage obstacle,xObstacle,yObstacle,wObstacle,hObstacle
	cmp [xObstacle], 92d ;92 Because obstacle starts being drawn at 128d
	je checkObs
	cmp [xObstacle], 87d ;97 Because obstacle starts being drawn at 128d
	je checkObs
	cmp [xObstacle], 82d ;97 Because obstacle starts being drawn at 128d
	je checkObs
	cmp [xObstacle], 77d ;97 Because obstacle starts being drawn at 128d
	je checkObs
	cmp [xObstacle], 72d ;97 Because obstacle starts being drawn at 128d
	je checkObs
	cmp [xObstacle], 67d ;97 Because obstacle starts being drawn at 128d
	je checkObs
	cmp [xObstacle], 2d ;Last place obstacle is drawn in
	je restartObs
	pop cx
	pop ax
	ret
checkObs:
	mov ax, [yObstacle]
	sub ax, 10d
	mov cx, 37d ;Obstacle length plus copter length
ifU:
	cmp ax, [copterY]
	je exitP 
	inc ax
	loop ifU
	pop cx
	pop ax
	ret
exitP:
	pop cx
	pop ax
	jmp exit
restartObs:
	DrawImage bObstacle,xObstacle,yObstacle,wObstacle,hObstacle
	mov [xObstacle], 312d
	xor ax, ax ; ax => 0
	in al, 40h ;Get system time
	and ax, 11b ;Random 0-3
	cmp ax, 2d
	je paintD
	cmp ax, 1d 
	je paintU
	cmp ax, 0d
	je paintU
	mov [yObstacle], 65d
	pop cx
	pop ax
	ret
paintD:
	mov [yObstacle], 70d
	pop cx
	pop ax
	ret
paintU:
	mov [yObstacle], 40d
	pop cx
	pop ax
	ret
endp obs


