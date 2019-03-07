// kompilacja ---------------------
// gcc casmc.c casma.s -o casm
// ./casmc 
// gcc -m32 sum-tab-asm.c rdtsc32.s sum-tab-asm.s -o sum-tab-asm kompilacja z rdtsc32
#include <stdio.h>
#include <stdlib.h> 
#include <time.h>
#define MAX 100000 
int tab[MAX]; 
long long qua;
/* prototype for asm function */
int  * pow1();
int *pow2();
int *pow3();
 unsigned long long rdtsc() ; 

int main() {
 // int  fren[5]={ 1, 2, 3, 4, 5 };
int suma = 0; 
long long t1,t2;
int i; 
srand(time(NULL));
printf("Podaj ilość elementów tablicy do wygenerowania: ");
scanf("%llu", &qua);
printf("Ilość elementów w tablicy do testu: %llu\n",qua);
for(int j=0;j<0xFFFF;j++){
  //printf("Tablica przed wywolaniem: %d %d %d %d %d\n",fren[0],fren[1],fren[2],fren[3],fren[4]);
for(i=0;i<qua;i++) {tab[i] = (int) (10.0*rand()/(RAND_MAX+1.0));} 
t1 = rdtsc();
  /* call the asm function */
  //asm_mod_array(fren, 5);
asm_mod_array(tab,qua);
 t2 = rdtsc();
  t2 = t2 -t1; 
}
 // printf("Po wywolaniu: %d %d %d %d %d\n",fren[0],fren[1],fren[2],fren[3],fren[4]);
printf("Wynik= %d czas: %llu\n",tab[qua-1],t2); //%d - signed decimal %llu - long long unsigned 
  return 0;
}
