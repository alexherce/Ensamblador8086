;Karina Mariaud
;Alejandro Herce
;Rodolfo Olagaray
;Javier Curiel
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

   
jmp main   

textoUno db 'Selecciona la opcion deseada:', 0
textoDos db '1.- Cronometro 2.- Temporizador 3.- Salir:', 0
textoTres db 'No seleccionaste una opcion valida. Terminando programa.', 0
textoCuatro db 'Cronometro corriendo... Presione enter para pausar.           ', 0
textoCinco db 'Ingrese el tiempo en el siguiente formato: HHMMSS', 0
textoSeis db 'Cronometro pausado, presiona R para continuar o S para salir.', 0
integrantes db 'Karina Mariaud, Alejandro Herce, Rodolfo Olagaray, Javier Curiel, Alan Bleier.', 0
dosPuntos db ':', 0
cero db   '0',0
uno db    '1',0
dos db    '2',0
tres db   '3',0
cuatro db '4',0
cinco db  '5',0
seis db   '6',0
siete db  '7',0
ocho db   '8',0
nueve db  '9',0  


main: 
     
int 10h

mov ah, 00h
mov al, 03h
int 10h     
     
imprimir integrantes, 24, 1, 00eh

;----------------------- MENU DE OPCIONES ------------------------
imprimir textoUno, 1, 1, 00fh
imprimir textoDos, 2, 1, 00fh   

obtenerDato 1, 200h

cmp [200h], 1
je cronometro

cmp [200h], 2
je temporizador

cmp [200h], 3
je endprog
jmp nooption

;------------------------ CRONOMETRO ------------------------------
cronometro:

    jmp cronometroDos
         
    pausaCron:
    
    imprimir textoSeis, 5, 1, 00fh
         
    obtenerTexto 1, 3015h
    
    cmp [3015h], 's'
    je endprog
    
    cmp [3015h], 'r'
    je reanudarTexto
    jmp pausaCron
    
    reanudarTexto:
    
    imprimir textoCuatro, 5, 1, 00fh
    jmp no_pressedCron     
    
    cronometroDos:

    imprimir textoCuatro, 5, 1, 00fh
    
    ; "Settings"
     
    mov [2000h], 5 ;Columna donde imprimir
    mov [2001h], 8 ;Renglon donde imprimir
    mov [2002h], 0
    mov [2003h], 0
    mov [2004h], 00fh ;Color
    mov [3000h], 0
    mov [3001h], 0
    mov [3002h], 0
    mov [3003h], 0
    mov [3004h], 0
    mov [3005h], 0
    
    startCron:
    cmp [3005h], 9
    je segundos1
    
    inc [3005h]
    jmp continuarCron
    
    segundos1:
        mov [3005h], 0
        cmp [3004h], 5
        je minutos2
        
        inc [3004h]
        jmp continuarCron
        
    minutos2:
        mov [3004h], 0
        cmp [3003h], 5
        je minutos1
        
        inc [3003h]
        jmp continuarCron
    
    minutos1:
        mov [3003h], 0
        cmp [3002h], 9
        je horas2
        
        inc [3002h]
        jmp continuarCron
        
    horas2:
        mov [3002h], 0
        cmp [3001h], 5
        je horas1
        
        inc [3001h]
        jmp continuarCron
        
    horas1:
        mov [3001h], 0
        cmp [3000h], 9
        je continuarCron
        
        inc [3000h]
        jmp continuarCron
        
    continuarCron: 
    ; "Settings" 
    mov di, 3000h
    mov [2000h], 5 ;Columna donde imprimir
    mov [2001h], 8 ;Renglon donde imprimir
    mov [2002h], 0
    mov [2003h], 0
    mov [2004h], 00fh ;Color
    
    comparacionCron:
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
    
    comp2Cron: inc di
    inc [2002h]
    inc [2003h]
    add [2000h], 1
    cmp [2003h], 2
    jz espacioCron
    
    comp3Cron: 
    cmp [2002h], 6
    jnz comparacionCron
    jz endCron
    
    
    espacioCron:
    cmp [2002h], 6
    jz endCron
    imprimir dosPuntos, [2001h], [2000h], [2004h] 
    add [2000h], 1
    mov [2003h], 0
    jmp comp3Cron    
    
    impr0: imprimir  cero, [2001h], [2000h], [2004h]
    jmp comp2Cron
    impr1: imprimir  uno, [2001h], [2000h], [2004h]
    jmp comp2Cron
    impr2: imprimir  dos, [2001h], [2000h], [2004h]
    jmp comp2Cron
    impr3: imprimir  tres, [2001h], [2000h], [2004h]
    jmp comp2Cron
    impr4: imprimir  cuatro, [2001h], [2000h], [2004h]
    jmp comp2Cron
    impr5: imprimir  cinco, [2001h], [2000h], [2004h]
    jmp comp2Cron
    impr6: imprimir  seis, [2001h], [2000h], [2004h]
    jmp comp2Cron
    impr7: imprimir  siete, [2001h], [2000h], [2004h]
    jmp comp2Cron
    impr8: imprimir  ocho, [2001h], [2000h], [2004h]
    jmp comp2Cron
    impr9: imprimir  nueve, [2001h], [2000h], [2004h]
    jmp comp2Cron 
    
    endCron:
    
    mov ah, 01h ;Revisa si se presiono alguna tecla
    int 16h
    jz no_pressedCron ;Cero = no hay teclas presionadas
    
    mov ah, 00h ;Obtener tecla presionada
    int 16h
    
    cmp al, 0dh ;Enter = 0dh
    je pausaCron
    
    no_pressedCron:
    
    ;Delay de un segundo
    ;MOV CX, 0FH
    ;MOV DX, 4240H
    ;MOV AH, 86H
    ;INT 15H
    
    jmp startCron


