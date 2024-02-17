#include <stdio.h>
#include <stdlib.h>
extern __int64 suma_siedmiu_liczb(__int64 v1, __int64 v2, __int64 v3, __int64 v4, __int64 v5, __int64 v6, __int64 v7);
extern wchar_t* convert_to_bin(unsigned long long liczba);

int main() {
	__int64 tab[7];
	for (int i = 0; i < 7; i++)
	{
		printf("Podaj liczbe nr %d: ",i);
		scanf_s("%I64d", &tab[i]);
	}
	__int64 suma = suma_siedmiu_liczb(tab[0], tab[1], tab[2], tab[3], tab[4], tab[5], tab[6]);
	printf("%I64d", suma);
	wchar_t* bin = convert_to_bin(suma);
	_putws(bin);
	free(bin);
	return 0;
}