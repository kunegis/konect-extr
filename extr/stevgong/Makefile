all: out.stevgong_social_social out.stevgong_attribute_attribute

#out.stevgong_newlinks_newlinks: gplus/data
#	<gplus/snakdd12/predict-new-links/*.txt  ./mk "social" | ../mkrel 'sym' 'unweighted' >$@

#out.stevgong_newlinksA_newlinksA: gplus/data
#	<gplus/snakdd12/predict-new-links/*.txt ./mk "attrib" | ../mkrel 'sym' 'unweighted' >$@

#out.stevgong_missinglinks_missinglinks: gplus/data
#	<gplus/snakdd12/predict-missing-links/*.txt  ./mk "social" | ../mkrel 'sym' 'unweighted' >$@

#out.stevgong_missinglinksA_missinglinksA: gplus/data
#	<gplus/snakdd12/predict-missing-links/*.txt ./mk "attrib" | ../mkrel 'sym' 'unweighted' >$@

out.stevgong_social_social: gplus/data
	<gplus/imc12/direct_social_structure.txt ./mkimc12 | ../mkrel --keep-dynsorted --use-math 'asym' 'dynamic' >$@

out.stevgong_attribute_attribute: gplus/data
	<gplus/imc12/node_attri.txt ./mkimc12 | ../mkrel --+ent=ent.stevgong_attribute_attribute.attribute.type:gplus/imc12/attri_type.txt:0:1:1 'bip' 'unweighted' >$@

.SECONDARY: gplus.tar gplus.tar.gz gplus/data

gplus/data: gplus.tar
	tar xvvf $<
	touch gplus/data

gplus.tar: gplus.tar.gz
	gunzip $<

gplus.tar.gz:
	wget http://aerie.cs.berkeley.edu/release/gplus.tar.gz -O gplus.tar.gz

#jatt.txt: gplus/data
#	sort -k2n,2r gplus/imc12/node_attri.txt | join -1 1 -2 2 gplus/imc12/attri_type.txt - >$@


.PHONY: clean
clean:
	rm -f *.txt *.tar*
	rm -rf gplus
	rm -rf ent.* out.*

