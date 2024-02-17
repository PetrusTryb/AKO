#include <stdio.h>
extern float nowy_exp(float x);
int main() {
	for (float i = 0; i <= 10; i++) {
		float result = nowy_exp(i);
		printf("%f: %f\n", i, result);
	}
	return 0;
}