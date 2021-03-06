# Top-level directory containing ableC repository and extensions folder
ABLEC_BASE?=../../../ableC
EXTS_BASE?=../../../extensions

# The jar file to built
ABLEC_JAR=../examples/ableC.jar
# The artifact specification grammar to compile
ARTIFACT=artifact
# All directories containing grammars that may be included
GRAMMAR_DIRS=$(wildcard $(EXTS_BASE)/*/grammars) $(ABLEC_BASE) ../examples
# All silver files in included grammars, to be included as dependancies
GRAMMAR_SOURCES=$(shell find $(GRAMMAR_DIRS) -name *.sv -print0 | xargs -0)
# Flags passed to silver including the appropriate directories
SVFLAGS=$(addprefix -I , $(GRAMMAR_DIRS))

# All extended C files to test
XC_FILES=$(wildcard translate_error/*.xc) $(wildcard runtime_error/*.xc) $(wildcard positive/*.xc)
# All extended C files that should translate successfully
TRANS_XC_FILES=$(wildcard runtime_error/*.xc) $(wildcard positive/*.xc)
# All C files that should be generated
C_FILES=$(TRANS_XC_FILES:.xc=.c)
# All object files that should be generated
OBJECTS=$(TRANS_XC_FILES:.xc=.o)
# All executables that should be generated
EXECUTABLES=$(TRANS_XC_FILES:.xc=.out)
# All evaluation marker files that should be generated
TESTS=$(XC_FILES:.xc=.test)

# All directories contining extension header files that may be included
XC_INCLUDE_DIRS=$(wildcard $(EXTS_BASE)/*/include)
# Flags passed to ableC including the appropriate directories
XCFLAGS=$(addprefix -I, $(XC_INCLUDE_PATH))

# All directories contining extension libraries that may be linked
LIB_DIRS=$(wildcard $(EXTS_BASE)/*/lib)
# Flags passed to the linker specifying the appropriate directories
LDLIBS=$(addprefix -L, $(LIB_DIRS)) -lm -lcilkrts

all: $(ABLEC_JAR) $(C_FILES) $(OBJECTS) $(EXECUTABLES) $(TESTS)

.PHONY: $(ABLEC_JAR)
$(ABLEC_JAR):
	make -C $(dir $(ABLEC_JAR)) ableC.jar

# This is phony despite being a real file, because the Makefile in src checks
# if the source files have been modified or not.
.PHONY: ../src/libTensorsLib.a ../src/libTensorsLib.so
../src/libTensorsLib.a:
	@cd ../src && make libTensorsLib.a
../src/libTensorsLib.so:
	@cd ../src && make libTensorsLib.so

%.c: %.xc $(ABLEC_JAR)
	java -jar $(ABLEC_JAR) $< $(XCFLAGS)

%.out: %.o ../src/libTensorsLib.a
	$(CC) $(LDFLAGS) $^ $(LOADLIBES) $(LDLIBS) -o $@

translate_error/%.test: translate_error/%.xc $(ABLEC_JAR)
	@echo "java -jar $(ABLEC_JAR) $< $(XCFLAGS)"
	@if java -jar $(ABLEC_JAR) $< $(XCFLAGS); then exit 1; fi
	touch $@

runtime_error/%.test: runtime_error/%.out
	@echo "./$<"
	@if ./$<; then echo "Failed to error"; exit 2; else echo "(exit $$?)"; fi
	touch $@

%.test: %.out
	@echo "./$<"
	@./$< || echo "(exit $$?)"
	touch $@

clean:
	rm -f *~ build.xml */*.i */*.c */*.o */*.out */*.test *.jar *.copperdump.html build.xml

.PHONY: all clean
