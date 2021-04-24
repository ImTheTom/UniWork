#ifndef __AUTHENTICATE_H__
#define __AUTHENTICATE_H__

#define FAIL_TO_AUTHENTICATE -1

void GetUsername(char * username);

void GetPassword(char * password);

int Authenticate(char * username, char * password,char * file_name);

#endif //__PRINTMESSAGES_H__
