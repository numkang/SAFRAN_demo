CC=gcc
CFLAGS = -g 
# uncomment this for SunOS
# LIBS = -lsocket -lnsl

all: RPI_1

RPI_1: RPI_1.o 
	$(CC) -o RPI_1 RPI_1.o $(LIBS)

RPI_1.o: RPI_1.c port.h

clean:
	rm -f RPI_1 RPI_1.o
