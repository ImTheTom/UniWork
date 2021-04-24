all: server client serverm serverp

server : server.c Library/*.c
	gcc -Wall -o server server.c Library/*.c

client : client.c Library/*.c
	gcc -Wall -o client client.c Library/*.c

serverm : servermulti.c Library/*.c
	gcc -Wall -o serverm servermulti.c Library/*.c -lpthread

serverp : serverpool.c Library/*.c
	gcc -Wall -o serverp serverpool.c Library/*.c -lpthread

clean :
	rm server client serverm serverp