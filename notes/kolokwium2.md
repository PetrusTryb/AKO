<style>@media print{.katex-html{display:none;}}</style>
# Pytania i zadania przykładowe do ćwiczeń cz. II, grudzień 2017

## 1
Poniżej podano fragment programu w języku C.
```c
int a, b, * wsk, wynik;
wsk = &b;
a = 21; b = 25;
wynik = roznica(&a, &wsk);
```
Napisać podprogram w asemblerze przystosowany do
wywoływania z poziomu języka C, którego prototyp ma
postać:
`int roznica (int * odjemna, int ** odjemnik);`
Podprogram ten powinien obliczyć różnicę dwóch liczb
całkowitych ze znakiem w kodzie U2.

```as
_roznica PROC
push ebp
mov ebp,esp
mov eax,[ebp+8]	;[odjemna]
mov eax,[eax]	;odjemna
mov ecx,[ebp+12];[[odjemnik]]
mov ecx,[ecx]	;[odjemnik]
mov ecx,[ecx]	;odjemnik
sub eax,ecx
pop ebp
ret
_roznica ENDP
```

## 2
Funkcja biblioteczna języka C o prototypie
`void * malloc(unsigned int k);`
przydziela k-bajtowy obszar pamięci i zwraca adres
przydzielonego obszaru. Jeśli wymagany obszar nie
może być przydzielony, to funkcja zwraca wartość 0.
Napisać podprogram w asemblerze, przystosowany do
wywoływania z poziomu języka C — prototyp tego
podprogramu ma postać:
`int * kopia_tablicy(int tabl[],
unsigned int n);`

Podprogram `kopia_tablicy` tworzy nową tablicę
o rozmiarach identycznych z oryginalną i zwraca adres
nowej tablicy (albo 0, jeśli tablicy nie można było
utworzyć).
Do nowej tablicy należy skopiować wszystkie
elementy tablicy oryginalnej o wartościach będących
liczbami parzystymi. Pozostałe elementy nowej tablicy
wypełnić zerami.
Wskazówki:
1. Nową tablicę należy utworzyć poprzez
przydzielenie odpowiedniego obszaru pamięci za
pomocą funkcji malloc.
2. Sprawdzenie czy liczba jest parzysta najłatwiej
wykonać poprzez odczytanie najmłodszego bitu
liczby (bit nr 0).
```as
_kopia_tablicy PROC
push ebp
push esi
push edi
push ebx
mov ebp,esp
mov eax,[ebp+24];eax=N
mov ecx,4
mul ecx;eax=k=4N
push eax
call _malloc
add esp,4
cmp eax,0; czy problem przy alokacji
jz koniec
mov edi,eax;edi=adres kopii
mov esi,[ebp+20];esi=adres tablicy
mov ecx,[ebp+24];ecx=N
ptl:
	mov edx,[esi]
	bt edx,0
	jc skip
	mov [edi],edx
	jmp dalej
	skip:
	mov [edi],dword ptr 0
	dalej:
	add esi,4
	add edi,4
	loop ptl
koniec:
pop ebx
pop edi
pop esi
pop ebp
ret
_kopia_tablicy ENDP
```

## 3
Podprogram, przystosowany do wywoływania z
poziomu języka C, o prototypie:
`char * komunikat (char * tekst);`
rezerwuje obszar pamięci (za pomocą funkcji
malloc) i wpisuje do niego tekst wskazany przez
parametr tekst, bezpośrednio za którym zostaje
dopisany łańcuch znaków "Błąd.". Podprogram
zwraca adres przydzielonego obszaru. Napisać kod
asemblerowy tego podprogramu.
Wskazówka: łańcuch znaków kończy się bajtem o
wartości 0.

```as
_komunikat PROC
push ebx
push esi
push edi
push ebp
mov ebp,esp
mov esi,[ebp+20];esi=adr. tekstu
mov ecx,0
kiedy_koniec:
	mov eax,[esi]
	inc esi
	cmp eax,0
	jz znam_koniec
	inc ecx
	jmp kiedy_koniec
znam_koniec:
add ecx,6
push ecx
call _malloc
pop ecx
mov esi,[ebp+20]
mov edi,eax;edi=adr.docelowy
ptl:
	mov dl, BYTE PTR [esi]
	cmp dl,0
	jz eptl
	mov [edi],BYTE PTR dl
	inc esi
	inc edi
	jmp ptl
eptl:
mov [edi],BYTE PTR'B'
mov [edi+1],BYTE PTR 'l'
mov [edi+2],BYTE PTR 'a'
mov [edi+3],BYTE PTR 'd'
mov [edi+4],BYTE PTR '.'
mov [edi+5],BYTE PTR 0
pop ebp
pop edi
pop esi
pop ebx
ret
_komunikat ENDP
```

