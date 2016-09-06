#
# http://odysseas.calit2.uci.edu/research/
#

all:  out.osn-mhrw out.osn-uni

all-files:  mhrw-nodeproperties-anonymized mhrw-socialgraph-anonymized uni-nodeproperties-anonymized uni-socialgraph-anonymized


mhrw-nodeproperties-anonymized:
	wget http://odysseas.calit2.uci.edu/research/data/mhrw-nodeproperties-anonymized -O$@

mhrw-socialgraph-anonymized: 
	wget http://odysseas.calit2.uci.edu/research/data/mhrw-socialgraph-anonymized -O$@


uni-nodeproperties-anonymized:
	wget http://odysseas.calit2.uci.edu/research/data/uni-nodeproperties-anonymized -O$@

uni-socialgraph-anonymized:
	wget http://odysseas.calit2.uci.edu/research/data/uni-socialgraph-anonymized -O$@


out.osn-%:  %-socialgraph-anonymized
	{ echo '% asym unweighted' ; <$*-socialgraph-anonymized ./mk | ../mkuniq1 ; } >$@

