all: linklist.txt dogs pals
	#cd dogs;aria2c -i../linklist.txt -j10 --auto-file-renaming=false --allow-overwrite=false

dogs:
	mkdir dogs
pals:
	mkdir pals

linklist.txt: sitemap_dogster_index.xml mklinklist.pl
	./mklinklist.pl>linklist.txt
	


sitemap_dogster_index.xml:
	wget http://www.dogster.com/sitemap_dogster_index.xml


clean: 
	rm -f linklist.txt
	rm -f sitemap_dogster_index.xml
	rm -f *.gz
	rm -f *.xml
	rm -f *.gz.*
	rm -rf dogs pals
.PHONY: clean
