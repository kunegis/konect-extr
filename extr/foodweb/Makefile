all: out.foodweb-baywet out.foodweb-baydry

.PHONY: clean

%.paj:
	wget http://vlado.fmf.uni-lj.si/pub/networks/data/bio/foodweb/$@
	fromdos $@

out.foodweb-baydry: baydry.paj
	cat $< | ./mk | ../mkrel "asym" "posweighted" > $@

out.foodweb-baywet: baywet.paj
	cat $< | ./mk | ../mkrel "asym" "posweighted" > $@
clean:
	rm -rf *.paj
	rm -f out.*
