<style>@media print{.katex-html{display:none;}}</style>
# Przykładowe kolokwium nr 1.

## 1
Litery B, Ł, Ą, D mają w Unicode kody odpowiednio 42H, 0141H, 0104H, 44H. Przedstaw 
zawartość kolejnych bajtów pliku tekstowego, w formacie UTF-16 Big Endian (bez BOM), 
w którym zapisano wyraz BŁĄD, w postaci liczb szesnastkowych.\
| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |\
|00|42|01|**41**|01|04|00|44|

Czwarty bajt tej sekwencji ma kod:
a) 00 b) 01 c) 04 **d) 41**

## 2
Ile razy wykona się pętla w podanym kodzie, jeśli do licznika ECX zostanie w pierwszym 
rozkazie wpisana wartość 0?
```js
MOV ECX,[EDX]
PTL: MOV AL, [ESI]
MOV [EDI], AL
INC ESI
INC EDI
LOOP PTL
EPTL:
```
a) 0 razy
b) 1 raz
c) 4294967295 razy
**d) 4294967296 razy**

## 3-4
Rejestr ESP ma wartość 10000000H, a EAX ma wartość 
0AABBCCDDH. Przy tych założeniach wykonywany 
jest rozkaz PUSH EAX. Wpisz w tabelkę adresy 
modyfikowanych komórek pamięci i ich zawartość.
|Adres|Zawartosc|
|-|-|
|**0FFFFFFF**|AA|
|**0FFFFFFE**|BB|
|**0FFFFFFD**|CC|
|**0FFFFFFC**|DD|

Zapisywane komórki mają adresy:\
a) od 10000000
do 10000003\
b) od 10000000
do 0FFFFFFD\
**c) od 0FFFFFFF
do 0FFFFFFC**\
d) od 0FFFFFFF
do 0FFFFFFD\
W powyższym zadaniu komórka pamięci o najwyższym adresie ma zawartość: **a) AA** b) BB c) CC d) DD\
*PUSH dekrementuje wskaźnik stosu i wstawia wartości zgodnie z little endian.*

## 5-6
Przeprowadź konwersję liczby dziesiętnej 241575 na kod 
ósemkowy. Wpisz w tabelkę kolejno wykonywane kroki 
algorytmu i podaj wynik.

|Krok|Dzialanie|
|-|-|
1.|241575 / 8 = 30196 reszta 7
2.|30196 / 8 = 3774 reszta 4
3.|3774 / 8 = 471 reszta 6
4.|471 / 8 = 58 reszta 7
5.|58 / 8 = 7 reszta 2
6.|7 / 8 = 0 reszta 7
7.|Zwrócenie wyniku: 727647

Najbardziej znacząca cyfra wyniku to: a) 2 b) 5 c) 6 **d) 7**\
Najmniej znacząca cyfra wyniku to: a) 2 b) 5 c) 6 **d) 7**

## 7-8
Po pomnożeniu dwóch liczb dziesiętnych 2 000 000 000 i 2 000 000 000:

a) Rejestr EAX przyjmuje wartość 3782DACEh,\
**b) Rejestr EAX przyjmuje wartość 9D900000h**\
**c) Rejestr EDX przyjmuje wartość 3782DACEh**,\
d) Rejestr EDX przyjmuje wartość 9D900000h

*Wynik tego mnożenia wynosi:*\
$
2*10^9 * 2*10^9 = 4*10^{18}
$\
*Wartość najmłodszego bitu to reszta z dzielenia liczby przez 16.*\
$
4*10^{18} : 16 = 0,25*10^18 = 25*10^{16} \in Z
$\
*A więc reszta wynosi zero, czyli EAX musi się równać 9D900000h (jedyna pasująca możliwość).
Jeśli chodzi o EDX, to jest mało prawdopodobne aby był taki sam, więc pasuje 3782DACEh.*


Po wykonaniu rozkazu mnożenia w powyższym przykładzie:\
a) Flaga CF=0 **b) Flaga CF=1** c) Flaga OF=0 **d) Flaga OF=1**

*Flagi CF i OF przy rozkazie MUL są ustawiane gdy starsza część nie równa się 0.*

## 9
Przy wczytywaniu łańcucha znaków z konsoli do bufora rozkazem CALL __Read
użytkownik wprowadza napis „1234”. Ostatnim zmodyfikowany bajt bufora ma zawartość
a) 00h **b) 0Ah** c) 0Dh d) 34h

