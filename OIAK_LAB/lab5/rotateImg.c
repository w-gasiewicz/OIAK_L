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
int main(int argc, char *argv[]) {
	bool quit = false;
	int degrees;
	int option;

option=Menu();

    SDL_Event event;
 
    SDL_Init(SDL_INIT_VIDEO);
 
    SDL_Window * window = SDL_CreateWindow("Edycja obrazu za pomoca SDL",
        SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 640, 480, 0);
 
    SDL_Renderer * renderer = SDL_CreateRenderer(window, -1, 0);
    SDL_Surface * image = SDL_LoadBMP("image.bmp");
    SDL_Texture * texture = SDL_CreateTextureFromSurface(renderer, image);

while(option!=3){ 
   if(option==1)
   {
	SDL_RenderCopy(renderer, texture, NULL, NULL);
	SDL_RenderPresent(renderer);

//petla utrzymuje obraz otwarty w oknie widocznym dla uzytkownika
    while (!quit)
    {
	printf("podaj kąt obrotu: ");
	scanf("%d",&degrees);
	SDL_RenderClear(renderer);

        SDL_WaitEvent(&event);
 	
        switch (event.type)
        {
            case SDL_QUIT:
                quit = true;
                break;
        } 
//do funkcji renderCopyEx przekazujemy kontekst graficzny, obraz, czesc obrazu zrodlowego, czesc obrazu docelowego, rodzaj odwracania
	SDL_RenderCopyEx(renderer, texture, NULL, NULL,degrees,NULL,SDL_FLIP_NONE);
        SDL_RenderPresent(renderer);
    }
   }
   else if(option==2)
   {

   }
}

//destruktory
    SDL_DestroyTexture(texture);
    SDL_FreeSurface(image);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
 
    SDL_Quit();

    return 0;
}
