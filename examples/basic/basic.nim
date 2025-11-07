import std/[strutils]
import sdl3_nim
import sdl3_nim/[loadImage]
import nimgl/[opengl]

#--- Add application icon
when defined(windows):
  when not defined(vcc):   # imguinVcc.res TODO WIP
    include ./res/resource

const MainWinWidth  = 480
const MainWinHeight = 480

#--------------
#--- main porc
#--------------
proc main() =
  #-------------------------
  #--- Start SDL initialize
  #-------------------------
  if not SDL_Init(SDL_INIT_VIDEO or SDL_INIT_GAMEPAD):
    echo "\nError!: SDL_Init()"
  else:
    echo "\nSDL_init() OK !"
  defer:
    SDL_Quit_proc()
    echo "SDL_Quit_proc()"

  #-----------------------------
  #--- Setting OpenGL3 backend
  #-----------------------------
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, 0)
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE.cint)
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3)
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3)

  #----------------------
  #--- Create SDL window
  #----------------------
  var flags = SDL_WINDOW_RESIZABLE or SDL_WINDOW_OPENGL
  #flags = flags or SDL_WINDOW_HIDDEN
  let title = "[ SDL " & ($SDL_GetRevision()).split('-')[1] &  " ]" & " [ nim_sdl3 ] test window"
  var window = SDL_CreateWindow(title.cstring, MainWinWidth, MainWinHeight, flags.SDL_WindowFlags)
  if isNil window:
    echo "Error!: SDL_CreateWindow()"
    quit(1)
  else:
    echo "SDL_CreateWindow() OK !"
  defer:
    SDL_DestroyWindow(window)
    echo "SDL_DestroyWindow()"

  let glContext = SDL_GL_CreateContext(window)
  if isNil glContext:
    echo "Error!: SDL_GL_CreateContext()"
  defer: discard SDL_GL_DestroyContext(glContext)
  SDL_GL_MakeCurrent(window, glContext);

  echo "SDL3 version : ",SDL_GetVersion()
  echo "SDL3 revision : ",SDL_GetRevision()

  #-------------
  #--- Renderer
  #-------------
  var renderer = SDL_CreateRenderer(window,nil)
  if isNil renderer:
    echo "Error!: SDL_CreateRenderer()"
    quit(1)
  else:
    echo "SDL_CreateRenderer() OK !"
  defer:
    SDL_DestroyRenderer(renderer)
    echo "SDL_DestroyRenderer()"

  #------------------
  #--- Vsync setting
  #------------------
  if SDL_SetRenderVSync(renderer, 1):
    echo "SDL_SetRenderVSync() OK !"
  else:
    echo "Error!: SDL_SetRenderVSync()"

  #------------------------
  #--- Load bmp as surface
  #------------------------
  const imageName1 = "beans-400.bmp"
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
    echo "SDL_GetTextureSize() OK !"
  else:
    echo "Error!: SDL_GetTextureSize()"

  #------------------------
  #--- Load png as textrue
  #------------------------
  doassert glinit()
  var textureImage2: ptr SDL_Texture
  when true:
    const imageName2 = "earth-512.png"
    var w: int
    var h: int
    if loadTextureFromFile(imageName2, renderer, textureImage2, w, h ):
      echo "loadTextureFromFile() OK !: ", imageName2
    else:
      echo "Error!: loadTextureFromFile() OK!", imageName2

  #--------------
  #--- main loop
  #--------------
  SDL_SetRenderDrawColor(renderer,110,132,174,255)
  var event: SDL_Event
  var xQuit = false
  while not xQuit:
    while SDL_PollEvent(addr event):
      if event.type_field == SDL_EVENT_QUIT.uint32:
        xQuit = true
      if event.type_field == SDL_EVENT_WINDOW_CLOSE_REQUESTED.uint32 and event.window.windowID == SDL_GetWindowID(window):
        xQuit = true;
      if event.key.type_field == SDL_EVENT_KEY_DOWN:
        if event.key.key == SDLK_Q or  event.key.key == SDLK_ESCAPE:
          xQuit = true;

    SDL_RenderClear(renderer)

    block: #--- drawImage
      var angle{.global.}:cdouble = 0
      var angle2{.global.}:cdouble = 0
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
      if not SDL_RenderTextureRotated(renderer, textureImage2
                                     ,nil              # src:    ptr frect
                                     ,addr rectDst2    # dst:    ptr frect
                                     ,-angle2          # angle:  cdouble
                                     ,nil              # center: ptr fpoint
                                     ,SDL_FLIP_NONE):  # flip
         echo("Error!: RenderCopy() ")

      #discard SDL_RenderTexture(renderer, textureImage2, nil, nil)
      const speed = 0.8
      angle = angle + speed
      angle2 = angle2 + speed

    #--- Render
    SDL_RenderPresent(renderer)

#-------------------
#--- Call main proc
#-------------------
main()
