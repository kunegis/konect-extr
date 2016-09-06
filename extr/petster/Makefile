
DEPRECATED

#
# This directory is deprecated.  Use ../petster2/ instead. 
#

all: \
	out.petster-familylinks-cat-dog \
	out.petster-friendships-cat \
	out.petster-friendships-dog \
	out.petster-friendships-hamster \
	out.petster-familylinks-hamster \
	out.petster-familylinks-cat-dog-uniq \
	out.petster-friendships-cat-uniq \
	out.petster-friendships-dog-uniq \
	out.petster-friendships-hamster-uniq \
	out.petster-familylinks-hamster-uniq \
	out.petster-hamster \
	out.petster-carnivore

%/dir:
	if [ ! -e $*/dir ]; then mkdir -p $* ; echo >$*/dir; fi

tmp/:
	mkdir tmp


Readme.txt: petster-data.tar.bz2
	tar xfj petster-data.tar.bz2
	ln -sf ../petster-data/catster/cats ./catster/cats
	ln -sf ../petster-data/catster/pals ./catster/pals
	ln -sf ../petster-data/dogster/dogs ./dogster/dogs
	ln -sf ../petster-data/dogster/pals ./dogster/pals
	ln -sf ../petster-data/hamsterster/hamsters ./hamsterster/hamsters
	ln -sf petster-data/Readme.txt
	touch Readme.txt

petster-data.tar.bz2:
	wget "http://konect.uni-koblenz.de/downloads/own/petster-data.tar.bz2" -O petster-data.tar.bz2
	touch petster-data.tar.bz2

tmp/out.petster-familylinks-cat-dog: tmp/dir Readme.txt mkfamilies.pl
	./mkfamilies.pl

out.petster-familylinks-cat-dog:  catdog

out.petster-friendships-cat: catdog

out.petster-friendships-dog: catdog

out.petster-friendships-hamster: hamsterster

out.petster-familylinks-hamster: hamsterster

out.petster-familylinks-cat-dog-uniq: tmp/out.petster-familylinks-cat-dog mkalluniq.pl
	./mkalluniq.pl tmp/out.petster-familylinks-cat-dog out.petster-familylinks-cat-dog-uniq
	mv out.petster-familylinks-cat-dog-uniq tmpfile
	awk '{ if ($$1 == "%") print $$0; else if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}' tmpfile|sort -r|uniq>out.petster-familylinks-cat-dog-uniq

out.petster-friendships-cat-uniq: catster/out/out.petster-friendships-cat mkalluniq.pl
	./mkalluniq.pl catster/out/out.petster-friendships-cat $@
	mv $@ tmpfile
	awk '{ if ($$1 == "%") print $$0; else if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}' tmpfile|sort -r|uniq>$@

out.petster-friendships-dog-uniq: dogster/out/out.petster-friendships-dog mkalluniq.pl
	./mkalluniq.pl dogster/out/out.petster-friendships-dog $@
	mv $@ tmpfile
	awk '{ if ($$1 == "%") print $$0; else if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}' tmpfile|sort -r|uniq>$@

hamsterster/out.petster-friendships-hamster: Readme.txt
	cd hamsterster;./extractfriends.pl

hamsterster/out.petster-familylinks-hamster: Readme.txt
	cd hamsterster;./extractfamily.pl

out.petster-friendships-hamster-uniq: hamsterster/out.petster-friendships-hamster
	./mkalluniq.pl hamsterster/out.petster-friendships-hamster $@
	mv $@ tmpfile
	awk '{ if ($$1 == "%") print $$0; else if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}' tmpfile|sort -r|uniq>$@

out.petster-familylinks-hamster-uniq: hamsterster/out.petster-familylinks-hamster
	./mkalluniq.pl hamsterster/out.petster-familylinks-hamster $@
	mv $@ tmpfile
	awk '{ if ($$1 == "%") print $$0; else if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}' tmpfile|sort -r|uniq>$@

