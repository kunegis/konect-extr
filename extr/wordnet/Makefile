#
# In all the joins, the string field must always be last, because it
# contains spaces and thus the cut/join/sort tools will be confused by
# spaces in quoted words. 
#

all:  out.wordnet out.wordnet-words  ent.wordnet-words-word


out.wordnet:  wordnet.nt 
	FORMAT=sym WEIGHTS=unweighted ../mksem <wordnet.nt '<[^>]+>' | ../mksym >$@

wordnet.nt:  
	rsync -vtrl $$USER@estrella.uni-koblenz.de:/export/kunegis/konect/own/wordnet.nt .

stat.wordnet:  wordnet.nt
	../semstat wordnet.nt >$@

# lexicalForm
# sorted on the word (1) field 
rel.word-string: mkwordstring wordnet.nt 
	<wordnet.nt ./mkwordstring | sort -k 1,1 >$@

# word^t
# sorted on the word (1) field
rel.word-wordsense: mkwordwordsense wordnet.nt
	<wordnet.nt ./mkwordwordsense | sort -k 1,1 >$@

# containsWordSense^t
# Sorted by wordsense (1) 
rel.wordsense-synset: mkwordsensesynset wordnet.nt
	<wordnet.nt ./mkwordsensesynset | sort -k 1,1 >$@

# *
# Sort on first field 
rel.synset-synset: mksynsetsynset wordnet.nt
	<wordnet.nt ./mksynsetsynset | sort -k 1,1 >$@

# Wordsense - string
# Sorted on WordSense (1) 
rel.wordsense-string:  rel.word-string rel.word-wordsense
	join -1 1 -2 1 rel.word-wordsense rel.word-string | sed -re 's,^[^ ]+ ,,' | sort -k 1,1 >$@

# SynSet - String
# Sorted on Synset
rel.synset-string:  rel.wordsense-string rel.wordsense-synset
	join -1 1 -2 1 rel.wordsense-synset rel.wordsense-string | sed -re 's,^[^ ]+ ,,' | sort -k 1,1 >$@

# Sorted on first field
rel.synset-string-indirect: rel.synset-synset rel.synset-string
	join -1 1 -2 1 rel.synset-synset rel.synset-string | sed -re 's,^[^ ]+ ,,' | sort -k 1,1 >$@

# Sorted on first field 
rel.wordsense-wordsense:  mkwordsensewordsense wordnet.nt
	<wordnet.nt ./mkwordsensewordsense | sort -k 1,1 >$@

# Sorted on first field
rel.wordsense-string-indirect: rel.wordsense-wordsense rel.wordsense-string
	join -1 1 -2 1 rel.wordsense-wordsense rel.wordsense-string | sed -re 's,^[^ ]+ ,,' | sort -k 1,1 >$@

rel.string-string-direct: rel.synset-string 
	join -1 1 -2 1 rel.synset-string rel.synset-string | sed -re 's,^[^ ]+ ,,' >$@

# With common SynSet
rel.string-string-indirect: rel.synset-string rel.synset-string-indirect
	join -1 1 -2 1 rel.synset-string rel.synset-string-indirect | sed -re 's,^[^ ]+ ,,' >$@

# With common WordSense
rel.string-string-indirect2: rel.wordsense-string rel.wordsense-string-indirect
	join -1 1 -2 1 rel.wordsense-string rel.wordsense-string-indirect | sed -re 's,^[^ ]+ ,,' >$@

rel.string-string-all:  rel.string-string-direct rel.string-string-indirect rel.string-string-indirect2
	cat $^ >$@

# The bare words (with underscores instead of spaces), separated by tab
rel.wordnet-words:  rel.string-string-all mkword
	<rel.string-string-all ./mkword >$@

out.wordnet-words ent.wordnet-words-word:  rel.wordnet-words
	<rel.wordnet-words ../mkrmdup | ../mkrel --ent-delimiter='	' --+ent=ent.wordnet-words-word:rel.wordnet-words:0:0 'sym' 'unweighted' >out.wordnet-words

.PHONY:  clean
clean:  ; rm -f out.* *.nt stat.* rel.* ent.*


