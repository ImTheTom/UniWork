#include <stdio.h> 
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "highscores.h"

//Used to get the number of lines within the "Authentication.txt" file
//Returns the number of lines within a text file
int GetNumLines(char * file_name){
    int number_of_lines=0;
    char buffer[200];

    FILE *file_ptr = fopen(file_name,"r");

    if(file_ptr){
        
        fgets(buffer,sizeof(buffer),file_ptr);//Move pointer passed Username Password Line

        while(fgets(buffer,sizeof(buffer),file_ptr)!=NULL)
            number_of_lines++;//Increment the counter
    
    }else{
        printf("File failed to open during Get Num Lines function\n");
        exit(1);
    }

    fclose(file_ptr);
    return number_of_lines;
}

//Creates the highscore database inside players variable
void CreateHighscores(Player * players, char * file_name){
    FILE *file_ptr;
    char buffer[1000];
    
    file_ptr = fopen(file_name,"r");

    if(!file_ptr){//If fail to open file return FAIL_TO_AUTHENTICATE
        printf("File failed to open during Create Highscores function\n");
        exit(1);
    }

    fgets(buffer, 1000,file_ptr);//Move pointer passed Username Password Line

    char name[10];
    int index=0;

    while(fscanf(file_ptr,"%10s",name)==1){
        
        strcpy(players[index].name,name);//Update players array with information
        players[index].id = index;
        players[index].games_won =0;
        players[index].total_games_played = 0;
        players[index].total_play_time = 0;
        
        fscanf(file_ptr,"%10s",name);//Move pointer pass the password
        index++;

    }

    fclose(file_ptr);
}

//Prints out the players database
void PrintHighScores(int number_of_lines, Player * players){
    int games_has_been_won = 0;

    for(int i=0; i<number_of_lines;i++){ //See if any games have been won
        if(players[i].games_won>0)
            games_has_been_won++;
    }

    if(games_has_been_won>0){ //If the database is worth displaying

        printf("\n===============================================================\n\n");
        int * seen =calloc(number_of_lines, sizeof(int)); //Used to not display the same player more than once

        for(int i=0; i<number_of_lines;i++)
            seen[i]=-1;

        for(int i=0; i<number_of_lines;i++){

            int most_time_played = -1;
            int most_time_played_index = -1;

            for(int j=0; j<number_of_lines;j++){

                if(players[j].total_play_time>=most_time_played){ //If the current player has more time played than the most_time_played
                    
                    int can = 1; //Set can to 1

                    for(int k=0; k<number_of_lines;k++){
                        if(seen[k]==players[j].id)//Check if already displayed the new player
                            can = 0; //If already displayed set can to zero
                    }

                if(can==1){ //If new player can be displayed

                    if(players[j].total_play_time==most_time_played){//If it is equal to the most time played

                        if(players[j].games_won<players[most_time_played_index].games_won){//If new player has less games won name new most played
                            most_time_played = players[j].total_play_time;
                            most_time_played_index = j;
                            
                        }else if(players[j].games_won==players[most_time_played_index].games_won){//If new player has equal games won
                            
                            if(strcmp(players[j].name,players[most_time_played_index].name)>0){ //If new player is less alpabetical ordered name new most played
                                most_time_played= players[j].total_play_time;
                                most_time_played_index = j;
                            }
                        }

                    }else{ //New player has more time played therefore new top most played
                        most_time_played = players[j].total_play_time;
                        most_time_played_index = j;
                    }
                }
            }
        }

        seen[i] = most_time_played_index; //Set new most player to be seen and therefore can't be displayed again

        if(players[most_time_played_index].games_won>0)
            printf("%s\t%d Seconds\t%d Games Won with %d Games Played\n", players[most_time_played_index].name, players[most_time_played_index].total_play_time, players[most_time_played_index].games_won, players[most_time_played_index].total_games_played );
    }  

    printf("\n===============================================================\n\n");
    
    }else //No useful data to display
        printf("\nNo High Scores Data\n\n");

}
