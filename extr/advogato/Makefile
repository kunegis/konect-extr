UNUSED

#
# The Advogato trust network, with three levels of trust, represented as
# 0.6, 0.8 and 1.0. 
#
# The network has loops, i.e. some users trust themselves.
#

all:    out.advogato

graph.dot:  
	wget http://www.advogato.org/person/graph.dot


out.advogato:  graph.dot  mkout
	./mkout 

.PHONY: clean

clean:
	rm -f graph.dot
	rm -f out.advogato ent.advogato.user.name
