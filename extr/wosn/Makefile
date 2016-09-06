DEPRECATED -- use main.stu

#
# WOSN Datasets
# =============
#
# http://socialnetworks.mpi-sws.org/data-wosn2008.html
#
# Please use the following BibTeX entry if you would like to cite this dataset.
#
# @inproceedings{mislove-2008-flickr,
#   author = {Alan Mislove and Hema Swetha Koppula and Krishna P. Gummadi
#   and Peter Druschel and Bobby Bhattacharjee}, 
#   title = {Growth of the Flickr Social Network}, 
#   booktitle = {Proceedings of the 1st ACM SIGCOMM Workshop on Social
#   Networks (WOSN'08)},  
#   location = {Seattle, WA},
#   month = {August},
#   year = {2008}
# }
#
# http://socialnetworks.mpi-sws.org/data-imc2007.html
#
# Please use the following BibTeX entry if you would like to cite this dataset.
#
# @inproceedings{mislove-2007-socialnetworks,
#   author = {Alan Mislove and Massimiliano Marcon and Krishna P. Gummadi
#     and Peter Druschel and Bobby Bhattacharjee}, 
#   title = {{Measurement and Analysis of Online Social Networks}}, 
#   booktitle = {Proceedings of the 5th ACM/Usenix Internet Measurement
#     Conference (IMC'07)}, 
#   address = {San Diego, CA},
#   month = {October},
#   year = {2007}
# }
#

#
# Note about the YouTube datasets:  "d" stands for "directed" and "u"
# for "undirected".  The "u" variant is however not undirected, and both
# datasets differ in size ("u" is about three times bigger than "d").
# We treat all as directed. 
#

DATASETS:=internet-growth flickr-growth youtube-d-growth wikipedia-growth 

DATASETS_GROUPMEMBERSHIPS := youtube flickr livejournal orkut

DATASETS_LINKS := orkut flickr livejournal
DATASETS_LINKSD := youtube 
DATASETS_UNDIRECTED :=youtube-u-growth

all: $(foreach I, $(DATASETS_UNDIRECTED), out.$(I)) $(foreach I, $(DATASETS), out.$(I)) $(foreach I, $(DATASETS_LINKS), out.$(I)-links) $(foreach I, $(DATASETS_LINKSD), out.$(I)-links) all.groupmemberships 

all.groupmemberships:  $(foreach I, $(DATASETS_GROUPMEMBERSHIPS), out.$(I)-groupmemberships)

%.txt:  
	wget http://socialnetworks.mpi-sws.mpg.de/data/$*.txt.gz -O $*.txt.gz
	gunzip $*.txt.gz
	touch $*.txt
.SECONDARY: ; *.txt

$(foreach I, $(DATASETS_UNDIRECTED), out.$(I)): out.%: %.txt
	./mk $* | ./rmloops |../mkrel --enforce-edgeweights 'sym' 'unweighted' >out.$*

$(foreach I, $(DATASETS), out.$(I)):  out.%:  %.txt mk
	{ echo '% asym unweighted' ; ./mk $* | ../mkuniq1 ; } | ../mkrmdup >out.$*

out.youtube-links: youtube-links.txt
	<$< ../mkrel --enforce-edgeweights 'asym' 'unweighted' >$@

out.%-links:  %-links.txt
	<$*-links.txt ../mkrel --enforce-edgeweights 'sym' 'unweighted' >out.$*-links

out.%-groupmemberships:  %-groupmemberships.txt
	{ echo '% bip unweighted' ; ../mkuniq <$*-groupmemberships.txt ; } >out.$*-groupmemberships

clean:
	rm -rf out.* *.txt
.PHONY:  clean
 
