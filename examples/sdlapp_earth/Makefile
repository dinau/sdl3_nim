TARGET_APP = $(notdir $(CURDIR))
TARGET_WASM = wasm/index.html

ifeq ($(OS),Windows_NT)
	EXE = .exe
endif

.PHONY: clean run fmt wasm server

all: wasm

app:
	nim c -d:strip $(OPT) $(TARGET_APP).nim
	#./$(TARGET_APP)$(EXE)

clean:
	rm -f $(TARGET_APP).exe
	rm -fr .nimcache_* .nimcache
	rm -f wasm/index.*

wasm:
	nim c -d:strip -d:emscripten -o:$(TARGET_WASM) $(TARGET_APP).nim

server:
	emrun $(TARGET_WASM)

run: all server

fmt:
	nimpretty --maxLineLen:1000 $(TARGET_APP).nim
