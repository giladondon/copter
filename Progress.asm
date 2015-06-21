IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------
; Your variables here
; --------------------------
CODESEG
start:
	mov ax, @data
	mov ds, ax
	mov ax, 0013h
   	int 10h
   	mov ah, 0eh
   	mov al, 'E'
exit:
	mov ah,00h
	mov al,03h
	int 10h
	mov ax, 4c00h
	int 21h
END start


