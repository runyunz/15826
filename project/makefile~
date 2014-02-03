
# MUST HAVE IT ###################
demo: install
	psql < demo.sql

# MUST HAVE IT ###################
install:
	psql < ./src/task1.sql

# MUST HAVE IT ###################
paper.ps:
	cd DOC; make paper.ps
	mv DOC/paper.ps .

all.tar:
	cd DOC; make spotless
	tar cvf all.tar *

all.tar.gz: all.tar
	gzip all.tar

# ready to ship with e-mail
# MUST HAVE IT ###################
uu: all.tar.gz
	uuencode all.tar.gz all.tar.gz > uu
