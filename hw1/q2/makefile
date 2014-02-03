PACKAGE= kdtree1_1
MAIN= ./main
CFLAGS=-g -ansi -pedantic -DNDEBUG # -DDEBUG # -DNDEBUG
SRC= kdtree.c vector.c
OBJ= kdtree.o vector.o
SRCALL= $(MAIN).c $(SRC)
ALLH= dfn.h kdtree.h vector.h
CC= gcc
SCRIPTS= input.script inp-large.script 2d-input.txt 3d-input.txt
COPYRIGHT= COPYRIGHT
REV=
.IGNORE:
# .SILENT:
LPR= lpr

all: 
	echo "implement k-nearest neighbor search using KD-Tree"

demo: $(MAIN) input.script
	echo "**** DEMO ***"
	$(MAIN) -d 4 < input.script

hw1: $(MAIN) 2d-input.txt 3d-input.txt
	echo "**** HW1 - 2d case *** "
	$(MAIN) -d 2 < 2d-input.txt #> 2d-output.txt
	echo "**** HW1 - 3d case *** "
	$(MAIN) -d 3 < 3d-input.txt #> 3d-output.txt

largedemo: $(MAIN) inp-large.script
	echo " ***large demo***"
	$(MAIN) -d 2 < inp-large.script

$(MAIN): $(MAIN).o $(OBJ)
	$(CC) $(CFLAGS) -o $(MAIN) $(MAIN).o $(OBJ) -lm

p$(MAIN): $(MAIN).o $(OBJ)
	purify $(CC) $(CFLAGS) -o $(MAIN) $(MAIN).o $(OBJ) -lm

vector.o: dfn.h vector.h

kdtree.o: dfn.h kdtree.h vector.h

$(MAIN).o: dfn.h kdtree.h vector.h kdtree.c

checkout:
	co -l $(REV) $(SRCALL) $(ALLH) README 

checkin:
	ci -l $(REV)  -f $(SRCALL) $(ALLH) README

cleanup:
	rm -f $(OBJ) $(MAIN).o core
	rm -f *~ *.bak

clean: cleanup

spotless: clean
	rm -f $(MAIN) $(PACKAGE).bundle $(PACKAGE).tar* uu *.exe

$(PACKAGE).tar: $(SRCALL) $(ALLH) README makefile \
	$(SCRIPTS) $(COPYRIGHT)
	tar cvfh $(PACKAGE).tar $(SRCALL) $(ALLH) \
	$(SCRIPTS) README makefile $(COPYRIGHT)

printout: $(SRCALL) $(ALLH)
	$(LPR) $(SRCALL) $(ALLH)

# uu: $(PACKAGE).tar
#  	gzip $(PACKAGE).tar
# 	uuencode $(PACKAGE).tar.gz $(PACKAGE).tar.gz > uu
