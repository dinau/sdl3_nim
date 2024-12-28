TARGET = basic

# Hiding background console
OPT += --app:gui


ifeq ($(OS),Windows_NT)
	EXE = .exe
endif

all:
	nim c -d:release -d:strip $(OPT) $(TARGET).nim

.PHONY: clean run

clean:
	rm -f $(TARGET).exe

run: all
	./$(TARGET)$(EXE)
