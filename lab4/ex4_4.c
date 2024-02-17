#include <stdio.h>
#include <stdlib.h>
void przestaw(int tabl[], int n);
int main() {
	int n;
	printf("Podaj liczbe elementow: ");
	scanf_s("%d", &n);
	int* tab = (int*)malloc(n*sizeof(int));
	for (int i = 0; i < n; i++) {
		printf("\nPodaj element nr %d: ",i);
		scanf_s("%d",&tab[i]);
	}

	for (int i = 0; i < n; i++)
	{
		przestaw(&tab[0], n - i);
	}

	for (int i = 0; i < n; i++)
	{
		printf("%d ", tab[i]);
	}
	return 0;
}