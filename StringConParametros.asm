;KARINA MARIAUD
;ALEJANDRO HERCE
;RODOLFO OLAGARAY
;JAVIER CURIEL
;ALAN BLEIER

imprimir macro texto ren col color
    local ciclo
        mov si, 0
        mov dl, col
        mov dh, ren
ciclo:
        mov bl, color
        mov ah, 02
        mov bh, 00
        int 10h
        mov ah, 09
        mov al, texto[si]
        mov cx, 1
        int 10h
        inc si 
        inc bl 
        inc dl
        cmp al, 0
        jnz ciclo
       
imprimir endm 

obtenerDato macro var mem
    local entrada
            mov di, mem
            mov cx, var 

        entrada:
            mov ah, 00h
            int 16h
            sub al, 30h
            mov [di], al
            dec cx
            inc di
            cmp cx, 0
            jne entrada
        
obtenerDato endm

org 100h
      
;vectores
jmp continuar
letra DB 'Color de letra: 0.- negro, 1.- azul, 2.- verde, 3.- cyan',0
fondo DB 'Color de fondo: 0.- negro, 1.- azul, 2.- verde, 3.- cyan',0 
continuar:

mov ah, 00
mov al, 03
int 10h


imprimir letra, 1, 1, 00fh
obtenerDato 1, 300h

imprimir fondo, 2, 1, 00fh
obtenerDato 1, 301h


mov al, [301H]
;MOV al, [300H]

;and bl, al


mov bl, 16
mul bl
mov [301h], al
mov ax, [301h]
add [300h], ax
;add [300h], 30h
mov di, 3000h

MOV [4000H], 1
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
        mov si, 3000h
        
salida:
        mov ah, 02h
        mov dh, 5
        mov dl, [4000H]
        mov bh, 0
        int 10h
        mov ah, 09h
        mov bh, 00
        mov bl, [300h]
        mov cx, 1
        lodsb
        int 10h
        inc [4000H]
        cmp al, 0dh
        jnz salida
        
ret