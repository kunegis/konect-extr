
#NOTE: @ is replaced with the file numbers.
URL:=https://archive.org/download/friendster-dataset-201107
FILENAMES:=friends-@______.txt.bz2
FILECOUNT:=124

#do not edit below this line
RANGE=$(shell seq -f '%03g' 0 $(FILECOUNT))
FILESBZ=$(foreach x,$(RANGE),data/$(subst @,$(x),$(FILENAMES)))
FILES=$(subst .txt.bz2,.txt,$(FILESBZ))

all: out.friendster

out.friendster: 
#data/all
	<data/all ./mk | ../mkrel 'asym' 'unweighted' >$@

data/all: data verify $(FILES)
	cat data/friends-*.txt > $@

data:
	mkdir data

data/%.bz2: data verify
	wget -U mozilla -e robots=off --no-check-certificate "$(URL)/$*.bz2" -O $@

data/%.txt: data/%.txt.bz2
	bunzip2 $^
	touch $@

.PHONY: clean verify

verify:
	[ -d 'data' ] || { echo "Could not create directory 'data'">&2; exit 1; }

clean:
	rm -rf data

test:
	echo $(FILES)
