switch "path", "../../sdl3_nim/src"

switch "define", "release"
switch "opt", "size"

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
  switch "passL", " --preload-file 1a.png"
  switch "passL", " --preload-file 2a.png"
  switch "passL", " --preload-file 3a.png"
  switch "passL", " --preload-file 4a.png"
  switch "passL", " --preload-file resources/fonts/ProggyClean.ttf@resources/fonts/ProggyClean.ttf"
  switch "passL", " --preload-file resources/fonticon/fa6/fa-solid-900.ttf@resources/fonticon/fa6/fa-solid-900.ttf"

else: # for desktop application
  # Hiding background console
  switch "app", "gui"
  switch "nimcache", ".nimcache_app"
  when defined(windows):
    switch "passC", "-static"   # Avoid  depencency on libgcc_s_seh-1.dll
    switch "passL", "-static "
    # Run on MSys2/MinGW: $ pacman -S mingw-w64-ucrt-x86_64-sdl3
    {.passL:"-lSDL3.dll".}
    {.passL:"-limm32"}
  else:
    {.passC:"-I/usr/local/include".}
