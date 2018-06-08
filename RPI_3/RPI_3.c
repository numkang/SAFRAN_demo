/*
        demo-udp-03: udp-send: a simple udp client
	send udp messages
	This sends a sequence of messages (the # of messages is defined in MSGS)
	The messages are sent to a port defined in SERVICE_PORT 

        usage:  udp-send

        Paul Krzyzanowski
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <netdb.h>
#include <sys/socket.h>
#include "port.h"

#define BUFLEN 2048
#define MSGS 3	/* number of messages to send */
#define RPI_NUM 3
#define MAXCHAR 100

struct sockaddr_in myaddr, remaddr;
int fd, i, slen=sizeof(remaddr);
char buf[BUFLEN];	/* message buffer */
int recvlen;		/* # bytes in acknowledgement message */
//char *server = "127.0.0.1";	/* change this to use a different server */
char *server = "169.254.193.195";

int UDP_Client_setup(){
	extern struct sockaddr_in myaddr, remaddr;
	extern int fd, i, slen;
	extern char buf[BUFLEN];	/* message buffer */
	extern int recvlen;		/* # bytes in acknowledgement message */
	extern char *server;

	/* create a socket */

	if ((fd=socket(AF_INET, SOCK_DGRAM, 0))==-1)
		printf("socket created\n");

	/* bind it to all local addresses and pick any port number */

	memset((char *)&myaddr, 0, sizeof(myaddr));
	myaddr.sin_family = AF_INET;
	myaddr.sin_addr.s_addr = htonl(INADDR_ANY);
	myaddr.sin_port = htons(0);

	if (bind(fd, (struct sockaddr *)&myaddr, sizeof(myaddr)) < 0) {
		perror("bind failed");
		return 0;
	}       

	/* now define remaddr, the address to whom we want to send messages */
	/* For convenience, the host address is expressed as a numeric IP address */
	/* that we will convert to a binary format via inet_aton */

	memset((char *) &remaddr, 0, sizeof(remaddr));
	remaddr.sin_family = AF_INET;
	remaddr.sin_port = htons(SERVICE_PORT);
	if (inet_aton(server, &remaddr.sin_addr)==0) {
		fprintf(stderr, "inet_aton() failed\n");
		exit(1);
	}

	/* now let's send the messages */
	
	for (i=0; i < MSGS; i++) {
		printf("Sending packet %d to %s port %d\n", i, server, SERVICE_PORT);
		sprintf(buf, "%d, Hello server", RPI_NUM);
		if (sendto(fd, buf, strlen(buf), 0, (struct sockaddr *)&remaddr, slen)==-1) {
			perror("sendto");
			exit(1);
		}
		/* now receive an acknowledgement from the server */
		recvlen = recvfrom(fd, buf, BUFLEN, 0, (struct sockaddr *)&remaddr, &slen);
        if (recvlen >= 0) {
            buf[recvlen] = 0;	/* expect a printable string - terminate it */
            printf("received message: \"%s\"\n", buf);
        }
	}
	return 0;
}

void request_PWM_and_SENSOR(int *PWM, float *sensor_data){
	extern struct sockaddr_in myaddr, remaddr;
	extern int fd, i, slen;
	extern char buf[BUFLEN];	/* message buffer */
	extern int recvlen;		/* # bytes in acknowledgement message */
	extern char *server;
	char str_pwm[5];
	char str_sensor[MAXCHAR];
	
	printf("Sending packet %d to %s port %d\n", i, server, SERVICE_PORT);
	sprintf(buf, "%d,%d", RPI_NUM, PWM);
	if (sendto(fd, buf, strlen(buf), 0, (struct sockaddr *)&remaddr, slen)==-1) {
		perror("sendto");
		exit(1);
	}
	/* now receive an acknowledgement from the server */
	recvlen = recvfrom(fd, buf, BUFLEN, 0, (struct sockaddr *)&remaddr, &slen);
    if (recvlen >= 0) {
        buf[recvlen] = 0;	/* expect a printable string - terminate it */
        printf("received message: \"%s\"\n", buf);
    }
    strncpy(str_pwm, buf, 4);
    strcpy(str_sensor, buf+5);
    *PWM = atoi(str_pwm);
    *sensor_data = atof(str_sensor);
}

int Monitor(int PWM, float sensor_data){

	return 0;
}

int main(void)
{
	UDP_Client_setup();
	int PWM = 1000;
	float sensor_data = 0.0;
	//while(1){ // should be set to send message in every ... second so that it won't be a conflict with another RPI
	for(int i = 0; i < 5; i++){ // send 5 times
		request_PWM_and_SENSOR(&PWM, &sensor_data);
		Monitor(PWM, sensor_data);
		printf("%d, %.12f", PWM, sensor_data);
	}
	close(fd);
	return 0;
}
