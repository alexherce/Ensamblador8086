org 100h

.data
ROWSIZE = 5
array db 1, 1, 1, 1
      db 1, 1, 1, 1
      db 1, 1, 1, 1
      db 1, 1, 1, 1
.code
      
mov bx, ROWSIZE
mov si, 2      
mov array[bx + si], 4

mov si, 16

mov ah, 00h
        mov al, 03h
        int 10h
        mov ah, 0eh
        mov bx, 0    
ciclo:
        mov al, array[bx]
        add al, 30h
        int 10h
        inc bx
        cmp si, 0
        dec si
        jnz ciclo 
        
ret