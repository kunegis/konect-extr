DEPRECATED -- use main.stu
::::::::::::::::::::::::::

all: out.amazon-ratings ent.amazon-ratings-member-names ent.amazon-ratings-member-location

amazon-member-shortSummary.txt:
	wget http://liu.cs.uic.edu/download/data/amazon-member-shortSummary.txt


reviewsNew.txt: reviewsNew.rar
	unrar e $<
	touch $@

reviewsNew.rar:
	wget "http://liu.cs.uic.edu/download/data/reviewsNew.rar"

ent.amazon-ratings-member-names ent.amazon-ratings-member-location out.amazon-ratings: reviewsNew.txt amazon-member-shortSummary.txt
	cat $< | ./mk | ../mkrel --+ent=ent.amazon-ratings-member-names:amazon-member-shortSummary.txt:0:1:0 --+ent=ent.amazon-ratings-member-location:amazon-member-shortSummary.txt:0:3:1 --ent-inputdelimiter='	' "bip" "weighted" > $@

.PHONY: clean

clean:
	rm -f *.rar
	rm -f *.txt
	rm -f out.*
