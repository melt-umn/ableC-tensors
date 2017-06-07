# Top-level directory containing ableC repository and extensions folder
ABLEC_BASE?=../../../ableC
EXTS_BASE?=../../../extensions

# All directories containing grammars that may be included
GRAMMAR_DIRS=$(ABLEC_BASE) $(EXTS_BASE)/ableC-arrays/grammars

# All silver files in included grammars, to be included as dependancies
GRAMMAR_SOURCES=$(shell find $(GRAMMAR_DIRS) -name *.sv -print0 | xargs -0)

CFLAGS+=-I../include -L../src -lArraysLib

all: ableC.jar examples

ableC.jar: $(GRAMMAR_SOURCES)
	touch artifact/Artifact.sv
	silver -o $@ -I $(ABLEC_BASE) \
		     -I $(EXTS_BASE)/ableC-arrays/grammars \
		     artifact

# This is phony despite being a real file, because the Makefile in src checks
# if the source files have been modified or not.
.PHONY: ../src/libArraysLib.so
../src/libArraysLib.so:
	@cd ../src && make

examples: simple_cat.out

simple_cat.c: ableC.jar simple_cat.xc ../src/libArraysLib.so
	java -jar ableC.jar simple_cat.xc $(CFLAGS)

simple_cat.out: simple_cat.c
	gcc $(CFLAGS) simple_cat.c -o simple_cat.out

clean:
	rm -f *~ *.i *.c *.o *.out *.test *.jar *.copperdump.html build.xml

.PHONY: all clean
