#
# Wikmedia Edit Histories
# =======================
#
# These are the edit histories of Wikimedia projects.
#
# Networks are user*page bipartite graphs, with multiple unweighted edges
# representing an edit, annotated with timestamps. 
#
# The list of projects that are extracted is set in the Makefile. 
#

WIKIS := eswiki  itwiki frwiki dewiki enwiki \
  frwikibooks enwikibooks \
  frwikinews enwikinews \
  enwikiquote \
  dewiktionary frwiktionary enwiktionary

all:  $(foreach I, $(WIKIS), out/out.edit-$(I))

clean:  ; rm -rf out tmp
.PHONY:  clean

$(foreach I, out tmp, $(I)/dir): %/dir: 
	mkdir -p $*
	touch $*/dir

out/out.edit-%:  tmp/%-latest-stub-meta-history.xml out/dir mkout
	./mkout $*

tmp/%-latest-stub-meta-history.xml:  tmp/dir
	rm -f tmp/$*-latest-stub-meta-history.xml*
	cd tmp && wget http://download.wikimedia.org/$*/latest/$*-latest-stub-meta-history.xml.gz
	gunzip -f tmp/$*-latest-stub-meta-history.xml.gz
	touch tmp/$*-latest-stub-meta-history.xml
.SECONDARY:  $(foreach I, $(WIKIS), tmp/$(I)-latest-stub-meta-history.xml) 

