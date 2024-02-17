<style>@media print{.katex-html{display:none;}}</style>
# Egzamin
## Zadania obliczeniowe (z zadań przykładowych)

1. W komórkach pamięci operacyjnej o adresach `0x00430F74` i `0x00430F75` została zapisana liczba `1025` w postaci 16-bitowej liczby binarnej. Podać zawartość tych komórek w postaci binarnej przy założeniu, że w komputerze stosowana jest konwencja mniejsze wyżej (big endian). W komputerze stosowana jest pamięć o organizacji bajtowej.\
*1025=1024+1=00000100 00000001*\
**0x00430F74=starsza część=00000100\
0x00430F75=młodsza część=00000001**

2. Przyjmując, że opcode operacji skoku warunkowego jest równy 72h podaj kod
rozkazu jc $-6 jako liczbę szesnastkową\
*Rozmiar rozkazu = 2 bajty, więc argument = -8 = 1111 1000*\
**A więc: 72h F8h**

3. Podaj rozmiar pamięci podręcznej o adresowaniu bezpośrednim, czterokanałowej, jeśli adresowanie jest 24-bitowe (etykieta ma 16 bitów, a offset 4 bity).
*Nr linii = 24-16-4 = 4 bity -> 16 linii\
Offset 4 bity -> w każdej linii po 16 bajtów*\
**Rozmiar = liczba linii * pojemność linii * liczba kanałów = 16*16*4 = 1024B**

4. Podać numer linii i wartość etykiety, które należy sprawdzić w pamięci podręcznej o
adresowaniu bezpośrednim przy wykonaniu sekwencji rozkazów\
`mov esi, 10195fc0h`\
`mov al, [esi]`\
Adresowanie 32 bitowe, rozmiar pamięci podręcznej 256 kB, rozmiar linii 32 bajty.\
*Liczba bitów adresu na offset: $log_232=5$\
Liczba linii: $256*1024/32=8192$ -> liczba bitów na zaadresowanie linii: $log_28192$=13\
Długość etykiety = 32-13-5=14\
Adres: 10195fc0h = 00010000 000110|01 01011111 110|00000*\
**Wartość etykiety: 0406h\
Nr linii: 0afeh**

5. Chcemy osiągnąć liniowe przyspieszenie używając 12 procesorów. Jaki procent oryginalnych obliczeń może być przeprowadzany sekwencyjnie?\
*Dzielimy zadania na 12 równych części, z czego jedna sekwencyjnie: 1/12 =* **8,33%**

6. W czterech kolejnych bajtach zapisano kod znaku UTF 16 w formacie Little Endian.
Wyznacz 21 bitową wartość punktu kodowego tego znaku

	| adres | wartość |
	|------|---------|
	| k+3  |   DC    |
	| k+2  |   05    |
	| k+1  |   D8    |
	| k+0  |   3D    |

	*DC05D83D = [110111]00 00000101 [110110]00 00111101*\
**Punkt kodowy: 0000111101 0000000101 + 10000h = 1F405h**

7. W trybie 16 bitowym pod adresem fizycznym 12345 h znajduje się nowa procedura obsługi przerwania klawiatury (nr 9, IRQ1). Podaj sekwencję rozkazów, która nadpisze w tablicy wektorów przerwań właściwe wartości.
*12345h = SEGx16+OFFSET\
A więc: SEG=1234h, OFFSET=5h\
Segment (młodszy) wpisujemy pod 9*4 = 36\
Offset (starszy) wpisujemy pod 9*4+2=38*\
**mov ax,1234h\
mov bx,0005h\
cli\
mov ds:[36],bx\
mov ds:[38],ax\
sti**

8. Co będzie w rejestrze MM0 po wykonaniu rozkazu PADDUSB MM0, MM1
(sumowanie rejestrów z nasyceniem). W rejestrach były wartości:\
`MM0 = F7 F8 FA FC FB FC FD FE`\
`MM1 = 06 06 06 06 03 03 03 03`\
*Sumujemy bajty ze sobą, z tym że nie ma przeniesienia tylko po prostu FF.*\
**`MM0 = FD FE FF FF FE FF FF FF`**

9. Podać maksymalną wielkość pamięci fizycznej RAM, jeśli zastosowano 40 bitową szynę adresową.\
**$2^{40}B=(2^{10})^4B=1024^4B=1024^3KB=1024^2MB=1024GB=1TB$**

10. Jaki jest całkowity rozmiar pamięci podręcznej, która pomieści 8 KB danych w liniach o wielkości 8B zakładając 32 bitowy adres? Jak wygląda adres takiej pamięci?\
*Linie 8B -> **bity na offset: $log_28=$ 3**\
Liczba linii: $8*2^{10}:8=2^10$ -> **bity na nr linii: 10**\
**Bity na etykietę: 32-10-3=19**
*Całk. rozmiar = pojemność + liczba linii(rozm.\ etykiety + bit V)=8kB + 1024*(20b) = 64kb + 20kb = **84kb = 10,5kB***

