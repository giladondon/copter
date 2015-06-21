; ===========================
; Programmer: Gilad Barak
; Name of Procedure: fly
; Date: 9/4/2015
; ==================================================
; DOWN ARROW - takes copterY down - copter goes up
; UP ARROW - takes copterY up - copter goes down
; program checks if a key is pressed, any other key
; lowers adds copterY 5d - takes copter down
; ==================================================
; INPUT: non
; OUTPUT: new copterY
; ======================================
; Uses and restore value of registers:
; 				AX DX CX
; ======================================
proc readKey
	push cx ;Saves value of cx
	push dx ;Saves value of dx
	push ax ;Saves value of ax
	in al, 60h ;keyboard port code
	mov ah, 0bh
	int 21h ;Checks if key is pressed - AL = 0 if no key is pressed
	and al, 1 
	jz takeDown ;if no key is pressed
	mov ah, 00h
	int 16h ;Check what key is pressed AL => key scan code
	cmp ah, UP_KEY ;If up key is pressed, take copter down
	je takeDown
	cmp ah, DOWN_KEY ;If down key is pressed, take copter up
	je takeUp
	jmp cont
takeDown:
	add [copterY], 10d ;take copter down by 10d - add cppterY 10d
	call downgr
	jmp endProc
takeUp:
	sub [copterY], 10d ;take copter up by 10d - sub copterY 10d
	call upgr
	jmp endProc
endProc:
	pop ax ;Restore value of ax
	pop dx ;Restore value of dx
	pop cx ;Restore value of cx
	ret
endp readKey


