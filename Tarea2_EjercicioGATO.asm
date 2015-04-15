ORG 100H 
JMP INICIO 

; Vectores de datos 

MSG1 DB '   |   |   |                            ',0 
MSG2 DB '---------------                         ',8
 
    



INICIO: ;MOV CX, 23 ;El counter del LOOP va en INICIO, sino se hace infinito

        MOV AH, 00H ; comando inicializacion de pantalla (de la INT 10H)
        MOV AL, 00H ; comando que da el tamano de la pantalla (40X25) 25 alto
        INT 10H ;ejecuta video
        ;comando de INT 10H del CICLO:
        MOV AH, 0EH ; comando ASCII sin atributos 
        MOV SI, 0  ;En los apuntes SI es BX

;MSG1 (3 RAYITAS)        
CICLO1:  MOV AL, MSG1 [SI]; comando que escibe un ASCII, de la INT 10H
        INT 10H 
        INC SI
        CMP MSG1 [SI], 0 
        JNZ CICLO1   
MOV SI,0; limpio mi vector para que empice en 0  



;MSG1        
CICLO2:  MOV AL, MSG1 [SI]; comando que escibe un ASCII, de la INT 10H
        INT 10H 
        INC SI
        CMP MSG1 [SI], 0 
        JNZ CICLO2   
MOV SI,0; limpio mi vector para que empice en 0  



;MSG1        
CICLO3:  MOV AL, MSG1 [SI]; comando que escibe un ASCII, de la INT 10H
        INT 10H 
        INC SI
        CMP MSG1 [SI], 0 
        JNZ CICLO3   
MOV SI,0; limpio mi vector para que empice en 0  

;----------------------------------------------------------------------


;MSG2 (LINEA COMPLETA)
CICLO4:  MOV AL, MSG2 [SI]; comando que escibe un ASCII, de la INT 10H
        INT 10H 
        INC SI
        CMP MSG2 [SI], 8 
        JNZ CICLO4
        
        ;MOV CX, 5  (esto va en INICIO, para que no se haga infinito)
        MOV SI, 0
  
        ;LOOP CICLO2   
MOV SI,0; limpio mi vector para que empice en 0


;-------------------------------------------------------------

;MSG1 (3 RAYITAS)        
CICLO5:  MOV AL, MSG1 [SI]; comando que escibe un ASCII, de la INT 10H
        INT 10H 
        INC SI
        CMP MSG1 [SI], 0 
        JNZ CICLO5   
MOV SI,0; limpio mi vector para que empice en 0  



;MSG1        
CICLO6:  MOV AL, MSG1 [SI]; comando que escibe un ASCII, de la INT 10H
        INT 10H 
        INC SI
        CMP MSG1 [SI], 0 
        JNZ CICLO6   
MOV SI,0; limpio mi vector para que empice en 0  



;MSG1        
CICLO7:  MOV AL, MSG1 [SI]; comando que escibe un ASCII, de la INT 10H
        INT 10H 
        INC SI
        CMP MSG1 [SI], 0 
        JNZ CICLO7   
MOV SI,0; limpio mi vector para que empice en 0  

;--------------------------------------------------------------------

;MSG2 (LINEA COMPLETA)
CICLO8:  MOV AL, MSG2 [SI]; comando que escibe un ASCII, de la INT 10H
        INT 10H 
        INC SI
        CMP MSG2 [SI], 8 
        JNZ CICLO8
        
        ;MOV CX, 5  (esto va en INICIO, para que no se haga infinito)
        MOV SI, 0
  
        ;LOOP CICLO2   
MOV SI,0; limpio mi vector para que empice en 0



; -------------------------------------------------------------------


;MSG1 (3 RAYITAS)        
CICLO9:  MOV AL, MSG1 [SI]; comando que escibe un ASCII, de la INT 10H
        INT 10H 
        INC SI
        CMP MSG1 [SI], 0 
        JNZ CICLO9   
MOV SI,0; limpio mi vector para que empice en 0  



;MSG1        
CICLO10:  MOV AL, MSG1 [SI]; comando que escibe un ASCII, de la INT 10H
        INT 10H 
        INC SI
        CMP MSG1 [SI], 0 
        JNZ CICLO10   
MOV SI,0; limpio mi vector para que empice en 0  



;MSG1        
CICLO11:  MOV AL, MSG1 [SI]; comando que escibe un ASCII, de la INT 10H
        INT 10H 
        INC SI
        CMP MSG1 [SI], 0 
        JNZ CICLO11   
MOV SI,0; limpio mi vector para que empice en 0  





RET
 