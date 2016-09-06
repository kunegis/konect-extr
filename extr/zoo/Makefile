# All files are built with make.
# See the mk* programs for descriptions of the generated files.

all:   out.stat out.net out.layout.png out.pred.eps out.scatter_out_in.eps pca out.clusco out.centr

# Dependencies on this variable indicate dependency on changes of the zoo directory. 
export ZOO ?= /home/hheinz/work/svn/extr/zoo/zoodir

# LGL location.  Must be compiled; see file LGL. 
export LGL ?= $(HOME)/tmp/LGL-1.1/

CXXFLAGS += -Werror

  #CXXFLAGS += -g
CXXFLAGS += -O3 -s -DNDEBUG 

clean:
	rm -rf out.* *.ps *.eps *~ mknet

plot/dir: ; mkdir -p plot; touch plot/dir
dat/dir: ; mkdir -p dat; touch dat/dir

#
# Files
#

out.corpus:  $(ZOO)

out.corpus:  mkcorpus 
	./mkcorpus

out.userids:  mkuserids out.corpus
	./mkuserids

out.matrix:  mkmatrix out.corpus out.userids
	./mkmatrix

out.adj:  out.matrix  #	by-product of mkmatrix

out.CmdrTaco:  out.userids mkname
	./mkname CmdrTaco

out.stat:  out.userids out.corpus out.matrix matlab stat.m out.CmdrTaco
	./matlab stat >$@

out.centr:  out.matrix matlab centr.m 
	./matlab centr >$@

out.pred:  out.test matlab pred.m
	./matlab pred >$@

out.clusco:  out.matrix matlab clusco.m 
	./matlab clusco >$@

out.maxit:  out.test matlab eval_maxit.m
	./matlab eval_maxit >$@

out.threshold:  out.test matlab eval_threshold.m
	./matlab eval_threshold >$@

out.edges.lgl:  mkedges out.matrix
	./mkedges

out.layout:  mklayout out.edges.lgl out.CmdrTaco
	./mklayout

out.test:   ./mksplit out.matrix
	./mksplit

out.net: ./mknet out.adj
	./mknet <out.adj

out.matrix.clean:  ./mkmatrixclean out.userids out.matrix
	./mkmatrixclean

# Troll statistics
out.troll:  troll.m troll_eval.m out.trolls
	./matlab troll >$@

out.decomp.mat:  out.test matlab decomp.m set_sparam.m
	./matlab decomp 

#
# Images
#

# deprecated
graph.ps:  out.matrix mkgraph
	./mkgraph

progress.eps progress2.eps: $(ZOO) progress
	./progress

out.layout.png:  out.layout mklayoutpng
	./mklayoutpng

out.pred.eps:	mkpred out.pred
	./mkpred

out.maxit.eps:   mkeval out.maxit
	./mkeval out.maxit

out.threshold.eps:  mkeval out.threshold
	./mkeval out.threshold

dat/decomp.mat:  out.matrix matlab pca.m dat/dir
	./matlab pca

pca_draw:  plot/pca.a.u.eps
.PHONY:  pca_draw
plot/pca.a.u.eps:  matlab pca_draw.m pca_draw_one.m plot/dir dat/dir dat/decomp.mat out.trolls
	./matlab pca_draw

out.scatter_out_in.eps:  out.matrix matlab scatter.m 
	./matlab scatter

#
# C stuff
#
config.hh:  mkconfig out.userids
	./mkconfig >$@

mknet:  mknet.cc config.hh
	$(CXX) $(CXXFLAGS) mknet.cc -o mknet
