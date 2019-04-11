#include <stdio.h>
char str[] = "AbCdEfGh";
const int len = 8;
 
int main(void)
{
    asm(
    "mov $0, %%rbx \n"  
    "petla: \n" 
    "mov (%0, %%rbx, 1), %%al \n"
    "and $223, %%al \n" 
    "add $32, %%al \n"  
    "mov %%al, (%0, %%rbx, 1) \n" 
    "inc %%rbx \n"    
    "cmp len, %%ebx \n" 
    "jl petla \n"
    :  
    :"r"(&str) 
    :"%rax", "%rbx"
    );
 
    printf("Wynik: %s\n", str);
    return 0;
}
