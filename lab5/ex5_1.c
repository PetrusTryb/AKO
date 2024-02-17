#include <stdio.h>
#include <stdlib.h>
extern float srednia_harm(float* tablica, unsigned int n);
int main() {
	unsigned int count;
	scanf_s("%d", &count);
	if (count == 0) {
		fprintf(stderr, "%s", "0 piv encounterd!");
		return 1;
	}
	float* procInputVector = malloc(count*sizeof(float));
	for (int i = 0; i < count; i++)
	{
		scanf_s("%f", &procInputVector[i]);
	}
	float m = srednia_harm(&procInputVector[0], count);
	printf("Srednia: %f\n", m);
	return 0;
}