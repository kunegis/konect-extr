SHELL := /bin/bash
TORRENT = 1881-dec-2011.torrent

#do not set to current directory, will get rm -rf on clean:
TMPFOLDER = stackexchange_tmp

OUTFOLDER = out

# This will go over every .*\.7z(\.001)?$ file and extract data from the
# contained votes.xml file. v 

all: out.stackexchange_votes

%/makedir:
	mkdir -p $* ; \
	touch $@

$(TMPFOLDER)/download/stackexchange-dump: $(TMPFOLDER)/download/makedir
	wget --output-document="$(TORRENT)" http://www.clearbits.net/get/$(TORRENT)
	aria2c --seed-time=0 --file-allocation=none --dir=$(TMPFOLDER)/download $(TORRENT)
	touch $(TMPFOLDER)/download/stackexchange-dump

out.stackexchange_votes: $(TMPFOLDER)/download/stackexchange-dump $(OUTFOLDER)/makedir $(TMPFOLDER)/extract/makedir
	 ./extract.sh $(TMPFOLDER) "" $(OUTFOLDER)        


.PHONY: clean

clean:
	rm -rf $(OUTFOLDER) ; \
        rm -rf $(TMPFOLDER) ; \
        rm $(TORRENT) 
