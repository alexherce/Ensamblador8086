chona macro jlo, taylor
    local ab
    mov ah, 0eh
    mov si, 0
ab:
    mov al, jlo[si]
    int 10h
    inc si
    cmp al, taylor
    jnz ab
chona endm


org 100h
jmp inicio
bsb db 'ensamblador esta chido!', 0
beyonce db 'ahora si podran hacer el reto', 3
chakira db 'solo faltan dos temas en ensamblador', 7

inicio:
        mov ah, 00
        mov al, 03
        int 10h
        call juanita
        chona bsb, 0
        call juanita
        chona beyonce, 3
        call juanita
        chona chakira, 7
ret

juanita proc
    mov ah, 01
ab:
    int 16h
    jz ab
    mov ah, 00
    int 16h
    ret
juanita endp