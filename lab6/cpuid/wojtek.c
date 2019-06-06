#include <stdio.h>

extern unsigned int cpuid(int rejestr);


int main()
{
	unsigned int rejestr = 1;
	unsigned int informacje = 0;

	printf("Prosze podac cyfre:\n1-Informacja o wersji procesora\n2-Liczba rdzeni, identyfikacja kontrolera przerwań\n3-Wyposażenie procesora rozszerzenia\n4-Wyposażenie procesora\n0-Wyjście\n");
	scanf("%d", &rejestr);
	
while(rejestr!=0){	
	informacje = cpuid(rejestr);
		
	printf("%u\n", informacje);

	printf("Prosze podac cyfre:\n1-Informacja o wersji procesora\n2-Liczba rdzeni, identyfikacja kontrolera przerwań\n3-Wyposażenie procesora rozszerzenia\n4-Wyposażenie procesora\n0-Wyjście\n");
	scanf("%d", &rejestr);
}
printf("Poprawnie zakończono pracę aplikacji \n");
	return 0;
	}
