
all:  out.libimseti stats gender.asc

out.libimseti:   ratings.dat
	{ echo '% asym weighted' ; <ratings.dat sed -re 's|,|	|g' ; } >$@

%.dat: 
	wget http://www.occamslab.com/petricek/data/$*.dat


stats:  gender.dat mkstats
	./mkstats >$@

# The gender info in matrix form (0=unknown, 1=male, 2=female)
gender.asc:  gender.dat
	<gender.dat tr ',UMF' '	012' >$@