*Funkcja __read wstawia dwa znaki 0xA (znak nowej linii - LF) ze względu na sposób, w jaki dane są przechowywane w pamięci.
W systemach operacyjnych, takich jak Unix, znak nowej linii 0xA jest używany do oznaczenia końca linii w plikach tekstowych. Kiedy używamy funkcji __read do odczytu danych z pliku, system operacyjny zwraca nam te dane w postaci surowej sekwencji bajtów.
Aby ułatwić nam interpretację tych danych jako tekstu, funkcja __read wstawia dwa znaki 0xA na końcu odczytanej sekwencji bajtów. Dzięki temu, jeśli odczytane dane zawierają znak nowej linii, będziemy mieli pewność, że zostanie on poprawnie zinterpretowany jako koniec linii.*

## 10
Przy wyświetlaniu komunikatu „To ja” w oknie MessageBoxW liczba przekazywanych
bajtów z bufora wynosi:
a) 5 b) 6 c) 10 **d) 12**

*MessageBoxW przyjmuje ciągu w formacie UTF-16 - każdy znak BMP zajmuje 2 bajty. Ciąg kończy się znakiem 0, który też zajmuje dwa bajty. 6 razy 2B = 12B.*

## 11-12
Dany jest kod przekształcający ciąg cyfr wczytanych z klawiatury na postać binarną. Dwa 
miejsca są zaczernione.

```js
; zamiana cyfr w kodzie ASCII na liczbe binarna
mov esi, 0 ; biezaca wartosc przekształcanej
; liczby przechowywana jest
; w rejestrze ESI; przyjmujemy 0
; jako wartosc poczatkowa
Mov ebx, OFFSET obszar ; adres obszaru ze znakami
; pobranie kolejnej cyfry w kodzie ASCII
_nowy:
mov al, [ebx]
inc ebx ; zwiekszenie indeksu
cmp al,10 ; sprawdzenie czy nacisnieto Enter
je _enter ; skok, gdy nacisnieto Enter
sub al, 30H ; zamiana kodu ASCII na wartosc cyfry
_1: [REDACTED] ; przechowanie wartosci cyfry
; w rejestrze EDI
mov eax, 10 ; mnozna
_2: [REDACTED] ; mnozenie wczesniej obliczonej
; wartosci razy 10
add eax, edi ; dodanie ostatnio odczytanej cyfry
mov esi, eax ; dotychczas obliczona wartosc
jmp _nowy
_enter:
mov eax, esi ; przepisanie wyniku konwersji
; do rejestru EAX
```
W pierwsze miejsce (oznaczone etykietą _1) trzeba wpisać rozkaz:\
a) mov esi, al b) movzx esi,al c) mov edi,al **d) movzx edi,al**

*Chcemy wpisać do rejestru EDI więc opcje A i B odpadają. Wpisujemy wartość 8-bitową do rejestru 32-bitowego więc chcemy wyzerować starsze bity.*

W drugie miejsce (oznaczone etykietą _2) trzeba wpisać rozkaz:\
**a) mul esi** b) mul esi,10 c) mul edi d) mul edi,1

*Rozkaz MUL jest jednoargumentowy więc opcje B i D odpadają. Chcemy pomnożyć wcześniej obliczoną wartość, która jest w rejestrze ESI.*

# cz. I, grudzień 2020

## 1
W czterech kolejnych bajtach pamięci znajdują się
liczby:
| adres | zawartość |
|-------|-----------|
| 65BH  | 2AH       |
| 65AH  | 00H       |
| 659H  | 37H       |
| 658H  | F2H       |

Przyjmując, że podane bajty stanowią liczbę binarną 32-
bitową podać wartość tej liczby w zapisie szesnastkowym
przy założeniu, że stosowana jest konwencja mniejsze wyżej
(ang. big endian).

**F237002Ah**

## 2
Przed wykonaniem poniższego fragmentu programu w
rejestrze EAX znajdowała się liczba p, w rejestrze EDX –
liczba q. Określić zawartość tych rejestrów po wykonaniu
poniższych rozkazów.
```cpp
xor eax, edx
xor edx, eax
xor eax, edx
```
Wskazówki: określić zawartość k-tego bitu rejestru EDX,
jeśli wiadomo, że przed wykonaniem podanego fragmentu
programu na bitach o numerze k znajdowały się wartości $a_k$
(rejestr EAX) i $d_k$ (rejestr EDX). Ponadto operacja XOR:
- jest przemienna x ⊕ y = y ⊕ x
- jest łączna (x ⊕ y) ⊕ z = x ⊕ (y ⊕ z)
- zachodzi związek x ⊕ x = 0.

