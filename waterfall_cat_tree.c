#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	int port = 0;					//port number
	int socket_fd;					//socket file descriptor
	int bind_result;				//bind() return value
	struct addrinfo hint;			//hint structure used for getaddrinfo()
	struct addrinfo *result = NULL;	//result pointer for getaddrinfo()

	//clear hint structure
	memset(&hint, 0, sizeof(hint));
	hint.ai_family = AF_INET;
	hint.ai_socktype = SOCK_STREAM;

	//get command line arguments
	if (argc > 1)
	{
		port = atoi(argv[1]);
	} else
	{
		port = 7000;
	}

	//get address information using getaddrinfo()
	if (getaddrinfo(NULL, argv[1], &hint, &result) != 0)
	{
		fprintf(stderr, "getaddrinfo failed\n");
		return 1;
	}

	//open a socket
	socket_fd = socket(AF_INET, SOCK_STREAM, 0);
	if (socket_fd < 0)
	{
		fprintf(stderr, "socket failed\n");
		return 1;
	}

	//bind the socket to an address
	bind_result = bind(socket_fd, result->ai_addr, result->ai_addrlen);
	if (bind_result < 0)
	{
		fprintf(stderr, "bind failed\n");
		return 1;
	}
	
	//listen for incoming connections
	if (listen(socket_fd, 10) < 0)
	{
		fprintf(stderr, "listen failed\n");
		return 1;
	}
	
	//free the address info allocated by getaddrinfo()
	freeaddrinfo(result);

	//accept incoming connections
	struct sockaddr_in client_addr;
	int client_fd;
	unsigned int client_len = sizeof(client_addr);
	client_fd = accept(socket_fd, (struct sockaddr *)&client_addr, &client_len);
	if (client_fd < 0)
	{
		fprintf(stderr, "accept failed\n");
		return 1;
	}

	//send a message
	const char *msg = "Hello World!\n";
	if (send(client_fd, msg, strlen(msg), 0) < 0)
	{
		fprintf(stderr, "send failed\n");
		return 1;
	}

	//receive data
	char buf[1024];
	int n = recv(client_fd, buf, sizeof(buf), 0);
	if (n == 0)
	{
		fprintf(stderr, "client disconnected\n");
		return 1;
	}
	else if (n < 0)
	{
		fprintf(stderr, "recv failed\n");
		return 1;
	}
	printf("Received: %s\n", buf);

	//close the connection
	close(client_fd);
	close(socket_fd);

	return 0;
}