# Flags needed to add the headers to the library.
CFLAGS+=-I../include

# Flags needed to create a shared library.
CFLAGS+=-fpic
LDLIBS+=-lm

# Flags to ensure good style.
CFLAGS+=-Wall -Wextra -Wpedantic -Werror -std=c11

# The C source and object files.
C_SOURCES=$(wildcard *.c)
C_OBJECTS=$(C_SOURCES:.c=.o)

all: libTensorsLib.so

libTensorsLib.a: $(C_OBJECTS)
	ar rcs $@ $^

libTensorsLib.so: $(C_OBJECTS)
	gcc $(LDFLAGS) -shared -o $@ $^ $(LDLIBS)

clean:
	rm -f *~ *.a *.i *.o *.so

.PHONY: all clean
