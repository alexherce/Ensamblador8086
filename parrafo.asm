;JAVIER CURIEL
;KARINA MARIAUD
;ALEJANDRO HERCE
;RODOLFO OLAGARAY
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

imprimirUno macro texto ren col color
    local ciclo
        mov dl, col
        mov dh, ren
        mov bl, color
        mov ah, 02
        mov bh, 00
        int 10h
        mov ah, 09
        mov al, texto
        add al, 30h
        mov cx, 1
        int 10h
       
imprimirUno endm 


org 100h
jmp main
VA DB 'Numero de As: ', 0
VE DB 'Numero de Es: ', 0
VI DB 'Numero de Is: ', 0
VO DB 'Numero de Os: ', 0
VU DB 'Numero de Us: ', 0
vocales DB 'Numero de vocales: ', 0
consonantes DB 'Numero de consonantes: ', 0
espacios DB 'Numero de espacios: ', 0



main:

mov ah, 00h
mov al, 03h
int 10h

MOV SI, 3000H

TECLADO: mov ah, 00h
       int 16h
       MOV [SI], Al
       INC SI
       CMP AL, 0DH
       JNE TECLADO

MOV DI, 00H
IMP:MOV AH, 0EH
    MOV AL, [SI]
    int 10h
    DEC SI
    CMP SI, 3000H
    JGE IMP 
    
MOV SI, 3000H
MOV [4000H],00H
MOV [4001H],00H
MOV [4002H],00H
MOV [4003H],00H
MOV [4004H],00H
MOV [4005H],00H
MOV [4006H],00H
MOV [4007H], 00H
CICLO:  CMP [SI],'a'
        JE A
        CMP [SI],'e'
        JE E
        CMP [SI],'i'
        JE I
        CMP [SI],'o'
        JE O 
        CMP [SI],'u'
        JE U
        CMP [SI], 032
        JE SPC    
        INC [4006H]
CONTINUAR: INC SI 
           CMP [SI], 0DH
           JNE CICLO
           jmp end

    
 
A: INC [4005H]
   INC [4000H]
   JMP CONTINUAR
E: INC [4005H]
   INC [4001H]
   JMP CONTINUAR
I: INC [4005H] 
   INC [4002H]
   JMP CONTINUAR
O: INC [4005H]
   INC [4003H]
   JMP CONTINUAR
U: INC [4005H]
   INC [4004H]
   JMP CONTINUAR
SPC: INC [4007H]
    JMP CONTINUAR   

       
end:
IMPRIMIR VA, 5, 1, 00FH
IMPRIMIRUNO [4000H], 5, 16, 00FH
IMPRIMIR VE, 6, 1, 00FH
IMPRIMIRUNO [4001H], 6, 16, 00FH
IMPRIMIR VI, 7, 1, 00FH
IMPRIMIRUNO [4002H], 7, 16, 00FH
IMPRIMIR VO, 8, 1, 00FH
IMPRIMIRUNO [4003H], 8, 16, 00FH
IMPRIMIR VU, 9, 1, 00FH
IMPRIMIRUNO [4004H], 9, 16, 00FH
IMPRIMIR VOCALES, 10, 1, 00FH
IMPRIMIRUNO [4005H], 10, 21, 00FH
IMPRIMIR CONSONANTES, 11, 1, 00FH
IMPRIMIRUNO [4006H], 11, 26, 00FH
IMPRIMIR ESPACIOS, 12, 1, 00FH
IMPRIMIRUNO [4007H], 12, 21, 00FH

ret