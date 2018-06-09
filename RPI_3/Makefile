CC=gcc
CFLAGS = -g 
# uncomment this for SunOS
# LIBS = -lsocket -lnsl

all: RPI_3

RPI_3: RPI_3.o 
	$(CC) -o RPI_3 RPI_3.o -lwiringPi $(LIBS)

RPI_3.o: RPI_3.c port.h

clean:
	rm -f RPI_3 RPI_3.o
