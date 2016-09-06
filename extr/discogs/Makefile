RELEASE=discogs_20151001_releases.xml

OUT=out.discogs_all_affiliation out.discogs_all_style out.discogs_all_genre out.discogs_all_lstyle out.discogs_all_lgenre
ENT=ent.discogs_all_all.artist.name ent.discogs_all_all.label.name ent.discogs_all_all.genre.name ent.discogs_all_all.style.name

PKG=ent.discogs_affiliation_affiliation.artist.name ent.discogs_affiliation_affiliation.label.name out.discogs_affiliation_affiliation ent.discogs_lstyle_lstyle.style.name ent.discogs_lstyle_lstyle.label.name out.discogs_lstyle_lstyle ent.discogs_lgenre_lgenre.genre.name ent.discogs_lgenre_lgenre.label.name out.discogs_lgenre_lgenre ent.discogs_style_style.style.name ent.discogs_style_style.label.name out.discogs_style_style ent.discogs_genre_genre.genre.name ent.discogs_genre_genre.label.name out.discogs_genre_genre

.PHONY: OUT_ALL
.SECONDARY: $(RELEASE) $(OUT) $(ENT)

all: $(ENT) OUT_ALL $(PKG)

$(ENT): $(OUT)
	touch $@

$(OUT): OUT_ALL
	touch $@

OUT_ALL: $(RELEASE) mk
	<$(RELEASE) ./mk 

out.discogs_affiliation_affiliation ent.discogs_affiliation_affiliation.artist.name ent.discogs_affiliation_affiliation.label.name: $@ out.discogs_all_affiliation ent.discogs_all_all.artist.name ent.discogs_all_all.label.name
	<$< ../mkrel --+ent=ent.discogs_affiliation_affiliation.artist.name:ent.discogs_all_all.artist.name:-1:0:0 --+ent=ent.discogs_affiliation_affiliation.label.name:ent.discogs_all_all.label.name:-1:0:1 --ent-delimiter=' ' "bip" "positive" > out.discogs_affiliation_affiliation

# TODO:  $@ should not appear in the list of dependencies 

out.discogs_lstyle_lstyle ent.discogs_lstyle_lstyle.style.name ent.discogs_lstyle_lstyle.label.name: $@ out.discogs_all_lstyle ent.discogs_all_all.label.name ent.discogs_all_all.style.name
	<$< ../mkrel --+ent=ent.discogs_lstyle_lstyle.style.name:ent.discogs_all_all.style.name:-1:0:1 --+ent=ent.discogs_lstyle_lstyle.label.name:ent.discogs_all_all.label.name:-1:0:0 --ent-delimiter=' ' "bip" "positive" > out.discogs_lstyle_lstyle

out.discogs_lgenre_lgenre ent.discogs_lgenre_lgenre.genre.name ent.discogs_lgenre_lgenre.label.name: $@ out.discogs_all_lgenre ent.discogs_all_all.label.name ent.discogs_all_all.genre.name
	<$< ../mkrel --+ent=ent.discogs_lgenre_lgenre.genre.name:ent.discogs_all_all.genre.name:-1:0:1 --+ent=ent.discogs_lgenre_lgenre.label.name:ent.discogs_all_all.label.name:-1:0:0 --ent-delimiter=' ' "bip" "positive" > out.discogs_lgenre_lgenre

out.discogs_style_style ent.discogs_style_style.style.name ent.discogs_style_style.label.name: $@ out.discogs_all_style ent.discogs_all_all.artist.name ent.discogs_all_all.style.name
	<$< ../mkrel --+ent=ent.discogs_style_style.style.name:ent.discogs_all_all.style.name:-1:0:1 --+ent=ent.discogs_style_style.artist.name:ent.discogs_all_all.artist.name:-1:0:0 --ent-delimiter=' ' "bip" "positive" > out.discogs_style_style

out.discogs_genre_genre ent.discogs_genre_genre.genre.name ent.discogs_genre_genre.label.name: $@ out.discogs_all_genre ent.discogs_all_all.artist.name ent.discogs_all_all.genre.name
	<$< ../mkrel --+ent=ent.discogs_genre_genre.genre.name:ent.discogs_all_all.genre.name:-1:0:1 --+ent=ent.discogs_genre_genre.artist.name:ent.discogs_all_all.artist.name:-1:0:0 --ent-delimiter=' ' "bip" "positive" > out.discogs_genre_genre

%.xml.gz:
	wget "http://www.discogs.com/data/$@" -O "$@" -U firefox
	touch $@

%.xml: %.xml.gz
	gunzip $<
	touch $@

.PHONY: clean

clean:
	rm -f *.xml.gz
	rm -f *.xml
	rm -f out.*
	rm -f ent.*
