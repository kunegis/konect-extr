#
# Semantic dataset:  MovieLens 100k. 
#

all:  ent.user ent.movie ent.genre rel.rating rel.genres rel.rating-unweighted

ml-data.tar__0.gz:
	wget http://www.grouplens.org/system/files/ml-data.tar__0.gz

ml-data:  ml-data.tar__0.gz 
	tar xfz ml-data.tar__0.gz 
	touch ml-data

ent.user:  ml-data mk.ent.user
	./mk.ent.user

ent.movie:  mk.ent.movie ml-data
	./mk.ent.movie

ent.genre:  mk.ent.genre ml-data
	./mk.ent.genre

rel.rating:  mk.rel.rating ml-data ent.user ent.movie
	./mk.rel.rating

rel.genres:  ml-data mk.rel.genres
	./mk.rel.genres

rel.rating-unweighted:  rel.rating
	../mkunweighted <rel.rating >rel.rating-unweighted

.PHONY:  clean
clean: ; rm -rf ml-data.tar__0.gz  ml-data rel.* ent.*
