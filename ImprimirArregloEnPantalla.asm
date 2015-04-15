;Programa que despliega un conjunto de arreglo en pantalla
org 100h
jmp inicio

;vectores de datos
nombre db 'Ahora si, computologos...', 10, 13
       db 'Ahora si veremos algunos resultados en pantalla', 0

inicio:
        mov ah, 00h
        mov al, 03h
        int 10h
        mov ah, 0eh
        mov bx, 0    
ciclo:
        mov al, nombre[bx]
        int 10h
        inc bx
        cmp nombre[bx], 0
        jnz ciclo 
        
ret