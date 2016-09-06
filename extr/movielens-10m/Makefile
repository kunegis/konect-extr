#
# The semantic MovieLens 10M dataset, including tags.  This is the
# version with about 10 millions ratings and tags. 
#

all:  all.dataset 
all.dataset: ent.movie ent.user rel.rating rel.annotation ent.tag rel.rating-unweighted \
  out/out.movielens-10m_ut out/out.movielens-10m_ui out/out.movielens-10m_ti out/out.movielens-10m_rating out/out.movielens-10m_rating-unweighted

#
# Clean
#
.PHONY:   clean
clean: ; rm -rf ml-10m.zip *.dat README.html \
  split_ratings.sh allbut.pl ent.* rel.* out/

#
# Dir
#
%/dir:  ; mkdir -p $* ; touch $@

#
# Download
#
ml-10m.zip:
	wget http://www.grouplens.org/sites/www.grouplens.org/external_files/data/ml-10m.zip

ratings.dat movies.dat tags.dat:  ml-10m.zip
	unzip ml-10m.zip
	mv ml-10M100K/* .
	rm -rf ml-10M100K
	touch ratings.dat movies.dat tags.dat

#
# Dataset
#
ent.movie:  movies.dat mk.ent.movie
	./mk.ent.movie

ent.user:  ratings.dat tags.dat mk.ent.user
	./mk.ent.user

rel.rating :  ratings.dat ent.user ent.movie mk.rel.rating
	./mk.rel.rating

out/out.movielens-10m_rating: ratings.dat out/dir
	awk -F'::' '{print $$1" "$$2" "$$3" "$$4}' $<  | ../mkrel "bip" "weighted" > $@

out/out.movielens-10m_rating-unweighted: ratings.dat out/dir
	awk -F'::' '{print $$1" "$$2" 1 "$$4}' $<  | ../mkrel "bip" "unweighted" > $@


rel.annotation ent.tag:  tags.dat  mk.rel.annotation
	./mk.rel.annotation

rel.rating-unweighted:  rel.rating
	<rel.rating >rel.rating-unweighted sed -re 's,^([0-9]+ [0-9]+) ([0-9.]+),\1 1,g;s,weighted,unweighted,'


#
# Tags
#
out/out.movielens-10m_ut:  tags.dat out/dir
	{ echo '% bip positive' ; <tags.dat sed -re 's, ,_,g;s,^([0-9]+)::([0-9]+)::([^|]+)::([0-9]+)$$,\1 \3 1 \4,' ; } | ../mkuniq >$@

out/out.movielens-10m_ui:  tags.dat out/dir
	{ echo '% bip positive' ; <tags.dat sed -re 's, ,_,g;s,^([0-9]+)::([0-9]+)::([^|]+)::([0-9]+)$$,\1 \2 1 \4,' ; } | ../mkuniq >$@

out/out.movielens-10m_ti:  tags.dat out/dir
	{ echo '% bip positive' ; <tags.dat sed -re 's, ,_,g;s,^([0-9]+)::([0-9]+)::([^|]+)::([0-9]+)$$,\3 \2 1 \4,' ; } | ../mkuniq >$@
