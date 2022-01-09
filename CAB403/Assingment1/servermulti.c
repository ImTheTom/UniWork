//Task2 - Multiple threads
#include <arpa/inet.h>
#include <stdio.h> 
#include <stdlib.h> 
#include <errno.h> 
#include <string.h> 
#include <sys/types.h> 
#include <netinet/in.h> 
#include <sys/socket.h> 
#include <sys/wait.h> 
#include <unistd.h>
#include <netdb.h>
#include <stdbool.h>
#include <time.h>
#include <signal.h>
#include <semaphore.h>
#include <pthread.h>
#include "Library/senddata.h"
#include "Library/minesweeper.h"
#include "Library/highscores.h"
#include "Library/authenticate.h"

//Define Magic Numbers
#define DEFAULTPORT 12345
#define NUMBER_OF_THREADS 255
#define PLAY_MINESWEEPER 1
#define SHOW_HIGHSCORES 2
#define QUIT 3
#define REVEAL_MINE "R"
#define PLACE_FLAG "P"
#define QUIT_GAME "Q"

//Define global variables
Player * players;
int number_of_lines;
pthread_mutex_t random_integer_lock;
pthread_mutex_t read_write_mutex;
pthread_mutex_t read_count_mutex;
int read_count = 0;

void Read(int socket_id){
                
    pthread_mutex_lock(&read_count_mutex); //Ensure that read_count variable is only incremented by one thread a time
    read_count++; //Increment
                
    if(read_count>=1)
        pthread_mutex_lock(&read_write_mutex); // Ensure no new values are being written while reading

    pthread_mutex_unlock(&read_count_mutex);
                        
    for(int i=0;i<number_of_lines;i++){// Send over each players information
        SendInteger(socket_id,players[i].id);
        SendString(socket_id, players[i].name);
        SendInteger(socket_id,players[i].total_play_time);
        SendInteger(socket_id,players[i].games_won);
        SendInteger(socket_id,players[i].total_games_played);
    }

    pthread_mutex_lock(&read_count_mutex);//Ensure that read_count variable is only decremented by one thread a time
    read_count--;

    if(read_count==0)
        pthread_mutex_unlock(&read_write_mutex); //unlock write mutex if no people are reading
                    
    pthread_mutex_unlock(&read_count_mutex);
    
}

void Write(int client_index, int time_taken, bool game_won){
    pthread_mutex_lock(&read_write_mutex);//Need to ensure that values aren't over written

    players[client_index].total_games_played++;// Update the highscores
    players[client_index].total_play_time += time_taken;

    if(game_won){
        players[client_index].games_won++;
    }

    pthread_mutex_unlock(&read_write_mutex);
}

