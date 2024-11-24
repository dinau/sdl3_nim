import std/[os,strutils]
import sdl3_nim

#--- Add application icon
when defined(windows):
  when not defined(vcc):   # imguinVcc.res TODO WIP
    include ./res/resource

const MainWinWidth  = 480
const MainWinHeight = 480

proc currentSourceDir(): string {.compileTime.} =
  result = currentSourcePath().replace("\\", "/")
  result = result[0 ..< result.rfind("/")]

#{.passL:"-lopengl32".}

#--------------
#--- main porc
#--------------
proc main() =
  #--- Start window initialize
  if not SDL_Init(SDL_INIT_VIDEO or SDL_INIT_GAMEPAD):
    echo "\nSDL3 init error"
  else:
    echo "\nSDL3 init OK !"
  defer:
    SDL_Quit_proc()
    echo "SDL_Quit_proc()"

  #--- Setting OpenGL3 backend
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, 0)
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE.cint)
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3)
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3)

  #--- Create window
  const SDL_WINDOW_RESIZABLE = 0x0000000000000020'u64
  const SDL_WINDOW_OPENGL    = 0x0000000000000002'u64
  const SDL_WINDOW_HIDDEN    = 0x0000000000000008'u64
  var flags = SDL_WINDOW_RESIZABLE or SDL_WINDOW_OPENGL
  #flags = flags or SDL_WINDOW_HIDDEN
  var window = SDL_CreateWindow("SDL3 test Window", MainWinWidth, MainWinHeight, flags.SDL_WindowFlags)
  if isNil window:
    echo "Window could not be created"
    quit(1)
  else:
    echo "Window create OK !"
  defer:
    SDL_DestroyWindow(window)
    echo "SDL_DestroyWindow()"

  echo "SDL3 version : ",SDL_GetVersion()
  echo "SDL3 revision : ",SDL_GetRevision()

  #--- Renderer
  var renderer = SDL_CreateRenderer(window,nil)
  if isNil renderer:
    echo "Renderer could not be created"
    quit(1)
  else:
    echo "Renderer create OK !"
  defer:
    SDL_DestroyRenderer(renderer)
    echo "SDL_DestroyRenderer()"

  #--- Vsync setting
  if SDL_SetRenderVSync(renderer, 1):
    echo "Vsync setting OK !"
  else:
    echo "Error!: Renderer Vsync setting fail!"

  #--- Load bmp as surface
  const imageName1 = joinPath(currentSourceDir(), "beans-400.bmp")
  let surfaceImage = SDL_LoadBMP(imageName1)
  if isNil surfaceImage:
    echo("Error!:  SDL_LoadBMP() file = ", imageName1)
  else:
    echo("Loaded: ",imageName1)
  #--- Convert to texture
  let textureImage1 = SDL_CreateTextureFromSurface(renderer, surfaceImage)
  var textureWidth:cfloat
  var textureHeight:cfloat
  if SDL_GetTextureSize(textureImage1, addr textureWidth, addr textureHeight):
    echo "Get texture size OK !"
  else:
    echo "Error!: Get texture size"

  #--- main loop
  SDL_SetRenderDrawColor(renderer,110,132,174,255)
  var event: SDL_Event
  var xQuit = false
  while not xQuit:
    while SDL_PollEvent(addr event):
      if event.type_field == SDL_EVENT_QUIT.uint32:
        xQuit = true
      if event.type_field == SDL_EVENT_WINDOW_CLOSE_REQUESTED.uint32 and event.window.windowID == SDL_GetWindowID(window):
        xQuit = true;
    SDL_RenderClear(renderer)

    block: #--- drawImage
      var angle{.global.}:cdouble = 0
      var w:cint
      var h:cint
      SDL_GetWindowSizeInPixels(window, addr w, addr h)
      var rectDst = SDL_FRect(x: (w.cfloat - textureWidth)/2, y: (h.cfloat - textureHeight)/2, w: textureWidth/2, h: textureHeight/2)
      if not SDL_RenderTextureRotated(renderer, textureImage1
                                     ,nil              # src:    ptr frect
                                     ,addr rectDst     # dst:    ptr frect
                                     ,angle            # angle:  cdouble
                                     ,nil              # center: ptr fpoint
                                     ,SDL_FLIP_NONE):  # flip
         echo("Error!: RenderCopy() ")
      let ws = textureWidth/2
      let hs = textureHeight/2
      var rectDst2 = SDL_FRect(x: w.cfloat / 2, y: h.cfloat / 2 , w: ws, h: hs )
      if not SDL_RenderTextureRotated(renderer, textureImage1
                                     ,nil              # src:    ptr frect
                                     ,addr rectDst2    # dst:    ptr frect
                                     ,-angle            # angle:  cdouble
                                     ,nil              # center: ptr fpoint
                                     ,SDL_FLIP_NONE):  # flip
         echo("Error!: RenderCopy() ")

      const speed = 0.2
      angle = angle + speed

    #--- Render
    SDL_RenderPresent(renderer)


#--- Call main proc
main()
