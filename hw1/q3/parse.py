# Runyun Zhang - 15826 Fall 2013
import os

n = 7
fz = open("zorder_data","w")
fh = open("horder_data","w")

for zh in range(0, (2**n)**2):
	cmdz = './izorder -n %d %d' % (n, zh)
	resz = os.popen(cmdz).readlines()
	fz.write(resz[0])
	
	cmdh = './ihorder -n %d %d' % (n, zh)
	resh = os.popen(cmdh).readlines()
	fh.write(resh[0])