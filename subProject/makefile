#This makefile is for submodule

ifdef PROJECTNAME
EXE = $(PROJECTNAME)
else
PROJECTDIR = $(shell pwd)
EXE = $(notdir $(basename $(PROJECTDIR)))
endif

LIB_A = lib$(EXE).a
LIB_O = lib$(EXE).o

#sourcelist included SOURCE and SOURCEPATH
include sourcelist

OBJS = $(SOURCE:.cpp=.o)

INCLUDEPATH = -Isrc/
INCLUDEFILE = 

LIB =  
LIBPATH = 

SO = 

LINKFLAG = -o
CCFLAG = -g -c

OS := $(shell uname)
ifeq ($(OS),Darwin)
# Run MacOS commands 
CC = clang++ -w -std=c++11
else
# check for Linux and run other commands
CC = g++ -w -std=c++11
endif

CC_LIBA = ar rcs

all: $(EXE)

$(EXE): $(OBJS)
	$(CC) $(LINKFLAG) $(EXE) $(OBJS) $(LIB) $(LIBPATH) $(SO)

$(OBJS): $(SOURCEPATH)
	$(CC) $(CCFLAG) $(SOURCEPATH) $(INCLUDEPATH) $(INCLUDEFILE)


liba: $(LIB_A)

$(LIB_A): $(OBJS)
	$(CC_LIBA) $(LIB_A) $(OBJS)


$(TESTOBJS): $(TESTSRC)
	$(CC) $(CCFLAG) $(TESTSRC) $(INCLUDEPATH) $(INCLUDEFILE)

clean:
	rm -f *.o

cleanall:
	rm -f *.o $(EXE) $(LIB_A)
