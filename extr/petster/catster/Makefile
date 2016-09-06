all: linklist.txt cats pals
	cd cats;aria2c -i../linklist.txt -j10 --auto-file-renaming=false --allow-overwrite=false

cats:
	mkdir cats
pals:
	mkdir pals

linklist.txt: sitemap_catster_index.xml mklinklist.pl
	./mklinklist.pl>linklist.txt
	


sitemap_catster_index.xml:
	wget http://www.catster.com/sitemap_catster_index.xml


clean: 
	rm -f linklist.txt
	rm -f sitemap_catster_index.xml
	rm -f *.gz
	rm -f *.xml
	rm -f *.gz.*
	rm -rf cats pals
.PHONY: clean
