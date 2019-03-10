#include <stdio.h>
#include <stdlib.h> 
#include <stdbool.h>
#include "SDL2/SDL.h"
#include <SDL2/SDL_image.h>

int Menu(){
int choice;
printf("MENU:\n");
printf("1 - obrót obrazu. \n");
printf("2 - edycja kolorów obrazu. \n");
printf("3 - koniec. \n");
printf("Twój wybór: ");
scanf("%d",&choice);
return choice;
}
Uint32 Getpx(SDL_Surface *image, int x, int y){
int bpp=image->format->BytesPerPixel;
Uint8 *p=(Uint8 *)image->pixels+y*image->pitch+x*bpp;

switch(bpp){
case 1:
	return *p;
	break;
case 2:
	return *(Uint16 *)p;
	break;
default:
	return 0;
}
}
Uint32 Putpx(SDL_Surface *image, int x, int y, Uint32 pixel){
int bpp=image->format->BytesPerPixel;
Uint8 *p=(Uint8 *)image->pixels+y*image->pitch+x*bpp;

switch(bpp){
case 1:
	*p=pixel;
	break;
case 2:
	*(Uint16 *)p=pixel;
	break;
case 4:
	*(Uint32 *)p=pixel;
	break;
default:
	return 0;
}
}
int main(int argc, char *argv[]) {
	bool quit = false;
	int degrees;
	int option;
 
    SDL_Window * window = SDL_CreateWindow("Edycja obrazu za pomoca SDL",
        SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 640, 480, 0);
 
    SDL_Renderer * renderer = SDL_CreateRenderer(window, -1, 0);
    SDL_Surface * image = SDL_LoadBMP("image.bmp");
    SDL_Texture * texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_Event event;
option=Menu();
while(option!=3){ 
	quit=false;
	SDL_RenderCopy(renderer, texture, NULL, NULL);
	SDL_RenderPresent(renderer);

   if(option==1)
   {
	printf("podaj kąt obrotu: ");
	scanf("%d",&degrees);
	printf("Aby wrócić do MENU kliknij na wyświetlany obraz i przytrzymaj klawisz q. \n");

//petla utrzymuje obraz otwarty w oknie widocznym dla uzytkownika
while (!quit)
while(SDL_PollEvent(&event))
    {	
	SDL_RenderClear(renderer);
        SDL_WaitEvent(&event);
 	
        switch (event.type)
        {
	 case SDL_KEYDOWN:
 	 switch(event.key.keysym.sym){
            case SDLK_q:
                quit = true;
                break;
	 }
		break;
        } 
//do funkcji renderCopyEx przekazujemy kontekst graficzny, obraz, czesc obrazu zrodlowego, czesc obrazu docelowego, rodzaj odwracania
	SDL_RenderCopyEx(renderer, texture, NULL, NULL,degrees,NULL,SDL_FLIP_NONE);
        SDL_RenderPresent(renderer);
    }
   }
   else if(option==2)
   {//negatyw asm
     Uint32 px;
     int mask=-1;
/*
__asm__("movq %0, %%mm0;"
::"ym" (mask));
*/

     for(int i=0;i<image->h;i++){
	for(int j=0;j<image->w;j++){
//printf("tutaj \n");	
 px=Getpx(image,i,j);
	/* asm(
		"movq (%1), %%mm1;"
		"pxor %%mm0, %%mm1;"
		"movq %%mm1, (%0);"
		"pcmpeqd %%mm1, %%mm1;"
		:"=r" (px)
		:"r" (px) );
	Putpx(image, i, j, px); */
     }
	}


for (int i=0;i<image->h*image->pitch;i+=8){
asm("\
pcmpeqd %%mm1, %%mm1; \
movq (%0), %%mm1; \
pandn %%mm1, %%mm0; \
pxor %%mm1, %%mm0; \
movq %%mm0, (%0); \
" :: "r"(/*buf+*/i) : "memory", "%mm0");
}

   }
   else {
printf("Opcja nieprawidłowa! \n");
option=Menu();
}
	option=Menu();
}

//destruktory
    SDL_DestroyTexture(texture);
    SDL_FreeSurface(image);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
 
    SDL_Quit();

    return 0;
}
