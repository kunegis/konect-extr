
OWN=../own

all:  out.slashdot-threads
#currently skipping .new files
#need perl XML::SIMPLE
#mkuniq1
out.slashdot-threads: $(OWN)/slashdot-julia.tar.bz2
	tar xvvf $<
	rm -rf slashdot/user
	./mkslashdot | ../mkuniq1 > out.slashdot.tmp
	echo '% asym positive' > out.slashdot-threads
	cat out.slashdot.tmp | ../mkcountasym >> out.slashdot-threads
	cat out.slashdot.tmp >> out.slashdot-threads
	rm -f out.slashdot.tmp
	rm -rf slashdot

.PHONY: clean
clean:
	rm -f out.slashdot-threads
	rm -f out.slashdot.tmp
	rm -rf slashdot
