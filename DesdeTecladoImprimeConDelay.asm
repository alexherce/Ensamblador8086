org 100h

mov ah, 00
mov al, 03
int 10h
mov di, 300h 

entrada:
        mov ah, 01
ab:
        int 16h
        jz ab
        stosb
        mov ah, 00
        int 16h
        cmp al, 0dh
        jnz entrada
        mov si, 300h
        
salida:
        mov ah, 0eh
        lodsb
        int 10h
        mov ah, 86h
        mov cx, 4ch
        mov dx, 4b40h
        int 15h
        cmp al, 0dh
        jnz salida
        
ret