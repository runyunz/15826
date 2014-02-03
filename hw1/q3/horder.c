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
 
int horder (int n, int x, int y) {
    int rx, ry, s, d=0;
    for (s=n/2; s>0; s/=2) {
        rx = (x & s) > 0;
        ry = (y & s) > 0;
        d += s * s * ((3 * rx) ^ ry);
        rotate(s, &x, &y, rx, ry);
    }
    return d;
}

int main(int argc, char* argv[])
{
    unsigned int n;
    unsigned int x, y;
    unsigned int h;

    if(argc < 5)
    {
        printf("zorder -n <order-of-curve> <xvalue> <yvalue>\n");
        exit(0);
    }

    n = atoi(argv[2]);
    x = atoi(argv[3]);
    y = atoi(argv[4]);
    
    h = horder(1<<n, x, y);
    printf("%d\n", h);

    return 0;
}