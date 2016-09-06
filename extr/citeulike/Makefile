#
# The CiteULike folksonomy.
#
# http://www.citeulike.org/faq/data.adp
#

VERSION := 20080220

all:  out.citeulike-ut out.citeulike-ui out.citeulike-ti

current:  
	rsync --progress kunegis@file.isweb.uni-koblenz.de:/data/isweb/konect/own/citeulike/current .

current.in:  current mkin
	<current ./mkin >current.in

#../mkrel --ent-delimiter=';' --+ent=ent.bookcrossing_full-rating_full-rating.book.author:BX-Books.csv:0:2:1
out.citeulike-ut:  current.in
	<current.in sed -re 's,^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)$$,\1 \2 1 \4,' | ../mkrel --+ent=ent.citeulike-ut.tag.name:current.in:1:1:1 'bip' 'positive' >$@
#	{ echo '% bip positive' ; <current.in sed -re 's,^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)$$,\1 \2 1 \4,' ; } | ../mkuniq >$@

out.citeulike-ui:  current.in
	{ echo '% bip positive' ; <current.in sed -re 's,^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)$$,\1 \3 1 \4,' ; } | ../mkuniq >$@

out.citeulike-ti:  current.in
	<current.in sed -re 's,^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)$$,\2 \3 1 \4,' | ../mkrel --+ent=ent.citeulike-ti.tag.name:current.in:1:1:0 'bip' 'positive' >$@ 


clean:
	rm -rf current current.in out.*
.PHONY:  clean
