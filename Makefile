all: checkver
	# Native application
	$(MAKE) -C examples/basic
	$(MAKE) -C examples/platformer app
	$(MAKE) -C examples/sdlapp_earth app
	$(MAKE) -C examples/sdlapp_lines app
	$(MAKE) -C examples/showanim
	$(MAKE) -C examples/play_multiple_sounds
	# Wasm
	$(MAKE) -C examples/platformer
	$(MAKE) -C examples/sdlapp_earth
	$(MAKE) -C examples/sdlapp_lines

PHONY: gen clean install checkver

install:
	nimble install

gen:
	-rm -fr src/.nimcache
	nimble gen

clean:
	@-$(MAKE) -C examples/basic clean
	@-$(MAKE) -C examples/platformer clean
	@-$(MAKE) -C examples/sdlapp_earth clean
	@-$(MAKE) -C examples/sdlapp_lines clean
	@-$(MAKE) -C examples/showanim clean
	@-$(MAKE) -C examples/play_multiple_sounds clean

MAKEFLAGS += --no-print-directory

checkver:
	@nim --hints:off checkVersion.nims
