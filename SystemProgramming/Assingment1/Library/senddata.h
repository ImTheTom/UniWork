#ifndef __SENDDATA_H__
#define __SENDDATA_H__

void SendInteger(int socket_id, int integer);

int RecieveInteger(int socket_id);

void SendString(int socket_id, char * string);

char * RecieveString(int socket_id);

void SendArrayInt(int socket_id, int ** send_array);

void RecieveArrayInt(int socket_id, uint16_t ** byte_array, int ** recieved_array);

#endif //__SENDDATA_H__