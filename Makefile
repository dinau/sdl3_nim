all:
	$(MAKE) -C examples/basic
	$(MAKE) -C examples/platformer
	$(MAKE) -C examples/sdlapp_lines
	$(MAKE) -C examples/sdlapp

PHONY: gen clean install

install:
	nimble install

gen:
	-rm -fr src/.nimcache
	nimble gen

clean:
	@-$(MAKE) -C examples/basic clean
	@-$(MAKE) -C examples/platformer clean
	@-$(MAKE) -C examples/sdlapp_lines clean
	@-$(MAKE) -C examples/sdlapp clean

MAKEFLAGS += --no-print-directory
