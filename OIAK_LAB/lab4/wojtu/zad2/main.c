#include <stdio.h>
#include <limits.h>
#include <float.h>

void print_bits(double);

// changing precision changes only the significand size, not the exponent size!

int main(){
    double a = 3.0;
    decrease_precision();
    a = 1.0/a;
    printf("Single precision (sig 24b): ");
    print_bits(a);
    a = 3.0;
    increase_precision();
    a = 1.0/a;
    printf("Double precision (sig 53b): ");
    print_bits(a);
}

void print_bits(double d)
{
    unsigned long long *double_as_int = (unsigned long long *)&d;
    int i;

    for (i=0; i<=64; i++){
        if (i==1)
            printf(" "); // Space after sign field
        if (i==11)
            printf(" "); // Space after exponent field
        if ((*double_as_int >> (63-i)) & 1)
            printf("1");
        else
            printf("0");
    }
        printf("\n");
}
