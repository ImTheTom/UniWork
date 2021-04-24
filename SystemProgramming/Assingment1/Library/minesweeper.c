#include <stdio.h> 
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "minesweeper.h"

//Used to initialise a game state variable s
void InitialiseGameState(GameState * game_state){
    game_state->game_over=false;
    game_state->number_of_mines = NUM_MINES;

    FillFieldWithTiles(game_state);//Fill all tile locations with a tile
    PlaceMines(game_state);//Place NUM_MINES on the game state
    UpdateAdjacentMines(game_state);//Update adjacent mines values
}

//Fill game state with tiles
void FillFieldWithTiles(GameState * game_state){
    
    for(int x =0; x<NUM_TILES_X;x++){

        for(int y = 0; y<NUM_TILES_Y;y++){//Set each x and y to a tile
            Tile tile;
            tile.is_revealed=false;
            tile.is_mine=false;
            tile.is_flagged=false;
            tile.adjacent_mines=0;
            game_state->tiles[x][y] = tile;
        }

    }
    
}

//Places NUM_MINES of mines on the game state
void PlaceMines(GameState * game_state){
    for(int i=0; i<NUM_MINES;i++){//Place NUM_MINES on the game state
        int x,y;
        do{
            x = rand() % NUM_TILES_X;//Generate random values
            y = rand() % NUM_TILES_Y;
        }while(TileContainsMine(x,y, game_state));//Randomly generated x and y could already contain mine

        game_state->tiles[x][y].is_mine=true;
    }
}

//Updates the adjacent mines variable of each tile
void UpdateAdjacentMines(GameState * game_state){
    for(int x =0; x<NUM_TILES_X;x++){

        for(int y = 0; y<NUM_TILES_Y;y++){

            int adjMines = 0;

            if(IsValid(x-1,y)){//up
                if(TileContainsMine(x-1,y, game_state)){
                    adjMines++;
                }
            }

            if(IsValid(x+1,y)){//down
                if(TileContainsMine(x+1,y, game_state)){
                    adjMines++;
                }
            }

            if(IsValid(x,y-1)){//left
                if(TileContainsMine(x,y-1, game_state)){
                    adjMines++;
                }
            }

            if(IsValid(x,y+1)){//right
                if(TileContainsMine(x,y+1, game_state)){
                    adjMines++;
                }
            }

            if(IsValid(x-1,y-1)){//up left;
                if(TileContainsMine(x-1,y-1, game_state)){
                    adjMines++;
                }
            }

            if(IsValid(x-1,y+1)){//up right
                if(TileContainsMine(x-1,y+1, game_state)){
                    adjMines++;
                }
            }

            if(IsValid(x+1,y-1)){//down left
                if(TileContainsMine(x+1,y-1, game_state)){
                    adjMines++;
                }
            }

            if(IsValid(x+1,y+1)){//down right
                if(TileContainsMine(x+1,y+1, game_state)){
                    adjMines++;
                }
            }

            game_state->tiles[x][y].adjacent_mines=adjMines;
        }
    }
}

//Used to print the board using a GameState variable
void PrintBoard(GameState * game_state){
    printf("\nRemaining Mines: %d\n", game_state->number_of_mines);
    for(int x =0; x<NUM_TILES_X+2;x++){
        if(x==0){
            printf("    ");//Leave top left empty
        }else if(x==1){
            printf("----");//Place a seperator between columns and rows
        }else{
            printf("%c  |", x+63);//Place the Letter of each Row
        }
        for(int y=1; y<NUM_TILES_Y+1;y++){
            if(x==0){
                printf(" %d",y);//Place the number of column
            }else if(x==1){
                printf("--");//Place a seperator between row and column
            }else{
                if(game_state->tiles[x-2][y-1].is_flagged){
                    printf(" +");//Place + for a flagged mine
                }else if(game_state->tiles[x-2][y-1].is_revealed){
                    if(game_state->tiles[x-2][y-1].is_mine){
                        printf(" *");//Place a * for a mine
                    }else{
                        printf(" %d", game_state->tiles[x-2][y-1].adjacent_mines);//Place the adjacent mines value for a revealed tile
                    }
                }else{
                    printf("  ");//Place a empty space for a unrevealed tile
                }
            }
        }
        printf("\n");
    }
    printf("\n");
}

void PrintArray(int ** game_array){
    for(int x=0; x<NUM_TILES_X; x++){
        for(int y=0; y<NUM_TILES_Y;y++){
            printf("%d ", game_array[x][y]);
        }
        printf("\n");
    }
    printf("\n");
}

//Used to set the values of a game array to new values based on the GameState values
void ResetArray(int ** game_array, GameState * game_state){
    for(int x=0; x<NUM_TILES_X;x++){
        for(int y=0; y<NUM_TILES_Y; y++){
            if(game_state->tiles[x][y].is_flagged){
                game_array[x][y] = FLAGGED;
            }else if(game_state->tiles[x][y].is_revealed){
                if(game_state->tiles[x][y].is_mine){
                    game_array[x][y] = MINE_REVEALED;
                }else{
                    game_array[x][y] = game_state->tiles[x][y].adjacent_mines;
                }
            }else{
                game_array[x][y] = NOT_REVEALED;
            }
        }
    }
}

