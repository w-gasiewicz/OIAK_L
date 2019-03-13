#include <stdio.h>
#include <stdlib.h> 
#include <stdbool.h>
#include "SDL2/SDL.h"
#include <SDL2/SDL_image.h>

void bright(unsigned char * in, unsigned char * out, int iterations);
void dark(unsigned char *in, unsigned char *out, int iterations);

int Menu(){
int choice;
printf("MENU:\n");
printf("1 - obrót obrazu. \n");
printf("2 - rozjaśnienie obrazu. \n");
printf("3 - przyciemnienie obrazu. \n");
printf("0 - koniec. \n");
printf("Twój wybór: ");
scanf("%d",&choice);
return choice;
}

int main(int argc, char *argv[]) {
	bool quit = false;
	int degrees;
	int option;
 	int iterations;

    SDL_Window * window = SDL_CreateWindow("Edycja obrazu za pomoca SDL",
        SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 640, 480, 0);
 
    SDL_Renderer * renderer = SDL_CreateRenderer(window, -1, 0);
    SDL_Surface * image = SDL_LoadBMP("image.bmp");
    SDL_Texture * texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_Event event;

    unsigned pixels=image->w * image->h;
    unsigned bytes=pixels * image->format->BytesPerPixel;
    unsigned char * tempBuf= calloc(pixels, image->format->BytesPerPixel);
    iterations=image->w * image->h * image->format->BytesPerPixel;

printf("Właściwości obrazu: \n");
printf("Bity na pixel: %i \n",image->format->BitsPerPixel);
printf("Bajty na pixel: %i \n",image->format->BytesPerPixel);
printf("Szerokość: %d Wysokość: %d \n",image->w, image->h);

option=Menu();
while(option!=0){ 
	quit=false;
	
   if(option==1)
   {
SDL_RenderCopy(renderer, texture, NULL, NULL);
	SDL_RenderPresent(renderer);

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
   {//rozjasnienie obrazu
SDL_LockSurface(image);

bright(image->pixels,tempBuf,iterations/8);

memcpy(image->pixels,tempBuf,iterations);
texture = SDL_CreateTextureFromSurface(renderer, image);

SDL_UnlockSurface(image);

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
	SDL_RenderCopy(renderer, texture, NULL, NULL);
        SDL_RenderPresent(renderer);
    }

   }
else if(option==3)
   {//przyciemnienie obrazu
SDL_LockSurface(image);

dark(image->pixels,tempBuf,iterations/8);

memcpy(image->pixels,tempBuf,iterations);
texture = SDL_CreateTextureFromSurface(renderer, image);

SDL_UnlockSurface(image);

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
	SDL_RenderCopy(renderer, texture, NULL, NULL);
        SDL_RenderPresent(renderer);
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
    free(tempBuf);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
 
    SDL_Quit();
printf("Program poprawnie zakończył działanie. \n");
    return 0;
}
