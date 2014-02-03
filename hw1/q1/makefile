#MOVIEDB = /afs/andrew.cmu.edu/usr22/seunghak/15826/movies.db
#We will use our full data above for our grading (it is not publicly available)
#Change this test db file to your movie db file
MOVIEDB = movies.db 
#MOVIEDB = [YOUR MOVIE DB]

#Change this source to your movie data source
SRC = movies-mini.csv
#SRC = [YOUR MOVIE DATA SOURCE]

all: hw1.q1.4 hw1.q1.5 hw1.q1.6 hw1.q1.7 hw1.q1.8 hw1.q1.9

linenum: $(SRC)
	wc -l $(SRC)

hw1.q1.4: 
	sqlite3 $(MOVIEDB) < hw1.q1.4.txt

hw1.q1.5: 
	sqlite3 $(MOVIEDB) < hw1.q1.5.txt

hw1.q1.6: 
	sqlite3 $(MOVIEDB) < hw1.q1.6.txt

hw1.q1.7: 
	time sqlite3 $(MOVIEDB) < hw1.q1.7.txt
	sqlite3 $(MOVIEDB) < hw1.q1.9.txt

hw1.q1.8:
	sqlite3 $(MOVIEDB) < hw1.q1.8.txt

hw1.q1.9:
	time sqlite3 $(MOVIEDB) < hw1.q1.7.txt
	sqlite3 $(MOVIEDB) < hw1.q1.9.txt

clean:
	\rm -f *.o
