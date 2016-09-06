
NAME_REUTERS := reuters21578-t-d-matrix.txt
NAME_TREC := trec-t-d-matrix.txt
NAME_EXCELLENT := wiki-exc-t-d-matrix.txt

all: out.gottron-reuters out.gottron-trec out.gottron-excellent
#all:  out.$(foreach I, reuters trec excellent, out.gottron-$(I))

out.gottron-reuters:  ../own/$(NAME_REUTERS)
	{ echo '% bip positive' ; cat ../own/$(NAME_REUTERS) ; } >$@

out.gottron-trec:  ../own/$(NAME_TREC)
	{ echo '% bip positive' ; cat ../own/$(NAME_TREC) ; } >$@

out.gottron-excellent:  ../own/$(NAME_EXCELLENT)
	{ echo '% bip positive' ; cat ../own/$(NAME_EXCELLENT) ; } >$@