## 4
Poniżej podano fragment programu w języku C.
```c
int pomiary[7], * wsk;
- - - - - - - - - - - - - - -
wsk = szukaj_elem_min(pomiary, 7);
printf("\nElement minimalny = %d\n", * wsk);
```
Napisać podprogram w asemblerze przystosowany do
wywoływania z poziomu języka C, którego prototyp
ma postać:
`int * szukaj_elem_min (int tablica[ ], int n);`
Podprogram ten powinien wyznaczyć najmniejszy
element tablicy i zwrócić adres (wskaźnik) tego
elementu. Liczbę elementów tablicy określa drugi
parametr funkcji.
```as
_szukaj_elem_min PROC
push esi
push ebp
mov ebp,esp
mov esi,[ebp+12]	;edx = adr. tablicy
mov ecx,[ebp+16]	;ecx = n
mov eax,07FFFFFFFh
mov edx,0
ptl:
	cmp eax, DWORD PTR [esi]
	jl dalej
	mov eax, DWORD PTR [esi]
	mov edx, esi
	dalej:
	add esi,4
	loop ptl
mov eax,edx
pop ebp
pop esi
ret
_szukaj_elem_min ENDP
```

## 5
Podprogram, przystosowany do wywoływania z
poziomu języka C, o prototypie:
`void szyfruj (char * tekst);`
szyfruje każdy bajt obszaru tekst poprzez
wykonanie operacji XOR, której drugim argumentem
jest ciąg 8 bitów. Ciąg ma inną postać dla każdego
bajtu i stanowi 8 najmłodszych bitów 32-bitowej
liczby losowej. Pierwsza liczba losowa ma wartość
`52525252H`, a następne obliczane są w poniższy
sposób:\
a. wyznacza się sumę modulo dwa bitów nr 30 i 31,\
b. przesuwa się całą liczbę 32-bitową o jedną
pozycję w lewo,\
c. na bit nr 0 liczby wprowadza się wcześniej
obliczoną sumę modulo dwa.\
Napisać kod podprogramu szyfruj w asemblerze.
```as
_szyfruj PROC
push ebp
mov ebp,esp
mov edx,[ebp+8]
mov eax,052525252h
ptl:
	mov cl,[edx]
	cmp cl,0
	jz eptl
	xor cl,al
	mov [edx],cl
	mov ch,0
	bt eax,30
	adc ch,0
	bt eax,31
	adc ch,1
	and ch,1
	shl eax,1
	add al,ch
	inc edx
	jmp ptl
eptl:
mov byte ptr [edx],0
pop ebp
ret
_szyfruj ENDP
```

## 6
Napisać podprogram w asemblerze obliczający
wartość funkcji kwadrat metodą rekurencyjną
korzystając z zależności:\
$a^2= (a – 2)^2 + 4a – 4$ dla a > 1\
$a^2 = 1$ dla a = 1\
$a^2 = 0$ dla a = 0\
przy czym argument a jest liczbą całkowitą 32-bitową
zawartą w przedziale <1, 65535>.
Podprogram powinien być przystosowany do
wywoływania z poziomu języka C, a jego prototyp ma
postać:
`unsigned int kwadrat (unsigned int a);`
W podprogramie nie można używać rozkazów
mnożenia i rozkazów przesunięć.

