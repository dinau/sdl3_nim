all:
	$(MAKE) -C examples/basic
	$(MAKE) -C examples/platformer

PHONY: gen clean install copydll

install:
	nimble install

DLL_DIR = src/sdl3_nim/private/SDL3/x86_64-w64-mingw32/bin

gen:
	nimble gen


clean:
	@-$(MAKE) -C examples/basic clean
	@-$(MAKE) -C examples/platformer clean
