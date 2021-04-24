#include <stdio.h> 
#include <stdlib.h>
#include <string.h> 
#include "authenticate.h"

//Scans in user input for username
void GetUsername(char * username){
    printf("Username: ");
    scanf("%s", username);
}

//Scans in user input for password
void GetPassword(char * password){
    printf("Password: ");
    scanf("%s", password);
}

//Used to see if username and password combo is inside "Authentication.txt"
//Returns the index of the authenticated user or FAIL_TO_AUTHENTICATE
int Authenticate(char * username, char * password, char * file_name){
    FILE *ptr_file;
    char temp_buffer[1000];//used to clear the first line
    
    ptr_file = fopen(file_name,"r");
    if(!ptr_file){//If fail to open file return FAIL_TO_AUTHENTICATE
        printf("File failed to open during authenticate function\n");
        exit(1);
    }

    fgets(temp_buffer, 1000,ptr_file); //Clear the first line that states username and password

    char file_word[10];
    int user_index = 0;//Index of the user authenticated
    
    while(fscanf(ptr_file,"%10s",file_word)==1){ //Read in the username
        
        if(strcmp(username,file_word)==0){ //If username and read in word are equal

            fscanf(ptr_file,"%10s",file_word); //Read in the password
            
            if(strcmp(password,file_word)==0){ //If password and read in word are equal
                
                fclose(ptr_file);
                return user_index; //Return the index of the authenticated user
            
            }

        }else
            fscanf(ptr_file,"%10s",file_word);
        
        user_index++;
    }

    fclose(ptr_file);
    return FAIL_TO_AUTHENTICATE;
}