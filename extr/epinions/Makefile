
all:  out/out.epinions out/out.epinions-rating 

%/dir: ; mkdir -p $* && touch $@

data/user_rating.txt:  data/dir
	cd data && wget	http://www.trustlet.org/datasets/extended_epinions/user_rating.txt.gz && gunzip user_rating.txt.gz && touch user_rating.txt

data/rating.txt:  data/dir
	cd data && wget http://www.trustlet.org/datasets/extended_epinions/rating.txt.gz && gunzip rating.txt.gz && touch rating.txt

out/out.epinions:  data/user_rating.txt out/dir mk
	{ echo '% asym signed' ; ./mk | ../mkuniq1 ; }  >$@

out/out.epinions-rating:  data/rating.txt out/dir mkrating
	{ echo '% bip weighted' ; ./mkrating | ../mkuniq ; } >$@

.PHONY: clean
clean:
	rm -rf out/ data/	



