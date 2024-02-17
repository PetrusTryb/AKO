.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
public _main

.data
tekst db 10, "Nazywam sie Piotr Trybisz", 10
db "Moj pierwszy 32-bitowy program asemblerowy "
db "dziala juz poprawnie!", 10, 0

.code
_main PROC
    mov ecx, 94
    push ecx
    push dword PTR OFFSET tekst
    push dword PTR 1
    call __write
    add esp, 12
    push dword PTR 0
    call _ExitProcess@4
_main ENDP
END