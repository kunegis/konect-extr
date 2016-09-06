#
# A signed network of Wikipedia user interactions.
#
# http://www.infres.enst.fr/wp/maniu/datasets/
#
# Relevant publication: Casting a web of trust over Wikipedia: an
# interaction-based approach. Silviu Maniu, Bogdan Cautis and Talel 
# Abdessalem, DBSocial 2011. 
#

NAMES := k2 

.SECONDARY: 

all:  $(foreach NAME, $(NAMES), out.wikisigned-$(NAME))

out.wikisigned-%:  rel.wikisigned-%
	../mkuniq1 >$@ <rel.wikisigned-$*

rel.wikisigned-%:  wiki_trustnet_%.dot mk
	NAME=$* ./mk >$@ <wiki_trustnet_$*.dot

wiki_trustnet_%.dot: wiki_trustnet_%.zip
	rm -f wiki_trustnet_$*.dot
	unzip wiki_trustnet_$*.zip

wiki_trustnet_%.zip: 
	wget -O wiki_trustnet_$*.zip  http://perso.telecom-paristech.fr/~maniu/datasets/wiki_trustnet_$*.zip


clean: ; rm -f *.zip *.dot rel.* out.* 

.PHONY: clean all
