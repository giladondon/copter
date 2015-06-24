IDEAL
MODEL small
STACK 100h
DATASEG
	ring db 64 dup ('$') ;Array of the ring
	startY dw 80d ;The Y that the ring currently starts at
	copterY dw 20d ;The Y the copter is currently at
	lowBoarderCopter dw ? ;Saves the value of ringY in order to limit copter movement
	Up_KEY equ 72d ; arrow down
	Down_KEY equ 80d ; arrow up
	white equ 1010b
	lowBoarder equ 198d ;Boarders of ring
	highBoarder equ 2d ;Boarders of ring
	Address dw ?
	bitmapHeight equ [bp+4]
	bitmapWidth equ [bp+6]
	bitmapY equ [bp+8]
	bitmapX equ [bp+10]
	bitmapPic equ [bp+12]
	xCopter dw 80d
	wCopter dw 16d
	hCopter dw 16d
	xObstacle dw 312d
	yObstacle dw 50d
	wObstacle dw 8d 
	hObstacle dw 16d
	y dw ?
	toDrawObs db ?
	include 'copterD.asm'
	StartPictX dw 0
   	StartPictY dw 0
   	WidthPict dw ? ;(if 320*200 than not necessary. In ;PCX must be even)
   	HeightPict dw ? 
   	LengthPict dw ? 
   	Handle dw 0 ;(a number to recognize the file)
   	FileLength dw ? 
   	FileName db '1.pcx', 0
   	Buffer db 64000 dup(?)
   	Point_Fname dd FileName
   	FileName2 db '2.pcx', 0
   	Point_Fname2 dd FileName2
   	FileName3 db '3.pcx', 0
   	Point_Fname3 dd FileName3
   	Point_Buffer dd Buffer
	macro DrawImage obj,ObjX,ObjY,ObjW,ObjH ;Macro calls drawBitmap in one line
		lea dx,[obj]
		push dx
		mov dx,[word ptr objX]
		push dx
		mov dx,[word ptr objY]
		push dx
		mov dx,[objW]
		push dx
		mov dx,[objH]
		push dx
		call drawBitmap
	endm
CODESEG
start:
	mov ax, @data
	mov ds, ax
	mov ax, 0013h
   	int 10h
mainMenu:
	lds dx, [Point_Fname]
   	call loadPcx
	cmp al, 33h
	je ExitT
	cmp al, 32h
	je Inst
	cmp al, 31h
	je contk
	jmp mainMenu
Inst:
	lds dx, [Point_Fname2]
	call loadPcx
	mov ah, 01h
	int 16h
	jmp mainMenu
ExitT:
	jmp exiting
contk:
	call clear
	push offset ring
	call ramArray
	push [startY]
	push offset ring
	call fixArray
	push [startY]
	push offset ring
	call ramPaint
	DrawImage copterDraw,xCopter,copterY,wCopter,hCopter
	mov ah, 00h
	int 16h
	DrawImage blackD,xCopter,copterY,wCopter,hCopter
	call readKey
	call delay
paintNew:
	DrawImage obstacle,xObstacle,yObstacle,wObstacle,hObstacle
	call checkCop
	mov bx, offset ring
	cmp [byte ptr bx], 1d
	je decrease
	cmp [byte ptr bx], 2d
	je increase
cont:
	push offset ring
	call newRing
	push [startY]
	push offset ring
	call fixArray
	call readKey
	push [startY]
	push offset ring
	call ramPaint
	call delay
	call obs
	jmp paintNew
	jmp exit
increase:
	mov ax, 5d
	add [startY], ax
	jmp cont
decrease:
	mov ax, 5d
	sub [startY], ax
	jmp cont
exit:
	pop [Address]
	lds dx, [Point_Fname3]
	call loadPcx
	mov ah, 01h
	int 16h
	mov [copterY], 20d
	mov [startY], 80d
	mov [xObstacle], 312d
	jmp mainMenu
exiting:
	mov ah,00h
	mov al,03h
	int 10h
	mov ax, 4c00h
	int 21h
reStart:
	jmp start
	include 'ramPaint.asm'
	include 'newRing.asm'
	include 'ramArray.asm'
	include 'fixArray.asm'
	include 'readKey.asm'
	include 'delay.asm'
	include 'downgr.asm'
	include 'upgr.asm'
	include 'checkCop.asm'
	include 'drawBit.asm'
	include 'Grass.asm'
	include 'obs.asm'
	include 'clear.asm'
	include 'loadPcx.asm'
END start