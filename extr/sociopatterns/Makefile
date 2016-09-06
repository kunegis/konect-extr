
all: out.sociopatterns-infectious out.sociopatterns-hypertext

ht09_contact_list.dat.gz:
	wget "http://www.sociopatterns.org/files/datasets/003/ht09_contact_list.dat.gz"

sg_infectious_contact_list.tgz:
	wget "http://www.sociopatterns.org/files/datasets/004/sg_infectious_contact_list.tgz"

out.sociopatterns-hypertext: ht09_contact_list.dat.gz
	gunzip $<
	awk -F'	' '{printf("%s %s 1 %s\n",$$2,$$3,$$1+1246255200);}' "ht09_contact_list.dat" | ../mkrel "sym" "positive" > $@ 

out.sociopatterns-infectious: sg_infectious_contact_list.tgz
	tar xvvf $<
	cat listcontacts_2009_07_15.txt | awk -F'	' '{print $$2" "$$3" 1 "$$1}' | ../mkrel "sym" "positive" > $@

.PHONY: clean
clean:
	rm -f sg_infectious_contact_list.tgz
	rm -f ht09_contact_list.dat*
	rm -f out.*
	rm -f *listcontacts*.txt
