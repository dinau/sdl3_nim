import std/[strutils]

#--- Futhark start
when defined(useFuthark): # Generate header files with Futhark.
  import std/[os, strformat]
  proc currentSourceDir(): string {.compileTime.} =
    result = currentSourcePath().replace("\\", "/")
    result = result[0 ..< result.rfind("/")]
  const SDL3mixerRootPath = joinPath(currentSourceDir(),fmt"sdl3_nim/private/SDL3_mixer/x86_64-w64-mingw32/include/SDL3_mixer")
  #--- To specify the place that has "stdbool.h"
  const ClangIncludePath = "c:/drvDx/msys64/ucrt64/lib/clang/22/include"
  #const ClangIncludePath = "c:/drvDx/msys64/ucrt64/opt/llvm-21/lib/clang/21/include"
  const SDL3_mixer_DEFS_FILE = "sdl3_nim/sdl3_mixer_defs.nim"
  #
  import futhark
  importc:
    syspath ClangIncludePath
    path    SDL3mixerRootPath
    compilerArg "-D__INTRIN_H_"
    compilerArg "-DSDL_COMPILE_TIME_ASSERT(name,x)="
    "SDL_mixer.h"

    # Output file name
    outputPath SDL3_mixer_DEFS_FILE
#--- Futahrk end

#-------------------------------------------------
# Use generated header by Futark in your programs.
#-------------------------------------------------
else:
  when defined(emscripten):
    {.push discardable.}
    include "sdl3_nim/sdl3_mixer_defs.nim"
    {.pop.}
  else:
    when defined(windows):
      const libsdl3mixer{.inject.} = "SDL3_mixer.dll"
    else:
      const libsdl3mixer {.inject.} = "libSDL3_mixer.so"
    {.push dynlib:libsdl3mixer, discardable.}
    include "sdl3_nim/sdl3_mixer_defs.nim"
    {.pop.}
