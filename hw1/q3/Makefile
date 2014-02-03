#
# Makefile that builds btest and other helper programs for the CS:APP data lab
# 
CC = gcc

all: zorder izorder horder ihorder

parse: parse.py
	python parse.py

plot: plot.m
	octave plot.m

zorder: zorder.c
	$(CC) -o zorder zorder.c

izorder: izorder.c
	$(CC) -o izorder izorder.c

horder: horder.c
	$(CC) -o horder horder.c

ihorder: ihorder.c
	$(CC) -o ihorder ihorder.c

clean:
	rm -f *.o zorder izorder horder ihorder *~