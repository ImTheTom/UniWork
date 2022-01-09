#include <stdio.h> 
#include <stdlib.h> 
#include <errno.h> 
#include <string.h> 
#include <netdb.h> 
#include <sys/types.h> 
#include <netinet/in.h> 
#include <sys/socket.h> 
#include <unistd.h>
#include "senddata.h"
#include "minesweeper.h"

//Used to send an integer to the socket_id
void SendInteger(int socket_id, int integer){
    uint16_t new_byte = htons(integer);//Convert integer to unsigned integer
    send(socket_id, &new_byte, sizeof(uint16_t), 0);//Send unsigned integer to socket_id
    //fflush(stdout);
}

//Used to recieve an integer
int RecieveInteger(int socket_id){
    uint16_t new_byte;//create new unsigned integer
    recv(socket_id, &new_byte, sizeof(uint16_t),0);//recieve unsigned integer
    int sent_integer =(int) ntohs(new_byte);//convert unsigned integer to integer
    return sent_integer;
}

//Used to send a string of data of 10 characters
void SendString(int socket_id, char * string){
    send(socket_id,string, 10,0);//Send string of 10 characters
    fflush(stdout);
}

//Used to recieve a string of data of 10 characters
char * RecieveString(int socket_id){
    char * string = malloc(10);//set aside memory
    recv(socket_id, string, 10, 0);//recieve data
    return string;
}

//Used to send a 2D array of integers of NUM_TILES_X by NUM_TILES_Y
void SendArrayInt(int socket_id, int ** send_array){
    uint16_t new_byte;//create new unsigned integer
    for(int x=0; x<NUM_TILES_X; x++){//Loop through array
        for(int y=0; y<NUM_TILES_Y;y++){
            new_byte = htons(send_array[x][y]);//Convert integer to unsigned integer
            send(socket_id, &new_byte, sizeof(uint16_t), 0);//Send unsigned integer to socket_id
        }
    }
    fflush(stdout);
}

//Used to recieve a 2D array of integers of NUM_TILES_X by NUM_TILES_Y
void RecieveArrayInt(int socket_id, uint16_t ** byte_array, int ** recieved_array){

    for(int x=0; x<NUM_TILES_X;x++){//Loop through array
        for(int y=0; y<NUM_TILES_Y;y++){
            recv(socket_id, &byte_array[x][y], sizeof(uint16_t),0);//recieve a 2D array of unsigned bytes
        }
    }

    for(int x=0; x<NUM_TILES_X;x++){//Loop through array
        for(int y=0; y<NUM_TILES_Y;y++){
            recieved_array[x][y] = (int) ntohs(byte_array[x][y]);//Convert the unsigned bytes to integers
        }
    }
}