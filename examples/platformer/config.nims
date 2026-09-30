switch "path", "../../sdl3_nim/src"

switch "define", "release"

when defined(emscripten):
  # Nim options
  switch "define", "emscripten"
  switch "threads", "off"
  switch "nimcache", ".nimcache_webgl"
  switch "cpu", "wasm32"
  switch "os", "linux"
  switch "cc", "clang"
  switch "clang.exe", "emcc"
  switch "clang.linkerexe", "em++"
  # Linker
  switch "passL", "-sUSE_SDL=3"
  switch "passL", "-sUSE_SDL_TTF=3"
  switch "passL", "-sWASM=1"
  switch "passL", "-sALLOW_MEMORY_GROWTH=1"

  # Assets
  switch "passL", " --shell-file shell_minimal.html"
  switch "passL", " --preload-file DejaVuSans.ttf@DejaVuSans.ttf"
  switch "passL", " --preload-file grass.png@grass.png"
  switch "passL", " --preload-file Mipi.png@Mipi.png"
  switch "passL", " --preload-file player.png@player.png"
  switch "passL", " --preload-file default.map@default.map"

else: # for desktop application
  # Hiding background console
  switch "app", "gui"
  switch "nimcache", ".nimcache_app"
