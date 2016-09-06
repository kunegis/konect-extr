#
# The BibSonomy Dataset
# =====================
#
# This extracts the BibSonomy dataset. 
#
# See for [1] new versions. 
#
# [1] http://www.kde.cs.uni-kassel.de/bibsonomy/dumps 
#
# Username:bibsonomy-research
#
# Important: Variable 'BPASSWD' has to be set to the correct password.

# enter username and password below
# BUSER:=XXX
# BPASSWD:=XXX
# 
# The name inside the tarball; may not correspond to the tarball name
export VERSION := 2010-01-01
export TAS  := $(VERSION)/tas

RELATIONSHIPS := ut ui ti 
ENTITIES := ent.bibsonomy-2ut.tag.name ent.bibsonomy-2ui.item.name ent.bibsonomy-2ti.tag.name ent.bibsonomy-2ti.item.name

all:  $(foreach I, $(RELATIONSHIPS), out.bibsonomy-2$(I)) $(ENTITIES)

clean:  ; rm -rf out.* $(VERSION) $(VERSION).tgz ent.* 
.PHONY:  clean


#$(VERSION).tgz:  
#	echo "Download http://www.kde.cs.uni-kassel.de/bibsonomy/dumps/$(VERSION).tgz using username/password"
#	test ! $(BPASSWD) && echo 'Please set $$BPASSWD.' 1>&2 && exit 1
$(VERSION).tgz:
	wget --user=$(BUSER) --password=$(BPASSWD) --no-check-certificate http://www.kde.cs.uni-kassel.de/bibsonomy/dumps/$(VERSION).tgz

$(TAS):  $(VERSION).tgz
	tar xfz $(VERSION).tgz
	touch $(TAS)

$(ENTITIES) out.bibsonomy-2ut out.bibsonomy-2ui out.bibsonomy-2ti:  $(VERSION)/tas $(VERSION)/bookmark mkui2
	./mkui2