out.petster-hamster: hamsterster/out.petster-friendships-hamster hamsterster/out.petster-familylinks-hamster
	cp hamsterster/out.petster-friendships-hamster tmpfile
	grep -v "#" hamsterster/out.petster-familylinks-hamster>>tmpfile
	./mkalluniq.pl tmpfile $@
	mv $@ tmpfile
	awk '{ if ($$1 == "%") print $$0; else if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}' tmpfile|sort -r|uniq>$@

out.petster-carnivore: tmp/out.petster-familylinks-cat-dog catster/out/out.petster-friendships-cat dogster/out/out.petster-friendships-dog
	cp tmp/out.petster-familylinks-cat-dog tmpfile
	grep -v "#" catster/out/out.petster-friendships-cat>>tmpfile
	grep -v "#" dogster/out/out.petster-friendships-dog>>tmpfile
	./mkalluniq.pl tmpfile $@
	mv $@ tmpfile
	awk '{ if ($$1 == "%") print $$0; else if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}' tmpfile|sort -r|uniq>$@

hamsterster: hamsterster/out.petster-friendships-hamster hamsterster/out.petster-familylinks-hamster
	./mkalluniq.pl  hamsterster/out.petster-friendships-hamster out.petster-friendships-hamster hamsterster/out.petster-familylinks-hamster out.petster-familylinks-hamster
	mv out.petster-friendships-hamster tmpfile
	awk '{ if ($$1 == "%") print $$0; else if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}' tmpfile|sort -r|uniq>out.petster-friendships-hamster
	mv out.petster-familylinks-hamster tmpfile
	awk '{ if ($$1 == "%") print $$0; else if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}' tmpfile|sort -r|uniq> out.petster-familylinks-hamster

catster/out/out.petster-friendships-cat: Readme.txt
	cd catster;mkdir -p out;./mkfriendsmatrix.pl

dogster/out/out.petster-friendships-dog: Readme.txt
	cd dogster;mkdir -p out;./mkfriendsmatrix.pl

catdog: tmp/out.petster-familylinks-cat-dog catster/out/out.petster-friendships-cat dogster/out/out.petster-friendships-dog
	./mkalluniq.pl catster/out/out.petster-friendships-cat out.petster-friendships-cat dogster/out/out.petster-friendships-dog out.petster-friendships-dog tmp/out.petster-familylinks-cat-dog out.petster-familylinks-cat-dog
	 mv out.petster-friendships-cat tmpfile
	 awk '{ if ($$1 == "%") print $$0; else if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}' tmpfile|sort -r|uniq>out.petster-friendships-cat
	 mv out.petster-friendships-dog tmpfile
	 awk '{ if ($$1 == "%") print $$0; else if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}' tmpfile|sort -r|uniq>out.petster-friendships-dog
	 mv out.petster-familylinks-cat-dog tmpfile
	 awk '{ if ($$1 == "%") print $$0; else if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}' tmpfile|sort -r|uniq>out.petster-familylinks-cat-dog
clean:
	rm -rf tmp/
	rm -f out.* ent.*
	rm -rf catster/cats catster/pals
	rm -rf dogster/dogs dogster/pals
	rm -rf hamsterster/hamsters
	rm -f petster-data.tar.bz2
	rm -rf petster-data/
	cd catster; make clean
	cd dogster; make clean
	rm -rf hamsterster/out.*
	rm -rf hamsterster/ent.*
	rm -f Readme.txt
	rm -rf catster/out
	rm -rf dogster/out
	rm -rf catster/
	rm -rf dogster/
	rm -rf hamsterster/
	rm -f petster-data.tar.bz2
	rm -rf petster-data/

copy:
	cp out.* /export/kunegis/konect/dat/petster/
	cp meta.* /export/kunegis/konect/dat/petster/
	cp ent.* /export/kunegis/konect/dat/petster/

.PHONY: catdog hamsterster clean copy sourcedata
