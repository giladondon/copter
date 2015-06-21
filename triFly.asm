IDEAL
MODEL small
STACK 100h
DATASEG
	copterY dw 100d
	Up_KEY equ 72d ; arrow down
	Down_KEY equ 80d ; arrow up
	copterX equ 80d
	white equ 1111b
	lowBoarder equ 198d
	highBoarder equ 2d
CODESEG
start:
	mov ax, @data
	mov ds, ax
	mov ax, 0013h
   	int 10h
   	mov cx, 200d
L1:
	call readKey
	call delay
	loop L1
exit:
	mov ah,00h
	mov al,03h
	int 10h
	mov ax, 4c00h
	int 21h
	include 'copter.asm'
	include 'downgr.asm'
	include 'upgr.asm'
	include 'readKey.asm'
	include 'clear.asm'
	include 'delay.asm'
END start


