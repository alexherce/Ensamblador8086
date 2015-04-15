cr EQU 13
lf EQU 10


 print macro arg1
	push ax
	push dx
	lea dx,arg1
	mov ah,9
	int 21h
	pop dx
	pop ax
 endm
 
 
 read macro arg1
	push ax
	push dx
	lea dx,arg1
	mov ah,10
	int 21h
	pop dx
	pop ax
 endm

;Empieza SEGMENTO dades
dades SEGMENT PARA PUBLIC
	missatge DB 'Ingresa el texto que quieres invertir:',cr,lf,'$'
	maxcad DB 30
	lencad DB 0
	cadena DB 30 DUP(0)
	girat DB 30 DUP(0)
	linia_blanc DB cr,lf,'$'
	
	
	missatge2 DB 'Salir? Si=s, No=n. Seguido de ENTER',cr,lf,'$'
	maxcad2 DB 2                    ;longitud maxima
	lencad2 DB 0                    ;longitud leida
	cadena2 DB 2 DUP(0)             ;buffer que contendra el texto introducido

dades ENDS  ;Empieza SEGMENTO dades




;empieza SEGMENTO codi 
codi SEGMENT PARA PUBLIC 'code'



;empieza PROCEDIMIENTO main
main PROC FAR

ASSUME CS:codi,DS:dades,SS:pila,ES:dades ;segmentos
mov ax,dades
mov ds,ax
mov es,ax



inicio:
	print missatge			;pide que se introduzca un mensaje y lo guarda en maxcad
	read maxcad
	print linia_blanc		;imprime lina en blanco
	mov bx,0			    ;pone el registro bx a 0
	



pushpila:
	mov al, cadena[bx]	;movemos la cadena introducida a al
	push ax
	inc bl
	cmp bl, lencad		;hacemos la comparacion para que el proceso se repita mientras bl no sea 0
	jne pushpila		
	
	mov bx, 0




poppila:
	pop ax
	mov girat[bx], al	;extraemos la cadena del registro ax
	inc bl			;incrementamos el registro bl para comparar con lencad
	cmp bl,lencad
	jne poppila		;si el registro bl no es = que el valor de lencad repetimos el proceso

	mov girat[bx], '$' 
	print girat
	print linia_blanc

	print missatge2
	read maxcad2
	print linia_blanc

	cmp cadena2[0],'s'
	je salir
	cmp cadena2[0],'S'
	je salir
	jmp inicio

salir:
	mov ax,4c00h
	int 21h
	
	
	
main ENDP   ;end PROCEDIMIENTO main
codi ENDS   ;end SEGMENTO codi 

 
 
 
;Ciclo3:
pila SEGMENT PARA STACK 'stack'
DB 128 DUP(0)
pila ENDS ;end Ciclo3 



END main