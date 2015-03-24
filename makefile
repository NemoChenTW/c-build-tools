ifdef PROJECTNAME
EXE = $(PROJECTNAME)
else
PROJECTDIR = $(shell pwd)
EXE = $(notdir $(basename $(PROJECTDIR)))
endif

-include source.mk

ALIB = "lib$(EXE).a"
OLIB = "lib$(EXE).o"


# => This section can include outer file for personal setting.
INCLUDEPATH = -Isrc/
INCLUDEFILE = 

LIB =  
LIBPATH = 

SO = 

LINKFLAG += -o
CCFLAG += -g -c

-include project.mk
# <= This section can include outer file for personal setting.

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

SRCLISTSUBDIRS = $(SUBMODULEDIR:%=srclist-%)
CLEANSUBDIRS = $(SUBMODULEDIR:%=clean-%)
CLEANALLSUBDIRS = $(SUBMODULEDIR:%=cleanall-%)

.PHONY: sub $(SUBMODULEDIR)
.PHONY: srclistsub $(SRCLISTSUBDIRS)
.PHONY: cleansub $(CLEANSUBDIRS)
.PHONY: cleanallsub $(CLEANALLSUBDIRS)

##Color Setting
lightYellow="\\033[33\;1m"
lightGreen="\\033[32\;1m"
lightRed="\\033[31\;1m"
colorEnd="\\033[0m"

#Message using color
colorStart=$(lightYellow)
##Color Setting

SUCCESSMSG="$(lightYellow)Build success.$(colorEnd)"

mainproject:
	$(MAKE) exe && echo $(SUCCESSMSG)
	
exe: $(EXE)


all:
	$(MAKE) sub
	$(MAKE) mainproject && echo $(SUCCESSMSG)

$(EXE): $(OBJS)
	$(CC) $(LINKFLAG) $(EXE) $(OBJS) $(SUBMODULELOC) $(SUBMODULE) $(LIB) $(LIBPATH) $(SO)

$(OBJS): $(SOURCEPATH)
	$(CC) $(CCFLAG) $(SOURCEPATH) $(INCLUDEPATH) $(INCLUDEFILE)

liba: $(ALIB)

$(ALIB): $(OBJS)
	$(STATICLIB) $(ALIB) $(OBJS)

# => Generate sourcelist
srclist:
	if [ -f slist ]; then ./slist ;else ./c-build-tools/slist; fi;
	make srclistsub

srclistsub: $(SRCLISTSUBDIRS)
$(SRCLISTSUBDIRS):
	$(MAKE) -C $(@:srclist-%=%) srclist

# <= Generate sourcelist

# => Build submodule
sub: $(SUBMODULEDIR)
$(SUBMODULEDIR):
	$(MAKE) liba -C $@ && echo $(SUCCESSMSG)
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
	rm -f *.o *.a $(EXE) 
