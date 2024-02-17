.686
.XMM
.model flat
.data
ALIGN 16
tabl_A dd 1.0, 2.0, 3.0, 4.0
tabl_B dd 2.0, 3.0, 4.0, 5.0
liczba db 1
db 15 dup(?); naprawa wyrownania
tabl_C dd 3.0, 4.0, 5.0, 6.0
.code
_srednia_harm PROC
push ebp
mov ebp,esp
mov ecx,[ebp+12]
mov eax,ecx
mov edx,[ebp+8]
finit
fldz; st(0)=0
ptl:
	fld1; st(0)=1, st(1)=0
	fld DWORD PTR [edx]; st(0)=An, st(1)=1, st(2)=0
	fdivp st(1), st(0); st(0)=1/An, st(1)=0
	faddp st(1),st(0); st(0)=0+1/An
	add edx,4
loop ptl
fild DWORD PTR [ebp+12]; st(0)=n, st(1)=suma
fdiv st(0), st(1)
pop ebp
ret
_srednia_harm ENDP

_nowy_exp PROC
push ebp
mov ebp,esp
finit
mov ecx,20
sub esp,16
fld1
fst dword ptr [esp]
fstp dword ptr [esp+4]
mov [esp+8], DWORD PTR 0; suma
mov eax,0
ptl:
fld DWORD PTR [esp+4]; st(0)=licznik
fld DWORD PTR [esp]; st(0)=mianownik, st(1)=licznik
fdivp st(1), st(0); st(0)=licznik/mianownik
fadd DWORD PTR [esp+8]; st(0)=suma+(licznik/mianownik)
fstp DWORD PTR [esp+8]

fld DWORD PTR [esp+4]; st(0)=licznik
fmul DWORD PTR [ebp+8]; st(0)=licznik*x
fstp DWORD PTR [esp+4]

fld dword ptr [esp]; st(0)=mianownik
inc eax
push eax
fimul dword ptr [esp]; st(0)=mianownik*i
pop eax
fstp dword ptr [esp]

loop ptl
fld DWORD PTR[esp+8]
add esp,16
pop ebp
ret
_nowy_exp ENDP

_suma_wektorow PROC
push ebp
mov ebp,esp
push esi
mov esi,[ebp+8]
MOVDQU xmm0, [esi]
mov esi,[ebp+12]
MOVDQU xmm1, [esi]
paddsb xmm0, xmm1
mov esi,[ebp+8]
movdqu xmmword ptr [esi], xmm0
pop esi
pop ebp
ret
_suma_wektorow ENDP

_int2float PROC
push ebp
mov ebp,esp
push esi
mov esi,[ebp+8]
cvtpi2ps xmm0, qword PTR [esi]
mov esi,[ebp+12]
movdqu xmmword ptr [esi], xmm0
pop esi
pop ebp
ret
_int2float ENDP

_pm_jeden PROC
push ebp
mov ebp,esp
push esi
mov esi,[ebp+8]
movups xmm0,[esi]
sub esp,16
mov ecx,4
fld1
ptl:
lea esi,[esp+ecx*4-4]
fst dword ptr [esi]
loop ptl
movups xmm1,[esp]
add esp,16
addsubps xmm0,xmm1
mov esi,[ebp+8]
movups [esi],xmm0
pop esi
pop ebp
ret
_pm_jeden ENDP

_dodawanie_SSE PROC
push ebp
mov ebp,esp
mov eax,[ebp+8]
movaps xmm2, tabl_A
movaps xmm3, tabl_B
movaps xmm4, tabl_C

addps xmm2, xmm3
addps xmm2, xmm4
movups [eax],xmm2

pop ebp
ret
_dodawanie_SSE ENDP
END