
all: out.opsahl-ucforum out.opsahl-ucsocial out.opsahl-collaboration out.opsahl-usairport out.opsahl-powergrid out.opsahl-openflights out.opsahl-southernwomen

Newman-Cond_mat_95-99-two_mode.txt:
	wget "http://opsahl.co.uk/tnet/datasets/Newman-Cond_mat_95-99-two_mode.txt" -O Newman-Cond_mat_95-99-two_mode.txt -U firefox

OF_longitudinal_binary.txt:
	wget "http://opsahl.co.uk/tnet/datasets/OF_longitudinal_binary.txt" -O OF_longitudinal_binary.txt -U firefox

openflights.txt:
	wget "http://opsahl.co.uk/tnet/datasets/openflights.txt" -O openflights.txt -U firefox

out.opsahl-openflights: openflights.txt
	cut -d" " -f1-2 "$<" | ../mkrel "asym" "unweighted" > $@

USairport_2010.txt:
	wget "http://opsahl.co.uk/tnet/datasets/USairport_2010.txt" -O USairport_2010.txt -U firefox

USpowergrid_n4941.txt:
	wget "http://opsahl.co.uk/tnet/datasets/USpowergrid_n4941.txt" -O USpowergrid_n4941.txt -U firefox

USpowergrid_n4941.txt.nothirdcolumn: USpowergrid_n4941.txt
	<$< >$@ sed -re 's,\s+1\s*$$,,'

Davis_southern_club_women-two_mode.txt:
	wget "http://opsahl.co.uk/tnet/datasets/Davis_southern_club_women-two_mode.txt" -O Davis_southern_club_women-two_mode.txt -U firefox

out.opsahl-southernwomen: Davis_southern_club_women-two_mode.txt
	<$< ../mkrel "bip" "unweighted" > $@

out.opsahl-powergrid: USpowergrid_n4941.txt.nothirdcolumn
	<$< ../mkrel "sym" "unweighted" > $@

out.opsahl-usairport: USairport_2010.txt
	<$< sed -re 's,1e\+05,100000,' | ../mkrel "asym" "posweighted" > $@

OCnodeslinks.txt:
	wget "http://opsahl.co.uk/tnet/datasets/OCnodeslinks.txt" -O OCnodeslinks.txt -U firefox

out.opsahl-collaboration: Newman-Cond_mat_95-99-two_mode.txt
	<$< ../mkrel "bip" "unweighted" > $@  

out.opsahl-ucforum: OF_longitudinal_binary.txt
	./mk2 $< | ../mkrel "bip" "positive" > $@	

out.opsahl-ucsocial: OCnodeslinks.txt
	./mk $< | ../mkrel "asym" "positive" > $@

.PHONY: clean
clean:
	rm -f OCnodeslinks.txt
	rm -f "OF_longitudinal_binary.txt"
	rm -f out.*
	rm -f *.txt
