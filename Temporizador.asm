;Karina Mariaud
;Alejandro Herce
;Javier Curiel
;Rodolfo Olagaray
;Alan Bleier

imprimir macro num, ren, col, color
    local salto, regreso, enter, final, continuar, fondonegro
   
    mov dl, col
    mov dh, ren
   
    mov ah, 02h
    int 10h
    mov cx, 1
   
    mov bh, 0
 
    mov ah, 09h
    mov si, 00
            
    salto:
    mov al, num[si]
    cmp al, ' '
    jz fondonegro
    mov bl, color
    jmp continuar
    
    fondonegro:
    mov bl, 0
    
    continuar:
    int 10h
    inc dl
    mov ah, 02h
    int 10h
    inc si
    mov al, si
    mov bl, 5
    div bl
    cmp ah, 0
    jz enter
       
    regreso: mov al, cero[si]
    mov ah, 09h 
    cmp al, 0
    jnz salto
    jmp final
           
    enter:
    inc dh
    mov dl, col
    mov ah, 02h
    int 10h
    jmp regreso
        
    final:
imprimir  endm 

imprimirTexto macro texto col ren color
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
       
imprimirTexto endm
 
 

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


obtenerTexto macro var mem
    local entrada, ab
    mov di, mem
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
        
obtenerTexto endm

org 100h 

jmp inicio
;------------- NO MOVER/EDITAR/TOCAR -----------------
cero db   '000000   00   00   000000',0
uno db    '  1   11    1    1  11111',0
dos db    '22222    2222222    22222',0
tres db   '33333    3  333    333333',0
cuatro db '4   44   444444    4    4',0
cinco db  '555555    55555    555555',0
seis db   '666666    666666   666666',0
siete db  '77777    7    7    7    7',0
ocho db   '888888   8888888   888888',0
nueve db  '999999   999999    9    9',0
punto db  '       o         o       ',0
;----------------------------------------------------

textoUno db 'Ingresa el tiempo en el siguiente formato: HHMMSS', 0
textoDos db 'Ingresa el numero de minutos', 0
textoTres db 'LA CUENTA HA TERMINADO! GRACIAS.', 0
textoCuatro db 'Temporizador corriendo...', 0
textoCinco db 'Ingrese la contrasena de 10 caracteres:', 0
textoSeis db 'Contrasena incorrecta. Terminando programa.', 0
password db 'KMAHJCROAB'


inicio:
int 10h

mov ah, 00h
mov al, 03h
int 10h
mov [2005h], 0

;------------ OBTENER TIEMPO Y CONTRASENA ------------

imprimirTexto textoUno, 5, 1, 00fh 

obtenerDato 6, 3000h 
;El tiempo se guarda de 3000h a 3005h, NO MOVER.
;El solo se puede usar 6 para establecer el tiempo:
;2 numeros para la hora, 2 para los minutos y 2 para
;los segundos.

imprimirTexto textoCinco, 5, 3, 00fh

obtenerTexto 10, 4000h
;Obtener la contrasena. Tiene 10 caracteres.
;Contrasena: KMAHJCROAB


;-------------- VERIFICAR CONTRASENA -----------------
jmp continuarProg

passwordWrong:
imprimirTexto textoSeis, 5, 15, 0e0h
jmp passwordFail
 
continuarProg:

mov si, 4000h
mov di, 0
mov cx, 9

cicloPass:
mov ax, password[di]
cmp [si], ax
jne passwordWrong
inc si
inc di
loop cicloPass

;----------------- EMPIEZA CONTADOR ------------------
; "Settings"
 
mov di, 3000h
mov [2000h], 5 ;Columna donde imprimir
mov [2001h], 8 ;Renglon donde imprimir
mov [2002h], 0
mov [2003h], 0
mov [2004h], 0c0h ;Color
imprimirTexto textoCuatro, 5, 15, 0e0h

jmp comparacion 


 
;------------- RESTAR TIEMPOS Y CHECAR ---------------
;Comparar hh:mm:s<S>
start:
cmp [3005h], 0
je checar

dec [3005h]
jmp continuar

