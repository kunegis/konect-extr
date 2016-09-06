UNUSED - use main.stu 

#
# The DBLP dataset of scientific publications.
#
# out.dblp-cite:  citations between publications
# out.dblp-author:  authorship links between authors and publications
# out.dblp_coauthor:  co-authorship links between authors 
#

all:  out.dblp-cite out.dblp-author out.dblp_coauthor ent.author

.PHONY: clean
clean:
	rm -f out.* dblp.xml* dblp.dat

dblp.xml:
	wget http://dblp.uni-trier.de/xml/dblp.xml.gz
	gunzip dblp.xml.gz

dblp.dat:  dblp.xml mkdblp
	./mkdblp <dblp.xml >dblp.dat

out.dblp-cite:  dblp.dat ../mkuniq1
	<dblp.dat sed -re '/^cite /!d;s,^cite ,,' | ../mkrel --enforce-edgeweights 'asym' 'unweighted' >out.dblp-cite

out.dblp-author:  dblp.dat ../mkuniq
	sed -re '/^author /!d;s,^author ,,;s,(.* .*) ,\1_,;s,(.* .*) ,\1_,' dblp.dat | ../mkrel --enforce-edgeweights 'bip' 'unweighted' >out.dblp-author

out.dblp_coauthor ent.dblp_coauthor:  dblp.xml mkco ../mkuniq1
	./mkco | ../mkuniq1 ent.author >out.dblp_coauthor

