all:  out.reuters ent.reuters.word.name

OWN:=/data/estrella/konect/own/
#$(HOME)/data/isweb/webstore/own/

reuters.dat:  $(wildcard $(OWN)/reuters/RCV1/english/preprocessed_nach_d.lewis/lyrl2004_tokens_test_pt?.dat)
	cat >$@ $(OWN)/reuters/RCV1/english/preprocessed_nach_d.lewis/lyrl2004_tokens_test_pt?.dat

out.reuters ent.reuters.word.name:  reuters.dat Makefile mkr
	#{ echo '% bip positive' ; <reuters.dat ./mkr | uniq -c | awk '{print $$2 " " $$3 " " $$1}' | ../mkuniq ; } >out.reuters
	<reuters.dat ./mkr | uniq -c | awk '{print $$2 " " $$3 " " $$1}' | ../mkrel --+ent=ent.reuters.word.name:STDIN:::1 'bip' 'positive' >$@

.PHONY: clean

clean:
	rm -f out.reuters ent.reuters.word.name reuters.dat


