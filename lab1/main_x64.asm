extern ExitProcess : PROC
extern _write : PROC
public main

.data
tekst db 10, "Nazywam sie Piotr Trybisz", 10
db "Moj pierwszy 64-bitowy program asemblerowy "
db "dziala juz poprawnie!", 10, 0

.code
main PROC
    mov rcx, 1
    mov rdx , OFFSET tekst
    mov r8, 94
    sub rsp, 40
    call _write
    add rsp, 40
    sub rsp, 8
    mov rcx, 0
    call ExitProcess
main ENDP
END