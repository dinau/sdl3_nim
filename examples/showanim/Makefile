TARGET = $(notdir $(CURDIR))

# Hiding background console
#OPT += --app:gui

OPT += --nimcache:.nimcache
OPT += -d:release

ifeq ($(OS),Windows_NT)
	EXE = .exe
endif

all:
	nim c -d:strip $(OPT) $(TARGET).nim

app: all

.PHONY: clean run fmt

clean:
	rm -f $(TARGET).exe
	rm -fr .nimcache

IMAGE_DIR = ../../src/sdl3_nim/private/img
run: all
	@echo --------------------------------------
	@echo Use left arrow key to view next image.
	@echo --------------------------------------
	./$(TARGET)$(EXE) $(IMAGE_DIR)/basic-nim-sdl3.gif $(IMAGE_DIR)/earth4.gif $(IMAGE_DIR)/platformer-nim-sdl3.gif

fmt:
	nimpretty --maxLineLen:1000 $(TARGET).nim
