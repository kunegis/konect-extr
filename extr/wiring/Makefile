all:  rel.pos rel.neg pca

plot/dir:  ; mkdir -p plot && touch plot/dir

wiring.dat:  
	wget http://vlado.fmf.uni-lj.si/pub/networks/data/Ucinet/wiring.dat

wiring.pos:  wiring.dat
	tail -n56 wiring.dat | head -n14 >$@
wiring.neg:  wiring.dat
	tail -n42 wiring.dat | head -n14 >$@

rel.%:  wiring.% mkrel
	./mkrel $*

pca:  plot/pca.a.eps
.PHONY:  pca
plot/pca.a.eps:  rel.pos rel.neg pca.m plot/dir
	../matlab/matlab pca
