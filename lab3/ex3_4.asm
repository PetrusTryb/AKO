.686
.model flat
extern __read: PROC
extern __write: PROC
extern _ExitProcess@4: PROC
public _main
.code

wczytaj_do_EAX PROC
push ebx
push ecx
push edx
push esi
push edi
push ebp
mov ebp,esp
sub esp,12
mov edi,esp
push dword ptr 12
push edi
push dword ptr 0
call __read
add esp,24

mov eax,0
mov ebx,10
pobieraj_znaki:
	mov cl,[edi]
	inc edi
	cmp cl,10
	je byl_enter
	sub cl,30h
	movzx ecx,cl
	mul ebx
	add eax,ecx
	jmp pobieraj_znaki
byl_enter:
	pop ebx
	pop ecx
	pop edx
	pop esi
	pop edi
	pop ebp
	ret
wczytaj_do_EAX ENDP

wyswietl_EAX_hex PROC
push ebp
mov ebp,esp
sub esp,12
mov ecx,8
mov edi, OFFSET hexy
dec ebp
mov [ebp],BYTE PTR 10
ptl:
	movzx ebx, al
	and bl, 0Fh
	mov dl, [edi][ebx]
	dec ebp
	mov [ebp], dl
	ror eax,4
loop ptl
dec ebp
mov [ebp],BYTE PTR 10
mov ebp,esp
add ebp,2
push 10
push ebp
push 1
call __write
add esp,24
popa
ret
wyswietl_EAX_hex ENDP

_main PROC
call wczytaj_do_EAX
call wyswietl_EAX_hex
push 0
call _ExitProcess@4
_main ENDP
END