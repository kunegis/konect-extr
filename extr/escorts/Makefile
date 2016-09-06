all: out.escorts

LuisRocha_sexnet_pnas.csv.zip:
	wget http://www.tp.umu.se/~rocha/data/LuisRocha_sexnet_pnas.csv.zip

out.escorts: LuisRocha_sexnet_pnas.csv.zip
	unzip $<
	awk -F';' '{ if ( substr($$0,0,1) != "#" ) { printf("%s %s %s %s\n",$$2,$$1,$$4,($$3*86400+1030831200));  } }' LuisRocha_sexnet_pnas.csv | ../mkuniq > out.escorts.tmp
	echo '% bip multiweighted' > out.escorts
	../mkcount out.escorts.tmp 0 >> out.escorts
	cat out.escorts.tmp >> out.escorts
	rm out.escorts.tmp	

.PHONY: clean

clean:
	rm -f LuisRocha_sexnet_pnas.*
	rm -f out.*
