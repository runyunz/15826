/* Runyun Zhang - 15826 Fall 2013 */
#include <stdio.h>
#include <stdlib.h>

int part1by1(unsigned int n)
{
	n&= 0x0000ffff;
	n = (n | (n << 8)) & 0x00FF00FF;
	n = (n | (n << 4)) & 0x0F0F0F0F;
	n = (n | (n << 2)) & 0x33333333;
	n = (n | (n << 1)) & 0x55555555;
	return n;
}

int zorder(unsigned int x, unsigned int y)
{
	return (part1by1(y) | (part1by1(x) << 1));
}

int main(int argc, char* argv[])
{
	unsigned int n;
	unsigned int x, y;
	unsigned int z;

	if(argc < 5)
	{
		printf("zorder -n <order-of-curve> <xvalue> <yvalue>\n");
		exit(0);
	}

	n = atoi(argv[2]);
	x = atoi(argv[3]);
	y = atoi(argv[4]);
	
	z = zorder(x, y);
	printf("%d\n", z);

	return 0;
}