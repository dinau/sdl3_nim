CAHCHE = --nimcache:.nimcache

# For futhark options
OPT_GEN += $(CACHE)
OPT_GEN += -d:useFuthark --maxLoopIterationsVM:50000000
OPT_GEN += -d:futharkRebuild
OPT_GEN += -d:nodeclguards

# For application options
OPT += $(CACHE)
OPT += --hint:XDeclaredButNotUsed:off
OPT += -d:release -d:strip

all:
	nim c -r  $(OPT) gen_sdl3_module.nim

PHONY: gen clean

gen:
	nim c -c $(OPT_GEN) gen_sdl3_module.nim

clean:
	-rm *.exe
	-rm -fr $(CACHE)
