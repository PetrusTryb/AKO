.686
.model flat
extern _ExitProcess@4: PROC
extern __write: PROC
extern __read:PROC
extern _MessageBoxA@16: PROC
extern _MessageBoxW@16: PROC
public _main

.data
tekst_pocz db 10, 'Prosz',0A9H,' napisa',086H,' jaki',098H,' tekst '
db 'i nacisn',0A5H,086H,' Enter', 10
koniec_t db ?
magazyn db 80 dup(?)
magazyn_win1250 db 80 dup(?)
nowa_linia db 10
liczba_znakow dd ?

latin2 db 0A5H,086H,0A9H,088H,0E4H,0A2H,098H,0ABH,0BEH, 0A4H,08FH,0A8H,09DH,0E3H,0E0H,097H,08DH,0BDH
win1250 db 0B9H,0E6H,0EAH,0B3H,0F1H,0F3H,09CH,09FH,0BFH, 0A5H,0C6H,0CAH,0A3H,0D1H,0D3H,08CH,08FH,0AFH

.code
_main PROC

mov ecx, (OFFSET koniec_t - OFFSET tekst_pocz)
push ecx
push OFFSET tekst_pocz
push 1
call __write
add esp,12

push 80
push OFFSET magazyn
push 0
call __read
add esp,12
mov liczba_znakow,eax

mov ecx, liczba_znakow
mov ebx,0

ptl1:	mov dl,magazyn[ebx]

		mov eax,0
polskie1:cmp dl,latin2[eax]
		jne next1
		mov dl,win1250[eax]
		jmp dalej1
next1:	inc eax
		cmp eax, 18
		jne polskie1
dalej1:	mov magazyn_win1250[ebx],dl
		inc ebx
		loop ptl1

push 0
push OFFSET 0
push OFFSET magazyn_win1250
push 0
call _MessageBoxA@16

mov ecx, liczba_znakow
mov ebx,0

ptl:	mov dl,magazyn[ebx]

		mov eax,0
polskie:cmp dl,latin2[eax]
		jne next
		mov dl,latin2[9+eax]
		mov magazyn[ebx],dl
		jmp dalej
next:	inc eax
		cmp eax, 9
		jne polskie

		cmp dl,'a'
		jb dalej
		cmp dl,'z'
		ja dalej
		sub dl,20h
		mov magazyn[ebx],dl
dalej:	inc ebx
		loop ptl

push liczba_znakow
push OFFSET magazyn
push 1
call __write
add esp,12

push 0
call _ExitProcess@4
_main ENDP
END