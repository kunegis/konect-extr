all:  out.training out.training-unweighted

clean:  
	rm -rf out.* download download.tar.gz
.PHONY:  clean


# The corpus in Matlab format
out.training:  out.training.bare out.header
	cat out.header out.training.bare >$@

out.training.bare out.header:  out.training.raw mktraining
	./mktraining

# Dataset with original IDs
out.training.raw:   download/ mktrainingraw
	./mktrainingraw

## The downloaded dataset
## Set this by hand 
download.tar.gz:  
	scp $$USER@file.isweb:/data/isweb/webstore/own/netflix/download_7107831001.tar.gz $@
#	ln -s /mnt/munin-data1/corpora/netflix/20070723/download

download:  download.tar.gz
	tar xfvvz download.tar.gz
	touch download 
	cd download && tar xf training_set.tar

out.training-unweighted:  out.training
	../mkunweighted <out.training >$@
