s = []
# fr = open('mv.txt','r')
fr = open('movies-short.txt','r')
fw = open('movies-short.csv','a')
for l in fr:
	if len(l.strip()) == 0:
		fw.write(','.join(s) + "\n")
		s = []
	else:
		(a, b) = l.strip().split(": ")
		s.append(b)
fw.write(','.join(s) + "\n")
