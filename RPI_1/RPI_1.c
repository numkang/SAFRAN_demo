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
#include <bcm2835.h>
#include <pthread.h>

#define BUFSIZE 2048
#define RPI_CONTROLLER 2
#define RPI_MONITOR 3
struct sockaddr_in myaddr;	/* our address */
struct sockaddr_in remaddr;	/* remote address */
socklen_t addrlen = sizeof(remaddr);		/* length of addresses */
int recvlen;			/* # bytes received */
int fd;				/* our socket */
int msgcnt = 0;			/* count # of messages we received */
unsigned char buf[BUFSIZE];	/* receive buffer */

#define PIN RPI_GPIO_P1_12
#define PWM_CHANNEL 0
#define RANGE 2048
#define MIN_DATA 900
#define MAX_DATA 1800
int direction = 1;
int data = 1350;

int UDP_Server_setup(){
	extern struct sockaddr_in myaddr;	/* our address */
	extern struct sockaddr_in remaddr;	/* remote address */
	extern socklen_t addrlen;		/* length of addresses */
	extern int recvlen;			/* # bytes received */
	extern int fd;				/* our socket */
	extern int msgcnt;			/* count # of messages we received */
	extern unsigned char buf[BUFSIZE];	/* receive buffer */

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

void *UDP_communication(void *ptr){
	extern struct sockaddr_in myaddr;	/* our address */
	extern struct sockaddr_in remaddr;	/* remote address */
	extern socklen_t addrlen;		/* length of addresses */
	extern int recvlen;			/* # bytes received */
	extern int fd;				/* our socket */
	extern int msgcnt;			/* count # of messages we received */
	extern unsigned char buf[BUFSIZE];	/* receive buffer */
	
	printf("waiting on port %d\n", SERVICE_PORT);
	recvlen = recvfrom(fd, buf, BUFSIZE, 0, (struct sockaddr *)&remaddr, &addrlen);
	if (recvlen > 0) {
		buf[recvlen] = 0;
		printf("received message: \"%s\" (%d bytes)\n", buf, recvlen);
	}
	else
		printf("uh oh - something went wrong!\n");
	sprintf(buf, "ack %d", msgcnt++);
	printf("sending response \"%s\"\n", buf);
	if (sendto(fd, buf, strlen(buf), 0, (struct sockaddr *)&remaddr, addrlen) < 0)
		perror("sendto");
		
	return ptr;
}

int PWM_setup(){
	if (!bcm2835_init())
	return 1;
	
	bcm2835_gpio_fsel(PIN, BCM2835_GPIO_FSEL_ALT5);
    bcm2835_pwm_set_clock(BCM2835_PWM_CLOCK_DIVIDER_16);
    bcm2835_pwm_set_mode(PWM_CHANNEL, 1, 1);
    bcm2835_pwm_set_range(PWM_CHANNEL, RANGE);
    bcm2835_pwm_set_data(PWM_CHANNEL, MIN_DATA);
    //bcm2835_delay(8000); //wait for a motor to be initialized
    
    return 0;
}

void *PWM_send(void *PWM){
	/* For Testing PWM only */
	extern int direction;
	extern int data;
	//bcm2835_pwm_set_data(PWM_CHANNEL, 1378); //motor starts at 1378
	if (data == MIN_DATA)
	    direction = 1;   // Switch to increasing
	else if (data == MAX_DATA)
	    direction = -1;  // Switch to decreasing
	data += direction;
	bcm2835_pwm_set_data(PWM_CHANNEL, data);
	//printf("%d\n", data);
	bcm2835_delay(1);
	/* End for Testing PWM */
	
	int pwm = (int) PWM;
	return PWM;
}

int main(int argc, char **argv)
{	
	UDP_Server_setup();
	PWM_setup();
	
	//while(1){
		//PWM_send(0);
		//UDP_communication();
		
		int PWM = 0;
		int thr = 1;
		pthread_t thread1, thread2;
		pthread_create(&thread1, NULL, *UDP_communication, (void *) thr);
		pthread_create(&thread2, NULL, *PWM_send, (void *) PWM);
		
		pthread_join(thread1, NULL);
		pthread_join(thread2, NULL);
		
	//}
	//while(1);
	
	//close(fd);
	return 0;
}
