#include <stdio.h>
extern void suma_wektorow(char*, char*);
int main() {
	char liczby_A[16] = { -128, -127, -126, -125, -124, -123, -122, -121, 120, 121, 122, 123, 124, 125, 126, 127 };
	char liczby_B[16] = { -3, -3, -3, -3, -3, -3, -3, -3, 3, 3, 3, 3, 3, 3, 3, 3 };
	suma_wektorow(&liczby_A[0], &liczby_B[0]);
	for (int i = 0; i < 16; i++)
	{
		printf("%d ", liczby_A[i]);
	}
	return 0;
}