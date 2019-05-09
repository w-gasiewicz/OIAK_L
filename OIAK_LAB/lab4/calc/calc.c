#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <float.h>
 
double suma(double a, double b);
double roznica(double a, double b);
double mnozenie(double a, double b);
double dzielenie(double a, double b);
double pierwiastek(double a);
double sinus(double a);
void print_bits(unsigned short);
void reset_fpu();
unsigned short status_world();
 
double a = 6.8;
double b = 4.5;
double wynik_suma, wynik_roznica, wynik_mnozenie, wynik_dzielenie, wynik_pierwiastek, wynik_sinus;
int wybor; 
int main() {
  printf("Start\n") ;

while(wybor!=7){
printf("Podaj liczbe A:\n");
	scanf("%lf", &a);
printf("Podaj liczbe B:\n");
	scanf("%lf", &b);

printf("Wybierz operacje:\n1-sumowanie\n2-odejmowanie\n3-Mnozenie\n4-dzielenie\n5-pierwiastkowanie liczby A\n6-sinus liczby A\n7-koniec\n");
	printf("opcja: ");
	scanf("%d", &wybor);

if(wybor==1)
{
 wynik_suma = suma(b,a);
  printf(" %f + %f = %f\n",a,b,wynik_suma);
printf("stan rejestru wyjatkow: ");
    print_bits(status_word());
    reset_fpu();
}
else if(wybor==2)
 { wynik_roznica = roznica(a,b);
  printf(" %f - %f = %f\n",a,b,wynik_roznica);
printf("stan rejestru wyjatkow: ");
    print_bits(status_word());
    reset_fpu();
}
else if(wybor==3)
 { wynik_mnozenie = mnozenie(a,b);
  printf(" %f * %f = %f\n",a,b,wynik_mnozenie);
printf("stan rejestru wyjatkow: ");
    print_bits(status_word());
    reset_fpu();
}
else if(wybor==4)
{  wynik_dzielenie = dzielenie(a,b);
  printf(" %f / %f = %f\n",a,b,wynik_dzielenie);
printf("stan rejestru wyjatkow: ");
    print_bits(status_word());
    reset_fpu();
}
else if(wybor==5)
 { wynik_pierwiastek = pierwiastek(a);
  printf(" sqrt(%f) = %f\n",a,wynik_pierwiastek);
printf("stan rejestru wyjatkow: ");
    print_bits(status_word());
    reset_fpu();
}
else if(wybor==6)
 { wynik_sinus = sinus(a);
  printf(" sin(%f) = %f\n",a,wynik_sinus);
printf("stan rejestru wyjatkow: ");
    print_bits(status_word());
    reset_fpu();
}
else if(wybor==7)
{
printf("Program pomyslnie zakonczyl dzialanie!");
}
else
printf("Nie ma wybranej opcji w menu!");
} 
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
