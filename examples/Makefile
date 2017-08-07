# Top-level directory containing ableC repository and extensions folder
ABLEC_BASE?=../../../ableC
EXTS_BASE?=../../../extensions

# All directories containing grammars that may be included
GRAMMAR_DIRS=$(ABLEC_BASE) $(EXTS_BASE)/ableC-tensors/grammars

# All silver files in included grammars, to be included as dependancies
GRAMMAR_SOURCES=$(shell find $(GRAMMAR_DIRS) -name *.sv -print0 | xargs -0)

# The C source files.
XC_SOURCES=$(wildcard *.xc)

CFLAGS+=-I../include -Wall -Wextra -Wpedantic -std=c11 $(shell sdl-config --cflags)
LDLIBS+=-lm $(shell sdl-config --libs)

all: ableC.jar examples

ableC.jar: $(GRAMMAR_SOURCES)
	touch artifact/Artifact.sv
	silver --clean -o $@ -I $(ABLEC_BASE) \
		     -I $(EXTS_BASE)/ableC-tensors/grammars \
		     artifact

# This is phony despite being a real file, because the Makefile in src checks
# if the source files have been modified or not.
.PHONY: ../src/libTensorsLib.a ../src/libTensorsLib.so
../src/libTensorsLib.a:
	@cd ../src && make libTensorsLib.a
../src/libTensorsLib.so:
	@cd ../src && make libTensorsLib.so

examples: $(XC_SOURCES:.xc=.out)

%.out: %.o ../src/libTensorsLib.a
	gcc $(LDFLAGS) -o $@ $^ $(LDLIBS)

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $^

%.c: %.xc ableC.jar
	java -jar ableC.jar $<

clean:
	rm -f *~ *.i *.o *.c *.out *.test *.jar *.copperdump.html build.xml

.PHONY: all clean
