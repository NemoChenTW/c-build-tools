ifdef PROJECTNAME
EXE = $(PROJECTNAME)
else
PROJECTDIR = $(shell pwd)
EXE = $(notdir $(basename $(PROJECTDIR)))
endif

ALIB = "lib$(EXE).a"
OLIB = "lib$(EXE).o"

DIR = src/

SOURCE = *.cpp
SOURCELOCATION = $(DIR:/=/$(SOURCE))

INCLUDEPATH = -Isrc/
INCLUDEFILE = 

LIB =  
LIBPATH = 

SO = 
SUBLIB = src/submodule/*.a


LINKFLAG = -o
CCFLAG = -g -c

OBJS = $(SOURCE:.cpp=.o)

OS := $(shell uname)
ifeq ($(OS),Darwin)
# Run MacOS commands 
CC = clang++ -w -std=c++11
else
# check for Linux and run other commands
CC = g++ -w -std=c++11
endif

STATICLIB = ar rcv

all: $(EXE)

bl:
	$(MAKE) liba -C src/submodule && make

rbl:
	make cleanall && make bl

$(EXE): $(OBJS)
	$(CC) $(LINKFLAG) $(EXE) $(OBJS) $(SUBLIB) $(LIB) $(LIBPATH) $(SO)

$(OBJS): $(SOURCELOCATION)
	$(CC) $(CCFLAG) $(SOURCELOCATION) $(INCLUDEPATH) $(INCLUDEFILE)

liba: $(ALIB)

$(ALIB): $(OBJS)
	$(STATICLIB) $(ALIB)


clean:
	$(MAKE) -C src/submodule clean
	rm -f *.o

cleanall:
	$(MAKE) -C src/submodule cleanall
	rm -f *.o $(EXE) $(ALIB)
