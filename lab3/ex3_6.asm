.686
.model flat
extern __write: PROC
extern __read: PROC
extern _ExitProcess@4: PROC
public _main
.code

wyswietl_EAX PROC
PUSHA
mov ebp,esp
sub esp, 12
mov ecx, 1
mov ebx, 10
dec ebp
mov [ebp],BYTE PTR 20h
cnv:
	dec ebp
	mov edx,0
	div ebx
	add edx,'0'
	mov [ebp],dl
	inc ecx
	cmp eax,0
	jne cnv
push ecx
push ebp
push dword ptr 1
call __write
add esp,24
POPA
RET
wyswietl_EAX ENDP

wczytaj_do_EAX_hex PROC
push ebx
push ecx
push edx
push esi
push edi
push ebp
sub esp,12
mov ebp,esp
push 12
push ebp
push 0
call __read
add esp,12
mov eax,0
czytaj:
movzx ecx, BYTE PTR [ebp]
cmp ecx,BYTE PTR 10
je napotkano_enter
cmp ecx,BYTE PTR 58
jb cyfra
cmp ecx,BYTE PTR 71
jb litera_duza
litera_mala:
sub ecx,61h
add ecx,10
rol eax,4
or eax,ecx
jmp kont
cyfra:
sub ecx,30h
rol eax,4
or eax,ecx
jmp kont
litera_duza:
sub ecx,41h
add ecx,10
rol eax,4
or eax,ecx
jmp kont
kont:
inc ebp
jmp czytaj
napotkano_enter:
add esp,12
pop ebx
pop ecx
pop edx
pop esi
pop edi
pop ebp
ret
wczytaj_do_EAX_hex ENDP

_main PROC
call wczytaj_do_EAX_hex
call wyswietl_eax
push 0
call _ExitProcess@4
_main ENDP
END