*EAX=p, EDX=q*\
*EAX = p xor q*
*EDX = q xor EAX = q xor (p xor q) = q xor (q xor p) = (q xor q) xor p = 0 xor p = p*
*EAX = EAX xor EDX = (p xor q) xor p = (q xor p) xor p = q xor (p xor p) = q xor 0 = q*

**EAX=q, EDX=p**

## 3
Napisać fragment programu w asemblerze, który wykona
działania równoważne działaniu poniższego rozkazu
xor edi, esi
W napisanym fragmencie nie można używać rozkazu xor.

*edi xor esi <=> (edi or esi) and not (edi and esi)*

```rb
push ebx
mov ebx,edi		;ebx=edi
or edi,esi		;edi or esi
and ebx,esi		;edi and esi
not ebx			;not (edi and esi)
and edi, ebx	;(edi or esi) and not (edi and esi)
pop ebx
```

## 4
Wyjaśnić dlaczego wykonanie poniższego fragmentu
programu spowoduje wygenerowanie wyjątku procesora?
```rb
mov ax, 0
mov dx, 1
div dx
```

*Oczekiwany rezultat: Dzielenie DX:AX przez DX, wynik w AX reszta w DX.*
**Wystąpi wyjątek, ponieważ wynikiem będzie liczba 2^16, która nie zmieści się w rejestrze AX.**

## 5
Na czym polega różnica w sposobie wykonania
poniższych rozkazów:
```rb
push dword PTR esi
push dword PTR [esi]
```
**Pierwszy rozkaz wstawia na stos wartość rejestru ESI.\
Drugi rozkaz wstawia na stos wartość komórki pamięci po adresem podanym w rejestrze ESI.**

## 6
Podać zawartości rejestrów EBX i CX po wykonaniu
niżej podanego fragmentu programu
```rb
.data
stale DW 2,1
napis DW 10 dup (3),2
tekst DB 7
DQ 1
.code
_main:
MOV CX, napis -1
SUB tekst, CH
MOV EDI,1
MOV tekst[4*EDI],CH
MOV EBX, DWORD PTR tekst+1
```

*Wygląd segmentu danych:\
stale
02h 00h
01h 00h\
napis
03h 00h 03h 00h 03h 00h 03h 00h 03h 00h 03h 00h 03h 00h 03h 00h 03h 00h 03h 00h 02h 00h\
tekst
~~07h~~04h 01h 00h 00h ~~00h~~03h 00h 00h 00h 00h\
\
**CX = 0300h**; napis-1 to ADRES o 1 niżej niż napis, CX ma dwa bajty\
tekst[0] = 7h-3h = 4h\
EDI = 1\
tekst[4] = 3h\
**EBX = DWORD PTR tekst[1] = 03000001h***

## 7
Poniższy fragment programu może służyć do rezerwacji
obszaru pamięci na dane o nieokreślonych wartościach
początkowych. Podać równoważną deklarację tego obszaru
używając dyrektywy dd.
```rb
obroty LABEL dword
ORG $ + 28
```
*Makro ORG zwiększa licznik lokacji o N bajtów, podwójne słowo ma 4 bajty więc liczba potrzebnych podwójnych słów to $28:4=7$.*\
**obroty DD 7 dup(?)**

## 8
Określić zawartości znaczników OF, ZF i CF po
wykonaniu podanego niżej fragmentu programu.
```pl
xor eax, eax
sub eax, 0FFFFFFFFH
```
*xor eax,eax -> eax=0\
0 - FFFFFFFFh = 00000001h -> **ZF=0, CF=1, OF=0** (wystarczy rozpisać odejmowanie 0-FFh w słupku).*

## 9
W wyniku wykonania podanego niżej fragmentu
programu w języku C, zmiennej `p` została przypisana
wartość `0x12`. Określić czy w komputerze stosowana jest
konwencja mniejsze niżej (little endian) czy mniejsze wyżej
(big endian).
```c
unsigned char p ;
unsigned short int proba = 0x1234 ;
unsigned char * wsk =
(unsigned char *) &proba ;
p = *wsk ;
```

