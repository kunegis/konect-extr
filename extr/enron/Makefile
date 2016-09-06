#
# The Enron email dataset:  logs of emails sent at Enron.
#
# http://www.cs.cmu.edu/~enron/
#

all:  out.enron


enron_mail_082109.tar.gz: 
	wget http://www.cs.cmu.edu/~enron/enron_mail_082109.tar.gz

maildir:  enron_mail_082109.tar.gz
	tar xfz $<
	touch $@

out.enron:  maildir mkout
	./mkout

clean:
	rm -rf enron_mail_*.tar.gz maildir out.*
.PHONY:  clean 
