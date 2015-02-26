ifdef PROJECTNAME
EXE = $(PROJECTNAME)
else
PROJECTDIR = $(shell pwd)
EXE = $(notdir $(basename $(PROJECTDIR)))
endif

include sourcelist
ALIB = "lib$(EXE).a"
OLIB = "lib$(EXE).o"

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

CLEANSUBDIRS = $(SUBMODULEDIR:%=clean-%)
CLEANALLSUBDIRS = $(SUBMODULEDIR:%=cleanall-%)

all: $(EXE)

$(EXE): $(OBJS)
	$(CC) $(LINKFLAG) $(EXE) $(OBJS) $(SUBMODULELOC) $(SUBMODULE) $(LIB) $(LIBPATH) $(SO)

$(OBJS): $(SOURCEPATH)
	$(CC) $(CCFLAG) $(SOURCEPATH) $(INCLUDEPATH) $(INCLUDEFILE)

liba: $(ALIB)

$(ALIB): $(OBJS)
	$(STATICLIB) $(ALIB) $(OBJS)

# => Build submodule
sub: $(SUBMODULEDIR)
$(SUBMODULEDIR):
	$(MAKE) liba -C $@
# <= Build submodule

# => Clean submodule
cleansub: $(CLEANSUBDIRS)
$(CLEANSUBDIRS): 
	$(MAKE) -C $(@:clean-%=%) clean

cleanallsub: $(CLEANALLSUBDIRS)
$(CLEANALLSUBDIRS): 
	$(MAKE) -C $(@:cleanall-%=%) cleanall
# <= Clean submodule

clean:
	make cleansub
	rm -f *.o

cleanall:
	make cleanallsub
	rm -f *.o $(EXE)


.PHONY: sub $(SUBMODULEDIR)
.PHONY: cleansub $(CLEANSUBDIRS)
.PHONY: cleanallsub $(CLEANSUBDIRS)