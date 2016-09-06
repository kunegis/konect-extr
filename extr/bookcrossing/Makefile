
#all: out.bookcrossing_rating_rating 

ENTBOOK1=ent.bookcrossing_rating_rating.book.author ent.bookcrossing_rating_rating.book.isbn ent.bookcrossing_rating_rating.book.publisher ent.bookcrossing_rating_rating.book.title ent.bookcrossing_rating_rating.book.year
ENTUSER1=ent.bookcrossing_rating_rating.user.age ent.bookcrossing_rating_rating.user.id ent.bookcrossing_rating_rating.user.location
ENTBOOK2=$(subst _rating,_full-rating,$ENTBOOK1)
ENTUSER2=$(subst _rating,_full-rating,$ENTUSER1)

OUT1=out.bookcrossing_rating_rating
OUT2=out.bookcrossing_full-rating_full-rating
ENTITIES=$(ENTBOOK1) $(ENTUSER1) $(ENTBOOK2) $(ENTUSER2)
.PHONY: OUTP OUTP2 data clean
all: $(ENTITIES) $(OUT1) $(OUT2)

$(ENTITIES): $(OUT1) $(OUT2)
	touch $@

$(OUT1): OUTP1
	touch $@
$(OUT2): OUTP2
	touch $@

OUTP2: BX-Book-Ratings.csv BX-Books.csv BX-Users.csv
	tail -n +2 "BX-Book-Ratings.csv" | sed 's/;/ /g' | sed 's/"//g' | ./mk2  | ../mkrel --ent-delimiter=';' --+ent=ent.bookcrossing_full-rating_full-rating.book.author:BX-Books.csv:0:2:1 --+ent=ent.bookcrossing_full-rating_full-rating.book.title:BX-Books.csv:0:1:1 --+ent=ent.bookcrossing_full-rating_full-rating.book.isbn:BX-Books.csv:0:0:1 --+ent=ent.bookcrossing_full-rating_full-rating.book.year:BX-Books.csv:0:3:1 --+ent=ent.bookcrossing_full-rating_full-rating.book.publisher:BX-Books.csv:0:4:1 --+ent=ent.bookcrossing_full-rating_full-rating.user.location:BX-Users.csv:0:1:0 --+ent=ent.bookcrossing_full-rating_full-rating.user.age:BX-Users.csv:0:2:0 --+ent=ent.bookcrossing_full-rating_full-rating.user.id:BX-Users.csv:0:0:0 'bip' 'unweighted' >out.bookcrossing_full-rating_full-rating


OUTP1: BX-Book-Ratings.csv BX-Books.csv BX-Users.csv
	tail -n +2 "BX-Book-Ratings.csv" | sed 's/;/ /g' | sed 's/"//g' | ./mk  | ../mkrel --ent-delimiter=';' --+ent=ent.bookcrossing_rating_rating.book.author:BX-Books.csv:0:2:1 --+ent=ent.bookcrossing_rating_rating.book.title:BX-Books.csv:0:1:1 --+ent=ent.bookcrossing_rating_rating.book.isbn:BX-Books.csv:0:0:1 --+ent=ent.bookcrossing_rating_rating.book.year:BX-Books.csv:0:3:1 --+ent=ent.bookcrossing_rating_rating.book.publisher:BX-Books.csv:0:4:1 --+ent=ent.bookcrossing_rating_rating.user.location:BX-Users.csv:0:1:0 --+ent=ent.bookcrossing_rating_rating.user.age:BX-Users.csv:0:2:0 --+ent=ent.bookcrossing_rating_rating.user.id:BX-Users.csv:0:0:0 'bip' 'weighted' >out.bookcrossing_rating_rating

%.csv: data
	touch $@

data: BX-CSV-Dump.zip
	unzip $<
	fromdos BX-Book-Ratings.csv BX-Books.csv BX-Users.csv
	recode latin1..utf8 BX-Book-Ratings.csv BX-Books.csv BX-Users.csv

BX-CSV-Dump.zip:
	wget http://www.informatik.uni-freiburg.de/~cziegler/BX/BX-CSV-Dump.zip -U firefox -O "$@"

clean:
	rm -f *.csv
	rm -f ent.* out.*
#	rm -f BX-CSV-Dump.zip
