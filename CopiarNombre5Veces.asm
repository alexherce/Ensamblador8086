org 100h
mov [200h], 'A'
mov [201h], 'L'
mov [202h], 'E'
mov [203h], 'X'

mov si, 200h
mov di, 204h
mov cx, 35
rep movsb
ret