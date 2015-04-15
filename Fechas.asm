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
texto DB '1.- DDMMAA, 2.- MMDDAA, 3.- DDMMAAAA, 4.-AAMMDD', 0

main:
int 10h

mov ah, 00h
mov al, 03h
int 10h   

mov ah, 2Ah
int 21h


mov ah, 0
mov al, dl
mov bl, 10
div bl
mov [3000h], al
mov [3001h], ah
mov ah, 0

mov al, dh
div bl
mov [3002h], al
mov [3003h], ah
mov ah, 0

mov [3004h], 2
mov [3005h], 0

mov ax, cx
sub ax, 2000d
div bl
mov [3006h], al
mov [3007h], ah
mov ah, 0

mov [3008h], '/'


imprimir texto, 1, 1, 00fh
obtenerDato 1, 300h

cmp [300h], 1
je opcion1

cmp [300h], 2
je opcion2

cmp [300h], 3
je opcion3

cmp [300h], 4
je opcion4

opcion1:
imprimir2 [3000h], 4, 2
imprimir2 [3001h], 4, 3
imprimir2 [3008h], 4, 4
imprimir2 [3002h], 4, 5
imprimir2 [3003h], 4, 6
imprimir2 [3008h], 4, 7
imprimir2 [3006h], 4, 8
imprimir2 [3007h], 4, 9
jmp endprog


opcion2:
imprimir2 [3002h], 4, 1
imprimir2 [3003h], 4, 2
imprimir2 [3008h], 4, 3
imprimir2 [3000h], 4, 4
imprimir2 [3001h], 4, 5
imprimir2 [3008h], 4, 6
imprimir2 [3006h], 4, 7
imprimir2 [3007h], 4, 8
jmp endprog

opcion3:
imprimir2 [3000h], 4, 2
imprimir2 [3001h], 4, 3
imprimir2 [3008h], 4, 4
imprimir2 [3002h], 4, 5
imprimir2 [3003h], 4, 6
imprimir2 [3008h], 4, 7
imprimir2 [3004h], 4, 8
imprimir2 [3005h], 4, 9
imprimir2 [3006h], 4, 10
imprimir2 [3007h], 4, 11
jmp endprog

opcion4:
imprimir2 [3006h], 4, 2
imprimir2 [3007h], 4, 3
imprimir2 [3008h], 4, 4
imprimir2 [3002h], 4, 5
imprimir2 [3003h], 4, 6
imprimir2 [3008h], 4, 7
imprimir2 [3000h], 4, 8
imprimir2 [3001h], 4, 9
jmp endprog

endprog:
ret







 


