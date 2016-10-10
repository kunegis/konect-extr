
:::: DEPRECATED - use main.stu

all:  out.ucidata-zachary out.ucidata-gama

out.ucidata-zachary:  ucidata-zachary.dat matlab conv.m
	./matlab conv

ucidata-zachary.dat:  zachary.dat
	<zachary.dat head -n 41 | tail -n 34 >$@

gama-pos.dat:  gama.dat
	<gama.dat head -n 57 | tail -n 16 >$@

gama-neg.dat:  gama.dat
	<gama.dat tail -n 16 >$@

zachary.dat gama.dat:
	wget http://vlado.fmf.uni-lj.si/pub/networks/data/ucinet/$@ -O $@

matlab: ../../analysis/matlab
	cp ../../analysis/matlab .

out.ucidata-gama:  gama-pos.dat gama-neg.dat conv_gama.m
	./matlab conv_gama

