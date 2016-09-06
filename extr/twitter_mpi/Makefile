all: out.twitter_mpi


links-anon.txt.gz:
	wget "http://twitter.mpi-sws.org/links-anon.txt.gz"
	touch $@

links-anon.txt: links-anon.txt.gz
	 gunzip -c $< > $@

out.twitter_mpi: links-anon.txt 
	cat links-anon.txt | ../mkuniq1 > tmp
	echo '% asym unweighted' > $@
	echo -n '% ' >> $@
	wc -l tmp | cut -d" " -f1 >>$@
	cat tmp >> $@


.PHONY: clean

clean:
	rm -f *.txt.gz
	rm -f *.txt
	rm -f out.*