```as
_kwadrat PROC
push ebp
push edx
mov ebp,esp
mov eax,[ebp+12]
cmp eax,1
ja ok
pop edx
pop ebp
ret
ok:
mov edx,eax
sub eax,2
push eax
call _kwadrat
add esp,4
mov ecx,4
ptl:
	add eax,edx
	loop ptl
sub eax,4
pop edx
pop ebp
ret
_kwadrat ENDP
```
## 7
W pewnym programie używana jest funkcja
iteracja, której prototyp ma postać:
`unsigned char iteracja(unsigned char a);`
Podać wartość zwracaną przez funkcję iteracja w
poniższym fragmencie programu w języku C
`w = iteracja(32);`
Kod funkcji iteracja zapisany w asemblerze ma
postać
```as
_iteracja PROC
push ebp
mov ebp, esp
mov al, [ebp+8]
sal al, 1
; SAL wykonuje przesuniecie logiczne
; w lewo
jc zakoncz
inc al
push eax
call _iteracja
add esp, 4
pop ebp
ret
zakoncz: rcr al, 1
; rozkaz RCR wykonuje przesunięcie
; cykliczne w prawo przez CF
pop ebp
ret
_iteracja ENDP
```

AL=32=00100000b\
AL=01000000b, CF=0\
AL=01000001b\
AL=10000010b, CF=0\
AL=10000011b\
AL=00000110b, CF=1\
AL=10000011b = **131**

## 8
W programie asemblerowym zdefiniowano format
32-bitowych liczb mieszanych bez znaku, przyjmując,
że najmniej znaczący bit ma wagę $2^{-7}$
Napisać fragment programu w asemblerze, który
wpisze 1 do znacznika CF (rozkaz STC) jeśli część
całkowita liczby zawartej w rejestrze EBX jest różna
od zera; w przeciwnym razie CF powinien zostać
wyzerowany (rozkaz CLC).
```as
;EBX[0]=2^-7->EBX[7]=2^0
mov ecx,7
ptl:
	bt ebx,ecx; CF=ebx[ecx]
	jc koniec
	inc ecx
	cmp ecx,32
	jnz ptl
clc
koniec:
```
## 9
W programie zdefiniowano format 32-bitowych
liczb mieszanych w kodzie U2 przyjmując, że
najmniej znaczący bit ma wagę $2^{-7}$.
Przyjmując, że liczba w podanym formacie znajduje
się w rejestrze EDX, napisać fragment programu,
który zaokrągli tę liczbę do najbliższej liczby
całkowitej. Wynik należy pozostawić również w
rejestrze EDX w podanym formacie.
Wskazówka: zbadać stan bitu o wadze $2^{-1}$.
```as
;EDX[0]=2^-7
;EDX[6]=2^-1
;EDX[7]=2^0
;EDX[31]=znak
SHR EDX,7; EDX[0]=2^0, CF=2^-1
ADC EDX,0
SHL EDX,7
```
## 10
Na poniższym rysunku pokazane są dwa formaty
32-bitowych liczb stałoprzecinkowych bez znaku
używane w programie.
|Nr bitu|31|0|
|--|--|--|
|Wartość|$2^{23}$|$2^{-8}$|

|Nr bitu|31|0|
|--|--|--|
|Wartość|$2^{24}$|$2^{-7}$|

Zakładając, że w rejestrze ESI znajduje się liczba
zakodowana wg pierwszego formatu (najmniej
znaczący bit ma wagę $2^{-8}$), a w rejestrze EDI liczba
zakodowana wg drugiego formatu (najmniej znaczący
bit ma wagę $2^{-7}$), napisać fragment programu, który porówna obie liczby. Jeśli liczba w rejestrze ESI jest większa od liczby w rejestrze EDI, to do CF należy wpisać 1, w przeciwnym razie 0 (rozkazy STC/CLC).

```as
bt edi,31
jnc nie_duzo_wieksza
cmc
jmp koniec
nie_duzo_wieksza:
shl edi,1
mov eax,esi
mov ebx,edi
mov al,0
mov bl,0
cmp ebx,eax
jne koniec
mov eax,esi
mov ebx,edi
cmp bl,al
jne koniec
clc
koniec:
```
## 11
Podać reprezentację liczby –0.25 w formacie
zmiennoprzecinkowym *double.* Wskazówka: pole
mantysy w formacie w formacie *double* zajmuje 52
bity.

Nr bitów|63|62-51 (11b)|51-0 (52b)|
|-|-|-|-|
|Dane|Znak|Wykładnik|Mantysa


0|25\
0|50\
1|00\


0.010000000...= 1.00000000...*2^-2\
Znak = 1\
Wykładnik = -2 + bias(1023) = 1021 = 01111111101\
1021|1\
510|0\
255|1\
127|1\
63|1\
31|1\
15|1\
7|1\
3|1\
1|1\
0
Mantysa (znorm.) = 0\
**10111111 11010000 00000000 00000000 00000000 00000000 00000000 00000000**

