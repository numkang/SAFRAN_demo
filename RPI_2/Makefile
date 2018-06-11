CC=gcc
CFLAGS = -g 
# uncomment this for SunOS
# LIBS = -lsocket -lnsl

all: RPI_2

RPI_2: RPI_2.o 
	$(CC) -o RPI_2 RPI_2.o -lwiringPi $(LIBS)

RPI_2.o: RPI_2.c port.h

clean:
	rm -f RPI_2 RPI_2.o
