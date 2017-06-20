# Flags needed to add the headers to the library.
CFLAGS+=-I../include

# Flags needed to create a shared library.
CFLAGS+=-fpic
LDFLAGS=-lm

# The C source and object files.
C_SOURCES=$(wildcard *.c)
C_OBJECTS=$(C_SOURCES:.c=.o)

all: libTensorsLib.so

libTensorsLib.a: $(C_OBJECTS)
	ar rcs $@ $^

libTensorsLib.so: $(C_OBJECTS)
	gcc $(LDFLAGS) -shared -o $@ $^

clean:
	rm -f *~ *.a *.i *.o *.so

.PHONY: all clean
