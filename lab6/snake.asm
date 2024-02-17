.386
rozkazy SEGMENT use16
		ASSUME cs:rozkazy

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

obsluga_zegara PROC
	push ax
	push bx
	push es
	mov ax, 0B800h
	mov es,ax
	mov bx,0
	sub cs:timer,DWORD PTR 1
	jnz wysw_dalej
	mov cs:timer,DWORD PTR 3

	mov ax,cs:pos_x
	mov cl,2
	div cl
	mov bx,0
	call wyswietl_AL
	mov al,cs:pos_y
	mov bx,8
	call wyswietl_AL

	mov bx,cs:pos_x
	mov al,cs:pos_y
	mov cl,160
	mul cl
	add bx,ax

	cmp cs:pos_y,0
	jbe stop
	cmp cs:pos_y,25
	jae stop
	cmp cs:pos_x,0
	jbe stop
	cmp cs:pos_x,157
	jae stop
	
	jmp nie_stop
	stop:
	mov cs:exit,1
	nie_stop:

	;mov BYTE PTR es:[bx],'-'
	mov al,cs:znak
	mov BYTE ptr es:[bx],al
	mov BYTE PTR es:[bx+1],00001010b

	
	mov bx,0
	mov ax,cs:pos_x
	add ax,cs:d_x
	mov cs:pos_x,ax

	mov al,cs:pos_y
	add al,cs:d_y
	mov cs:pos_y,al

wysw_dalej:
	;mov cs:licznik,bx

	pop es
	pop bx
	pop ax

	jmp dword PTR cs:wektor8

	znak db '.'
	pos_x dw 50
	pos_y db 10
	d_x dw 0;2/-2
	d_y db 0;1/-1
	timer dw 18
	wektor8 dd ?
obsluga_zegara ENDP

obsluga_klawiatury PROC
	push ax
	push bx
	push es
	mov ax, 0B800h
	mov es,ax
	mov bx,0
	in al,60h
	cmp al,72
	jne nie_gora
	mov cs:d_x,0
	mov cs:d_y,-1
	mov cs:znak,'|'
	nie_gora:
	cmp al,80
	jne nie_dol
	mov cs:d_x,0
	mov cs:d_y,1
	mov cs:znak,'|'
	nie_dol:
	cmp al,75
	jne nie_lewo
	mov cs:d_x,-2
	mov cs:d_y,0
	mov cs:znak,'-'
	nie_lewo:
	cmp al,77
	jne nie_prawo
	mov cs:d_x,2
	mov cs:d_y,0
	mov cs:znak,'-'
	nie_prawo:
	;kont:
	cmp al,1
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

mov ax,03h
int 10h

;clk
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
;klaw
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

mov eax,cs:wektor8
cli
mov ds:[32],eax
sti

mov ax,03h
int 10h

mov al,0
mov ah,4Ch
int 21h
rozkazy ENDS

nasz_stos SEGMENT stack
	db 128 dup (?)
nasz_stos ENDS

END zacznij