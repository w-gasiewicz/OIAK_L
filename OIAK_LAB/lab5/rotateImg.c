// kompilacja ---------------------
// gcc casmc.c casma.s -o casm
// ./casmc 
// gcc -m32 sum-tab-asm.c rdtsc32.s sum-tab-asm.s -o sum-tab-asm kompilacja z rdtsc32
#include <stdio.h>
#include <stdlib.h> 
#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>

int main() {
FILE *image;
int width,height;

image=fopen("image.png","r");
fscanf(image,"%d%d", &width, &height);

	printf("Width= %d height= %d",width, height); 
 
fclose(image);
 return 0;
}
