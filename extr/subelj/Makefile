URL=http://lovro.lpt.fri.uni-lj.si/resources/research/networks

all: out.subelj_jdk_jdk out.subelj_jung-j_jung-j out.subelj_euroroad_euroroad out.subelj_cora_cora

out.subelj_euroroad_euroroad: euroroad euroroad.map
	<euroroad sed -ne '/\*edges/,//p' | tail -n +2 | ../mkrel --ent-delimiter=' ' --+ent=ent.subelj_euroroad_euroroad.city.name:euroroad.map:0:1 'sym' 'unweighted' >$@

out.subelj_cora_cora: cora cora.in
	<cora sed -ne '/\*edges/,//p' | tail -n +2 | ../mkrel --+ent=ent.subelj_cora_cora.class.name:cora.in:2:1 --+ent=ent.subelj_cora_cora.id.name:cora.in:2:3 'asym' 'unweighted' >$@

out.subelj_jung-j_jung-j: jung-j jung-j.map
	<jung-j sed '/^#/d' | ../mkrel --enforce-edgeweights --+ent=ent.subelj_jung-j_jung-j.class.name:jung-j.map:1:0 'asym' 'positive' >$@

out.subelj_jdk_jdk: jdk jdk.map
	<jdk sed '/^#/d' | ../mkrel --enforce-edgeweights --+ent=ent.subelj_jdk_jdk.class.name:jdk.map:1:0 'asym' 'positive' >$@

cora.in: cora cora.map
	<cora sed -ne '/\*vertices/,/\*edges/p' | tail -n +2 | sed 's/\"//g' | sort -s -n -k 3 | tail -n +2 | join -1 1 -2 3 cora.map - >$@

jdk:
	wget $(URL)/other/jdk -O $@
jung-j:
	wget $(URL)/ssa/jung-j -O $@
cora:
	wget $(URL)/cpm/cora -O $@
euroroad:
	wget $(URL)/bpa/euroroad.net -O $@
cora.map:
	wget $(URL)/cpm/cora.map -O $@

euroroad.map: euroroad
	<euroroad sed -ne '/\*vertices/,/\*edges/p' | tail -n +2 >$@

jdk.map:
	wget $(URL)/other/jdk.map -O $@
jung-j.map:
	wget $(URL)/ssa/jung-j.map -O $@

.PHONY: clean
clean:
	rm -f jdk jung-j cora *.map ent.* out.*
