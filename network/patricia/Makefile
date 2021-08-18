CC?=gcc

all: patricia

patricia: patricia.c patricia_test.c
	$(CC) -static patricia.c patricia_test.c -O3 -o patricia

clean:
	rm -rf patricia output*
