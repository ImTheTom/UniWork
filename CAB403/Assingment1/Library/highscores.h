#ifndef __HIGHSCORES_H__
#define __HIGHSCORES_H__

//Used to hold information about a user
typedef struct{
    char name[10];
    int games_won;
    int total_play_time;
    int total_games_played;
    int id;
} Player;

int GetNumLines(char * file_name);

void CreateHighscores(Player * players, char * file_name);

void PrintHighScores(int numLines, Player * players);

#endif //__PRINTMESSAGES_H__