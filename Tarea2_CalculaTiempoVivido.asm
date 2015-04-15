macro conv x, y
    
    sub x, 30h
    sub y, 30h
    mov al, x
    mov ah, 00
    mov bl, 0ah
    mul bl
    add al, y
    mov x, al
    
endm conv 




macro convAscii r, loc1, loc2 ;loc1 es la localidad para las decenas 
                              ;loc2 para las unidades ya conv a ascii
    mov al, r
    mov ah, 00
    mov bl, 0ah
    div bl
    mov [loc2], ah
    mov [loc1], al
    add [loc2], 30h
    add [loc1], 30h
    
    
    endm convascii



macro convierteAno mil, cien, diez, uno 
    ;los parametros son localidades [100h], etc.
    ;las localidades que le pases tienen un caracter ascii
    mov al, mil  
    sub al, 30h  
    mov bx, 03e8h
    mul bx
    mov cx, ax
      
    mov ax, 00h
    mov al, cien
    sub al, 30h 
    mov bx, 00h
    mov bx, 64h
    mul bx  
    add cx, ax 
    
    mov ax, 00h
    mov al, diez
    sub al, 30h
    mov bx, 00h
    mov bx, 0ah
    mul bx  
    add cx, ax  
    
    mov ax, 00h
    mov al, uno
    sub al, 30h 
    mov bx, 1h
    mul bx
    add cx, ax  
    mov bx, cx
    mov cx, 00h  
    
    ;---convertir ano a anos que han pasado---  
    mov ah, 2ah
    int 21h   
    sub cx, bx 
    ;anos que han pasado estan en cx
    mov ax, 00h
    mov bx, 00h
    mov al, cl    
    mov bl, 0ah
    div bl  
    
    mov bx, 00h
    mov bh, al
    mov bl, ah 
    
    add bh, 30h
    add bl, 30h
    
    mov [750h], bx
    mov bx, 00h
    ;en [351h] esta el primer caracter de los anos pasados
    ;en [350] esta el segundo caracter de los anos pasados  
endm convierteAno 

macro moverrenglon ren, col   
mov al,00h    
mov ah, 02h
mov bh, 00h 
mov dh, ren
mov dl, col
int 10h
 
endm   moverrenglon

macro imprime etiqueta  
    
local salto
mov ax, 0h
mov ah, 0eh 
mov si, 00h

salto:  mov ah, 0eh
        mov al, etiqueta[si]
       int 10h
       inc si
       cmp al, 0
       jne salto
         
        
endm  imprime


org 100h   

jmp inicio

dia db 'Inserte el dia de nacimiento (DD): ',0
mes db 'Inserte el mes de nacimiento:(MM) ',0
ano db 'Inserte el anio de nacimiento: (AA)',0  
res db 'Han pasado: ',0
rano db ' anios, ',0
rmes db ' meses y ',0
rdia db ' dias.',0 

 


inicio: 

mov al, 00h
mov ah, 00h 
int 10h 
 
mov di, 800h 

imprime dia 

moverrenglon 1h, 0h 
 

mov cx, 2h ;para el ciclo
 
obtenerdia: 
call obtenertecla
mov [di], al 
inc di
loop obtenerdia  


moverrenglon 2h, 0h 

imprime mes 

moverrenglon 3h, 0h 
 

mov cx, 2h  ;para el ciclo
 
obtenermes: 
call obtenertecla
mov [di], al 
inc di
loop obtenermes  

moverrenglon 4h, 0h 


imprime ano  

moverrenglon 5h, 0h 
 
mov cx, 4h ;para el ciclo

obtenerano: 
call obtenertecla
mov [di], al
inc di   
loop obtenerano


convierteAno [804h], [805h], [806h], [807h] ;guarda años que han pasado en ascii
conv [751h], [750h]  ;convierte los años a numero y lo guarda en 351H


 ;mes______________________________________  
 
mov ah, 2ah
int 21h

conv [802h],[803h] ;convierte los meses del usuario

sub dh, [802h]

js calcularmesneg 

mov [752h],dh

jmp calculardia

calcularmesneg: 
sub [751h], 1h
mov ah, 12 
mov cl,00h
sub cl, dh
sub ah, cl
mov [752h], ah  
jmp calculardia
 
 ;dia___________________________________

calculardia:
mov ah, 2ah
int 21h

conv [800h],[801h]

sub dl, [800h]

js calculardianeg 

convascii dl, [754h],[755h]

jmp imprimeresultado

calculardianeg:

sub [752h], 1h
mov ah, 30 
mov cl,00h
sub cl, dl
sub ah, cl
convascii ah, [754h],[755h]            
 jmp imprimeresultado




imprimeresultado:

convascii [751h] ,[750h], [751h] 

convascii [752h], [752h], [753h] 


 
 moverrenglon 7, 0 
 imprime res
 moverrenglon 8,0
 
  
 mov ah, 0eh
 mov al, [750h]
  int 10h
 mov ah, 0eh
 mov al, [751h] 
 int 10h 
 
 imprime rano
 
 
 
 mov ah, 0eh
 mov al, [752h]
  int 10h
 mov ah, 0eh
 mov al, [753h] 
 int 10h  
 
 imprime rmes
 
  
  mov ah, 0eh
 mov al, [754h]
  int 10h
 mov ah, 0eh
 mov al, [755h] 
 int 10h 
  
  imprime rdia
  
  moverrenglon 0ah,0 
  

jmp fin


fin:
ret


;PROCEDIMIENTO PARA OBTENER TECLA         
proc obtenerTecla ;REGRESA EN AL LA TECLA
    CICLO: 
    MOV AH,00H
    INT 16H ;OBTENER LA TECLA 
    MOV AH,0Eh
    INT 10h ;IMPRIMIR CARACTER EN PANTALLA  
    RET
obtenerTecla endp
