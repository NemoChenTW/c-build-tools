# c-build-tools
C++ build tools for the project include sub-module.

## Quick Use ##
First you have to ensure the projet file system architecture is correct.

### Build ###
  1. `make srclist`
  2. `make all`

### Clean Project ###
  1. `make cleanall`

### Checkout branch ###
  1. `./checkout branchname`

## File System ##
An independent repo should have directory `src/`, the `slist` script will recognize the src folder and treat them as submodule.

The file system is shown as follow.
```
Project
|- checkout
|- makefile
|- slist
|- src/
   |- source.cpp
   |- sourceheader.h
   |- submodule_A/
      |- makefile
      |- slist
      |- src/
         |- subsource.cpp
         |- subsource.h
   |- submodule_B/
      |- makefile
      |- slist
      |- src/
         |- subsource2.cpp
         |- subsource2.h
```
The main project include 2 submodules `submodule_A` and `submodule_B`.

## slist ##
This script is using for generating the `sourcelist` file which is need in build session.

The file `sourcelist` include the souece and submoudle information. <br/>
The example is shown as follow.
```
SUBDIR = -path ./src/submodule_A -o -path ./src/submodule_B
SOURCE = source.cpp
SOURCEPATH = ./src/source.cpp
SUBMODULEDIR = src/submodule_A src/submodule_B
SUBMODULELOC = -Lsrc/submodule_A -Lsrc/submodule_B
SUBMODULE = -lsubmodule_A -lsubmodule_B
```

## makefile ##
This makefile will include the `sourcelist` generated by `slist` for sourece information.

### Rule ###
* srclist
  - Generate `sourcelist` for main project and submodules.
* all
  - Build main project and all submodules.
* sub
  - Build all submodule as static library.
* clean
  - Remove all .o file in main project and submodules.
* cleansub
  - Remove all .o file in submodules.
* cleanall
  - Remove all .o .a and execution file in main project and submodules.
* cleanallsub
  - Remove all .o .a and execution file in submodules.

## checkout ##
Considering the git submoule is not 100% suit for the submoulde with multi-version control by branch, 
this script can switch the branch by one command for main project and all submoudles.

Input the branch name as parameter, the script will change directory to all submodule 
and checkout the git branch according to the input branch name.

`./checkout branchname`