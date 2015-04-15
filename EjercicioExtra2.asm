org 100h

mov bx, 100h
mov cx, 40
mov dx, 0

ciclo:
    mov al, [bx]
    mov dl, 2
    div dl
    cmp ah, 0
    je par
    jne impar
par:
    add si, [bx]
    inc bx
    jmp terminapar
impar: 
    add di, [bx]
    inc bx
terminapar:
loop ciclo

;resultado final pares:
mov ax, si
;resultado final impares:
mov bx, di

ret

