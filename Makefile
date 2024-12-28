all:
	$(MAKE) -C examples/basic
	$(MAKE) -C examples/platformer

PHONY: gen clean install

install:
	nimble install

gen:
	nimble gen

clean:
	$(MAKE) -S basic clean
	$(MAKE) -S platformer clean
