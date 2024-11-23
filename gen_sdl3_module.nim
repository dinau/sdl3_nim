const SDL3RootPath1    = "SDL3-3.1.3/x86_64-w64-mingw32/include/SDL3"
const SDL3RootPath2    = "SDL3-3.1.3/x86_64-w64-mingw32/include"

#--- Futhark start
when defined(useFuthark): # Generate header files with Futhark.
  #--- To specify the place that has "stdbool.h"
  const ClangIncludePath = "c:/drvDx/msys64/ucrt64/lib/clang/19/include"
  const SDL3_DEFS_FILE = "sdl3_defs.nim"
  #
  import futhark
  importc:
    syspath ClangIncludePath
    path    SDL3RootPath1
    path    SDL3RootPath2
    #define "DLL_EXPORT"
    #define "INT64_C"

    "SDL.h"
    # Output
    outputPath SDL3_DEFS_FILE
#--- Futahrk end

# Use generated header by Futark in your programs.
else:
  import os
  when defined(windows):
    const libname {.inject.} = "SDL3.dll"
  else:
    const libname {.inject.} = "libSDL3.so"

  {.push dynlib:libname, discardable.}
  include "sdl3_defs.nim"
  {.pop.}

  {.passC:"-I" & SDL3RootPath1.}

 #--- Start initialize
  if not SDL_Init(SDL_INIT_VIDEO or SDL_INIT_GAMEPAD):
    echo "SDL init error"
  else:
    echo "\nSDL init OK !"
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, 0)
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE.cint)
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3)
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3)
  const MainWinWidth = 1280
  const MainWinHeight =  800

  const SDL_WINDOW_RESIZABLE = 0x0000000000000020'u64
  const SDL_WINDOW_OPENGL    = 0x0000000000000002'u64
  const SDL_WINDOW_HIDDEN    = 0x0000000000000008'u64
  var flags = SDL_WINDOW_OPENGL or SDL_WINDOW_RESIZABLE
  #flags = flags or SDL_WINDOW_HIDDEN
  var window = SDL_CreateWindow("SDL3 Window", MainWinWidth, MainWinHeight, flags.SDL_WindowFlags)
  if isNil window:
    echo "Window could not be created"
    quit(1)
  else:
    echo "Window create OK !"
  echo "SDL3 version : ",SDL_GetVersion()
  echo "SDL3 revision : ",SDL_GetRevision()

  var renderer = SDL_CreateRenderer(window,nil)
  if isNil renderer:
    echo "Renderer could not be created"
    quit(1)
  else:
    echo "Renderer create OK !"

  #--- main loop
  SDL_SetRenderDrawColor(renderer,110,132,174,255)
  var count = 1000
  var event: SDL_Event
  var xQuit = false
  while not xQuit:
    while SDL_PollEvent(addr event):
      if event.type_field == SDL_EVENT_QUIT.uint32:
        xQuit = true
      if event.type_field == SDL_EVENT_WINDOW_CLOSE_REQUESTED.uint32 and event.window.windowID == SDL_GetWindowID(window):
        xQuit = true;
    SDL_RenderClear(renderer)
    SDL_RenderPresent(renderer)
    sleep(1)
    dec count
    if count == 0:
      xQuit = true

  #--- End procs
  SDL_DestroyRenderer(renderer)
  SDL_DestroyWindow(window)
  SDL_Quit_proc()
  echo "SDL quited !"
