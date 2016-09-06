UNUSED - use main.stu

out:  out.lasagne-yahoo out.lasagne-frenchbook out.lasagne-spanishbook


out.lasagne-yahoo:  ydata-ysm-advertiser-phrase-graph-v1_0.nde
	{ echo '% asym unweighted' ; sed -re '1d' <$< | ../mkuniq1 ; } >$@

out.lasagne-frenchbook:  frenchBookInter_st.nde
	{ echo '% asym unweighted' ; sed -re '1d' <$< | ../mkuniq1 ; } >$@

out.lasagne-spanishbook:  spanishBookInter_st.nde
	{ echo '% asym positive' ; sed -re '1d' <$< | ../mkuniq1 ; } >$@


ydata-ysm-advertiser-phrase-graph-v1_0.nde:  ydata-ysm-advertiser.zip
	rm -f $@
	unzip $<
	touch $@

ydata-ysm-advertiser.zip: 
	wget http://amici.dsi.unifi.it/graphs_dataset/nde/language-words_adjacency/ydata-ysm-advertiser.zip

frenchBookInter_st.nde:  frenchBookInter_st.zip
	rm -f $@
	unzip $<
	touch $@


frenchBookInter_st.zip: 
	wget http://amici.dsi.unifi.it/graphs_dataset/nde/language-words_adjacency/frenchBookInter_st.zip

spanishBookInter_st.nde:  spanishBookInter_st.zip
	rm -f $@
	unzip $<
	touch $@


spanishBookInter_st.zip: 
	wget http://amici.dsi.unifi.it/graphs_dataset/nde/language-words_adjacency/spanishBookInter_st.zip

.PHONY: clean
clean: ; rm -f out.* *.nde *.zip 
