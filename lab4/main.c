#include <stdio.h>
extern int sum(int count, ...);
 int main() {
	int count=0;
	int val[5] = { 0,0,0,0,0 };
	char tmp='0';
	int s;
	while (1) {
		tmp = getchar();
		if (tmp == ' ') {
			count++;
			if (count > 4) {
				printf("Zbyt wiele liczb!\n");
				return 1;
			}
			continue;
		}
		if (tmp == '\n') {
			if (val[count] != 0)
				count++;
			break;
		}
		val[count] *= 10;
		val[count] += tmp - '0';
	}
	switch (count) {
		case 0:
			s=sum(0);
			break;
		case 1:
			s=sum(1, val[0]);
			break;
		case 2:
			s=sum(2, val[0], val[1]);
			break;
		case 3:
			s=sum(3, val[0], val[1], val[2]);
			break;
		case 4:
			s=sum(4, val[0], val[1], val[2], val[3]);
			break;
		case 5:
			s=sum(5, val[0], val[1], val[2], val[3], val[4]);
			break;
	}
	printf("%d\n", s);
	return 0;
}