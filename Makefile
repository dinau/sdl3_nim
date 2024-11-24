all:
	nimble test

PHONY: gen clean

gen:
	nimble gen

clean:
	@-rm tests/test_sdl3.exe
