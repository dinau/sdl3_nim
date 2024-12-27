TARGET = platformer

ifeq ($(OS),Windows_NT)
	EXE = .exe
endif

all:
	nim c -r -d:release -d:strip $(TARGET).nim

.PHONY: run clean

run: all

clean:
	rm -f $(TARGET)$(EXE)
