imprimirMatriz macro memoria ren col color
local ciclom     
        mov 5000h, 16
        mov al, [2001h]
        mov 5001h, al
        mov 5002h, 0
        mov di, 0
        mov cx, 16
        mov si, memoria
        mov dl, col
        mov dh, ren
ciclom:
        cmp [si], 0dh
        je endmacro
        mov bl, 00fh
        mov ah, 02
        mov bh, 00
        int 10h
        mov ah, 09
        mov al, [si]
        mov cx, 1
        int 10h
        inc si 
        inc bl 
        inc dl
        inc [5002h]
        dec [5000h]
        cmp [5002h], 4
        je newrenglon
continuarmacro: 
        cmp [5000h], 0
        jne ciclom
        jmp endmacro
newrenglon:
        add dh, 1
        mov dl, [5001h]
        mov 5002h, 0
        jmp continuarmacro
        
        endmacro:
            
imprimirMatriz endm

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

org 100h

jmp main
texto DB 'Ingresa cadena: ', 0

main:
mov ah, 00
mov al, 03
int 10h

;imprimir texto, 1, 1, 00fh
mov si, 3000h
entrada:
        mov ah, 01
ab:
        int 16h
        jz ab
        mov [si], al
        inc si
        mov ah, 00
        int 16h
        cmp al, 0dh
        jnz entrada

mov 2000h, 3
mov 2001h, 1
mov 2002h, 8
mov 2003h, 0
mov si, 3000h

impresiones:
imprimirMatriz si, [2000h], [2001h], 00fh
cmp [2001h], 33
je nuevorenglon

continuar:
add [2001h], 8
cmp [si], 0dh
jne impresiones

jmp endprog
nuevorenglon:
mov 2001h, 1
add [2000h], 8
jmp continuar

endprog:
ret
        
        

        
