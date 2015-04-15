;Karina Mariaud
;Rodolfo Olagaray
;Javier Curiel
;Alejandro Herce
;Alan Bleier

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

imprimirArray macro texto ren col color
    local ciclo
        mov si, 0
        mov dl, col
        mov dh, ren
        mov di, 16
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
        dec di
        cmp di, 0
        jnz ciclo
       
imprimirArray endm

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

llenarMatriz macro matriz
     local entrada, ciclo
            mov di, 0    
            mov cx, 16 

       entrada:
            mov ah, 00h
            int 16h
            ;add al, 30h
            mov matriz[di], al
            dec cx
            inc di
            cmp cx, 0
            jne entrada
    
llenarMatriz endm
;--------------------------------------------------------------------------------------------------
org 100h

.data
ROWSIZE = 4
array   db 1, 2, 3, 4
        db 5, 6, 7, 8
        db 9, 1, 2, 3
        db 40, 5, 6, 7
      
array2  db 0, 0, 0, 0
        db 0, 0, 0, 0
        db 0, 0, 0, 0
        db 0, 0, 0, 0
        
array3  db 1, 1, 1, 1
        db 1, 1, 1, 1
        db 1, 1, 1, 1
        db 1, 1, 1, 1        
      
.code 

jmp main   

textoUno db 'Selecciona la opcion deseada:', 0
menu db '1.- Transpuesta, 2.- Suma, 3.- Multiplicacion (No sirve)', 0
menuDos db '4.- Vector x matriz (no sirve), 5.- Matriz x vector (no sirve), 6.- Salir.', 0
textoTres db 'No seleccionaste una opcion valida. Terminando programa.', 0
textoLlenar1 db 'Llene la matriz 1. Los datos no pueden ser mayores a 50.', 0
textoLlenar2 db 'Llene la matriz 2. Los datos no pueden ser mayores a 50.', 0
textoLlenarHelp db 'La matriz se llena por filas. Ej 2x2: 1, 2, 3, 4. Fila 1: 1, 2. Fila 2: 3, 4', 0
textoTamano db 'Ingrese el tamano de ambas matrices, no puede ser mayor a 4:', 0



integrantes db 'Karina Mariaud, Alejandro Herce, Rodolfo Olagaray, Javier Curiel, Alan Bleier.', 0
clear db '                                                                              ', 0


main: 
     
int 10h

mov ah, 00h
mov al, 03h
int 10h     
     
imprimir integrantes, 24, 1, 00eh

;----------------------- MENU DE OPCIONES ------------------------
imprimir textoUno, 1, 1, 00fh
imprimir menu, 2, 1, 00fh
imprimir menuDos, 3, 1, 00fh
  

obtenerDato 1, 200h

imprimir clear, 1, 1, 00fh
imprimir clear, 2, 1, 00fh
imprimir clear, 3, 1, 00fh

cmp [200h], 1
je transpuesta

cmp [200h], 2
je suma 

cmp [200h], 3
je multiplicacion


cmp [200h], 6
je endprog
jmp nooption

;------------------------- TANSPUESTA -----------------------------
transpuesta:

imprimir textoTamano, 1, 1, 00fh

obtenerDato 1, 2000h

cmp [2000h], 4
jg transpuesta


imprimir clear, 1, 1, 00fh

imprimir textoLlenar1, 1, 1, 00fh
imprimir textoLlenarHelp, 2, 1, 00fh
llenarMatriz array
 

imprimirArray array, 1, 1, 00fh


mov bx, 0
mov cx, 1
mov si, 0
mov [2005h], 0
jmp ciclo3

ciclo2:
    add bx, ROWSIZE
    
ciclo3:
    mov al, array[bx]
    mov array2[si], al
    inc si
    inc [2005h]
    
    cmp si, 16
    je continuarTrans
    
    cmp [2005h], 4
    jne ciclo2
    
    mov bx, 0
    add bx, cx
    inc cx
    mov [2005h], 0
    
    mov al, array[bx]
    mov array2[si], al
    inc si
    inc [2005h]
    
    jmp ciclo2

continuarTrans:
    
imprimirArray array2, 3, 1, 00fh     
 

jmp endprog
;--------------------------- SUMA ---------------------------------
suma:

imprimir textoLlenar1, 1, 1, 00fh
imprimir textoLlenarHelp, 2, 1, 00fh
llenarMatriz array

imprimir clear, 1, 1, 00fh

imprimir textoLlenar2, 1, 1, 00fh
imprimir textoLlenarHelp, 2, 1, 00fh
llenarMatriz array2

imprimir clear, 1, 1, 00fh
imprimir clear, 2, 1, 00fh

imprimirArray array, 1, 1, 00fh 
imprimirArray array2, 3, 1, 00fh

mov cx, 16
mov si, 0

ciclo4:
    mov al, array[si]
    add al, array2[si]
    mov array3[si], al
    sub array3[si], 30h
    inc si
    dec cx
    cmp cx, 0
    jne ciclo4
    
imprimirArray array3, 6, 1, 00fh 


jmp endprog 
;------------------------- MULTIPLICACION -----------------------------
multiplicacion:

;LA MULTIPLICACION NO SIRVE, LO INTENTAMOS



;imprimir textoTamano, 1, 1, 00fh

;obtenerDato 1, 2000h

;cmp [2000h], 4
;jg transpuesta


;imprimir clear, 1, 1, 00fh

;imprimir textoLlenar1, 1, 1, 00fh
;imprimir textoLlenarHelp, 2, 1, 00fh
llenarMatriz array

llenarMatriz array3
 
imprimirArray array, 1, 1, 00fh
imprimirArray array3, 3, 1, 00fh


mov bx, 0
mov cx, 1
mov si, 0
mov [2005h], 0
jmp ciclo3m

ciclo2m:
    add bx, ROWSIZE
    
ciclo3m:
    mov al, array3[bx]
    mov array2[si], al
    inc si
    inc [2005h]
    
    cmp si, 16
    je continuarMult
    
    cmp [2005h], 4
    jne ciclo2m
    
    mov bx, 0
    add bx, cx
    inc cx
    mov [2005h], 0
    
    mov al, array3[bx]
    mov array2[si], al
    inc si
    inc [2005h]
    
    jmp ciclo2m

continuarMult:
    
imprimirArray array2, 6, 1, 00fh

mov dh, 0
mov dl, 4
mov si, 0
mov di, 0
mov 400h, 0
ciclo4m:
mov [6000h], 0
ciclo5m:
mov al, array[si]
sub al, 30h
mov bl, array2[di]
sub bl, 30h
mul bl
add [6000h], al
inc si
inc di
cmp si, dx
jne ciclo5m
mov si, dl
add dh, ROWSIZE 
add dl, dh
mov ax, [6000h]
mov array3[400h], ax
inc [400h]
cmp di, 16            
jne ciclo4m



imprimir array3, 8, 1, 00fh     
 

jmp endprog


;------------------------ SIN OPCION ------------------------------
nooption:
imprimir textoTres, 2, 1, 0c0h

endprog:
ret