void BeginGames(void* data){
    char * username;
    char * password;
    char * recieved_string;
    int recieved_integer = 1;
    int mine_exploded = 0;
    int game_won = 0;
    time_t start, end;
    double elapsed;
    int time_taken = 0;

    int new_fd = *((int*)data);

    GameState *game_state;// Used to store game of minesweeper data

    game_state = malloc(sizeof(GameState));// allocate memory for game_state
    if(!game_state){
        printf("Servermulti Line 97: Memory allocation failed\n");
        exit(1);
    }

    int ** game_array;// Used to store the game of minesweeper data without the use of the struct

    game_array = calloc(NUM_TILES_X, sizeof(int *));
    if(!game_array){
        printf("Servermulti Line 105: Memory allocation failed\n");
        exit(1);
    }

    for(int i=0; i<NUM_TILES_X;i++){
        game_array[i] =calloc(NUM_TILES_Y, sizeof(int));// allocate memory for the game array
        if(!game_array[i]){
            printf("Servermulti Line 112: Memory allocation failed\n");
            exit(1);
        }
    }

    username = RecieveString(new_fd);// Recive the username and password from the client
    password = RecieveString(new_fd);

    int authenticated_index = Authenticate(username,password, "Authentication.txt");// Authenticate the user and send the integer over
    SendInteger(new_fd,authenticated_index);

    if(authenticated_index != FAIL_TO_AUTHENTICATE){
        while(recieved_integer != QUIT){
            
            recieved_integer = RecieveInteger(new_fd);// Recive the response from the main menu
            printf("Recieved data %d\n", recieved_integer);

            if(recieved_integer==PLAY_MINESWEEPER){
                
                pthread_mutex_lock(&random_integer_lock); // Random function is not thread safe, need to have it in a mutex
                InitialiseGameState(game_state);
                pthread_mutex_unlock(&random_integer_lock);

                start=time(NULL);// Set the time variable
                
                while(!game_state->game_over){
                    
                    SendInteger(new_fd,game_state->number_of_mines);// Send the number of mines remaining
                    
                    ResetArray(game_array,game_state);// Send over the game array so no mine locations are sent
                    SendArrayInt(new_fd, game_array);

                    recieved_string = RecieveString(new_fd);// Recieve the response from the game options
                    printf("%s \n", recieved_string);
                    
                    if(strcmp(recieved_string,REVEAL_MINE)==0){

                        recieved_string = RecieveString(new_fd);// Recieve the tile co ordinates to reveal
                        printf("%s \n", recieved_string);
                        printf("Reveal tile\n");
                        
                        mine_exploded = ProcessRevealResponse(recieved_string,game_state);// Process the request
                        SendInteger(new_fd, mine_exploded);// Send the response to client

                    }else if(strcmp(recieved_string, PLACE_FLAG)==0){
                        
                        recieved_string = RecieveString(new_fd);// Recieve the tile co ordinates to reveal
                        printf("%s \n", recieved_string);
                        printf("Place flag\n");
                    
                        game_won = ProcessFlagResponse(recieved_string,game_state);// Process the request
                        SendInteger(new_fd, game_won);// Send the response to client
                    
                    } else if(strcmp(recieved_string, QUIT_GAME)==0){
                    
                        printf("Quit game");
                        game_state->game_over=true;// Game is ended
                    
                        end = time(NULL);
                        elapsed=difftime(end,start);
                        time_taken=(int)elapsed;
                        
                        Write(authenticated_index,time_taken,false);

                    }
                    
                    if(mine_exploded==MINE_EXPLODED){// Game is ended

                        end = time(NULL);
                        elapsed=difftime(end,start);
                        time_taken=(int)elapsed;

                        Write(authenticated_index,time_taken,false);

                    }else if(game_won==GAME_WON){// Game is ended
                        
                        end = time(NULL);
                        elapsed=difftime(end,start);
                        time_taken=(int)elapsed;
                        
                        Write(authenticated_index,time_taken,true);
                    
                    }

                }
                
                ResetArray(game_array,game_state);// Send final game array
                SendArrayInt(new_fd, game_array);
                SendInteger(new_fd,time_taken);// Send the time taken to reach the end

                time_taken=0;// Reset variables
                game_won=0;
                mine_exploded=0;

            }else if(recieved_integer==SHOW_HIGHSCORES){
                printf("Send highscores\n");

                Read(new_fd);
            }

        }
    }
}

int main(int argc, char *argv[]){
    socklen_t sin_size;
    int sock_fd, new_fd; //Listen on sock_fd, new_fd for new connections
    struct sockaddr_in my_address, their_address; //my and their address
    int requested_port = DEFAULTPORT;//Set the request port to the default value
    srand(42); //Random Seed
    pthread_t client_threads[NUMBER_OF_THREADS];
    pthread_attr_t thread_attribute;

    if(argc==2)
        requested_port = atoi(argv[1]);//Check if port is passed and if so overwrite the default port
        
    //Set up socket	

    sock_fd = socket(AF_INET, SOCK_STREAM, 0);
    if(sock_fd == -1){
        perror("Socket error");
        exit(1);
    }

    my_address.sin_family = AF_INET;
    my_address.sin_port = htons(requested_port);
    my_address.sin_addr.s_addr = INADDR_ANY;

    if(bind(sock_fd, (struct sockaddr *) &my_address, sizeof(struct sockaddr)) == -1){
        perror("Bind error");
        exit(1);
    }

    if(listen(sock_fd, 10) == -1){
        perror("listen");
        exit(1);
    }

    printf("Server initiated\n");

    //Server running

    number_of_lines = GetNumLines("Authentication.txt"); //Get the size of database needed

    players = calloc(number_of_lines, sizeof(Player));
    if(!players){
        printf("Server multi Line 257: Memory allocation failed\n");
        exit(1);
    }

    CreateHighscores(players,"Authentication.txt"); //Initialise the HighScores

    int x=0;

	while(1) {  /* main accept() loop */
		sin_size = sizeof(struct sockaddr_in);

		if ((new_fd = accept(sock_fd, (struct sockaddr *)&their_address, &sin_size)) == -1) {
			perror("accept");
			continue;
		}

		printf("server: got connection from %s\n", inet_ntoa(their_address.sin_addr));
            
        pthread_attr_init(&thread_attribute); //reinitiate thread attribute
        pthread_create(&client_threads[x], &thread_attribute, (void *) BeginGames, (void*)&new_fd); //Create new thread with BeginGames function passing the new socket

        x++;
        if(x>NUMBER_OF_THREADS) //Restart threads if needed
            x=0;
        
	}
    close(sock_fd);

    return 0;
}