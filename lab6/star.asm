.386
rozkazy SEGMENT use16
		ASSUME CS:rozkazy

obsluga_zegara PROC
	push ax
	push bx
	push es
	mov ax, 0B800h
	mov es,ax
	mov bx,cs:licznik
	sub cs:timer,DWORD PTR 1
	jnz wysw_dalej
	mov cs:timer,DWORD PTR 1

	mov BYTE PTR es:[bx],'*'
	mov BYTE PTR es:[bx+1],00011110b

	add bx,160
	cmp bx,4000
	jb wysw_dalej

	sub bx,4000
	add bx,2
	cmp bx,320
	jb wysw_dalej
	mov bx,0

wysw_dalej:
	mov cs:licznik,bx

	pop es
	pop bx
	pop ax

	jmp dword PTR cs:wektor8

	licznik dw 0
	timer dw 18
	wektor8 dd ?
obsluga_zegara ENDP


zacznij:
mov al,0
mov ah,5
int 10
mov ax,0
mov ds,ax

mov eax,ds:[32]
mov cs:wektor8, eax

mov ax,SEG obsluga_zegara
mov bx,OFFSET obsluga_zegara
cli

mov ds:[32],bx
mov ds:[34],ax
sti

aktywne_oczekiwanie:
mov ah,1
int 16h
jz aktywne_oczekiwanie

mov ah,0
int 16h
cmp al,'x'
jne aktywne_oczekiwanie

mov eax,cs:wektor8
cli
mov ds:[32],eax
sti

mov al,0
mov ah,4Ch
int 21h
rozkazy ENDS

nasz_stos SEGMENT stack
	db 128 dup (?)
nasz_stos ENDS

END zacznij