#
# http://cfinder.org/wiki/?n=Main.Data
#

all:  out.cfinder-google

GoogleNw.txt:
	wget http://cfinder.org/wiki/networkData/GoogleNw.txt.zip -O GoogleNw.txt.zip
	unzip GoogleNw.txt.zip
	touch -c $@

tmp.ent: mkentsource GoogleNw.txt
	<GoogleNw.txt ./mkentsource >$@
	

out.cfinder-google ent.cfinder-google:  GoogleNw.txt tmp.ent
	<$< ../mkrel --+ent=ent.cfinder-google.url.name:tmp.ent:0:0 'asym' 'unweighted' >$@ 

.PHONY: clean

clean:
	rm -f out.* GoogleNw.txt GoogleNw.txt.zip tmp.ent ent.*
