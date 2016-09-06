#
# User-repository bipartite network from the Github contest. 
#
# http://github.com/blog/466-the-2009-github-contest
#

all:  out.github ent.github.repository.name ent.github.repository.creationTime 

out.github ent.github.repository.name ent.github.repository.creationTime:  download/data.txt
	<download/data.txt ./mkgithub >$@

download/data.txt:
	wget https://github.s3.amazonaws.com/data/download.zip -O download.zip
	unzip download.zip

.PHONY: clean

clean:
	rm -rf download*
	rm -f out.github
	rm -f ent.github.*
