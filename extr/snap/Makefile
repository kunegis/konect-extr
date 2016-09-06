UNUSED and UNMAINTAINED -- use main.stu instead
:::::::::::::::::::::::::::::::::::::::::::::::

#
# Large networks from the Stanford Network Analysis Project (SNAP) by Jure
# Leskovec. 
#
# http://snap.stanford.edu/
#

SHELL=/bin/bash

# For these datasets, also extract the temporal co-citation graph. 
DATASETS_CITATION := cit-HepPh cit-HepTh 

DATASETS := \
  $(DATASETS_CITATION) \
  soc-Slashdot0902 wiki-Vote email-EuAll ca-AstroPh amazon0601 wiki-Talk \
  soc-sign-Slashdot081106 soc-sign-Slashdot090216 soc-sign-Slashdot090221 \
  as-skitter \
  soc-LiveJournal1 \
  p2p-Gnutella31 \
  web-NotreDame web-BerkStan web-Google web-Stanford \
  as20000102 as-caida20071105 \
  soc-pokec-relationships soc-Epinions1 \
  com-livejournal com-amazon com-dblp com-youtube

EGODATASETS := twitter facebook gplus
SYMDATASETS :=loc-gowalla_edges loc-brightkite_edges flickrEdges roadNet-CA roadNet-TX roadNet-PA

all: all.datasets all.datasets-citation out/out.elec all.egodatasets all.symdatasets 

all.datasets: $(foreach I, $(DATASETS), out/out.$(I))
all.symdatasets: $(foreach I, $(SYMDATASETS), out/out.$(I))
all.datasets-citation:  $(foreach I, $(DATASETS_CITATION), out/out.ca-$(I))
all.egodatasets: $(foreach I, $(EGODATASETS), out/out.ego-$(I))

$(foreach I, $(SYMDATASETS), out/out.$(I)): $(foreach I, $(SYMDATASETS), out/$(I).txt)
	sed -re '/^#/d' $(subst out/out.,out/,$@).txt | tr -s ' ' ' ' | ../mkrel "sym" "unweighted"  >$@

work/ego-%: work/%.tar.gz
	tar xvvf $< -C work
	mv work/$* $@

work/%.tar.gz: work/dir
	wget -O $@ http://snap.stanford.edu/data/$*.tar.gz 

out/dir: 
	mkdir -p out && touch out/dir
work/dir:
	mkdir -p work && touch work/dir

out/com-livejournal.txt: out/dir
	wget http://snap.stanford.edu/data/bigdata/communities/com-lj.all.cmty.txt.gz -O $@.gz
	cd out && gunzip -f $@.gz && touch $*.txt
	fromdos $@

out/com-%.txt: out/dir
	wget http://snap.stanford.edu/data/bigdata/communities/com-$*.ungraph.txt.gz -O out/com-$*.ungraph.txt.gz
	 cd out && gunzip -f com-$*.ungraph.txt.gz && touch com-$*.ungraph.txt && mv com-$*.ungraph.txt com-$*.txt

out/%.txt:  out/dir
	wget http://snap.stanford.edu/data/$*.txt.gz -O out/$*.txt.gz
	cd out && gunzip -f $*.txt.gz && touch $*.txt
	fromdos out/$*.txt
.SECONDARY:  ; out/*.txt work/*

$(foreach I, $(DATASETS), out/out.$(I)): out/out.%:  out/%.txt mk
	./mk $*

$(foreach I, $(DATASETS_CITATION), out/out.ca-$(I)): \
out/out.ca-%: out/%.txt out/%-dates.txt mkcit
	./mkcit $* | ../mkrel 'sym' 'unweighted' >$@

out/tmp.elec:  mkelec out/wikiElec.ElecBs3.txt
	./mkelec

out/out.elec:  out/tmp.elec
	../mkrel --enforce-edgeweights 'asym' 'signed' <$< >$@

out/out.ego-%: work/ego-% out/dir
	{ find work/ego-$*/ -name '*.circles' | ./mkcircle; find work/ego-$*/ -name '*.edges' | ./mkego; } | sort -u | ./mk2 "$*" >$@

.PHONY: clean

clean:
	rm -rf out/ work/
