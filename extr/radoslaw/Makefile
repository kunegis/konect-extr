OWN=../own
all: out.radoslaw_email_email

out.radoslaw_email_email: manufacturing.csv
	tail -n +2 $< | awk '{print $$1" "$$2" 1 "$$3}' | ../mkrel 'asym' 'positive'>$@

manufacturing.csv: $(OWN)/manufacturing_konect.zip
	unzip $<
.PHONY: clean
clean:
	rm -f out.* *.zip *.csv *.bib *.txt
