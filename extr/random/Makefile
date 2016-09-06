#
# Random graphs.  All graphs are undirected, and unweighted or
# positively weighted.  
#

include Makefile.base 

all:  \
  $(foreach TYPE, $(TYPES), \
    $(foreach SIZE, $(SIZES), \
      $(foreach DENSITY, $(DENSITIES), \
        out.random-$(TYPE)-$(SIZE)-$(DENSITY) \
      ) \
    ) \
  )

define TEMPLATE_out
out.random-%-$(1)-$(2):   %.m matlab
	SIZE=$(1) DENSITY=$(2) ./matlab $$*
endef
$(foreach SIZE, $(SIZES), $(foreach DENSITY, $(DENSITIES), $(eval $(call TEMPLATE_out,$(SIZE),$(DENSITY)))))

matlab:  ../../analysis/matlab
	cp ../../analysis/matlab .

clean: ; rm -rf out.*
.PHONY:  clean 
