TARGET = platformer

ifeq ($(OS),Windows_NT)
	EXE = .exe
endif

# Hiding background console
OPT += --app:gui

all:
	nim c -d:release -d:strip $(OPT) $(TARGET).nim

.PHONY: run clean

run: all
	./$(TARGET)$(EXE)


clean:
	rm -f $(TARGET)$(EXE)
