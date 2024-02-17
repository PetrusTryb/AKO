.386
rozkazy SEGMENT use16
		ASSUME cs:rozkazy

linia PROC
push ax
push bx
push cx
push es

mov ax,0A000h
mov es,ax


mov bx,cs:adres_piksela
mov al,cs:kolor
inc cs:kolor

add word ptr cs:przyrost,1
cmp word ptr cs:przyrost,3
jne dal
mov word ptr cs:przyrost,1
dal:
cmp cs:druga,word ptr 0
je nie_druga
sub bx,cs:przyrost
cmp bx,word ptr 80
jb koniec
jmp dr
nie_druga:
add bx,cs:przyrost
cmp bx,320*200
cmc
adc word ptr cs:druga,0
cmp word ptr cs:druga,1
je switch
dr:
mov es:[bx],al
add bx,320
mov cs:adres_piksela,bx
jmp koniec

switch:
mov cs:adres_piksela,word ptr -10


koniec:
pop es
pop cx
pop bx
pop ax
jmp dword ptr cs:wektor8

kolor db 10
adres_piksela dw 10
druga dw 0
przyrost dw 1
wektor8 dd ?


linia ENDP

zacznij:
mov ah,0
mov al,13h
int 10h

mov bx,0
mov es,bx
mov eax,es:[32]
mov cs:wektor8,eax

mov ax,SEG linia
mov bx,OFFSET linia
cli
mov es:[32],bx
mov es:[32+2],ax
sti

czekaj:
mov ah,1
int 16h
jz czekaj

mov ah,0
mov al,3h
int 10h

mov eax,cs:wektor8
mov es:[32],eax

mov ax,4C00h
int 21h
rozkazy ENDS

stosik SEGMENT stack
	db 256 dup(?)
stosik ENDS

END zacznij