## Egzaminy z eNauczania
1. W komunikacji komputera z klawiaturą:\
1.1. Mikrokontroler klawiatury na podstawie odczytu z matrycy i wyjścia z multipleksera odczytuje **kod pozycji (scan code)**.\
1.2.Mikrokontroler klawiatury formuje **kod naciśnięcia**, który dociera do układu na płycie głównej komputera (mikrokontroler, np. 8042 lub 8741 lub 8742).\
1.3.Ten z kolei (np. 8042) odtwarza oryginalny
**kod pozycji (scan code)** i udostępnia go w porcie 60H.\
*Kod pozycji (scan code) - 8-bitowy kod przyporządkowany każdemu przyciskowi klawiatury.
System numeracji obejmuje także klawisze sterujące i funkcyjne.
Po naciśnięciu lub zwolnieniu dowolnego klawisza mikrokontroler klawiatury
formuje kod naciśnięcia (ang. make code) lub kod zwolnienia (ang. break code) klawisza — kod
ten zostaje przesłany szeregowo do układów płyty głównej komputera.*

2. Załóżmy, że istnieje procesor, który działa na rejestrach 6 bitowych oznaczanych symbolami r0,r1. Wyznaczanie znaczników w operacjach
arytmetycznych jest zgodne z architekturą x86. Określić zawartości znaczników OF, ZF i CF po wykonaniu podanego niżej fragmentu programu.\
`move r0,101010b`\
`add r0, 111110b`\
*r0' = 101000b*\
**CF = najstarsze przeniesienie = 1**\
**ZF = czy wynik równy zero = 0**\
**OF = suma modulo 2 przeniesienia do najstarszego bitu i z najstarszego bitu = 0**

3. Bezpośrednio przed wykonaniem rozkazu POP EAX rejestr ESP miał wartość 0F430D79H. Na podstawie poniższego rysunku podaj w postaci liczby
szesnastkowej (bez odstępu pomiędzy symbolami i bez znaku H na końcu) zawartość rejestru EAX po wykonaniu podanego rozkazu POP.

	|  wartość  |  adres  |
	|-----------|---------|
	| 10000000  |0F430D7CH|
	| 00000000  |0F430D7BH|
	| 00000000  |0F430D7AH|
	| 00000010  |0F430D79H|
	| 00000000  |0F430D78H|
	| 11111110  |0F430D77H|
	| 10000001  |0F430D76H|

	*POP najpiew zdejmuje wartości (zgodnie z Little Endian), a potem zwiększa rejestr ESP, wskazujący na wierzchołek stosu.*\
	**80000002**

4. Przyjmując, że opcode operacji skoku warunkowego jest równy 7Ch, podaj kod rozkazu `jl $-13`\
*Rozkaz zajmuje 2 bajty, więc skok o -15 (11110001b) bajtów:* **7C F1**

5. Czy i jeśli tak, to w jaki sposób można zablokować przyjmowanie przerwań sprzętowych oraz wyjątków przez procesor?
**Przerwania maskowalne można zablokować poprzez ustawienie znacznika IF na 0 (`CLI`). Należą do nich przerwania urządzeń podłączonych do APIC. Wyjątków nie można maskować.**

6. Pewien znak reprezentowany jest w formacie UTF–8 przez dwa bajty `C5H` i `B8H`. Podać kod tego znaku w standardzie Unicode w postaci 16-bitowej.
Wskazówka: znaki Unicode z przedziału 80H - 7FFH kodowane są w UTF–8 w postaci 110xxxxx 10xxxxxx.\
*C5h B8h = [110]00101 [10]111000*\
**00000001 01111000 = U+0178**

7. W programie używane są dwa 4 kilobajtowe (4096) obszary pamięci A i B, których początek wskazują, odpowiednio, rejestry ESI i EDI (ESI < EDI, obszary nachodzą na siebie). Napisać fragment programu w asemblerze, który korzystając z rozkazu MOVSW prześle zawartość obszaru A do obszaru B.\
Wskazówka:
rozkaz CLD zeruje znacznik DF, a rozkaz STD wpisuje 1 do tego znacznika.\
*Działanie MOVSW: Kopiuje Word spod adresu ESI do EDI, a następnie zwiększa (a przy DF = 1 zmniejsza) obydwa rejestry o 2.Można zwierokrotnić MOVSW dodając REP (wykonuje się dopóki ECX nie równy 0).*\
**ADD ESI,4094\
ADD EDI,4094\
MOV ECX,2048\
SLD\
REP MOVSW**

