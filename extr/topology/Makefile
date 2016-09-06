#
# Internet Topology.
#
# http://irl.cs.ucla.edu/topology/
#
# There are new versions almost every day. 
# 

VERSION := 20100310

all:  out.topology

links.$(VERSION):
	rm -rf links.$(VERSION).gz
	wget http://irl.cs.ucla.edu/topology/data/2010.03/links.$(VERSION).gz
	gunzip links.$(VERSION).gz
	touch links.$(VERSION)

out.topology:  links.$(VERSION)
	{ echo '% sym positive' ; <links.$(VERSION) sed -re 's,^([0-9.]+)	([0-9.-]+)	([0-9]+)	.*$$,\1 \2 1 \3,' ; } | ../mkuniq1 >$@

.PHONY: clean

clean:
	rm -f out.topology links*	
