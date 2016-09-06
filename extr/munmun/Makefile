all: \
  out.munmun_digg_reply \
  out.munmun_twitter_social out.munmun_twitter_at \
    out.munmun_twitter_ut out.munmun_twitter_ui \
    out.munmun_twitter_ti \
  out.munmun_twitterex_at \
    out.munmun_twitterex_ut out.munmun_twitterex_ui \
    out.munmun_twitterex_ti

%_data.zip:
	wget http://www.public.asu.edu/~mdechoud/data/$*_data.zip

%_data:  %_data.zip
	unzip $*_data.zip
	touch $*_data $*_data/*

#
# Digg
#

out.munmun_digg_reply:  rel.digg1 rel.digg2 mkdigg
	join rel.digg1 rel.digg2 | ./mkdigg | ../mkuniq1 >$@


rel.digg1:  digg_data
	<digg_data/replies.sql sed -e :a -e '/\\$$/N; s/\\\n//; ta' | cut -f 7,2,4 | \
          tr ' ' 'T' | sort -n >$@

rel.digg2:  digg_data
	cat digg_data/comments.sql digg_data/replies.sql | sed -e :a -e '/\\$$/N; s/\\\n//; ta' | \
          cut -f 1,7 | sort -n >$@

#
# Twitter
#
out.munmun_twitter_at:  twitter_data mktweets
	{ echo '% asym positive' ; <twitter_data/tweets.data \
          sed -e :a -e '/\\$$/N; s/\\\n//; ta' |  ./mktweets '@' | \
          sed -e 's, @, ,' | ../mkuniq1 ; } >$@

out.munmun_twitter_social:  twitter_data
	sed -re '/^[^ ]+	[^ ]+$$/!d' 'twitter_data/socialgraph.data' | ../mkrel --enforce-edgeweights 'asym' 'unweighted' >$@ 

out.munmun_twitter_ut:  twitter_data mktweets
	{ echo '% bip positive' ; <twitter_data/tweets.data \
          sed -e :a -e '/\\$$/N; s/\\\n//; ta' |  ./mktweets '#' | ../mkuniq ; } >$@

out.munmun_twitter_ui:  twitter_data mktweets
	{ echo '% bip positive' ; <twitter_data/tweets.data \
          sed -e :a -e '/\\$$/N; s/\\\n//; ta' |  ./mktweets 'http:' | ../mkuniq ; } >$@

out.munmun_twitter_ti:  twitter_data mktwitter_ti
	{ echo '% bip positive' ; <twitter_data/tweets.data \
          sed -e :a -e '/\\$$/N; s/\\\n//; ta' |  ./mktwitter_ti | ../mkuniq ; } >$@

#
# Twitter extended
#

twitter-released-dataset:  
	cp -p ../own/twitter-released-dataset.tar.gz .
	tar xfvvz twitter-released-dataset.tar.gz
	touch twitter-released-dataset

twitter-released-dataset/tweets.data:  twitter-released-dataset
	for file in twitter-released-dataset/tweets_*.sql ; do <$$file sed 1d ; done | \
          sed -re 's,\\n, ,g' | recode l1..u8 >$@


out.munmun_twitterex_at:   mktweets twitter-released-dataset/tweets.data
	{ echo '% asym positive' ; <twitter-released-dataset/tweets.data \
          sed -e :a -e '/\\$$/N; s/\\\n//; ta' |  ./mktweets '@' | \
          sed -e 's, @, ,' | ../mkuniq1 ; } >$@

out.munmun_twitterex_ut:  twitter-released-dataset/tweets.data mktweets
	{ echo '% bip positive' ; <twitter-released-dataset/tweets.data \
          sed -e :a -e '/\\$$/N; s/\\\n//; ta' |  ./mktweets '#' | ../mkuniq ; } >$@

out.munmun_twitterex_ui:  twitter-released-dataset/tweets.data mktweets
	{ echo '% bip positive' ; <twitter-released-dataset/tweets.data \
          sed -e :a -e '/\\$$/N; s/\\\n//; ta' |  ./mktweets 'http:' | ../mkuniq ; } >$@

out.munmun_twitterex_ti:  twitter-released-dataset/tweets.data mktwitter_ti
	{ echo '% bip positive' ; <twitter-released-dataset/tweets.data \
          sed -e :a -e '/\\$$/N; s/\\\n//; ta' |  ./mktwitter_ti | ../mkuniq ; } >$@

out.munmun_twitterex_triple:  twitter-released-dataset/tweets.data mktriple 
	<twitter-released-dataset/tweets.data sed -e :a -e '/\\$$/N; s/\\\n//; ta' | \
	./mktriple >$@

#
# For the paper "Retweets"
#
# This is deprecated, it has been moved to projects/retweets/. 
#
dagstuhl:  retweet.dat retweet-words.dat words-1.dat words-0.dat statistics statistics-result2 words-odds.dat

retweet.dat:  twitter_data mkretweet
	<twitter_data/tweets.data recode l1...u8 | sed -e :a -e '/\\$$/N; s/\\\n//; ta' | ./mkretweet >$@

retweet-words.dat:  twitter_data mkretweet-words
	<twitter_data/tweets.data recode l1...u8 | sed -e :a -e '/\\$$/N; s/\\\n//; ta' | \
        ./mkretweet-words >$@

words-1.dat:  retweet-words.dat
	<retweet-words.dat sed -re '/^1 /!d;s,^1 ,x ,' | sort | uniq -c | sort -nr >$@

words-0.dat:  retweet-words.dat
	<retweet-words.dat sed -re '/^0 /!d;s,^0 ,x ,' | sort | uniq -c | sort -nr >$@

words-odds.dat:  words-1.dat words-0.dat
	java -jar tweetodds.jar

statistics:  retweet.dat mkstatistics
	./mkstatistics >$@

statistics-dump:  statistics
	<statistics sed -re '/^%/d;s,\[.+\],,' >$@

statistics-result:  statistics-dump statistics.m
	../../matlab/octave statistics 

statistics-result2:  statistics-result
	<statistics sed -re '/^%/d;s,\].*,\],' | paste - statistics-result >$@
