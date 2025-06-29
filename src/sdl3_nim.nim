import std/[os, strutils, strformat]


proc currentSourceDir(): string {.compileTime.} =
  result = currentSourcePath().replace("\\", "/")
  result = result[0 ..< result.rfind("/")]

const SDL3RootPath1    = joinPath(currentSourceDir(),fmt"private/SDL3/x86_64-w64-mingw32/include/SDL3")
const SDL3RootPath2    = joinPath(currentSourceDir(),fmt"private/SDL3/x86_64-w64-mingw32/include")

#--- Futhark start
when defined(useFuthark): # Generate header files with Futhark.
  #--- To specify the place that has "stdbool.h"
  #const ClangIncludePath = "c:/drvDx/msys64/ucrt64/lib/clang/20/include"
  const ClangIncludePath = "c:/drvDx/msys64/mingw64/lib/clang/20/include"
  const SDL3_DEFS_FILE = "sdl3_nim/sdl3_defs.nim"  # == From project top: sdl3_nim/src/sdl3_nim/sdl3_defs.nim
  #
  import futhark
  importc:
    syspath ClangIncludePath
    path    SDL3RootPath1
    path    SDL3RootPath2
    "SDL.h"
    # Output file name
    outputPath SDL3_DEFS_FILE
#--- Futahrk end

#-------------------------------------------------
# Use generated header by Futark in your programs.
#-------------------------------------------------
else:
  when defined(windows):
    const libname {.inject.} = "SDL3.dll"
  else:
    const libname {.inject.} = "libSDL3.so"

  {.push dynlib:libname, discardable.}
  include "sdl3_nim/sdl3_defs.nim"        # == SDL3_DEFS_FILE
  {.pop.}

  {.passC:"-I" & SDL3RootPath1.}
  {.passC:"-I" & SDL3RootPath2.}