## 12
Poniżej podano reprezentację binarną liczby -8.25
w postaci 32-bitowej liczby zmiennoprzecinkowej
(*float*). Uzupełnić brakujące bity mantysy w tej
reprezentacji.
10000010 ?????000000000000000000

Format float:\
Mantysa 23 bity\
Wykładnik 8 bitów (bias +127)\
Znak 1 bit (1)

10000010b = 130
130 - 127 = 3

8.25 = 1000 + 0.01 = 1000.01

0|25\
0|50\
1|00\

1000.01 * 2^3 = 1.00001

**Brakujące bity: 00001**

## 13
Poniżej podano reprezentację binarną dwóch 32-
bitowych liczb binarnych zmiennoprzecinkowych
(format *float*) x i y. Ile wynosi iloraz x/y tych liczb?\
x: 0 10000001 00000000000000000000000\
y: 1 10000000 00000000000000000000000

Wykł.(x) = 10000001b - 127 = 129-127 = 2\
Wykł.(y) = 10000000b - 127 = 128-127 = 1

x=1*2^2=4\
y=-1*2^1=-2

**x/y = 4/-2 = -2**

## 14
W pamięci komputera, począwszy od adresu
podanego w rejestrze ESI znajduje się 32-bitowa
liczba zmiennoprzecinkowa w formacie *float*. Napisać
fragment programu, który przekształci tę liczbę na 64-bitowy format *double* i uzyskany rezultat wpisze do
pamięci począwszy od adresu podanego w rejestrze
EDI. W omawianym fragmencie nie można używać
rozkazów koprocesora arytmetycznego.

```as
;Float: 1b znak, 8b wykladnik, 23b mantysa
;ZWWWWWWW WMMMMMMM MMMMMMMM MMMMMMMM
;Double: 1b znak, 11b wykladnik, 52b mantysa
;ZWWWWWWW WWWWMMMM MMMMMMMM MMMMMMMM MMMMMMMM MMMMMMMM MMMMMMMM MMMMMMMM
;Przekonwertowany F->D: 
ZWWWWWWW WWWWMMMM MMMMMMMM MMMMMMMM MMM00000 0 0 0
mov eax,0
mov [edi],al
mov [edi+1],ax ;zerowanie najmlodszych trzech bajtow
mov al,[esi]; AL=najmlodszy bajt mantysy
shl al,5
mov [edi+3],al
mov eax,[esi]
shr eax,3
mov [edi+4],ax
mov ax,[esi+2]
shl ax,1; AH=wykladnik+127
sub ah,127
shr ax,8; AL=wykladnik, AH=0
add ax,1023; AX=wykladnik dla dword
shl ax,4
mov dx,[esi+2]
shl dl,1
shr dl,4
and dh,80h
or ax,dx
mov [edi+6],ax
```

## 15
Poniższy program w języku C wczytuje promień r
koła z klawiatury, oblicza pole koła i wyświetla na
ekranie wynik obliczenia.\
Obliczenie pola koła wykonuje podprogram
zakodowany w asemblerze, przystosowany do
wywoływania z poziomu języka C, którego prototyp
na poziomie języka C ma postać:
`void pole_kola (float * pr);`
Argument `pr` jest adresem (wskaźnikiem) zmiennej, w
której przechowywany jest promień `r` koła.
Napisać podprogram w asemblerze dokonujący
opisanego obliczenia i uruchomić program składający
się z plików źródłowych w języku C i w asemblerze.
```c
#include <stdio.h>
void pole_kola (float * pr);
int main()
{
float k;
printf("\nProszę podać promień: ");
scanf_s("%f", &k);
pole_kola (&k);
printf("\nPole koła wynosi %f\n",k);
return 0;
}
```

```as
_pole_kola PROC
push ebp
mov ebp,esp
mov edx,[ebp+8]		;edx=wsk. na R
finit
fld DWORD PTR [edx]	;ST(0)=R
fld DWORD PTR [edx]	;ST(0)=R, ST(1)=R
fmulp				;ST(0)=R^2
fldpi				;ST(0)=PI, ST(1)=R^2
fmulp				;ST(0)=PI*R^2
fstp DWORD PTR [edx]
pop ebp
ret
_pole_kola ENDP
```

