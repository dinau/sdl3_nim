all:
	$(MAKE) -C examples/basic
	$(MAKE) -C examples/platformer

PHONY: gen clean install copydll

install:
	nimble install

copydll:
	cp -f src/private/SDL3/x86_64-w64-mingw32/bin/SDL3.dll examples/basic/
	cp -f src/private/SDL3/x86_64-w64-mingw32/bin/SDL3.dll examples/platformer/

gen: copydll
	nimble gen


clean:
	@-$(MAKE) -C examples/basic clean
	@-$(MAKE) -C examples/platformer clean
