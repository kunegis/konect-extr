#
# The very large Twitter follow graph, with about 1.5 billion edges.
# Does not contain usernames or tweets. 
#
# This was presented at WWW 2010 by Haewoon Kwak et al.. 
#
# http://an.kaist.ac.kr/traces/WWW2010.html
#

out.twitter:   twitter_rv.net
	{ echo '% asym unweighted' ; ../mkuniq1 <twitter_rv.net ; } >out.twitter

twitter_rv.net:  twitter_rv.tar.gz
	tar xfvvz twitter_rv.tar.gz
	touch twitter_rv.net

twitter_rv.tar.gz:
	./bittorrent "http://an.kaist.ac.kr/~haewoon/twitter_rv.tar_gz.torrent"


.PHONY: clean

clean:
	rm -f twitter* out.twitter
