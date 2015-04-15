RECIBE MACRO LUGAR, TAM
    LOCAL F
    MOV SI, LUGAR
    MOV DI, TAM
F:  MOV [SI], 00H
    MOV AH,00H
    INT 16H
    MOV [SI],AL
    INC SI
    DEC DI
    JNZ F
    
    ENDM RECIBE


JUNTA MACRO LUGAR
    SUB [LUGAR],48
    SUB [LUGAR+1],48    
    MOV DL,[LUGAR]
    MOV AL,0AH
    MUL DL
    MOV DL,AX
    ADD DL,[LUGAR+1]
    MOV [LUGAR],DL 
    
    ENDM JUNTA

RESTA MACRO LUGAR, RES
    ;LOCAL NIEGA,TERMINA
    MOV DI,[LUGAR]
    SUB DI,[LUGAR-4]
    MOV [RES], DI       
    ENDM RESTA
ORG 100H

MAIN:

MOV AH, 00H
MOV AL, 03H
INT 10H



    RECIBE 4000H,02H ; RECIBE DIA
    RECIBE 4002H,02H ; RECIBE MES
    RECIBE 4004H,04H ; RECIBE ANO
    
    JUNTA 4000H
    JUNTA 4002H
    
    MOV BP,[4002H]
    MOV [4001H],BP
    MOV BP,00H
    

    SUB [4004H],48
    MOV DH,00H
    MOV DL,[4004H]
    MOV AX,3E8H
    MUL DX
    MOV DI,AX
    
    SUB [4005H],48
    MOV BH,00H
    MOV BL,[4005H]
    MOV AX,64H        
    MUL BX
    MOV BX,AX
    
    
    JUNTA 4006H
    ADD DI,BX
    MOV DH,00H
    MOV DL,[4006H]
    ADD DI,DX
    MOV [4002H],DI
    
    MOV AH, 2AH
    INT 21H
    
    MOV [4004H],DL 
    MOV [4005H],DH
    MOV [4006H],CX
    
    MOV AX, [4001H]
    MOV DL, 30
    MUL DL
    MOV DH, 00H
    MOV DL, [4000H]
    ADD AX, DX
    MOV DX, 365
    SUB DX, AX
    MOV [4010H],DX
    
    
    MOV AX, [4005H]
    MOV DL, 30
    MUL DL
    MOV DH, 00H
    MOV DL, [4004H]
    ADD AX, DX
    MOV [4011H],AX
    
    MOV AX,[4010H]
    MOV BX,[4011H]
    ADD AX,BX
    MOV [4015H],AL
    
    RESTA 4006H,4012H
    JMP N
    
    RES: MOV AX,[4012H]
         SUB AX,1
         MOV [4012H],AX
         RET
    
N:  CMP AL,16D
    JG RES
    SUB AL,16D
    RET
     
     
    ;RESTA 4004H,4010H
    ;RESTA 4005H,4011H
    ;RESTA 4006H,4012H
    
    ;SOLO SI ES NEGATIVO
    
;DIAS: MOV DH, 30
;      ADD DH, [4010H]
;      MOV [4010H], DH
;    
;MESES: MOV DH, 12
;       ADD DH, [4011H]
;       DEC DH
;       MOV [4011H], DH
       
    
    


END MAIN