*Jeśli big endian to proba = 1234h\
Jeśli little endian to proba = 3412h*\
**Pierwszy bajt wynosi 12h więc jest to big endian.**

## 10
W rejestrze EBX znajduje się liczba całkowita w kodzie
U2. Zakładamy, że liczba zawarta jest w przedziale $< – (2^{31}
– 1), 2^{31}
– 1>$. Napisać fragment, który przekoduje tę liczbę
na kod znak-moduł.

```as
cmp ebx,0
jl ujemna
jmp koniec; liczba dodatnia U2 = Z-M
ujemna:
not ebx; odwrócenie bitów liczby
inc ebx; zwiększenie liczby o 1
and ebx,80000000h; ustawienie ostatniego bitu (znaku)
koniec:
```

## 11
Podać zawartość rejestru DH w postaci liczby dziesiętnej
po wykonaniu poniższych rozkazów:
```as
mov dh, 15
xor dh, 12
```
*DH = 15 = 00001111b\
00001111b xor 12 = 00001111b xor 00001100b = 00000011b = **3***

## 12
Uzupełnić zdanie: W wyniku wykonania poniższego
rozkazu zawartość rejestru ESI zostanie...
```as
lea esi, [esi + esi*8]
```
**Pomnożona razy 9.**

## 13
Na czym polega błąd w poniższym fragmencie
programu:
```ts
sub esp, 4
mov [esp], 'A'
```
**Rozmiar wartości 'A' nie jest określony (np. przez ... PTR 'A'). Kompilator nie będzie wiedział jaki jest jej rozmiar i zwróci błąd.**

## 14
Rozkazy
```pl
push ebx
push ecx
```
można zastąpić równoważna sekwencją:
```pl
sub esp, 8
mov [...], ebx
mov [...], ecx
```
Uzupełnić pola adresowe podanych wyżej rozkazów mov.
**Kolejno: ESP+4, ESP**

## 15
Jakie wartości zostaną wpisane do rejestrów EDX i
EAX po wykonaniu niżej podanego fragmentu programu?
```as
mov eax, 0FFFFFFFFH
mov ebx, 0FFFFFFFFH
imul ebx
```
*Imul to rozkaz do mnożenia liczb w kodzie U2. FFFFFFFFh w U2 = -1\
$-1*-1=1$, więc*
**EDX=0, EAX=1**

## 16
Na czym polega błąd w poniższym fragmencie
programu?
```as
v2 dw ?
– – – – – – – – – – – –
mov v2, 11111H
```
**Wartość przesyłana do lokacji v2 jest zbyt duża (większa niż słowo).**

## 17
Określić zawartości znaczników OF, ZF i CF po
wykonaniu podanego niżej fragmentu programu.
```as
mov ax, 1
add ax, 0FFFFH
```

*Wystarczy rozpisać dodawanie binarne liczb. Wynikiem jest zero, więc **ZF=1**. Ostatnie dwa przeniesienia są równe 1, więc **CF=1** i **OF=0**.*

## 18
Podać liczbę, która zostanie wyświetlona na ekranie w
wyniku wykonania poniższego fragmentu programu.
Podprogram wyswietl32 wyświetla na ekranie w postaci
dziesiętnej liczbę binarną zawartą w rejestrze EAX.
```ts
qxy dw 254, 255, 256
— — — — — — — —
mov eax, dword PTR qxy + 1
call wyswietl32
```

*Wygląd pamięci:\
qxy FE 00 FF 00 00 01\
Pobieramy podwójne słowo z lokacji qxy+1, czyli 00FF0000h.\
Wynikiem jest 255 przesunięte o 8 bitów, czyli:*\
$255*2^8 = (2^8-1)*2^8=2^{16}-2^8=65536-256=$ **65280**

## 19
W rejestrach EDX:EBX:EAX znajduje się 96-bitowy
ciąg bitów. Napisać fragment programu, w którym ciąg ten
zostanie przesunięty cyklicznie w lewo o 1 pozycję.

Wskazówka: wykorzystać rozkazy przesunięcia w lewo SHL
(bity wychodzące z rejestru wpisywane są do CF) i RCL
(zawartość CF wpisywana jest na najmłodszy bit rejestru, a
bity wychodzące z rejestru wpisywane są do CF).
Wykorzystać także rozkaz BT.

