#include <stdio.h>
extern int szukaj4_max(int a, int b, int c, int d);
int main() {
	int a, b, c, d;
	printf("Podaj 4 liczby: ");
	scanf_s("%d %d %d %d", &a, &b, &c, &d);
	int max = szukaj4_max(a, b, c, d);
	printf("%d", max);
	return 0;
}