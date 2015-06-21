proc clear
	push ax
	push es
	push di
	push cx
	mov ax,0A000h
    mov es,ax
    xor di,di
    xor ax,ax
    mov cx,32000d
    cld
    rep stosw
    pop cx
    pop di
    pop es
    pop ax
    ret
endp clear


