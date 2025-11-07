TARGET = $(notdir $(CURDIR))

# Hiding background console
OPT += --app:gui

OPT += --nimcache:.nimcache
OPT += -d:release

ifeq ($(OS),Windows_NT)
	EXE = .exe
endif

all:
	nim c -d:strip -d:SDL $(OPT) $(TARGET).nim

.PHONY: clean run

clean:
	rm -f $(TARGET).exe
	rm -fr .nimcache

run: all
	./$(TARGET)$(EXE)
