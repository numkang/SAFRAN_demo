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
#define RPI_NUM 2
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
		//printf("Sending packet %d to %s port %d\n", i, server, SERVICE_PORT);
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

float send_PWM_request_SENSOR(int PWM, int *start_flag){
	extern struct sockaddr_in myaddr, remaddr;
	extern int fd, i, slen;
	extern char buf[BUFLEN];	/* message buffer */
	extern int recvlen;		/* # bytes in acknowledgement message */
	extern char *server;
	float sensor_data = 0.0;
	char str_start[1];
	char str_sensor[MAXCHAR];
	
	//printf("Sending packet %d to %s port %d\n", i, server, SERVICE_PORT);
	sprintf(buf, "%d,%d", RPI_NUM, PWM);
	if (sendto(fd, buf, strlen(buf), 0, (struct sockaddr *)&remaddr, slen)==-1) {
		perror("sendto");
		exit(1);
	}
	/* now receive an acknowledgement from the server */
	recvlen = recvfrom(fd, buf, BUFLEN, 0, (struct sockaddr *)&remaddr, &slen);
    if (recvlen >= 0) {
        buf[recvlen] = 0;	/* expect a printable string - terminate it */
        //printf("received message: \"%s\"\n", buf);
    }
    strncpy(str_start, buf, 1);
    strcpy(str_sensor, buf+2);
    //printf("start: %s\n",str_start);
    //printf("start: %s\n",str_sensor);
    *start_flag = str_start[0] - 48; //atoi(str_start);
    sensor_data = atof(str_sensor);
    return sensor_data;
}

int Controller(float thrust_goal, float meas_thrust, float* integral){
	// float force = 0;
	// PID controller
	float Kp = 2.0; // to be tuned
	float Ki = 0.0; // to be tuned
	
	float error = thrust_goal - meas_thrust; 
	
	*integral = *integral + error;
	
	float thrust_cmd = thrust_goal + (Kp * error + Ki * *integral); //round + offset: 1378 correspnds to the value above which the PWM signals makes the rotor rotate
	// saturation of the PWM command
	int pwm_command = (int)(2.5625*thrust_cmd*thrust_cmd + 32.6422*thrust_cmd + 1359.7555);
	if(pwm_command > 1780){pwm_command = 1780;}
	else if(pwm_command < 1380){pwm_command = 1300 ;}
	
	//printf("%f, %d ", thrust_cmd, pwm_command);
	
	return pwm_command;
}

int main(void)
{	
	FILE *f_thrust = fopen("thrust_measure.txt","w");
	if(f_thrust == NULL){
		printf("Error opening file");
	}
	
	int start_flag = 0;
	float thrust_goal = 3.0; //newton
	float thrust_measure = 0.0;
	float integral = 0;
	
	UDP_Client_setup();
	int PWM = 1300; //1000;
	float sensor_data = 0.0, filtered_sensor_data = 0.0, p_sensor_data = 0.0, alpha = 0.98;
	
	sensor_data = send_PWM_request_SENSOR(PWM, &start_flag);
	int avg_num = 100000;
	float sensor_data_sum = 0.0, offset = 0.0;;
	for(int i = 0; i < avg_num; i++){
		sensor_data_sum = sensor_data_sum + sensor_data;
	}
	offset = sensor_data_sum/avg_num;
	
	while(1){ // should be set to send message in every ... second so that it won't be a conflict with another RPI
	//for(int i = 0; i < 200; i++){ //
	
		//p_sensor_data = sensor_data;
		sensor_data = send_PWM_request_SENSOR(PWM, &start_flag);// - offset;
		//filtered_sensor_data = alpha*(p_sensor_data) + (1 - alpha)*sensor_data; //complementary filter
		filtered_sensor_data = sensor_data;
		thrust_measure = (186689.069*sensor_data - 13.540); //newton
		
		//PWM = Controller(thrust_goal, thrust_measure, &integral);
		
		if(start_flag > 0 && start_flag < 2){
			PWM = Controller(thrust_goal, thrust_measure, &integral);
			fprintf(f_thrust, "%d %.12f\n", PWM, thrust_measure);
		}else if (start_flag >= 2){
			PWM = 1300;
			fprintf(f_thrust, "%d %.12f\n", PWM, thrust_measure);
		}else{
			PWM = 1300;
		}
		
		printf("CMD = %d | | ", PWM);
		printf("Start: %d, Measured thrust = %f\n", start_flag, thrust_measure);
	}
	close(fd);
	return 0;
}
