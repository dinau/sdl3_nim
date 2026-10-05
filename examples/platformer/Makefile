TARGET_APP = $(notdir $(CURDIR))
TARGET_WASM = wasm/index.html


ifeq ($(OS),Windows_NT)
	EXE = .exe
endif

.PHONY: clean run fmt wasm server cleanwasm

all: wasm

app:
	nim c -d:strip $(OPT) $(TARGET_APP).nim
	#./$(TARGET_APP)$(EXE)

clean: cleanwasm
	rm -f $(TARGET_APP).exe
	rm -fr .nimcache_* .nimcache

cleanwasm:
	rm -f wasm/index.*

wasm:
	nim c -d:strip -d:emscripten -o:$(TARGET_WASM) $(TARGET_APP).nim

server:
	(cd wasm && python3 -m http.server 8000)

run: all
	emrun $(TARGET_WASM)

lib:
	@-mkdir libs_build\build
	emcmake cmake -S libs_build -B libs_build\build -G Ninja -DCMAKE_BUILD_TYPE=Release
	cmake --build libs_build\build
	cmake -DBUILD_DIR=libs_build/build -DOUT=libs -P libs_build/collect.cmake

fmt:
	nimpretty --maxLineLen:1000 $(TARGET_APP).nim
