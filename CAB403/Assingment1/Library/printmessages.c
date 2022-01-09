#include "printmessages.h"
#include <stdio.h>

//Prints the log in message
void PrintLogIn(){
    printf("==================================\n");
    printf("Welcome to the online Minesweeper gaming system\n");
    printf("==================================\n\n");
    printf("You are required to log on with your registered user name and password\n\n");
}

//Prints the welcome message
void PrintWelcome(){
    printf("Welcome to Minesweeper gaming system\n\n");
}

//Prints the faile authentiction message
void PrintFailAuthenticate(){
    printf("Failed to authenticate\n");
}

//Prints the main menu selection options
void PrintSelectionOptions(){
    printf("Please enter a selection: \n");
    printf("<1> Play Minesweeper \n");
    printf("<2> Show Leaderboard \n");
    printf("<3> Quit \n");
    printf("Selection option (1-3): ");
}

//Prints the game selection options
void PrintGameOptionChoice(){
    printf("Choose an Option: \n");
    printf("<R> Reveal Tile\n");
    printf("<P> Place Flag\n");
    printf("<Q> Quit Game\n");
    printf("\nOption(R,P,Q): ");
}

//Prints the tile locations question for game selection
void PrintTileCoordinates(){
    printf("Enter Tile Coordinates: ");
}

//Prints the number of mines remaining
void PrintNumberOfMinesRemaining(int mines){
    printf("Number of mines remaining: %d\n",mines);
}