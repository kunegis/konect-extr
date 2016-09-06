#
# The dataset from the private lending website prosper.com 
#
#
# List of data:
#
#	M member
#	G group
#	L listing
#
# 	M-M endorsement 
# 	M-M friend 
# 	M-G support
# 	M-L watch
#

all:   reli.endorsement reli.friend reli.support reli.watch out.prosper-endorsement out.prosper-friend out.prosper-support out.prosper-watch

clean:  ; rm -rf *.zip *.dat *.xml *.xsd reli.* out.*
.PHONY:  clean 

ProsperDataExport.xml: 
	wget https://services.prosper.com/DataExport/ProsperDataExport_xml.zip -OProsperDataExport_xml.zip
	unzip ProsperDataExport_xml.zip
	touch $@

# Only the lines containing member info
members.dat:  ProsperDataExport.xml mkmembers
	<ProsperDataExport.xml ./mkmembers >$@

reli.endorsement reli.friend reli.support reli.watch:  mk members.dat
	./mk 

out.prosper-endorsement:  reli.endorsement
	<reli.endorsement ../mkuniq1 >$@

out.prosper-friend:  reli.friend 
	<reli.friend ../mkuniq1 >$@

out.prosper-support:  reli.support
	<reli.support ../mkuniq >$@

out.prosper-watch:  reli.watch
	<reli.watch ../mkuniq >$@
