#--- Futhark start
when defined(useFuthark): # Generate header files with Futhark.
  import std/[os, strutils, strformat]
  proc currentSourceDir(): string {.compileTime.} =
    result = currentSourcePath().replace("\\", "/")
    result = result[0 ..< result.rfind("/")]
  const SDL3TTFRootPath = joinPath(currentSourceDir(),fmt"sdl3_nim/private/SDL3_ttf/x86_64-w64-mingw32/include/SDL3_ttf")
  #--- To specify the place that has "stdbool.h"
  const ClangIncludePath = "c:/drvDx/msys64/ucrt64/lib/clang/22/include"
  const SDL3_TTF_DEFS_FILE = "sdl3_nim/sdl3_ttf_defs.nim"
  #
  import futhark
  importc:
    syspath ClangIncludePath
    path    SDL3TTFRootPath
    compilerArg "-D__INTRIN_H_"
    compilerArg "-DSDL_COMPILE_TIME_ASSERT(name,x)="
    "SDL_ttf.h"
    "SDL_textengine.h"

    # Output file name
    outputPath SDL3_TTF_DEFS_FILE
#--- Futahrk end

#-------------------------------------------------
# Use generated header by Futark in your programs.
#-------------------------------------------------
else:
  when defined(emscripten):
    {.push discardable.}
    include "sdl3_nim/sdl3_ttf_defs.nim"
    {.pop.}
  else:
    when defined(windows):
      const libsdl3ttf{.inject.} = "SDL3_ttf.dll"
    else:
      const libname {.inject.} = "libSDL3_ttf.so"
    {.push dynlib:libsdl3ttf, discardable.}
    include "sdl3_nim/sdl3_ttf_defs.nim"
    {.pop.}

  #{.passC:"-I" & SDL3RootPath1.}
  #{.passC:"-I" & SDL3RootPath2.}
  #{.passC:"-I" & SDL3TTFRootPath1.}
  #{.passC:"-I" & SDL3TTFRootPath2.}
