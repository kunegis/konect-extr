#
# Alex Arenas - Network datasets
#
# http://deim.urv.cat/~aarenas/data/welcome.htm
# 

all:  out.arenas-email out.arenas-pgp out.arenas-meta

#
# ZIP files
#
email.zip:
	wget http://deim.urv.cat/~aarenas/data/xarxes/email.zip -O $@

jazz.zip:
	wget http://deim.urv.cat/~aarenas/data/xarxes/jazz.zip -O $@

PGP.zip:
	wget http://deim.urv.cat/~aarenas/data/xarxes/PGP.zip -O $@

celegans_metabolic.zip: 
	wget http://deim.urv.cat/~aarenas/data/xarxes/celegans_metabolic.zip -O $@

#
# Text files
#
email.txt:  email.zip
	unzip email.zip
	touch -c $@

jazz.net:  jazz.zip
	unzip jazz.zip
	touch -c $@

PGPgiantcompo.net:  PGP.zip
	unzip PGP.zip
	touch -c $@

celegans_metabolic.net:  celegans_metabolic.zip
	unzip celegans_metabolic.zip
	touch -c $@

#
# OUT files
#

# Note:  the data does *not* have multiple edges, and it is also
# undirected, contains each edge in both directions. 
out.arenas-email:  email.txt	
	{ echo '% sym unweighted' ; <email.txt sed -re '/^([0-9]+)\s+\1\s/d' | ../mkuniq1 | \
          awk '$$1 < $$2 {print $$1, $$2}' ; } >$@

# The file jazz.net contains each edge just once.  The network is undirected. 
out.arenas-jazz:  jazz.net
	{ echo '% sym unweighted' ; \
          <jazz.net sed -re '/^\*/d;s,^\s*([0-9]+)\s+([0-9]+)\s.*$$,\1	\2,' | ../mkuniq1 | ../mksym ; } >$@

out.arenas-pgp:  PGPgiantcompo.net
	sed -re '/"v/d;/^\*/d;s,\s+1\s+$$,,' $< | ../mkrel sym unweighted >$@

out.arenas-meta:  celegans_metabolic.net
	{ echo '% sym positive' ; <celegans_metabolic.net sed -re \
          '/"v/d;/^\*/d;s,\s+1\s+$$,,' | ../mkuniq1 ; } >$@

.PHONY: clean

clean:
	rm -f out.* *.zip *.net *.txt