```as
BT EDX,31
RCL EAX,1
RCL EBX,1
RCL EDX,1
```

## 20
Napisać fragment programu w asemblerze, który
zamieni młodszą (bity 15 – 0) i starszą (bity 31 – 16) część
rejestru EDX.
**ROL EDX,16**

## 21
W czterech kolejnych bajtach pamięci począwszy od
adresu podanego w rejestrze w EBX znajduje się 32-bitowa
liczba całkowita bez znaku zakodowana w formacie
mniejsze wyżej (big endian). Nie używając rozkazu BSWAP
załadować tę liczbę do rejestru EAX w formacie mniejsze
niżej (little endian).

```as
mov eax,[ebx]
xchg ah,al
rol eax,16
xchg ah,al
```

## 22
Napisać fragment programu w asemblerze, który
obliczy liczbę bitów o wartości 1 zawartych w rejestrze
EAX. Wynik obliczenia wpisać do rejestru CL.
```as
mov ecx,0
mov ebx,31
ptl:	bt eax,ebx
		adc cx,0; Add With Carry = suma dwóch operandów i flagi CF
		sub ebx,1
		cmp ebx,-1; koniec gdy sprawdzimy najmłodszy bit
		jnz ptl
```

## 23
Napisać fragment programu, w którym liczba 32-bitowa
bez znaku znajdująca się w rejestrze EAX zostanie
pomnożona przez 10 (dziesięć). Wynik mnożenia w postaci
liczby 32-bitowej powinien zostać wpisany do rejestru EAX.
Zakładamy, że mnożenie nie doprowadzi do powstania
nadmiaru. W omawianym fragmencie nie mogą być
używane rozkazy MUL lub IMUL. Wskazówka: wykorzystać
rozkazy przesunięć i zależność $a * 10 = a * 8 + a * 2$.

```as
shl eax,1; EAX = EAX*2
mov edx,eax; EDX = EAX*2
shl edx,2; EDX = EAX*2 *2^2 = EAX*8
add eax, edx; EAX = EAX*2 + EAX*8 = EAX*10
```

## 24
Ile bajtów zarezerwuje asembler na zmienne opisane
przez poniższe wiersze?
```cpp
v1 dq ?, ?
v2 dw 4 dup (?), 20
v3 db 10 dup (?)
```
*v1 = 2 x QWORD = 2 x 8B = 16B*\
*v2 = 5 x WORD = 5 x 2B = 10B*\
*v3 = 10 x BYTE = 10B*\
**Razem 36 bajtów.**

## 25
Na czym polega błąd w poniższym fragmencie
programu?
```as
const2 db ?
– – – – – – – – – – –
mov const2, 256
```
**Wartość 256 przekracza maks. wartość jednego bajtu, wynoszącą 255.**

## 26
Wyjaśnić działanie poniższego fragmentu programu
```ts
start: mov ecx, 3
sub ax, 10
loop start
```
**Program w nieskończonej pętli odejmuje wartość 10 od rejestru AX.**

## 27
Podać zawartość rejestru EIP po wykonaniu poniższej
sekwencji rozkazów
```as
mov edx, 347
xchg [esp], edx
ret
```
**347**

## 28
Dla podanych niżej dwóch rozkazów podać równoważny
ciąg rozkazów, w którym nie wystąpi rozkaz loop.
```ts
loop oblicz
oblicz: add dh, 7
```
```ts
sub ecx,1
;jnz oblicz niepotrzebne bo to i tak wykona się jako następna instrukcja
oblicz: add dh,7
```

## 29
Na czym polega błąd w podanym niżej zapisie rozkazu
```ps
mov byte PTR [eax], byte PTR [edx]
```
**Nie da się przesyłać MOV bezpośrednio z lokacji pamięci do innej lokacji pamięci.**

## 30
W pewnym programie została zdefiniowana zmienna
`wskaznik dd ?`. Napisać fragment programu w asemblerze, który wpisze do
tej zmiennej adres komórki pamięci, w której znajduje się ta
zmienna.

**MOV wskaznik, OFFSET wskaznik**

## 31
Jaka wartość zostanie wprowadzona do rejestru EDX po
wykonaniu podanego niżej fragmentu programu
```rb
linie dd 421, 422, 443,
dd 442, 444, 427, 432
— — — — — — — — — —
mov esi, (OFFSET linie)+4
mov ebx, 4
mov edx, [ebx] [esi]
```
*ESI=adres 2. elementu linie\
EBX=4\
EDX=[4 + adres 2. elementu linie]=[adres 3. elementu linie] = **443***

