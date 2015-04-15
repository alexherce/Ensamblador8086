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

imprimir2 macro texto ren col
mov ah, 02h
mov dh, ren
mov dl, col
mov bh, 00
int 10h

mov ah, 0ah
mov al, texto
add al, 30h
mov bh, 00
mov cx, 1 
int 10h
       
imprimir2 endm 

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

jmp main
texto DB '1.- HH:MM:SS, 2.- MM:HH, 3.- SS:MM:HH', 0
textoDos DB '1.- 12 Hrs, 2.- 24Hrs.', 0
dosPuntos DB ':',0

main:
int 10h

mov ah, 00h
mov al, 03h
int 10h   

imprimir textoDos, 1, 1, 00fh
obtenerDato 1, 400h


mov ah, 2Ch
int 21h


mov ah, 0

cmp [400h], 1
jne seguir

mov ax, ch
cmp ax, 0ch
jg seguir2

seguir:
mov al, ch
mov bl, 10
div bl
mov [3000h], al
mov [3001h], ah
mov ah, 0
jmp continue

seguir2:
sub ch, 12
mov al, ch
mov bl, 10
div bl
mov [3000h], al
mov [3001h], ah
mov ah, 0

continue:
mov al, cl
div bl
mov [3002h], al
mov [3003h], ah
mov ah, 0

mov al, dh
div bl
mov [3004h], al
mov [3005h], ah
mov ah, 0

mov [3006h], ':'


imprimir texto, 2, 1, 00fh
obtenerDato 1, 300h

cmp [300h], 1
je opcion1

cmp [300h], 2
je opcion2

cmp [300h], 3
je opcion3

opcion1:
imprimir2 [3000h], 4, 1
imprimir2 [3001h], 4, 2
imprimir dosPuntos, 4, 3, 007h
imprimir2 [3002h], 4, 4
imprimir2 [3003h], 4, 5
imprimir dosPuntos, 4, 6, 007h
imprimir2 [3004h], 4, 7
imprimir2 [3005h], 4, 8
jmp endprog


opcion2:
imprimir2 [3002h], 4, 1
imprimir2 [3003h], 4, 2
imprimir dosPuntos, 4, 3, 007h
imprimir2 [3000h], 4, 4
imprimir2 [3001h], 4, 5

jmp endprog

opcion3: 
imprimir dosPuntos, 4, 1, 007h
imprimir2 [3004h], 4, 2
imprimir2 [3005h], 4, 3
imprimir dosPuntos, 4, 4, 007h
imprimir2 [3002h], 4, 5
imprimir2 [3003h], 4, 6
imprimir dosPuntos, 4, 7, 007h
imprimir2 [3000h], 4, 8
imprimir2 [3001h], 4, 9
jmp endprog

endprog:
ret







 


