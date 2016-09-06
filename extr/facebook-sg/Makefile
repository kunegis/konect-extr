#
# Partial Facebooks dataset from
# http://odysseas.calit2.uci.edu/doku.php/public:online_social_networks#facebook_social_graph
#

#
# Please cite the Facebook Social graph data sets using the following bibtex entry:
#
#   @inproceedings{gjoka10_walkingfb, 
#   author= {Minas Gjoka and Maciej Kurant and Carter T. Butts and Athina Markopoulou}, 
#   title= { {Walking in Facebook: A Case Study of Unbiased Sampling of OSNs} }, 
#   booktitle = {Proceedings of IEEE INFOCOM '10},
#   address = {San Diego, CA}, 
#   month = {March}, 
#   year = {2010} 
#   }
#

.PHONY: clean cleanOutputs

all: uni-socialgraph-anonymized.txt out.facebook-sg tmp.facebook-sg

uni-socialgraph-anonymized.txt: 
	wget -c http://odysseas.calit2.uci.edu/research/data/uni-socialgraph-anonymized -O $@

tmp.facebook-sg: facebook.class uni-socialgraph-anonymized.txt
	java -Xmx7G facebook

out.facebook-sg: tmp.facebook-sg
	echo "% sym unweighted" > out.facebook-sg;grep -v "%" tmp.facebook-sg|awk '{ if ( $$1 > $$2 )  print $$1, $$2; else print $$2,$$1}'|sort -n|uniq | ../mkrmdup >> out.facebook-sg

facebook.class:	facebook.java
	javac facebook.java

clean: 
	rm -rf out.* *.class *.txt

cleanOutputs:
	rm -rf out.* *.class
