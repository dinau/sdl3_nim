all:
	$(MAKE) -C examples/basic
	$(MAKE) -C examples/platformer

PHONY: gen clean

gen:
	nimble gen

clean:
	$(MAKE) -S basic clean
	$(MAKE) -S platformer clean
