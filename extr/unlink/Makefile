DATASETS=bar  de  fr  it  nl  pih  pl  simple
all: $(foreach I,$(DATASETS),out.link-dynamic-$(I)wiki)
out.link-dynamic-%wiki: %.log
	<$< sed -ne 's/^\([0-9]*\)\sA\s\([0-9]*\)\s\([0-9]*\)/\2 \3 +1 \1/p;s/^\([0-9]*\)\sR\s\([0-9]*\)\s\([0-9]*\)/\2 \3 -1 \1/p' | ../mkrel "asym" "dynamic">$@

.PHONY: clean

clean:
	rm -f out.*
	rm -f *.log
