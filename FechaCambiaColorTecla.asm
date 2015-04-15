;Karina Mariaud
;Alejandro Herce
;Rodolfo Olagaray
;Javier Curiel
;Alan Bleier

imprimir macro texto ren col color
    local ciclo
        mov si, texto
        mov dl, col
        mov dh, ren
ciclo:
        mov bl, color
        mov ah, 02
        mov bh, 00
        int 10h
        mov ah, 09
        mov al, [si]
        add al, 30h
        mov cx, 1
        int 10h
        inc si 
        inc bl 
        inc dl
        cmp al, '_'
        jnz ciclo
       
imprimir endm

obtenerTexto macro var mem
    local entrada
            mov di, mem
            mov cx, var 

        entrada:
            mov ah, 00h
            int 16h
            mov [di], al
            dec cx
            inc di
            cmp cx, 0
            jne entrada
        
obtenerTexto endm

org 100h
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

mov 4000h, 1
imprimirFecha:
imprimir 3000h, 1, 1, [4000h]
inc [4000h]
cmp [4000h], 9

obtenerTexto 1, 5000h
cmp [5000h], 'a'
jne endprog

cmp [4000h], 9
jne imprimirFecha
mov 4000h, 1
jmp imprimirFecha


endprog:
ret