8. Omówić działanie mechanizmu maskowania wyjątków w koprocesorze arytmetycznym.\
**Wyjątki maskujemy poprzez ustawianie odpowiednich flag w rejestrze sterującym koprocesowa. Służy do tego rozkaz `FLDCW`.**

9. Wyjaśnić, dlaczego asembler traktuje rozkaz add [esi-4*edi+14], al jako błędny?
**Nie jest znany rozmiar liczby pod wskazanym adresem.Trzeba użyć BYTE PTR. Mnożnikiem mogą być tylko liczby: 1, 2, 4 i 8 (dodatnie).**

10. Rozkaz RET można zastąpić dwoma rozkazami (patrz poniżej). Podać postać pierwszego z tych rozkazów.\
**pop ebx** *;zdejmuje ślad ze stosu*\
jmp ebx

11. Ile linii adresowych potrzebnych jest do adresowania fizycznego pamięci 64 GB, zakładając, że magistrala danych jest 64 bitowa i jednocześnie odczytujemy całe bloki danych z pamięci fizycznej do pamięci podręcznej (tzn. nie musimy odczytywać pojedynczego bajtu z pamięci fizycznej i możemy zignorować najmłodsze bity adresu)?
*Potrzeba tyle linii co dla $64GB/8B=8GB$\
$8GB=8*(2^{10})^{3}=2^{33}$*\
**A więc potrzeba 33 linii adresowych.**

12. Na czym polega błąd w podanym niżej zapisie rozkazu
`movzx dword ptr PTR [eax], byte PTR [edx]`?\
**MOVZX jako pierwszy argument przyjmuje wyłącznie rejestry (16-64 bitowe).**

13. Procesor znajduje się w trakcie wykonywania cyklu rozkazowego. Wymienić główne działania jakie podejmuje procesor po nadejściu sygnału przerwania sprzętowego.
**Dokończy wykonywanie obecnego rozkazu, zapisze flagi i ślad na stos, przejdzie do procedury zapisanej w odpowiednim wektorze przerwania.**

14. Wyjaśnić, dlaczego assembler traktuje rozkaz `mul dword ptr [esi+ax-123]` jako błędny.\
**Rejestry bazowy i indeksowy muszą być tego samego rozmiaru, zgodnego z trybem pracy procesora (dla x86 32 bity).**

15. Pewien znak reprezentowany jest w formacie UTF–8 przez dwa bajty `C4H` i `98H`. Podać kod tego znaku w standardzie Unicode w postaci 16-bitowej.
Wskazówka: znaki Unicode z przedziału 80H - 7FFH kodowane są w UTF–8 w postaci 110xxxxx 10xxxxxx.\
*C4h 98h = [110]00100 [10]011000*
**=U+0118**

16. Jaki wpływ na wykonywanie niektórych rozkazów może mieć przedrostek `REPNE` (kod F2h)?\
**Będą się wykonywać dopóki flaga ZF nie będzie ustawiona lub ECX nie będzie równy 0.**

17. Podziel liczbę float zapisaną w rejestrze EAX przez 32. Nie używaj rozkazów koprocesora.\
*Float: |Znak 1 bit|Wykł. 8 bitów|Mantysa 23 bity\
Liczba = $(-Znak)*Mantysa*2^{Wykładnik}$, wystarczy odjąć 5 od wykładnika*\
**ror eax,23;AL=wykładnik\
sub al,5\
rol eax,23**

18. Pewien znak reprezentowany jest w formacie UTF–8 przez dwa bajty `C5H` i `B9H`. Podać kod tego znaku w standardzie Unicode w postaci 16-bitowej.
Wskazówka: znaki Unicode z przedziału 80H - 7FFH kodowane są w UTF–8 w postaci 110xxxxx 10xxxxxx.\
*C5h B9h = [110]00101 [10]111001*
**=U+0179**

19. W jaki sposób procesor odróżnia rozkazy wykonywane na operandach 16- i 32- bitowych.**W trybie 32-bit. rozkazy wykonywane na operandach 16-bitowych są poprzedzone przedrostkiem 66h**

20. Przyjmując, że opcode operacji skoku warunkowego jest równy 72h podaj kod
rozkazu jb $+4 jako liczbę szesnastkową\
*Rozmiar rozkazu to dwa bajty, więc argument = 2.*\
**A więc: 72h 02h**

21. Ile linii adresowych potrzebnych jest do adresowania fizycznego pamięci 128 GB, zakładając, że magistrala danych jest 64 bitowa i jednocześnie odczytujemy całe bloki danych z pamięci fizycznej do pamięci podręcznej (tzn. nie musimy odczytywać pojedynczego bajtu z pamięci fizycznej i możemy zignorować najmłodsze bity adresu)?
*Potrzeba tyle linii co dla $128GB/8B=16GB$\
$16GB=16*(2^{10})^{3}=2^{34}$*\
**A więc potrzeba 34 linii adresowych.**