#!/usr/bin/env python
# encoding: utf-8

# Made by Alex Beutel
# October 14, 2013

import sys
import os


def main():
	if (len(sys.argv) >= 5):
		word1 = sys.argv[1]
		word2 = sys.argv[2]
		deletion_cost = float(sys.argv[3])
		sub_cost = float(sys.argv[4])
	else:
		print "No parameters given. Use format: "
		print 'python edit_dist.py  "string 1" "string 2" 1 0.5'
		print 'where 1 is the example deletion cost and 0.5 is the example substitution cost'
		print "\nRunning in demo mode with 'some string' and 'somestring 2' with both costs at 1"
		word1 = "some string"
		word2 = "somestring 2"
		deletion_cost = 1
		sub_cost = 1


	########################################## 
	###### ADD YOUR IMPLEMENTATION HERE ######
	##########################################


if __name__ == '__main__':
	main()
