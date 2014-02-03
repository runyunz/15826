/* Runyun Zhang - 15826 Fall 2013 */
#include <stdio.h>
#include <stdlib.h>

int unpart1by1(unsigned int n)
{
	n&= 0x55555555;
	n = (n ^ (n >> 1)) & 0x33333333;
	n = (n ^ (n >> 2)) & 0x0f0f0f0f;
	n = (n ^ (n >> 4)) & 0x00ff00ff;
	n = (n ^ (n >> 8)) & 0x0000ffff;
	return n;
}

void izorder(unsigned int z, unsigned int* x, unsigned int* y)
{
	*x = unpart1by1(z >> 1);
	*y = unpart1by1(z);
}

int main(int argc, char* argv[])
{
	unsigned int n;
	unsigned int x, y;
	unsigned int z;

	if(argc < 4)
	{
		printf("izorder -n <order-of-curve> <zvalue>\n");
		exit(0);
	}

	n = atoi(argv[2]);
	z = atoi(argv[3]);

	izorder(z, &x, &y);

	// printf("x: %d\n", x);
	// printf("y: %d\n", y);
	printf("%d %d\n", x, y);

	return 0;
}