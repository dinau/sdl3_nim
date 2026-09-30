switch "path", "../../sdl3_nim/src"

switch "define", "release"

when defined(emscripten):
  # Nim option
  switch "nimcache", ".nimcache_webgl"
  switch "cpu", "wasm32"
  switch "os", "linux"
  switch "cc", "clang"
  switch "clang.exe", "emcc"
  switch "clang.linkerexe", "em++"
  switch "define", "emscripten"
  # Linker
  switch "passL", "-sUSE_SDL=3"
  switch "passL", "-sWASM=1"
  switch "passL", "-sALLOW_MEMORY_GROWTH=1"

  switch "passL", " --shell-file shell_minimal.html"

else: # Desktop application
  # Hiding background console
  switch "app", "gui"
  switch "nimcache", ".nimcache_app"
