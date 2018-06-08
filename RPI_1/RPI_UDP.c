/*
        demo-udp-03: udp-recv: a simple udp server
	receive udp messages

        usage:  udp-recv

        Paul Krzyzanowski
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <netdb.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include "port.h"

#define MAXCHAR 100

#define BUFSIZE 2048
#define RPI_CONTROLLER '2'
#define RPI_MONITOR '3'
struct sockaddr_in myaddr;	/* our address */
struct sockaddr_in remaddr;	/* remote address */
socklen_t addrlen = sizeof(remaddr);		/* length of addresses */
int recvlen;			/* # bytes received */
int fd;				/* our socket */
int msgcnt = 0;			/* count # of messages we received */
unsigned char buf[BUFSIZE];	/* receive buffer */

int UDP_Server_setup(){
	extern struct sockaddr_in myaddr;	/* our address */
	extern struct sockaddr_in remaddr;	/* remote address */
	extern int fd;				/* our socket */

	/* create a UDP socket */

	if ((fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
		perror("cannot create socket\n");
		return 0;
	}

	/* bind the socket to any valid IP address and a specific port */

	memset((char *)&myaddr, 0, sizeof(myaddr));
	myaddr.sin_family = AF_INET;
	myaddr.sin_addr.s_addr = htonl(INADDR_ANY);
	myaddr.sin_port = htons(SERVICE_PORT);

	if (bind(fd, (struct sockaddr *)&myaddr, sizeof(myaddr)) < 0) {
		perror("bind failed");
		return 0;
	}
	return 0;
}

int main(int argc, char **argv)
{		
	UDP_Server_setup();
	
	extern struct sockaddr_in myaddr;	/* our address */
	extern struct sockaddr_in remaddr;	/* remote address */
	extern socklen_t addrlen;		/* length of addresses */
	extern int recvlen;			/* # bytes received */
	extern int fd;				/* our socket */
	extern int msgcnt;			/* count # of messages we received */
	extern unsigned char buf[BUFSIZE];	/* receive buffer */
	
	FILE *f_sensor = fopen("sensor.txt","r");
	if(f_sensor == NULL){
		printf("Error opening file");
	}
	char str[MAXCHAR];
	char str_pwm[5];
	int rpi_num = RPI_CONTROLLER;
	
	while(1){
		
		
		printf("waiting on port %d\n", SERVICE_PORT);
		recvlen = recvfrom(fd, buf, BUFSIZE, 0, (struct sockaddr *)&remaddr, &addrlen);
		if (recvlen > 0) {
			buf[recvlen] = 0;
			printf("received message: \"%s\" (%d bytes)\n", buf, recvlen);
		}
		else
			printf("uh oh - something went wrong!\n");
		
		//printf("received message: \"%s\n", buf);
		f_sensor = fopen("sensor.txt","r");
		fgets(str, MAXCHAR, f_sensor);
		close(f_sensor);
		
		//printf("a %c\n", buf[0]);
		
		//memset(str_pwm, '\0', sizeof(str_pwm));
		//strncpy(str_pwm, str+2, 4);		
		//printf("b %s c\n", str_pwm);
		
		if(buf[0] == RPI_CONTROLLER){
			rpi_num = RPI_CONTROLLER;
			memset(str_pwm, '\0', sizeof(str_pwm));
			strncpy(str_pwm, buf+2, 4);
			printf("%s, %s", str_pwm, str);
			sprintf(buf, "%s", str);
			
		}else if(buf[0] == RPI_MONITOR){
			rpi_num = RPI_MONITOR;
			sprintf(buf, "%s,%s", str, str_pwm);
		}		
	
		//sprintf(buf, "ack %d", msgcnt++);
		printf("sending response \"%s\"\n", buf);
		if (sendto(fd, buf, strlen(buf), 0, (struct sockaddr *)&remaddr, addrlen) < 0)
			perror("sendto");			
	}
	return 0;
}
