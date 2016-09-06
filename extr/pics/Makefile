#
# Folksonomy of Visualize.us picture tags by Andreas König, Nicolas
# Neubauer's student.   
#
# http://user.cs.tu-berlin.de/~neubauer/db.zip
#

all:  out.pics_ut out.pics_ui out.pics_ti

out.pics:  ni_db.sql mkpics
	./mkpics <ni_db.sql >$@


ni_db.sql:
	rsync -vvt kunegis@file.isweb:/data/isweb/webstore/own/pics/db.zip .
	unzip db.zip

out.pics_ut:  out.pics
	{ echo '% bip positive' ; <out.pics sed -re 's,^([0-9]+) ([0-9]+) ([0-9]+)$$,\1 \2,' ; } | ../mkuniq >$@

out.pics_ui:  out.pics
	{ echo '% bip positive' ; <out.pics sed -re 's,^([0-9]+) ([0-9]+) ([0-9]+)$$,\1 \3,' ; } | ../mkuniq >$@

out.pics_ti:  out.pics
	{ echo '% bip positive' ; <out.pics sed -re 's,^([0-9]+) ([0-9]+) ([0-9]+)$$,\2 \3,' ; } | ../mkuniq >$@
