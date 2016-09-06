DEPRECATED -- use main.stu

# 
# The "Contact", a.k.a. Haggle dataset provided by Pan Hui (a.k.a. Ben)
# from Deutsche Telekom Laboratories.  The dataset was sent by email to
# Jérôme Kunegis on 2010-02-26. 
#
# The dataset is pretty small so we keep it in SVN. 
#

all:  out.contact

FILENAME := contacts.Exp3.dat

out.contact:  $(FILENAME) mkdat
	./mkdat <$(FILENAME) >out.contact

clean:
	rm -rf *~ out.*
