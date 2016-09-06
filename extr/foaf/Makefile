#
# A FOAF dataset, with only 212 relationships. 
#

all:  out.foaf


82.zip:
	wget http://ebiquity.umbc.edu/get/a/resource/82.zip

umbc-foafpub-2005-feb/readme.txt:   82.zip
	unzip 82.zip
	touch umbc-foafpub-2005-feb/readme.txt

out.foaf:  mkfoaf umbc-foafpub-2005-feb/readme.txt
	./mkfoaf


