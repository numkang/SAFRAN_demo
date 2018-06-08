CC=gcc
CFLAGS = -g -ggdb3 -Wall
# uncomment this for SunOS
# LIBS = -lsocket -lnsl
LIBS=-lphidget22 -lbcm2835 -lpthread 

#all: RPI_1 RPI_PWM RPI_UDP

#RPI_1: RPI_1.o 
#	$(CC) -o RPI_1 RPI_1.o $(LIBS) ${CFLAGS}

#RPI_1.o: RPI_1.c port.h

#clean:
#	rm -f RPI_1 RPI_1.o RPI_PWM RPI_PWM.o RPI_SENSOR RPI_SENSOR.o

all: RPI_PWM RPI_UDP RPI_SENSOR

RPI_UDP: RPI_UDP.o 
	$(CC) -o RPI_UDP RPI_UDP.o ${LIBS} ${CFLAGS}

RPI_PWM: RPI_PWM.o 
	$(CC) -o RPI_PWM RPI_PWM.o ${LIBS} ${CFLAGS}
	
RPI_SENSOR: RPI_SENSOR.o 
	$(CC) -o RPI_SENSOR RPI_SENSOR.o ${LIBS} ${CFLAGS} ${SRCS} ${INCDIR}

RPI_UDP.o: RPI_UDP.c port.h

RPI_PWM.o: RPI_PWM.c

RPI_SENSOR.o: RPI_SENSOR.c PhidgetHelperFunctions.c PhidgetHelperFunctions.h

clean:
	rm -f RPI_UDP RPI_UDP.o RPI_PWM RPI_PWM.o RPI_SENSOR RPI_SENSOR.o
