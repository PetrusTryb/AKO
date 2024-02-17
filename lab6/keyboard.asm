.386
rozkazy SEGMENT use16
		ASSUME CS:rozkazy

wyswietl_AL PROC
push ax
push cx
push dx

mov cl,10
mov ah,0

div cl

add ah,30h
mov es:[bx+4],ah
mov ah,0
div cl
add ah,30h
mov es:[bx+2],ah
add al,30h
mov es:[bx],al

mov al,00001111b
mov es:[bx+1],al
mov es:[bx+3],al
mov es:[bx+5],al

pop dx
pop cx
pop ax
ret
wyswietl_AL ENDP

obsluga_klawiatury PROC
	push ax
	push bx
	push es
	mov ax, 0B800h
	mov es,ax
	mov bx,0
	in al,60h
	call wyswietl_al
	cmp al,45
	jne obs_dalej
	mov cs:exit, DWORD PTR 1
obs_dalej:
	pop es
	pop bx
	pop ax
	jmp dword PTR cs:wektor9
	wektor9 dd ?
	exit dw 0
obsluga_klawiatury ENDP

zacznij:
mov al,0
mov ah,5
int 10

mov ax,0
mov ds,ax
mov eax,ds:[36]
mov cs:wektor9,eax

mov ax,SEG obsluga_klawiatury
mov bx,OFFSET obsluga_klawiatury
cli
mov ds:[36],bx
mov ds:[38],ax
sti

ptl: 
cmp cs:exit,1
jnz ptl

mov eax,cs:wektor9
cli
mov ds:[36],eax
sti
mov ax,4C00h
int 21h
rozkazy ENDS
nasz_stos SEGMENT stack
	db 128 dup (?)
nasz_stos ENDS
END zacznij