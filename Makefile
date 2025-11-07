all:
	$(MAKE) -C examples/basic
	$(MAKE) -C examples/platformer
	$(MAKE) -C examples/sdlapp

PHONY: gen clean install

install:
	nimble install

gen:
	nimble gen

clean:
	@-$(MAKE) -C examples/basic clean
	@-$(MAKE) -C examples/platformer clean
	@-$(MAKE) -C examples/sdlapp clean
