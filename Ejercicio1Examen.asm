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

textoUno DB 'Ingrese 1era cadena: ',0
textoDos DB 'Ingrese 2da cadena: ', 0
igualest DB 'Cadenas iguales.' ,0
noigualest DB ' Cadenas no iguales. ', 0


main:

mov ah, 00
mov al, 03
int 10h

;imprimir textoUno, 1, 1, 00fh
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


;imprimir textoDos, 1, 1, 00fh        
mov si, 4000h        
entrada2:
        mov ah, 01
ab2:
        int 16h
        jz ab2
        mov [si], al
        inc si
        mov ah, 00
        int 16h
        cmp al, 0dh
        jnz entrada2
        
        
mov si, 3000h
mov di, 4000h

comparar:
cmp [si], 0dh
jne seguir
cmp [di], 0dh
je end
seguir:ç
mov ax, [si]
mov bx, [di]
inc si
inc di
cmp al, bl
je comparar
jne noiguales

noiguales:
imprimir noigualest, 3, 1, 00fh
jmp terminar

end:
imprimir igualest, 3, 1, 00fh

terminar:
ret

        