/*
        demo-udp-03: udp-recv: a simple udp server
	receive udp messages

        usage:  udp-recv

        Paul Krzyzanowski
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <bcm2835.h>

#define MAXCHAR 5
#define PIN RPI_GPIO_P1_12
#define PWM_CHANNEL 0
#define RANGE 2048
#define MIN_DATA 900
#define MAX_DATA 1800
int direction = 1;
int data = 1300;

int PWM_setup(){
	if (!bcm2835_init())
	return 1;
	
	bcm2835_gpio_fsel(PIN, BCM2835_GPIO_FSEL_ALT5);
    bcm2835_pwm_set_clock(BCM2835_PWM_CLOCK_DIVIDER_16);
    bcm2835_pwm_set_mode(PWM_CHANNEL, 1, 1);
    bcm2835_pwm_set_range(PWM_CHANNEL, RANGE);
    bcm2835_pwm_set_data(PWM_CHANNEL, MIN_DATA);
    bcm2835_delay(10000); //wait for a motor to be initialized
    
    return 0;
}

void PWM_send(int PWM){
	/* For Testing PWM only */
	extern int direction;
	extern int data;
	bcm2835_pwm_set_data(PWM_CHANNEL, PWM); //motor starts at 1378
	/*if (data == 1350)
	    direction = 1;   // Switch to increasing
	else if (data == 1400)
	    direction = -1;  // Switch to decreasing
	data += direction;
	bcm2835_pwm_set_data(PWM_CHANNEL, data);
	printf("%d\n", data);*/
	//bcm2835_delay(1);
	/* End for Testing PWM */
}

int main(int argc, char **argv)
{	
	FILE *f_sensor = fopen("pwm.txt","r");
	if(f_sensor == NULL){
		printf("Error opening file pwm.txt");
	}
	char str_pwm[MAXCHAR];
	PWM_setup();
	int PWM = 1000;
	unsigned long i = 0;
	
	while(1){
		f_sensor = fopen("pwm.txt","r");
		if(f_sensor == NULL){
			printf("Error opening file pwm.txt");
		}else{
			fgets(str_pwm, MAXCHAR, f_sensor);
		}
		fclose(f_sensor);
		PWM = atoi(str_pwm);
		
		if(i < 2000){
			PWM = 1300;
			i++;
		}else if(i >= 2000 && i < 32000){
			//PWM = 1460;
			i++;
		}else if(i >= 32000 && i < 60000){
			PWM = 1300;
			i++;
		}else{
			PWM = MIN_DATA;
		}
		
		//printf("%lu,%d\n",i,PWM);
		PWM_send(PWM);
		
		//delay(1);	
		bcm2835_delay(1);		
	}
	return 0;
}
