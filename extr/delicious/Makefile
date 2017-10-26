#
# Delicious.com Folksonomy extracted by Robert Wetzker et al. 
#

all: out.delicious_delicious-ut_delicious-ut out.delicious_delicious-ui_delicious-ui out.delicious_delicious-ti_delicious-ti ent.delicious_delicious-ut_delicious-ut.user.name ent.delicious_delicious-ut_delicious-ut.tag.name ent.delicious_delicious-ui_delicious-ui.user.name ent.delicious_delicious-ui_delicious-ui.url.name ent.delicious_delicious-ti_delicious-ti.tag.name ent.delicious_delicious-ti_delicious-ti.url.name

DELICP=tmp.deliciousdb_main_nospam

OWN=/data/estrella/konect/own

#clear up input data, removing invalid lines
tmp.deliciousdb_main_nospam: $(OWN)/deliciousdb_main_nospam
	sed 's/[	]/ /g' $< | sed 's/ \+/ /g' | sed -e '/^[0-9]\+-[0-9]\+-[0-9]\+ \S\+ \S\+ \S\+ [0-9]\+/!d' | sed "s/'/\\\'/g" | sed 's/"/\\"/g'>$@

clean:
	rm -rf  txt.* out.* tmp.* ent.*

.PHONY:  clean

out.delicious_delicious-ut_delicious-ut ent.delicious_delicious-ut_delicious-ut.user.name ent.delicious_delicious-ut_delicious-ut.tag.name:  $(DELICP)
	<$(DELICP) sed 's/[ 	][ 	]*/ /g'| sed 's/	/ /g'|./mkdelic 1 3 | ../mkrel --ent-delimiter=' ' --+ent=ent.delicious_delicious-ut_delicious-ut.user.name:STDIN:::0 --+ent=ent.delicious_delicious-ut_delicious-ut.tag.name:STDIN:::1  "bip" "positive" >$@

out.delicious_delicious-ui_delicious-ui ent.delicious_delicious-ui_delicious-ui.user.name ent.delicious_delicious-ui_delicious-ui.url.name:  $(DELICP)
	<$(DELICP) sed 's/[ 	][ 	]*/ /g' |sed 's/	/ /g'| ./mkdelic 1 2 | ../mkrel --ent-delimiter=' ' --+ent=ent.delicious_delicious-ui_delicious-ui.user.name:STDIN:::0 --+ent=ent.delicious_delicious-ui_delicious-ui.url.name:STDIN:::1  "bip" "positive" >$@

out.delicious_delicious-ti_delicious-ti ent.delicious_delicious-ti_delicious-ti.tag.name ent.delicious_delicious-ti_delicious-ti.url.name:  $(DELICP)
	<$(DELICP) sed 's/[ 	][ 	]*/ /g' | sed 's/	/ /g' | ./mkdelic 3 2 | ../mkrel --ent-delimiter=' ' --+ent=ent.delicious_delicious-ti_delicious-ti.tag.name:STDIN:::0 --+ent=ent.delicious_delicious-ti_delicious-ti.url.name:STDIN:::1  "bip" "positive" >$@
