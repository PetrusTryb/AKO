.686
.model flat
extern __write: PROC
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

_main PROC
mov eax, 1
mov ecx, 0
ptl:
	call wyswietl_EAX
	inc ecx
	add eax,ecx
	cmp ecx,50
	jne ptl
PUSH 0
CALL _ExitProcess@4
_main ENDP
END