//Used to print the board using a int array variable
void PrintFromArray(int ** game_array){
    for(int x =0; x<NUM_TILES_X+2;x++){
        if(x==0){
            printf("    ");//Leave top left empty
        }else if(x==1){
            printf("----");//Place a seperator between columns and rows
        }else{
            printf("%c  |", x+63);//Place the Letter of each Row
        }
        for(int y=1; y<NUM_TILES_Y+1;y++){
            if(x==0){
                printf(" %d",y);//Place the number of column
            }else if(x==1){
                printf("--");//Place a seperator between row and column
            }else{
                if(game_array[x-2][y-1]==FLAGGED){
                    printf(" +");//Place + for a flagged mine
                }else if(game_array[x-2][y-1]==MINE_REVEALED){
                        printf(" *");//Place a * for a mine
                }else if(game_array[x-2][y-1]==NOT_REVEALED){
                        printf("  ");//Place a empty space for a unrevealed tile
                }else{
                    printf(" %d", game_array[x-2][y-1]);//Place the adjacent mines value for a revealed tile
                }
            }
        }
        printf("\n");
    }
    printf("\n");
}

//Checks if the location is valid on the board
bool IsValid(int row, int column){
    return(row>=0) && (row<NUM_TILES_X) &&(column>=0) && (column<NUM_TILES_Y);
}

//Checks if the tile location is revealed
bool CheckIfRevealed(int x, int y, GameState * game_state){
    return game_state->tiles[x][y].is_revealed;
}

//Processes the reveal request
int ProcessRevealResponse(char * response, GameState * game_state){
    int row = response[0]-65; //A
    int column = response[1]-49; // 1

    if(IsValid(row,column)){

        if(!CheckIfRevealed(row, column, game_state)){//Check if tile is revealed

            if(RevealTile(row,column, game_state))//Returns true if a mine was revealed
                return MINE_EXPLODED;
            else
                return NO_EXPLOSION;
        
        }else{
            return ALREADY_REVEALED;
        }
    }else{
        return INVALID_RESPONSE;
    }
    return 0;
}

//Reveals a tile returns True if the revealed tile is a bomb.
//Can recursively call itself if the tile revealed has zero mines adjacent
bool RevealTile(int x, int y, GameState * game_state){
    if(IsValid(x,y)){//Check if co ordinates are valid for game state

        if(TileContainsMine(x,y,game_state)){

            printf("A mine was exploded\n");
            game_state->game_over = true;
            RevealAllTiles(game_state);
            PrintBoard(game_state);
            return true;

        }

        if(game_state->tiles[x][y].is_revealed==true) //Check if tile is revealed
            return false;

        game_state->tiles[x][y].is_revealed=true; //Set tile to reveal

        if(game_state->tiles[x][y].adjacent_mines!=0)//If releaved tile is adjacent mines aren't zero return out of recursive function
            return false;

        RevealTile(x-1,y, game_state);//up

        RevealTile(x+1,y, game_state);//down

        RevealTile(x,y-1, game_state);//left

        RevealTile(x,y+1, game_state);//right

        RevealTile(x-1,y-1, game_state);//up left

        RevealTile(x-1,y+1, game_state);//up right

        RevealTile(x+1,y-1, game_state);//down left

        RevealTile(x+1,y+1, game_state);//down right
    }
    return false;
}

//Reveals all mines on the game state
//Done if a mine is revealed
void RevealAllMines(GameState * game_state){
    for(int x =0; x<NUM_TILES_X;x++){
        
        for(int y = 0; y<NUM_TILES_Y;y++){

            if(game_state->tiles[x][y].is_mine)
                game_state->tiles[x][y].is_revealed=true;
        
        }

    }
}

//Processes the flag tile request
//Returns an int value dependent on the game state and request
int ProcessFlagResponse(char * response, GameState * game_state){
    int row = response[0]-65; //A
    int column = response[1]-49; // 1
    if(IsValid(row,column)){

        if(!CheckIfRevealed(row,column, game_state)){//Check if co corinates are already releaved

            if(!FlagTile(row,column, game_state)){//Retruns true if mine was successfully flagged
                printf("No Mine at %s\n",response);
                return NO_MINE;
            }else{
                if(CheckGameWin(game_state)){//Returns true if no more mines remain
                    return GAME_WON;
                }
            }

        }else{
            printf("Already Flagged or Revealed\n");
            return ALREADY_FLAGGED;
        }
    }else{
        return INVALID_RESPONSE;
    }
    return 0;
}

//Flags a tile if the row and column contains a mine
//Decrements the total number of mines on the game state if so
//Returns true if the request contained a mine or false if not
bool FlagTile(int row, int column, GameState * game_state){
    if(IsValid(row,column)){
        if(TileContainsMine(row,column,game_state)){

            game_state->tiles[row][column].is_flagged = true;
            game_state->tiles[row][column].is_revealed = true;
            game_state->number_of_mines -= 1;
            return true;

        }else{
            return false;
        }
    }
return false;
}

//Checks if the tile is a mine
bool TileContainsMine(int x, int y, GameState * game_state){
    return game_state->tiles[x][y].is_mine;
}

//Checks if the game is won(where number of mines is equal to zero)
bool CheckGameWin(GameState * game_state){
    if(game_state->number_of_mines==0){
        game_state->game_over=true;
        RevealAllTiles(game_state);
        return true;
    } 
    return false;
}

//Reveals all the remaining tiles when a game has been won
void RevealAllTiles(GameState * game_state){
    for(int x =0; x<NUM_TILES_X;x++){
        
        for(int y = 0; y<NUM_TILES_Y;y++){

            game_state->tiles[x][y].is_revealed=true;
        
        }

    }
}