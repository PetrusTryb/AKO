.686
.model flat
public _szukaj4_max
public _liczba_przeciwna
public _odejmij_jeden
public _przestaw
.code
_szukaj4_max PROC
push ebp
mov ebp,esp
push esi
push edi
push ebx
mov ecx,2
mov eax,[ebp+8]
ptl:
inc ecx
mov edx,[ebp+4*ecx]
cmp edx,eax
jng cont
mov eax,edx
cont:
cmp ecx,5
jne ptl
pop ebx
pop edi
pop esi
pop ebp
RET
_szukaj4_max ENDP

_liczba_przeciwna PROC
push ebp
mov ebp,esp
push edi
mov edi, DWORD PTR [ebp+8]
neg DWORD PTR [edi]
pop edi
pop ebp
ret
_liczba_przeciwna ENDP

_odejmij_jeden PROC
push ebp
mov ebp,esp
push edi
mov edi, DWORD PTR [ebp+8]
mov edi, [edi]
dec DWORD PTR [edi]
pop edi
pop ebp
ret
_odejmij_jeden ENDP

_przestaw PROC
push ebp
mov ebp,esp
push esi
push edi
push ebx
mov ecx, [ebp+12]
dec ecx
jecxz koniec
mov ebx, [ebp+8]
mov edx, 0
ptl:
mov edi, [ebx+edx*4]
inc edx
mov esi, [ebx+edx*4]
cmp edi, esi
jl cont
mov DWORD PTR [ebx+edx*4-4], esi
mov DWORD PTR [ebx+edx*4], edi
cont:
loop ptl
koniec:
pop ebx
pop edi
pop esi
pop ebp
ret
_przestaw ENDP
END