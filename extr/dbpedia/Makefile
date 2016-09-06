UNUSED -- use main.stu

#
# Create datasets out of semantic networks.
#
# http://wiki.dbpedia.org/Downloads34
#
# The strict datasets are downloaded.  The old datasets are in own/. 
#

all:  all-dbpedia \
  stat.dbpedia.en stat.oldlenientmappingbased_en \
   multi.dbpedia

RELATIONS :=  genre birthplace starring team country recordlabel location occupation producer writer

# Only the actual DBpedia 
all-dbpedia: \
  all-core \
  $(foreach RELATION, $(RELATIONS), out.dbpedia-$(RELATION)) \
  out.dbpedia-link \
  out.dbpedia-all \
  out.dbpedia-similar
# The core semantic networks 
all-core:  $(foreach RELATION, $(RELATIONS), out.dbpedia-$(RELATION))

clean: ; rm -rf out.* stat.* *.nt
.PHONY:  clean

#
# Old dataset
#
out.dbpedia-link:   pagelinks.en.nt
	FORMAT=asym ../mksem <pagelinks.en.nt '<http://dbpedia.org/ontology/wikiPageWikiLink>' | ../mkrmdup >$@

#
# Strict dataset
#
out.dbpedia-genre:  dbpedia.en.nt 
	FORMAT=bip WEIGHTS=unweighted ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/genre>'
out.dbpedia-birthplace:  dbpedia.en.nt 
	FORMAT=bip ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/birthPlace>'
out.dbpedia-starring:  dbpedia.en.nt 
	FORMAT=bip WEIGHTS=unweighted ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/starring>'
out.dbpedia-team:  dbpedia.en.nt 
	FORMAT=bip WEIGHTS=unweighted ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/team>'
out.dbpedia-country:  dbpedia.en.nt 
	FORMAT=bip ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/country>'
out.dbpedia-recordlabel:  dbpedia.en.nt 
	FORMAT=bip WEIGHTS=unweighted ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/recordLabel>'
out.dbpedia-location:  dbpedia.en.nt 
	FORMAT=bip WEIGHTS=unweighted ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/location>'
out.dbpedia-occupation:  dbpedia.en.nt 
	FORMAT=bip WEIGHTS=unweighted ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/occupation>'
out.dbpedia-similar: dbpedia.en.nt
	 FORMAT=sym WEIGHTS=unweighted ../mksem <dbpedia.en.nt '<http://dbpedia.org/ontology/similar>' | sed '/^\%/d' | ../mkrel "sym" "unweighted" >$@
out.dbpedia-producer:  dbpedia.en.nt 
	FORMAT=bip WEIGHTS=unweighted ../mksem <dbpedia.en.nt '<http://dbpedia.org/ontology/producer>' | sed -re 's,^\s*([0-9]+)\s+([0-9]+)\s*$$,\2 \1,' >$@
out.dbpedia-writer:  dbpedia.en.nt 
	FORMAT=bip WEIGHTS=unweighted ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/writer>' | sed -re 's,^\s*([0-9]+)\s+([0-9]+)\s*$$,\2 \1,' >$@

#
# All
#
out.dbpedia-all:  dbpedia.en.nt  ../mksem 
	<dbpedia.en.nt FORMAT=asym WEIGHTS=positive ../mksem | ../mkrmdup >$@  


#
# Multi
#
multi.dbpedia:  dbpedia.en.nt ../mksemmulti
	<dbpedia.en.nt ../mksemmulti >$@

# 
# Download
#
dbpedia.en.nt:
	wget http://downloads.dbpedia.org/current/en/mappingbased_properties_cleaned_en.nt.bz2 -O dbpedia.en.nt.bz2
	bunzip2 dbpedia.en.nt.bz2
	touch dbpedia.en.nt

pagelinks.en.nt:
	wget http://downloads.dbpedia.org/current/en/page_links_en.nt.bz2 -O pagelinks.en.nt.bz2
	bunzip2 pagelinks.en.nt.bz2
	touch pagelinks.en.nt


oldlenientmappingbased_en.nt:  
	wget http://downloads.dbpedia.org/3.4/en/oldlenientmappingbased_en.nt.bz2 -O oldlenientmappingbased_en.nt.bz2
	bunzip2 oldlenientmappingbased_en.nt.bz2
	touch oldlenientmappingbased_en.nt

#
# Statistics
#
stat.%:  %.nt 
	../semstat $*.nt >$@