## 32
Napisać fragment programu w asemblerze, który
obliczy sumę cyfr dziesiętnych liczby zawartej w rejestrze
EAX. Wynik obliczenia wpisać do rejestru CL. Przykład:
jeśli w rejestrze EAX znajduje się liczba 1111101
(dziesiętnie 125), to po wykonaniu fragmentu rejestr CL
powinien zawierać 00001000.

```as
mov ecx,0
mov ebx,DWORD PTR 10
ptl:
	mov edx,0; zerowanie starszej części dzielnej
	div ebx; wynik w EAX, reszta w EDX
	add ecx,edx
	cmp eax,0
	jnz ptl; koniec gdy eax = 0
```

## 33
Określić postać komunikatu wyświetlanego przez
funkcję MessageBox po wykonaniu poniższego fragmentu
programu.
```cpp
napis db 'informatyka', 0, 4 dup (?)
— — — — — — — —

mov ecx, 12

przepisz: mov al, napis[ecx-1]
mov napis[ecx+3], al
loop przepisz
push 0
push OFFSET napis
lea eax, napis[3]
push eax
push 0
call _MessageBoxA@16
```

*Zamiany:\
12 napis[15]=napis[11]\
11 napis[14]=napis[10]\
10 napis[13]=napis[9]\
9 napis[12]=napis[8]\
8 napis[11]=napis[7]\
7 napis[10]=napis[6]\
6 napis[9]=napis[5]\
5 napis[8]=napis[4]\
4 napis[7]=napis[3]\
3 napis[6]=napis[2]\
2 napis[5]=napis[1]\
1 napis[4]=napis[0]*

*Czyli napis[4-15]=napis[0-11], a więc napis='infoinformatyka',0*

**tytul = 'infoinformatyka', tekst = 'oinformatyka', przycisk OK, okienko niemodalne**

## 34
W tablicy znaki znajduje się pewien tekst zakodowany
w formacie UTF–8. Tekst zakończony jest bajtem o
wartości 0. Napisać fragment programu w asemblerze, który
wyznaczy liczbę bajtów, które zajmować będzie ww. tekst
po zamianie na 16-bitowy format UTF-16. Obliczoną liczbę
bajtów wpisać do rejestru ECX. Przyjąć, że tekst w zawiera
znaki zakodowane na jednym, dwóch lub trzech bajtach.
Reguły kodowania opisuje poniższa tabela:

| Zakres   	  | Kodowanie UTF–8             |
|-------------|-----------------------------|
| 00H - 7FH   | 0xxxxxxx                    |
| 80H - 7FFH  | 110xxxxx 10xxxxxx           |
| 800H - FFFFH| 1110xxxx 10xxxxxx 10xxxxxx  |

```rb
mov esi,0
mov ecx,0
ptl: mov al, znaki[esi]
add ecx,2
cmp al,0
jz koniec
cmp al,0C0h
jb jednobajt
cmp al,0E0h
jb dwubajt
jmp trzybajt
jednobajt:
add esi,1
jmp ptl
dwubajt:
add esi,2
jmp ptl
trzybajt:
add esi,3
jmp ptl
koniec:
```

## 35
Podany poniżej podprogram dodaj sumuje dwie liczby
32-bitowe umieszczone bezpośrednio za rozkazem call,
który wywołuje ten podprogram. Obliczona suma
pozostawiana jest w rejestrze EAX.
```ts
dodaj PROC
mov esi, [esp]
mov eax, [esi]
add eax, [esi+4]
ret
dodaj ENDP
```
Przykładowe wywołanie podprogramu może mieć postać:
```ts
call dodaj
dd 5
dd 7
jmp ciag_dalszy
```
Wyjaśnić dlaczego wywołanie podanego podprogramu
może spowodować bliżej nieokreślone działania procesora,
prowadzące do błędu wykonania programu? Następnie, do
podanego kodu podprogramu wprowadzić dodatkowe
rozkazy, które wyeliminują ww. błędne działania.'

**Liczby podane w segmencie kodu zostaną zinterpretowane jako rozkazy i wykonane. Aby tego uniknąć, należy zwiększyć adres powrotu o 8.**
```as
pop edx
add edx,8
push edx
```

