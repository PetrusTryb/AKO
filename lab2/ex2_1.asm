.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
public _main

.data
tekst db 10, "Nazywam si",0A9h," Piotr Trybisz", 10
db "M",0A2h,"j pierwszy 32-bitowy program asemblerowy "
db "dzia",088H,"a ju",0BEh," poprawnie!", 10, 0

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