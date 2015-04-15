;KARINA MARIAUD
;ALEJANDRO HERCE
;RODOLFO OLAGARAY
;JAVIER CURIEL

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

org 100h 

jmp inicio
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

inicio:
int 10h

mov ah, 00h
mov al, 03h
int 10h
mov [2005h], 0

start:
mov ah, 02ch
int 21h

mov ah, 0
mov al, ch
mov bl, 10
div bl
mov [3000h], al
mov [3001h], ah
mov ah, 0

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

mov di, 3000h
mov [2000h], 1
mov [2001h], 1
mov [2002h], 0
mov [2003h], 0
mov [2004h], 0e0h

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

cmp [2005h], 1
jz end

espacio: add [2000h], 4
mov [2003h], 0
jmp comp3
  
impr0: 
imprimir  cero, [2001h], [2000h], [2004h]
jmp comp2
impr1: 
imprimir  uno, [2001h], [2000h], [2004h]
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
mov cx, 98h
mov dx, 9680h
mov ah, 86h
int 15h
jmp start
ret