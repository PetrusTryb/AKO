public suma_siedmiu_liczb
public convert_to_bin
extern malloc: PROC
.data
ALIGN 16
tresc db 'x','D',0,0,0,0,0,0
tytul db 'J','P',0,0,0,0,0,0
.code
suma_siedmiu_liczb PROC
push rbp
mov rbp,rsp
push rsi
mov rax,rcx
add rax,rdx
add rax,r8
add rax,r9
mov rsi,48
mov rcx,3
ptl:
add rax,[rbp+rsi]
add rsi,8
loop ptl
pop rsi
pop rbp
ret
suma_siedmiu_liczb ENDP

convert_to_bin PROC
push rbp
mov rbp,rsp
push rbx
mov rbx,rcx;tymczasowe zapisanie argumentu w RBX
mov rcx,136;64 cyfry po dwa bajty + znak koñca i entery
CALL malloc
push rdi
mov rdi,rax;adres bufora w RDI
mov rax,rbx;liczba w rax
mov [rdi+134], WORD PTR 0
mov [rdi+132], WORD PTR 0Ah
mov [rdi], WORD PTR 0Ah
mov [rdi+2], WORD PTR 0Ah
lea rbx, [rdi+130]
mov rcx,64
mov r8,2; dzielnik
ptl:
mov rdx,0
div r8; wynik w RAX, reszta w RDX
add rdx,48; konwersja na znak
mov [rbx], dx
sub rbx,2
loop ptl
mov rax,rdi
pop rdi
pop rbx
pop rbp
ret
convert_to_bin ENDP

END

