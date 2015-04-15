org 100h
JMP inicio
MSG DB 'Alejandro Herce Bernal', 5

inicio:
mov cx, 5
mov si, 200h
ab:
mov di, 0
ciclo:        
mov al, MSG[DI]
mov [si], al
inc di
inc si
cmp al, 5
jnz ciclo
;mov di, 0
loop ab



ret