#include <stdio.h>
#include <limits.h>
#include <float.h>

void print_bits(unsigned short);

int main(){
    int a = 5;
    print_bits(status_word());
    print_bits(div_zero());
    reset_fpu();
    print_bits(status_word());
    long double b = LDBL_MAX *2;
    print_bits(status_word());
}

void print_bits(unsigned short number) {
    int i = 0;
    int buf[16];
    for(;i<16;++i) {
        printf("%d", number & SHRT_MAX + 1 ? 1 : 0); 
        number = number << 1;
    }
    printf("\n");
}
