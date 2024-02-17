#include <stdio.h>
extern void liczba_przeciwna(int* a);
int main() {
	int x;
	scanf_s("%d", &x);
	liczba_przeciwna(&x);
	printf("%d", x);
	return 0;
}