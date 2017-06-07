# Flags needed to add the headers to the library.
CFLAGS+=-I../include

# Flags needed to create a shared library.
CFLAGS+=-fpic -shared

# The C source files.
C_SOURCES=$(wildcard *.c)

all: libArraysLib.so

libArraysLib.so: $(C_SOURCES)
	gcc $(CFLAGS) -o libArraysLib.so $(C_SOURCES)

clean:
	rm -f *~ *.i *.c *.o

.PHONY: all clean
