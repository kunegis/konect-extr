UNUSED

NAME=adjnoun

all: out.$(NAME)_adjacency_adjacency ent.$(NAME)_adjacency_adjacency.word.name


adjnoun.zip:
	wget 'www-personal.umich.edu/~mejn/netdata/adjnoun.zip'
	touch $@
adjnoun.gml: adjnoun.zip
	unzip adjnoun.zip
	touch $@

out.$(NAME)_adjacency_adjacency ent.$(NAME)_adjacency_adjacency.word.name: adjnoun.gml tmp.ent.$(NAME)
	<tmp.out ../mkrel --+ent=ent.$(NAME)_adjacency_adjacency.word.name:tmp.ent.$(NAME):0:1   "sym" "unweighted" > out.$(NAME)_adjacency_adjacency

tmp.ent.$(NAME): tmp.out

tmp.out:
	<adjnoun.gml ./gmlextract tmp.ent.$(NAME)>tmp.out

.PHONY: clean

clean:
	rm -f ent.*
	rm -f out.*
	rm -f adjnoun.*
	rm -f tmp.*
