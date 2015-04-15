;Programa que despliega un conjunto de arreglo en pantalla
org 100h
jmp inicio

;vectores de datos
nombre db 'Ahora si, computologos...', 10, 13
       db 'Ahora si veremos algunos resultados en pantalla', 0

inicio:
        mov ah, 00h
        mov al, 00h
        int 10h
        mov dx, 3h
        mov si, 0
ciclo:
        mov bl, 01h
        mov ah, 02
        mov bh, 00
        int 10h
        mov ah, 09
        mov al, nombre[si]
        mov cx, 1
        int 10h
        inc si 
        inc bl 
        inc dl
        cmp al, 0
        jnz ciclo
        
        
ret