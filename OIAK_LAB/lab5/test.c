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
 
    //SDL_Init(SDL_INIT_VIDEO);
 
    SDL_Window * window = SDL_CreateWindow("Edycja obrazu za pomoca SDL",
        SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 640, 480, 0);
 
    SDL_Renderer * renderer = SDL_CreateRenderer(window, -1, 0);
    SDL_Surface * image = SDL_LoadBMP("image.bmp");
    SDL_Texture * texture = SDL_CreateTextureFromSurface(renderer, image);

while(option!=3){
//petla utrzymuje obraz otwarty w oknie widocznym dla uzytkownika
    while (!quit)
    {
	
	SDL_RenderClear(renderer);

        SDL_WaitEvent(&event);
 	
        switch (event.type)
        {
            case SDL_QUIT:
                quit = true;
                break;
        } 
	SDL_RenderCopy(renderer, texture, NULL, NULL);
	SDL_RenderPresent(renderer);
	printf("podaj kąt obrotu: ");
	scanf("%d",&degrees);
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