segundos1:
    mov [3005h], 9
    cmp [3004h], 0
    je minutos2
    
    dec [3004h]
    jmp continuar
    
minutos2:
    mov [3004h], 5
    cmp [3003h], 0
    je minutos1
    
    dec [3003h]
    jmp continuar

minutos1:
    mov [3003h], 9
    cmp [3002h], 0
    je horas2
    
    dec [3002h]
    jmp continuar
    
horas2:
    mov [3002h], 5
    cmp [3001h], 0
    je horas1
    
    dec [3001h]
    jmp continuar
    
horas1:
    mov [3001h], 9
    check:
    cmp [3000h], 0
    je continuar
    
    dec [3000h]
    jmp continuar
    
;Revisa si todos los numeros son cero, si son cero,
;termina el contador, si no, regresa a segundos1:
checar:
        cmp [3001h], 0
        je cond2
        jmp segundos1
    cond2:
        cmp [3002h], 0
        je cond3
        jmp segundos1
    cond3:
        cmp [3003h], 0
        je cond4
        jmp segundos1
    cond4:
       cmp [3004h], 0
        je cond5
        jmp segundos1
    cond5:
        cmp [3005h], 0
        je endprog
        jmp segundos1


continuar: 
; "Settings" 
mov di, 3000h
mov [2000h], 5 ;Columna donde imprimir
mov [2001h], 8 ;Renglon donde imprimir
mov [2002h], 0
mov [2003h], 0
mov [2004h], 0c0h ;Color
 
 
;------- COMPARA NUMEROS GUARDADOS EN MEMORIA --------
;------- Y LLAMA A LA FUNCION PARA IMPRIMIRLO --------
 
comparacion:
cmp [di], 0
jz impr0
cmp [di], 1
jz impr1
cmp [di], 2
jz impr2
cmp [di], 3
jz impr3
cmp [di], 4
jz impr4
cmp [di], 5
jz impr5
cmp [di], 6
jz impr6
cmp [di], 7
jz impr7
cmp [di], 8
jz impr8
cmp [di], 9
jz impr9

comp2: inc di
inc [2002h]
inc [2003h]
add [2000h], 6
cmp [2003h], 2
jz espacio

comp3: cmp [2002h], 6
jnz comparacion
jz end


espacio:
cmp [2002h], 6
jz end
imprimir punto, [2001h], [2000h], [2004h] 
add [2000h], 6
mov [2003h], 0
jmp comp3




;-------- FUNCIONES PARA IMPRIMIR NUMEROS ------------
; imprimir [numero], [renglon], [columna], [color]

  
impr0: imprimir  cero, [2001h], [2000h], [2004h]
jmp comp2
impr1: imprimir  uno, [2001h], [2000h], [2004h]
jmp comp2
impr2: imprimir  dos, [2001h], [2000h], [2004h]
jmp comp2
impr3: imprimir  tres, [2001h], [2000h], [2004h]
jmp comp2
impr4: imprimir  cuatro, [2001h], [2000h], [2004h]
jmp comp2
impr5: imprimir  cinco, [2001h], [2000h], [2004h]
jmp comp2
impr6: imprimir  seis, [2001h], [2000h], [2004h]
jmp comp2
impr7: imprimir  siete, [2001h], [2000h], [2004h]
jmp comp2
impr8: imprimir  ocho, [2001h], [2000h], [2004h]
jmp comp2
impr9: imprimir  nueve, [2001h], [2000h], [2004h]
jmp comp2 

end:
jmp start

;--------- TERMINA EL CONTADOR Y EL PROGRAMA ----------
endprog:
imprimirTexto textoTres, 5, 15, 0e0h

passwordFail:
;Sonido beep
mov dl, 07h
mov ah, 2
int 21h
 
;Delay de 1 segundo 
MOV CX, 0FH
MOV DX, 4240H
MOV AH, 86H
INT 15H

;Sonido beep
mov dl, 07h
mov ah, 2
int 21h 
 
;Delay de 1 segundo 
MOV CX, 0FH
MOV DX, 4240H
MOV AH, 86H
INT 15H

;Sonido beep
mov dl, 07h
mov ah, 2
int 21h
 
ret