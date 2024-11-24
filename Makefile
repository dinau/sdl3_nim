all:
	nimble -d:strip test

build:
	nimble make

PHONY: gen clean

gen:
	nimble gen

clean:
	@-rm tests/test_sdl3.exe
