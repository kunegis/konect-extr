#
# The last.fm history of users listeling to songs.
#
# http://www.dtic.upf.edu/~ocelma/MusicRecommendationDataset/lastfm-1K.html
#

all:  out.lastfm_band out.lastfm_song

lastfm-dataset-1K:  
	wget http://mtg.upf.edu/static/datasets/last.fm/lastfm-dataset-1K.tar.gz
	tar xfvvz lastfm-dataset-1K.tar.gz
	touch lastfm-dataset-1K lastfm-dataset-1K/*

out.lastfm_band:  lastfm-dataset-1K
	{ echo '% bip positive' ; <lastfm-dataset-1K/userid-timestamp-artid-artname-traid-traname.tsv \
          sed -re 's,[ \f],_,g' | cut -f 1,2,4 | ./mk | ../mkuniq ; } >$@

out.lastfm_song:  lastfm-dataset-1K
	{ echo '% bip positive' ; <lastfm-dataset-1K/userid-timestamp-artid-artname-traid-traname.tsv \
          sed -re 's,[ \f],_,g' | cut -f 1,2,6 | ./mk | ../mkuniq ; } >$@

clean:  ; rm -rf out.* lastfm-dataset-*
.PHONY:  clean
