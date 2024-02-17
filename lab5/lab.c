#include <stdio.h>
extern double cysterna(double l, double d);
int main() {
	double L;
	double D;
	scanf_s("%lf %lf", &L, &D);
	double wynik = cysterna(L, D);
	printf("%lf\n", wynik);
}