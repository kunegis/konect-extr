#	Extraction of kdd cup dataset track1
#	by Daniel Dünker

all:	out.yahoo-song


out.yahoo-song: track1/trainIdx1.txt
	{ echo '% bip weighted' ; { ./kddcup.pl track1/trainIdx1.txt ; ./kddcup.pl track1/validationIdx1.txt; } | ../mkuniq ; } >$@

track1/trainIdx1.txt:
	wget http://h.yimg.com/ib/downloads/dataset.track1.tar.bz2 -O track1.tar.bz2
	tar -xvf track1.tar.bz2
	touch `find track1/`


clean: ; rm -rf out.* track1 track1.tar.bz2
.PHONY: clean