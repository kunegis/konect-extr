:::::: DEPRECATED - use main.stu

#
# Partial Facebooks dataset from
# http://socialnetworks.mpi-sws.org/data-wosn2009.html
#

#
# Please use the following BibTeX entry if you would like to cite this dataset. [480]
#
# @inproceedings{viswanath-2009-activity,
#   author = {Bimal Viswanath and Alan Mislove and Meeyoung Cha and
#       Krishna P. Gummadi}, 
#   title = {On the Evolution of User Interaction in Facebook}, 
#   booktitle = {Proceedings of the 2nd ACM SIGCOMM Workshop on Social
#         Networks (WOSN'09)}, 
#   location = {Barcelona, Spain},
#   month = {August},
#   year = {2009}
# }
#

all:  out.facebook-wosn-links out.facebook-wosn-wall

facebook-%.txt:  
	wget http://socialnetworks.mpi-sws.mpg.de/data/facebook-$*.txt.gz
	gunzip facebook-$*.txt.gz
.SECONDARY: ; facebook-*.txt

out.facebook-wosn-wall:  facebook-wall.txt mk
	./mk wall | ../mkrel 'asym' 'positive' >$@

out.facebook-wosn-links:  facebook-links.txt mk
	./mk links | ../mkrel --enforce-edgeweights 'sym' 'unweighted' >$@


.PHONY: clean

clean:
	rm -f out.* facebook-*.txt facebook-*.txt.gz
