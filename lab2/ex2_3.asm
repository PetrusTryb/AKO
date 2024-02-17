.686
.model flat
extern _ExitProcess@4: PROC
extern _MessageBoxA@16: PROC
extern _MessageBoxW@16: PROC

public _main
.data
tytul_Unicode	dw 'T','e','k','s','t',' ','w',' '
				dw 'f','o','r','m','a','c','i','e',' '
				dw 'U','T','F','-','1','6', 0
tekst_Unicode	dw 'K','a',017Ch,'d','y',' ','z','n','a','k',' '
				dw 'z','a','j','m','u','j','e',' '
				dw '1','6',' ','b','i','t',0F3h,'w', 0

tytul_Win1250 db 'Tekst w standardzie Windows 1250', 0
tekst_Win1250 db 'Ka',0BFh,'dy znak zajmuje 8 bit',0F3h,'w', 0

tytul_Znaki dw 'Z','n','a','k','i',0
tekst_Znaki dw 'T','o',' ','j','e','s','t',' '
			dw 'p','i','e','s',' ',0D83Dh,0DC15h,' ' ;1F415h - 10000h = 0F415h = 1101100000111101 1101110000010101
			dw 'i',' ','k','o','t',' ',0D83Dh,0DC08h,0 ;1F408h

.code
_main PROC
push 0
push offset tytul_Znaki
push offset tekst_Znaki
push 0
call _MessageBoxW@16

push 0
call _ExitProcess@4

_main ENDP
END