## 36
W programach obsługi kalendarza MS Visual Studio dni
świąteczne w miesiącu koduje się w postaci jedynek
umieszczonych na odpowiednich bitach słowa 32-bitowego.
Tablica zawierająca 12 takich elementów pozwala
zakodować informacje obejmujące rok.
Napisać podprogram w asemblerze wyświetlający na
ekranie daty dni świątecznych w podanym miesiącu.
Parametry wywołania podprogramu znajdują się w
rejestrach:\
CL – numer miesiąca (1 – 12)\
EBX – adres tablicy zawierającej zakodowane daty dni
świątecznych w poszczególnych miesiącach.

```as
wyswietl_swieta PROC
push ebp
mov ebp,esp
push ebx
push edi
push esi; odkładanie rejestrów
mov esi,10; potrzebne przy konwersji na ASCII
lea ebx,[ebx+4*ecx]; obliczanie adresu miesiąca
sub ebx,4
mov ebx,[ebx]; wczytywanie miesiąca
sub esp,770; rezerwacja bufora na tekst
mov edi,esp
mov ecx,1
ptl:
bt ebx,ecx; bit test: wartość n-tego bitu -> CF
jnc dalej
mov edx,0;konwersja na ASCII liczby dwucyfrowej
mov eax,ecx
div esi
add eax,48
mov [edi],al
add edx,48
mov [edi+1],dl
mov [edi+2],BYTE PTR 20h
add edi,3
dalej:
add ecx,1
cmp ecx,32
jne ptl
mov [edi],BYTE PTR 0Ah
sub edi,esp
mov esi,esp
push edi;liczba znaków
push esi;adres bufora
push 1; stdout
call __write
add esp,12; zwalnianie pamięci i przywrócenie rejestrów
add esp,770
pop esi
pop edi
pop ebx
pop ebp
ret
wyswietl_swieta ENDP
```

## 37
W pewnym programie używany jest rejestr 1024-bitowy,
który symulowany jest za pomocą tablicy rejestr1024,
zawierającej 128 bajtów.\
Napisać podprogram w asemblerze, który przesunie
zawartość tego rejestru cyklicznie o 1 pozycję w lewo, przy czym bit wychodzący zostanie także wpisany do znacznika CF (podobnie jak w rozkazie ROL).\
Wskazówki:\
a. Przyjąć, że tablica rejestr1024 została wcześniej
zdefiniowana w sekcji danych programu jako tablica 128-
bajtowa.\
b. Wykorzystać m.in. rozkazy SHL i RCL.\
c. W trakcie przenoszenia bitów z bajtu do bajtu za pomocą znacznika CF należy pamiętać, że znaczna liczba
rozkazów wpływa na stan tego znacznika, natomiast m.in.
rozkazy MOV, LOOP, INC, DEC nie wpływają na stan
CF.
```as
rol1024 PROC
push ebp
mov ebp,esp
push ebx
mov ebx, offset rejestr1024
mov ecx,128
movzx edx, BYTE PTR rejestr1024+127
bt edx,7; najstarszy bit -> CF
ptl:
rcl BYTE PTR [ebx],1; najmłodszy <- CF, najstarszy -> CF
inc ebx; nie zmienia CF
loop ptl
pop ebx
pop ebp
ret
rol1024 ENDP
```

## 38
Napisz podprogram zapisz5bitow, który
pobiera 5 najmłodszych bitów z rejestru AL i zapisuje je w pamięci począwszy od bajtu o adresie podanym w rejestrze EDI i bitu o numerze (7 – 0) podanym w rejestrze CL.\
Pozostałe bity w bieżącym bajcie i sąsiednim powinny pozostać niezmienione.

```as
push ebp
push ebx
mov ebp,esp
mov dx,[edi]; kopia bufora (słowo)
xchg dh,dl; zamiana na big endian
add cl,4;wpisywanie od starszego bajtu
and ax,01Fh; zachowanie tylko 5 najmłodszych bitów
shl ax,cl;przesunięcie bitów w dobre miejsce
mov bx,01Fh
shl bx,cl
not bx
and dx,bx;czyszczenie 5 bitów w buforze
or dx,ax;ustawienie 5 bitów w buforze gdzie AX był 1
xchg dh,dl; spowrotem little endian
mov [edi],dx
pop ebx
pop ebp
ret
```