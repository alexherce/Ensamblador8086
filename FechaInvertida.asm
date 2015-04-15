org 100h
           
MOV SI, 200h
           
;------- GET FECHA -------           
MOV AH, 2ah
INT 21h
             
                                
PUSH CX
MOV CX, 0   ;Anio al stack
 
MOV CL, DH
PUSH CX     ;Mes al stack 

MOV CL, DL
PUSH CX     ;Dia al stack

mov cx, 0000

;------- GET HORA ------- 

MOV AH, 2ch
INT 21h

MOV AX, 0

MOV AL, CL
PUSH AX     ;Minutos al stack
MOV AX, 0

MOV AL, CH
PUSH AX     ;Hora al stack



MOV [SI], 0 ;Sirve para comparar donde
            ;acaba en el ciclo del final
INC SI  


;SEPARAR NUMEROS Y GUARDAR EN MEMORIA
;------- HORAS ------- 

 
        MOV DX, 0
        POP AX 
        MOV CX, 0
        MOV BX, 10
 
divhoras:                         
 
        DIV BX
        PUSH DX
 
        ADD CX, 1
        MOV DX, 0
        CMP AX, 0
        JNE divhoras
 
divhoras2:
 
        POP DX 
            
        ADD DL, 30h 
        MOV [SI], DL
        INC SI  
 
        LOOP divhoras2

 
        MOV DL, ':' 
        MOV [SI], DL
        INC SI 
        
;------- MINUTOS ------- 
        MOV DX, 0
        POP AX 
 
 
        MOV CX, 0
        MOV BX, 10
 
divmin:                         
 
        DIV BX
        PUSH DX
 
        ADD CX, 1
        MOV DX, 0 
        CMP AX, 0
        JNE divmin
 
divmin2:
 
        POP DX
            
        ADD DL, 30h
        MOV [SI], DL
        INC SI
 
        LOOP divmin2
 
        MOV DL, ' '
        MOV [SI], DL
        INC SI
        
        
;------- DIA -------

        MOV DX, 0
        POP AX
        MOV CX, 0
        MOV BX, 10
 
divdia:                         
 
        DIV BX
        PUSH DX
 
        ADD CX, 1
        MOV DX, 0
        CMP AX, 0
        JNE divdia
 
divdia2:
 
        POP DX   
        ADD DL, 30h
        MOV [SI], DL
        INC SI
        LOOP divdia2
        MOV DL, '/'
        MOV [SI], DL
        INC SI  
        
;------- MES ------- 
        MOV DX, 0
        POP AX
        MOV CX, 0
        MOV BX, 10
 
divmes:                         
 
        DIV BX
        PUSH DX
 
        ADD CX, 1
        MOV DX, 0
        CMP AX, 0
        JNE divmes
 
divmes2:
 
        POP DX
            
        ADD DL, 30h
        MOV [SI], DL
        INC SI
 
        LOOP divmes2
 
        MOV DL, '/'
        MOV [SI], DL
        INC SI
         
 
;------- ANIO -------
 
        MOV DX, 0
        POP AX
 
 
        MOV CX, 0
        MOV BX, 10
 
divanio:                         
 
        DIV BX
        PUSH DX
 
        ADD CX, 1
        MOV DX, 0
        CMP AX, 0
        JNE divanio
 
divanio2:
 
        POP DX
            
        ADD DL, 30h  
        MOV [SI], DL
        INC SI
 
        LOOP divanio2
 
        MOV al, ' '
        mov [si], al
        inc si
        
        
;IMPRIMIR FECHA Y HORA AL REVES    
 
MOV AH, 00h
MOV AL, 03h
INT 10h
MOV AH, 0eh 
   
ciclo:
        MOV AL, [SI]
        INT 10h
        DEC SI
        CMP [SI], 0
        JNZ ciclo 
        
RET
