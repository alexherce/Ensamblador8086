org 100h
mov al, 18
mov bl, 25
mul bl
mov di, ax
mov dx, 00
mov ax, 18

ciclo:
mov cl, bl
mov ch, 00
ab:
add dx, ax
loop ab



ret