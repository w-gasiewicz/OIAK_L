#include <stdio.h>
#include <stdlib.h>
#include <float.h>

int returnFPU();

int main(){
float n1=5.0;
float n2=0.0;

//float m1=FLT_MAX;
//float m2=FLT_MAX;
char c='a';
int x=0;
float result=0.0;
printf("Start... \n");
//printf("Stan wyjatkow przed dzialaniem: \n");
//x=returnFPU();
//printf("%d \n", x);
result = n1/n2;
//result=m1+m2;
printf("Wynik= %f\n", result);
x=returnFPU();
printf("Stan wyjatkow po dzialaniu: \n");
printf("%d \n",x);
printf("Wstawka: \n");
asm(
"mov $0, %eax;"
"fstsw %ax;"
);



return 0;
}
