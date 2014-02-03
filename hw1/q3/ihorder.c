/* Runyun Zhang - 15826 Fall 2013 */
#include <stdio.h>
#include <stdlib.h>
 
void rotate(int n, int *x, int *y, int rx, int ry) {
    if (ry == 0) {
        if (rx == 1) {
            *x = n-1 - *x;
            *y = n-1 - *y;
        }
 
        //Swap x and y
        int t  = *x;
        *x = *y;
        *y = t;
    }
}
 
void ihorder(int n, int d, int *x, int *y) {
    int rx, ry, s, t=d;
    *x = *y = 0;
    for (s=1; s<n; s*=2) {
        rx = 1 & (t/2);
        ry = 1 & (t ^ rx);
        rotate(s, x, y, rx, ry);
        *x += s * rx;
        *y += s * ry;
        t /= 4;
    }
}

int main(int argc, char* argv[])
{
    unsigned int n;
    unsigned int x, y;
    unsigned int h;

    if(argc < 4)
    {
        printf("zorder -n <order-of-curve> <hvalue>\n");
        exit(0);
    }

    n = atoi(argv[2]);
    h = atoi(argv[3]);
    
    ihorder(1<<n, h, &x, &y);
    printf("%d %d\n", x, y);

    return 0;
}