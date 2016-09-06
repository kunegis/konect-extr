all: out.jester1 out.jester2 
URL="http://eigentaste.berkeley.edu/dataset"

out.jester2: jester3xls jesterfinal151cols.csv
	<jesterfinal151cols.csv ./mk | ../mkrel 'bip' 'weighted'>$@
out.jester1: jester1-1.csv jester1-2.csv jester1-3.csv 
	cat jester1-1.csv jester1-2.csv jester1-3.csv | ./mk | ../mkrel 'bip' 'weighted'>$@
%.zip:
	wget "$(URL)/$(subst -,_,$(patsubst jester%,jester_dataset_%.zip,$*))" -O "$@"

%.xls: %.zip
	unzip $<
	mv jester-data-*.xls $@

jester_ratings.dat: jester2.zip
	unzip $<

%.csv: %.xls
	py_xls2csv $< >$@

.PHONY: jester3xls
jester3xls: jester3.zip
	unzip $<

.PHONY: clean
clean:
	rm -f *.csv *.zip *.xls *.dat *.zip
	rm -f out.*
	rm -rf __*
