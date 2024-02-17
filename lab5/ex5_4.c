#include <stdio.h>
extern void int2float(int* calkowite, float* zmienno_przec);
int main() {
	int a[2] = { -17, 24 };
	float r[4];
	int2float(a, r);
	printf("\nKonwersja = %f %f\n", r[0], r[1]);
}