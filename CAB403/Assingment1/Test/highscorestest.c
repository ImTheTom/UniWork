#include "../Library/highscores.h"
#include <stdio.h> 
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

Player * players;

int main(){
    int number_of_lines = GetNumLines("Authentication.txt");

    players = calloc(number_of_lines, sizeof(Player));
    if(!players){
        printf("Server Line 213: Memory allocation failed\n");
        exit(1);
    }

    CreateHighscores(players,"Authentication.txt");//Initialise the high scores

    int i=0;
    players[i].total_play_time=7;//Maolin
    players[i].games_won=2;
    players[i].total_games_played=2;
    i++;
    players[i].total_play_time=29;//Jason
    players[i].games_won=3;
    players[i].total_games_played=5;
    i++;
    players[i].total_play_time=19;//Mike
    players[i].games_won=2;
    players[i].total_games_played=2;
    i++;
    players[i].total_play_time=40;//Peter
    players[i].games_won=2;
    players[i].total_games_played=2;
    i++;
    players[i].total_play_time=38;//Justin
    players[i].games_won=2;
    players[i].total_games_played=4;
    i++;
    players[i].total_play_time=26;//Anna
    players[i].games_won=2;
    players[i].total_games_played=3;
    i++;
    players[i].total_play_time=30;//Tim
    players[i].games_won=2;
    players[i].total_games_played=3;
    i++;
    players[i].total_play_time=24;//Anthony
    players[i].games_won=2;
    players[i].total_games_played=2;
    i++;
    players[i].total_play_time=29;//paul
    players[i].games_won=2;
    players[i].total_games_played=5;
    i++;
    players[i].total_play_time=28;//richie
    players[i].games_won=2;
    players[i].total_games_played=2;
    i++;
    players[i].total_play_time=60;//a
    players[i].games_won=2;
    players[i].total_games_played=2;
    i++;
    players[i].total_play_time=60;//b
    players[i].games_won=2;
    players[i].total_games_played=2;
    i++;
    players[i].total_play_time=60;//c
    players[i].games_won=3;
    players[i].total_games_played=3;
    i++;
    players[i].total_play_time=1421;//d
    players[i].games_won=3;
    players[i].total_games_played=5;
    i++;
    players[i].total_play_time=152;//e
    players[i].games_won=2;
    players[i].total_games_played=2;
    i++;
    players[i].total_play_time=104;//f
    players[i].games_won=2;
    players[i].total_games_played=2;
    i++;
    players[i].total_play_time=104;//g
    players[i].games_won=3;
    players[i].total_games_played=3;
    i++;
    players[i].total_play_time=20;//h
    players[i].games_won=0;
    players[i].total_games_played=2;
    i++;
    players[i].total_play_time=200;//i
    players[i].games_won=1;
    players[i].total_games_played=2;
    i++;

    PrintHighScores(number_of_lines,players);

    return 0;
}