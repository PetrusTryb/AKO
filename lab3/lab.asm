.686
.model flat
extern __read: PROC
extern __write: PROC
extern _ExitProcess@4: PROC
public _main
.data
osiem dd 8
.code
wyswietl_EAX PROC
PUSHA
mov ebp,esp
sub esp, 12
mov ecx, 1
mov ebx, 10
dec ebp
mov [ebp],BYTE PTR 10
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

wczytaj_do_EAX_oct PROC
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
mov ebx,8
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
wczytaj_do_EAX_oct ENDP

wyswietl_EAX_oct PROC
push ebp
mov ebp,esp
sub esp,12
mov ecx,8
dec ebp
mov [ebp],BYTE PTR 10
ptl:
	mov edx, 0
	div osiem; iloraz eax, reszta edx
	add dl,48
	dec ebp
	mov [ebp], dl
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
wyswietl_EAX_oct ENDP
_main PROC
call wczytaj_do_EAX_oct
push eax
call wyswietl_EAX
call wczytaj_do_EAX_oct
call wyswietl_EAX
pop ebx
add eax, ebx
call wyswietl_EAX
call wyswietl_EAX_oct
PUSH 0
CALL _ExitProcess@4
_main ENDP
END