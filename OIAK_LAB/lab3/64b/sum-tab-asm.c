// gcc -m32 sum-tab-asm.c rdtsc32.s sum-tab-asm.s -o sum-tab-asm kompilacja z rdtsc32
#include <stdio.h>
#include <stdlib.h> 
#include <time.h>  

//prototypy funkcji z assemblera
 unsigned long long rdtsc() ; 
 unsigned long long asm_mod_array64(int tab[],int qua);

int sum(int tab[], int qua){
  int sum=0;
	for(int i=0;i<qua;i++)
	{
		sum+=tab[i];
	}
return sum;
}
void SumASM(int tab[], int qua){
asm_mod_array64(tab,qua);
}
int main() {
int suma = 0; 
long long t1,t2,qua;

srand(time(NULL));
printf("Podaj ilość elementów tablicy do wygenerowania: ");
scanf("%llu", &qua);
int tab[qua];

 t1 = rdtsc();
	for(int i=0;i<qua;i++) {
		tab[i] = (int) (10.0*rand()/(RAND_MAX+1.0));
	} 

 t2 = rdtsc();
 t2 = t2 -t1; 
 printf("Ilość cykli na wypełnienie tablicy: %llu\n",t2);

 t1 = rdtsc();  
 suma=sum(tab,qua);
 t2 = rdtsc();
 t2 = t2 -t1; 

printf("Wynik= %d Ilość cykli na zsumowanie tablicy w c: %llu\n",suma,t2);

 t1 = rdtsc();  
SumASM(tab,qua);
 t2 = rdtsc();
 t2 = t2 -t1; 

printf("Wynik= %d Ilość cykli na zsumowanie tablicy w asm: %llu\n",tab[qua-1],t2); //%d - signed decimal %llu - long long unsigned 
 
  return 0;
}
