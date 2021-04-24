//Task 3 - Pool of threads 
#define _GNU_SOURCE
#include <stdio.h> 
#include <pthread.h>  
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <errno.h> 
#include <string.h> 
#include <sys/types.h> 
#include <netinet/in.h> 
#include <sys/socket.h> 
#include <sys/wait.h> 
#include <netdb.h>
#include <stdbool.h>
#include <signal.h>
#include "Library/senddata.h"
#include "Library/minesweeper.h"
#include "Library/highscores.h"
#include "Library/authenticate.h"

//Define Magic Numbers
#define DEFAULTPORT 12345
#define NUM_HANDLER_THREADS 10
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

pthread_mutex_t request_mutex = PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;//Thread pool matrix
pthread_cond_t got_request = PTHREAD_COND_INITIALIZER;//Thread pool condition variable

int number_of_requests = 0;

struct request {
    int socket_id;
    struct request* next; 
};

struct request* requests = NULL;//Head of linked list of requests
struct request* last_request = NULL;//Last request

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

void BeginGames(int new_fd){
    char * username;
    char * password;
    char * recieved_string;
    int recieved_integer = 1;
    int mine_exploded = 0;
    int game_won = 0;
    time_t start, end;
    double elapsed;
    int time_taken = 0;

    GameState *game_state;// Used to store game of minesweeper data

    game_state = malloc(sizeof(GameState));// allocate memory for game_state
    if(!game_state){
        printf("Serverpool Line 108: Memory allocation failed\n");
        exit(1);
    }

    int ** game_array;// Used to store the game of minesweeper data without the use of the struct

    game_array = calloc(NUM_TILES_X, sizeof(int *));
    if(!game_array){
        printf("Serverpool Line 116: Memory allocation failed\n");
        exit(1);
    }

    for(int i=0; i<NUM_TILES_X;i++){
        game_array[i] =calloc(NUM_TILES_Y, sizeof(int));// allocate memory for the game array
        if(!game_array[i]){
            printf("Serverpool Line 123: Memory allocation failed\n");
            exit(1);
        }
    }

    username = RecieveString(new_fd);// Recive the username and password from the client
    password = RecieveString(new_fd);

    int authenticated_index = Authenticate(username,password,"Authentication.txt");// Authenticate the user and send the integer over
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

//Used to add a request that needs to be completed by a thread from the pool
void AddRequest(int request_socket, pthread_mutex_t* pool_mutex, pthread_cond_t*  pool_mutex_condition){
    struct request* new_request;//Initialise a new request

    new_request = (struct request*)malloc(sizeof(struct request));//set aside memory and allocate variables
    new_request->socket_id = request_socket;
    new_request->next = NULL;

    pthread_mutex_lock(pool_mutex);//Lock thread pool mutex
    
    if (number_of_requests == 0) { //If no requests needs to set both requests and last requests to new requests
        requests = new_request;
        last_request = new_request;
    } else {//If there are requets then needs to update the last_request only
        last_request->next = new_request;
        last_request = new_request;
    }

    number_of_requests++;//Increment the number of requests before unlocking mutex

    pthread_mutex_unlock(pool_mutex);

    pthread_cond_signal(pool_mutex_condition);//Signal the condition mutex
}

//Used to get the head of requests linked list
struct request* get_request(pthread_mutex_t* pool_mutex){
    struct request* new_request; //Initialise a new request

    pthread_mutex_lock(pool_mutex);//Lock pool mutex

    if (number_of_requests > 0) {//If number of requests is greater than zero
        new_request = requests;//Set the new request created to the head of requests
        requests = new_request->next;//Update the head of requests
        if (requests == NULL) {//If requests is null then last requests is null
            last_request = NULL;
        }
        number_of_requests--;//Decrement number of requests
    }
    else { 
        new_request = NULL;
    }

    pthread_mutex_unlock(pool_mutex);

    return new_request;
}

//Used to call the BeginGames function
void HandleRequest(struct request* new_request){
    if (new_request) {
        BeginGames(new_request->socket_id);
    }
}

//Used for the threads from the pool to be able access requests when needed
void* HandleRequestsLoop(){
    struct request* new_request;//Initialise a request variable

    pthread_mutex_lock(&request_mutex);//Lock mutex

    while (1) {
        if (number_of_requests > 0) {//If there is a request needed to be done
            new_request = get_request(&request_mutex);//Get the request
            if (new_request) {
                pthread_mutex_unlock(&request_mutex);//Got the request therefore can let other threads access
                HandleRequest(new_request);//Go and handle the request
                free(new_request);//Free the request memory
                pthread_mutex_lock(&request_mutex);//Lock the mutex
            }
        } else {
            pthread_cond_wait(&got_request, &request_mutex);//Unlock the mutex
        }
    }
}

int main(int argc, char* argv[]) {
    socklen_t sin_size;
    int sock_fd, new_fd;
    struct sockaddr_in my_address, their_address;
    int requested_port = DEFAULTPORT;
    srand(42);
    pthread_t client_threads[NUM_HANDLER_THREADS]; 

    if(argc==2){
		requested_port = atoi(argv[1]);
    }
    
    //Set up server

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

    // Server set up and running

    for (int i=0; i<NUM_HANDLER_THREADS; i++) {//Create the threads for the pools
        pthread_create(&client_threads[i], NULL, HandleRequestsLoop, NULL);
    }

    number_of_lines = GetNumLines("Authentication.txt");

    players = calloc(number_of_lines, sizeof(Player));
    if(!players){
        printf("Server pool Line 350: Memory allocation failed\n");
        exit(1);
    }

    CreateHighscores(players,"Authentication.txt");//Create the highscores

	while(1) {
        sin_size = sizeof(struct sockaddr_in);
        
		if ((new_fd = accept(sock_fd, (struct sockaddr *)&their_address, &sin_size)) == -1) {
			perror("accept");
			continue;
		}
		printf("server: got connection from %s\n", inet_ntoa(their_address.sin_addr));
            
        AddRequest(new_fd, &request_mutex, &got_request);//Add the request for the threads
    }
    close(new_fd);
    
    return 0;
}
