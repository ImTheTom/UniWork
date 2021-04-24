#include <stdio.h> 
#include <stdlib.h> 
#include <errno.h> 
#include <string.h> 
#include <netdb.h> 
#include <sys/types.h> 
#include <netinet/in.h> 
#include <sys/socket.h> 
#include <unistd.h>
#include <stdbool.h>
#include <time.h>
#include <signal.h>
#include "Library/printmessages.h"
#include "Library/senddata.h"
#include "Library/minesweeper.h"
#include "Library/highscores.h"
#include "Library/authenticate.h"

#define FAIL_AUTHENTICATE 65535
#define PLAY_MINESWEEPER 1
#define SHOW_HIGHSCORES 2
#define QUIT 3
#define REVEAL_MINE "R"
#define PLACE_FLAG "P"
#define QUIT_GAME "Q"

Player * players;
int sock_fd;

//Used to handle ctrl+c action
void HandleSigint(int sig){
    pid_t id = getpid();
    free(players);
    close(sock_fd);
    kill(id,SIGTERM);
}

int main(int argc, char *argv[]){
    struct hostent *he;
    struct sockaddr_in their_address;
    int response_string_integer;
    int game_over=0;
    char username[10];
    char password[10];
    char response_string[2];
    int mine_exploded=0;
    int game_quit =0;
    int game_won = 0;
    int time_taken=0;
    int ** game_array;
    uint16_t ** byte_array;//Create a unsigned integer array

    if(argc != 3){//Client needs 2 commands server address and port number
        printf("No enough input commands - ./client {server address} {port number}\n");
        return 0;
    }

    signal(SIGINT, HandleSigint);//Handle Ctrl+c command

    //Start setting up connection

    he = gethostbyname(argv[1]);

    sock_fd = socket(AF_INET, SOCK_STREAM, 0);
    if(sock_fd == -1){
        perror("Socket error");
        exit(1);
    }

    their_address.sin_family = AF_INET;
    their_address.sin_port = htons(atoi(argv[2]));
    their_address.sin_addr = *((struct in_addr *)he->h_addr);
    bzero(&(their_address.sin_zero), 8);

    if(connect(sock_fd, (struct sockaddr *) &their_address, sizeof(struct sockaddr)) == -1){
        perror("Connect Error");
        exit(1);
    }

    //Connection made

    byte_array = calloc(NUM_TILES_X, sizeof(uint16_t *));//Allocate memory
    if(!byte_array){
        printf("Client Line 82: Memory allocation failed\n");
        exit(1);
    }

    for(int i=0; i<NUM_TILES_X;i++){
        byte_array[i] =calloc(NUM_TILES_Y, sizeof(uint16_t));
        if(!byte_array[i]){
            printf("Client Line 88: Memory allocation failed\n");
            exit(1);
        }
    }

    game_array = calloc(NUM_TILES_X, sizeof(int *));//Allocate memory for the game integer array
    if(!game_array){
        printf("Client Line 96: Memory allocation failed\n");
        exit(1);
    }

    for(int i=0; i<NUM_TILES_X;i++){
        game_array[i] =calloc(NUM_TILES_Y, sizeof(int));
        if(!game_array[i]){
            printf("Client Line 103: Memory allocation failed\n");
            exit(1);
        }
    }

    int num_lines = GetNumLines("Authentication.txt");//Get the number of users for high scores

    players = calloc(num_lines, sizeof(Player));
    if(!players){
        printf("Client Line 112: Memory allocation failed\n");
        exit(1);
    }

    PrintLogIn();//Print log in and get the username and password
    GetUsername(username);
    GetPassword(password);

    SendString(sock_fd, username);//Send information to server
    SendString(sock_fd, password);    

    response_string_integer = RecieveInteger(sock_fd);//Get the response from the server
    if(response_string_integer != FAIL_AUTHENTICATE){
        PrintWelcome();
    }else{
        PrintFailAuthenticate();
    }

    while(response_string_integer != FAIL_AUTHENTICATE && response_string_integer != QUIT){
        PrintSelectionOptions();//Print the main menu selection
        scanf("%d",&response_string_integer);
        SendInteger(sock_fd, response_string_integer);//send selection to server

        if(response_string_integer==PLAY_MINESWEEPER){
            printf("\n");

            while(game_over==0){

                response_string_integer=RecieveInteger(sock_fd);//Number of mines remaining
                PrintNumberOfMinesRemaining(response_string_integer);
                
                RecieveArrayInt(sock_fd,byte_array,game_array);//Game array
                PrintFromArray(game_array);

                PrintGameOptionChoice();//Print game menu
                scanf("%s",response_string);
                SendString(sock_fd,response_string);//Send selection to server

                if(strcmp(response_string,REVEAL_MINE)==0){
                    PrintTileCoordinates();//Print tile co ordinates message
                    scanf("%s",response_string);
                    SendString(sock_fd,response_string);//Send co ordinates to server
                    mine_exploded = RecieveInteger(sock_fd);//Recieve the integer response from server
                    printf("\n");

                    if(mine_exploded==ALREADY_REVEALED)//Print extra information
                        printf("Already revealed or flagged\n");
                    else if(mine_exploded==MINE_EXPLODED)
                        printf("Mine exploded\n");
                    else if(mine_exploded==INVALID_RESPONSE)
                        printf("Invalid tile coordinates\n");
                    
                }else if(strcmp(response_string, PLACE_FLAG)==0){
                    PrintTileCoordinates();//Print tile co ordinates message
                    scanf("%s",response_string);
                    SendString(sock_fd,response_string);//Send co ordinates to server
                    game_won = RecieveInteger(sock_fd);//Recieve the integer response from server
                    printf("\n");

                    if(game_won==NO_MINE)//Print extra information
                        printf("No Mine there\n");
                    else if(game_won == ALREADY_FLAGGED)
                        printf("Already flagged or revealed\n");
                    else if(game_won == INVALID_RESPONSE)
                        printf("Invalid tile coordinates\n");
                    
                } else if(strcmp(response_string, QUIT_GAME)==0){
                    SendString(sock_fd,response_string);//Send response to server
                    game_quit=1;//Game over
                }
                if(mine_exploded==MINE_EXPLODED || game_quit==1 || game_won==GAME_WON){
                    game_over=1;//Game over
                }
            }

            RecieveArrayInt(sock_fd,byte_array,game_array);//Get final game array from server

            time_taken = RecieveInteger(sock_fd);//Get time taken from server

            if(game_won==GAME_WON){//If game was won print array and time taken
                PrintFromArray(game_array);
                printf("Game Won! Time to complete - %d Seconds\n", time_taken);
            }else if(mine_exploded==MINE_EXPLODED){//If a mine was exploded print array and tell user
                PrintFromArray(game_array);
                printf("Game Over! A mine was exploded.\n");
            }

            game_quit=0;//Reset variables
            mine_exploded=0;
            game_over=0;
            game_won=0;
            printf("\n");

        }else if(response_string_integer==SHOW_HIGHSCORES){

            for(int i=0; i<num_lines;i++){//Recieve information to build highscores
                players[i].id = RecieveInteger(sock_fd);
                strcpy(players[i].name,RecieveString(sock_fd));
                players[i].total_play_time = RecieveInteger(sock_fd);
                players[i].games_won = RecieveInteger(sock_fd);
                players[i].total_games_played = RecieveInteger(sock_fd);
            }
            PrintHighScores(num_lines, players);//Print high scores after recieveing information

        }
    }
    close(sock_fd);
    return 0;
}

/*
1st Game
     1 2 3 4 5 6 7 8 9
----------------------
A  | *                
B  |   *         *    
C  |           *      
D  |             *    
E  |                  
F  |                  
G  | *           *   *
H  | *                
I  | *                

A1
B2
B7
C6
D7
G1
H1
I1
G7
G9

2nd Game
     1 2 3 4 5 6 7 8 9
----------------------
A  | 0 0 0 0 0 0 0 0 0
B  | 0 0 0 0 1 1 2 1 1
C  | 0 0 0 0 1 *   *  
D  | 0 0 1 1 2        
E  | 0 0 1 *          
F  | 1 2 3            
G  |   * *     *   *  
H  |                 3
I  | *     *         *

C6
C8
E4
G2
G3
G6
G8
I1
I4
I9
*/