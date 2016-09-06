#
# MIT contact data from Eiko Yoneki.
#

FILE:=../own/MIT_DISCRETE_600s.dat

out.mit:  $(FILE) 
	{ echo '% sym positive' ; \
          <$(FILE) sed -re 's,([0-9]+) ([0-9]+) ([0-9]+),\1	\2	1	\3,' | \
            ../mkuniq1 ; } >$@
