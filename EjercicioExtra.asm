org 100h

mov di, 100h
mov cx, 40
mov dx, 0

ciclo:
    mov al, [di]
    mov bl, 2
    div bl
    cmp ah, 0
    je par
    jne impar
par:
    ;guarda temporalmente los resultados pares en dh
    add dh, [di]
    inc di
    jmp terminapar
impar: 
    ;guarda temporalmente los resultados impares en dl
    add dl, [di]
    inc di
terminapar:
loop ciclo

;resultado final pares:
mov ax, dh
;resultado final impares:
mov bx, dl

ret

