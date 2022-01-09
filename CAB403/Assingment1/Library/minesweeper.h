#ifndef __MINESWEEPER_H__
#define __MINESWEEPER_H__

#include <stdbool.h>

//Used in GameState struct
#define NUM_TILES_X 9
#define NUM_TILES_Y 9
#define NUM_MINES 10

//Used in ResetArray
#define FLAGGED 9
#define MINE_REVEALED 10
#define NOT_REVEALED 11

//Used in ProcessRevealResponse
#define MINE_EXPLODED 1
#define ALREADY_REVEALED 2
#define NO_EXPLOSION 0

//Used in ProcessFlagResponse
#define NO_MINE 2
#define GAME_WON 1
#define ALREADY_FLAGGED 3

#define INVALID_RESPONSE 20

typedef struct{
    int adjacent_mines;
    bool is_revealed;
    bool is_mine;
    bool is_flagged;
} Tile;

typedef struct{
    Tile tiles[NUM_TILES_X] [NUM_TILES_Y];
    int number_of_mines;
    bool game_over;
} GameState;

void InitialiseGameState(GameState * game_state);

void FillFieldWithTiles(GameState * game_state);

void PlaceMines(GameState * game_state);

void UpdateAdjacentMines(GameState * game_state);

void PrintBoard(GameState * game_state);

void ResetArray(int ** game_array, GameState * game_state);

void PrintArray(int ** game_array);

void PrintFromArray(int ** game_array);

bool IsValid(int row, int column);

bool CheckIfRevealed(int x, int y, GameState * game_state);

int ProcessRevealResponse(char * response, GameState * game_state);

bool RevealTile(int row, int column, GameState * game_state);

void RevealAllMines(GameState * game_state);

int ProcessFlagResponse(char * response, GameState * game_state);

bool FlagTile(int row, int column, GameState * game_state);

bool TileContainsMine(int x, int y, GameState * game_state);

bool CheckGameWin(GameState * game_state);

void RevealAllTiles(GameState * game_state);

#endif //__PRINTMESSAGES_H__