jmp endprog

;----------------------- TEMPORIZADOR ------------------------------
temporizador:

    imprimir textoCinco, 5, 1, 00fh
    
    obtenerDato 6, 3000h

    ; "Settings"
     
    mov [2000h], 5 ;Columna donde imprimir
    mov [2001h], 8 ;Renglon donde imprimir
    mov [2002h], 0
    mov [2003h], 0
    mov [2004h], 00fh ;Color
    
    jmp continuarTemp
    
    
    startTemp:
    
    cmp [3005h], 0
    je checar
    
    dec [3005h]
    jmp continuarTemp
    
    segundos1Temp:
        mov [3005h], 9
        cmp [3004h], 0
        je minutos2Temp
        
        dec [3004h]
        jmp continuarTemp
        
    minutos2Temp:
        mov [3004h], 5
        cmp [3003h], 0
        je minutos1Temp
        
        dec [3003h]
        jmp continuarTemp
    
    minutos1Temp:
        mov [3003h], 9
        cmp [3002h], 0
        je horas2Temp
        
        dec [3002h]
        jmp continuarTemp
        
    horas2Temp:
        mov [3002h], 5
        cmp [3001h], 0
        je horas1Temp
        
        dec [3001h]
        jmp continuarTemp
        
    horas1Temp:
        mov [3001h], 9
        check:
        cmp [3000h], 0
        je continuarTemp
        
        dec [3000h]
        jmp continuarTemp
        
    ;Revisa si todos los numeros son cero, si son cero,
    ;termina el contador, si no, regresa a segundos1:
    checar:
        cmp [3001h], 0
        je cond2
        jmp segundos1Temp
    cond2:
        cmp [3002h], 0
        je cond3
        jmp segundos1Temp
    cond3:
        cmp [3003h], 0
        je cond4
        jmp segundos1Temp
    cond4:
       cmp [3004h], 0
        je cond5
        jmp segundos1Temp
    cond5:
        cmp [3005h], 0
        je endprog
        jmp segundos1Temp
        
    continuarTemp: 
    ; "Settings" 
    mov di, 3000h
    mov [2000h], 5 ;Columna donde imprimir
    mov [2001h], 8 ;Renglon donde imprimir
    mov [2002h], 0
    mov [2003h], 0
    mov [2004h], 00fh ;Color
    
    comparacionTemp:
    cmp [di], 0
    jz impr0Temp
    cmp [di], 1
    jz impr1Temp
    cmp [di], 2
    jz impr2Temp
    cmp [di], 3
    jz impr3Temp
    cmp [di], 4
    jz impr4Temp
    cmp [di], 5
    jz impr5Temp
    cmp [di], 6
    jz impr6Temp
    cmp [di], 7
    jz impr7Temp
    cmp [di], 8
    jz impr8Temp
    cmp [di], 9
    jz impr9Temp
    
    comp2Temp: inc di
    inc [2002h]
    inc [2003h]
    add [2000h], 1
    cmp [2003h], 2
    jz espacioTemp
    
    comp3Temp: 
    cmp [2002h], 6
    jnz comparacionTemp
    jz endTemp
    
    
    espacioTemp:
    cmp [2002h], 6
    jz endTemp
    imprimir dosPuntos, [2001h], [2000h], [2004h] 
    add [2000h], 1
    mov [2003h], 0
    jmp comp3Temp    
    
    impr0Temp: imprimir  cero, [2001h], [2000h], [2004h]
    jmp comp2Temp
    impr1Temp: imprimir  uno, [2001h], [2000h], [2004h]
    jmp comp2Temp
    impr2Temp: imprimir  dos, [2001h], [2000h], [2004h]
    jmp comp2Temp
    impr3Temp: imprimir  tres, [2001h], [2000h], [2004h]
    jmp comp2Temp
    impr4Temp: imprimir  cuatro, [2001h], [2000h], [2004h]
    jmp comp2Temp
    impr5Temp: imprimir  cinco, [2001h], [2000h], [2004h]
    jmp comp2Temp
    impr6Temp: imprimir  seis, [2001h], [2000h], [2004h]
    jmp comp2Temp
    impr7Temp: imprimir  siete, [2001h], [2000h], [2004h]
    jmp comp2Temp
    impr8Temp: imprimir  ocho, [2001h], [2000h], [2004h]
    jmp comp2Temp
    impr9Temp: imprimir  nueve, [2001h], [2000h], [2004h]
    jmp comp2Temp 
    
    endTemp:
    
    ;Delay de un segundo
    ;MOV CX, 0FH
    ;MOV DX, 4240H
    ;MOV AH, 86H
    ;INT 15H
    
    jmp startTemp


jmp endprog

;------------------------ SIN OPCION ------------------------------
nooption:
imprimir textoTres, 2, 1, 0c0h

endprog:
ret