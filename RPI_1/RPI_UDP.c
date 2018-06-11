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
	
	FILE *f_log = fopen("start_logging.txt","w");
	if(f_log == NULL){
		printf("Error opening file start_logging.txt");
	}
	fprintf(f_log, "0");
	fclose(f_log);
	
	f_log = fopen("start_logging.txt","r");
	if(f_log == NULL){
		printf("Error opening file start_logging.txt");
	}
	char str_start[2];
	
	FILE *f_PWM = fopen("pwm.txt","w");
	if(f_PWM == NULL){
		printf("Error opening file pwm.txt");
	}
	
	FILE *f_sensor = fopen("sensor.txt","r");
	if(f_sensor == NULL){
		printf("Error opening file sensor.txt");
	}
	char str[MAXCHAR];
	char str_pwm[5];
	int rpi_num = RPI_CONTROLLER;
	
	while(1){		
		
		//printf("waiting on port %d\n", SERVICE_PORT);
		recvlen = recvfrom(fd, buf, BUFSIZE, 0, (struct sockaddr *)&remaddr, &addrlen);
		if (recvlen > 0) {
			buf[recvlen] = 0;
			printf("received message: \"%s\" (%d bytes)\n", buf, recvlen);
		}
		else
			printf("uh oh - something went wrong!\n");

		//printf("bbb\n");
		f_sensor = fopen("sensor.txt","r");
		if(f_sensor == NULL){
			printf("Error opening file sensor.txt");
		}else{
			memset(str, '\0', sizeof(str));
			fgets(str, MAXCHAR, f_sensor);			
		}
		fclose(f_sensor);
		
		f_log = fopen("start_logging.txt","r");
		if(f_log == NULL){
			printf("Error opening file start_logging.txt");
		}else{
			memset(str_start, '\0', sizeof(str_start));
			fgets(str_start, 2, f_log);		
		}
		fclose(f_log);
		
		if(buf[0] == RPI_CONTROLLER){
			rpi_num = RPI_CONTROLLER;
			memset(str_pwm, '\0', sizeof(str_pwm));
			//printf("aaa\n");
			strncpy(str_pwm, buf+2, 4);
			if(str_start == NULL){
				sstrcpy(str_start, "0", 1);
			}
			printf("%s, %s, %s\n", str_pwm, str, str_start);
			sprintf(buf, "%s,%s", str_start, str);
			
			rewind(f_PWM);
			fprintf(f_PWM, "%s", str_pwm);
		}else if(buf[0] == RPI_MONITOR){
			rpi_num = RPI_MONITOR;
			sprintf(buf, "%s,%s,%s", str_start, str_pwm, str);
		}		
	
		//sprintf(buf, "ack %d", msgcnt++);
		//printf("sending response \"%s\"\n", buf);
		if (sendto(fd, buf, strlen(buf), 0, (struct sockaddr *)&remaddr, addrlen) < 0)
			perror("sendto");			
	}
	return 0;
}
