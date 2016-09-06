
DEPRECATED -- use main.stu

all:  out.filmtipset_rating out.filmtipset_comment out.filmtipset_friend

filmtipset:  
	rsync -vvt $$USER@estrella.uni-koblenz.de:/export/kunegis/konect/own/filmtipset.tar.bz2 .
	tar xfvvj filmtipset.tar.bz2
	touch filmtipset

rel.rating:  filmtipset mkrating
	./mkrating

rel.comment:  filmtipset mkcomment
	./mkcomment

rel.friend:  filmtipset mkfriend
	./mkfriend

out.filmtipset_rating:  rel.rating
	>$@ ../mkuniq <rel.rating 

out.filmtipset_comment:  rel.comment
	>$@ ../mkuniq <rel.comment

out.filmtipset_friend:  rel.friend
	{ echo '% sym unweighted' ; <rel.friend ../mkuniq1 | ../mksym ; } >$@


clean: 
	rm -rf filmtipset.tar.bz2 out.* rel.* filmtipset
