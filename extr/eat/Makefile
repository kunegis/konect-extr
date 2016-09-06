

all:  out.eat ent.eat
ent.eat: out.eat

out.eat: tmp.ent  eatRS.net
	<eatRS.net sed -re '/\s*[0-9]+\s+[0-9]+\s+[0-9]\s*$$/!d;s,\s*([0-9]+)\s+([0-9]+)\s+([0-9]+)\s*$$,\2	\1	\3,'  | ../mkrel --+ent=ent.eat:tmp.ent:0:1* 'asym' 'positive' >out.eat

tmp.ent:   eatRS.net
	<$< sed -re '/^[0-9]+\s+"[^"]*"\s*$$/!d' | sed -e 's/"//g' >$@ 


eatRS.net:  eatRS.zip
	rm -rf eatRS.net 
	unzip eatRS.zip
	touch -c $@

eatRS.zip:
	wget http://vlado.fmf.uni-lj.si/pub/networks/data/dic/eat/eatRS.zip -O $@

.PHONY:  clean
clean: ; rm -f out.* ent.* *.net *.zip tmp.ent 
