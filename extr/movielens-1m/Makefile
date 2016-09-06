# The MovieLens-million dataset
# =============================
#
# This is the MovieLens million dataset, with a million ratings. 
#


all:   out.movielens-1m_unweighted

clean: ; rm -rf ml out.* plot/
.PHONY:  clean

plot/dir: ; mkdir -p plot ; touch plot/dir

ml/ratings.dat:
	mkdir -p ml && cd ml && \
wget http://www.grouplens.org/system/files/million-ml-data.tar__0.gz && \
gunzip million-ml-data.tar__0.gz && \
tar xf million-ml-data.tar__0

out.movielens-1m:  ml/ratings.dat mkratings 
	./mkratings




out.movielens-1m_unweighted:  out.movielens-1m
	<out.movielens-1m >out.movielens-1m_unweighted sed -re 's,^([0-9]+\s+[0-9]+\s+)[1-5](\s+[0-9]+)$$,\11\2,;s,weighted,unweighted,'
