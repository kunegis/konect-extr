#
# Create datasets out of semantic networks.
#
# http://wiki.dbpedia.org/Downloads34
#
# The strict datasets are downloaded.  The old datasets are in own/. 
#

all:  all-dbpedia \
  stat.dbpedia.en stat.oldlenientmappingbased_en \
  stat.infobox_en  \
  multi.dbpedia

# only the actual DBpedia 
all-dbpedia: \
  out.dbpedia-genre out.dbpedia-birthplace out.dbpedia-starring \
  out.dbpedia-team out.dbpedia-country out.dbpedia-recordlabel \
  out.dbpedia-link out.dbpedia-similar \
  out.dbpedia-all 

clean: ; rm -rf out.* stat.* *.nt
.PHONY:  clean

#
# Old dataset
#
out.dbpedia-link:   pagelinks.en.nt
	FORMAT=asym ../mksem >$@ <pagelinks.en.nt '<http://dbpedia.org/ontology/wikiPageWikiLink>'

out.dbpedia-similar:  
	FORMAT=sym ../mksem >$@ <../own/infobox_en.nt '<http://dbpedia.org/property/similar>'

stat.infobox_en:  
	../semstat ../own/infobox_en.nt >$@

#
# Strict dataset
#
out.dbpedia-genre:  dbpedia.en.nt 
	FORMAT=bip ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/genre>'
out.dbpedia-birthplace:  dbpedia.en.nt 
	FORMAT=bip ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/birthPlace>'
out.dbpedia-starring:  dbpedia.en.nt 
	FORMAT=bip ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/starring>'
out.dbpedia-team:  dbpedia.en.nt 
	FORMAT=bip ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/team>'
out.dbpedia-country:  dbpedia.en.nt 
	FORMAT=bip ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/country>'
out.dbpedia-recordlabel:  dbpedia.en.nt 
	FORMAT=bip ../mksem >$@ <dbpedia.en.nt '<http://dbpedia.org/ontology/recordLabel>'

#
# All
#
out.dbpedia-all:  dbpedia.en.nt  ../mksem 
	FORMAT=asym WEIGHTS=positive ../mksem >$@ <dbpedia.en.nt 


#
# Multi
#
multi.dbpedia:  dbpedia.en.nt ../mksemmulti
	<dbpedia.en.nt ../mksemmulti >$@

# 
# Download
#
dbpedia.en.nt:
#newstrictmappingbased_en.nt:  
	wget http://downloads.dbpedia.org/current/en/mappingbased_properties_en.nt.bz2 -O dbpedia.en.nt.bz2
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

