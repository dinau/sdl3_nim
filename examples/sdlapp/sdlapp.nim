import std/[strutils]
import sdl3_nim
import sdl3_nim/[loadImage]

#--- Add application icon
when defined(windows):
  when not defined(vcc):   # imguinVcc.res TODO WIP
    include ./res/resource

const MainWinWidth  = 530
const MainWinHeight = 530

const SPEED1 = 0.3
var
  window:   ptr SDL_Window   = nil
  renderer: ptr SDL_Renderer = nil
  angle :cdouble  = 0
  speed           = SPEED1

#--------------------
#--- png as textrue
#--------------------
const ImageNames = ["1a.png", "2a.png", "3a.png", "4a.png"]
var textures:array[ImageNames.len, ptr SDL_Texture]
var textureWidth: int
var textureHeight:int

#----------------
#--- SDL_AppInit
#----------------
proc SDL_AppInit*   (appstate: ptr pointer, argc: cint, argv: ptr UncheckedArray[cstring]): SDL_AppResult {.cdecl.} =
  SDL_SetAppMetadata("Example Renderer Textures", "1.0", "sdl3_nim")
  if not SDL_Init(SDL_INIT_VIDEO):
    SDL_Log_proc("Couldn't initialize SDL: %s", SDL_GetError())
    return SDL_APP_FAILURE;

  if not SDL_CreateWindowAndRenderer("<Start/Stop>: Space, <Restart>: R, Enter", MainWinWidth, MainWinHeight, SDL_WINDOW_RESIZABLE, addr window, addr renderer):
      SDL_Log_proc("Couldn't create window/renderer: %s", SDL_GetError());
      return SDL_APP_FAILURE
  if not SDL_SetRenderVSync(renderer, 1):
      SDL_Log_proc("Fail!: VSync setting : %s", SDL_GetError())

  for i, imageName in ImageNames:
    let funcname = "loadTextureFromFile()"
    if loadTextureFromFile(imageName, renderer, textures[i], textureWidth, textureHeight):
      echo "$# OK !: $#" % [funcname, imageName]
    else:
      echo "Error!: $# OK!", imageName

  return SDL_APP_CONTINUE

#-------------------
#--- SDL_AppIterate
#-------------------
proc SDL_AppIterate*(appstate: pointer): SDL_AppResult {.cdecl.} =
  #/* as you can see from this, rendering draws over whatever was drawn before it. */
  SDL_SetRenderDrawColor(renderer,0,0,0,255)
  SDL_RenderClear(renderer)  #/* start with a blank canvas. */
  var w:cint
  var h:cint
  let width = textureWidth.cfloat/2
  let height = textureHeight.cfloat/2
  SDL_GetWindowSizeInPixels(window, addr w, addr h)
  type Attr = object
    texture: ptr SDL_Texture
    xs,ys: cfloat
    ws,hs: cfloat
  var attribs = [
                Attr(texture: textures[0], xs: (w.cfloat - textureWidth.cfloat)/2, ys: (h.cfloat - textureHeight.cfloat)/2, ws: width, hs: height)
               ,Attr(texture: textures[1], xs: w.cfloat/2 , ys: (h.cfloat - textureHeight.cfloat)/2, ws: width, hs: height)
               ,Attr(texture: textures[2], xs: (w.cfloat - textureWidth.cfloat)/2, ys: h.cfloat/2,                          ws: width, hs: height)
               ,Attr(texture: textures[3], xs: w.cfloat/2,                         ys: h.cfloat/2,                          ws: width, hs: height)
              ]
  for attrib in attribs:
    var rectDst = SDL_FRect(x: attrib.xs, y: attrib.ys, w: attrib.ws, h: attrib.hs)
    SDL_RenderTextureRotated(renderer, attrib.texture, nil, addr rectDst, angle, nil, SDL_FLIP_NONE)

  if angle < 360.0:
    angle = angle + speed

  #--- Render
  SDL_RenderPresent(renderer)
  return SDL_APP_CONTINUE  # carry on with the program!

#-----------------
#--- SDL_AppEvent
#-----------------
proc SDL_AppEvent*  (appstate: pointer, event: ptr SDL_Event): SDL_AppResult {.cdecl.} =
  if event.type_field == SDL_EVENT_QUIT.uint32:
    return SDL_APP_SUCCESS # end the program, reporting success to the OS.
  if event.key.type_field == SDL_EVENT_KEY_DOWN:
    if event.key.key == SDLK_R or  event.key.key == SDLK_RETURN:
      angle = 0
    if event.key.key == SDLK_SPACE:
      speed = if speed == 0: SPEED1 else: 0
      if angle > 360:
        angle = 0
        speed = SPEED1
  return SDL_APP_CONTINUE  # carry on with the program!

#----------------
#--- SDL_AppQuit
#----------------
proc SDL_AppQuit*   (appstate: pointer, res: SDL_AppResult): void {.cdecl.} =
  SDL_Quit_proc()

#-------------
#--- SDL_main
#-------------
proc SDL_main(argc: cint, argv: ptr UncheckedArray[cstring]): cint {.cdecl.}  =
  return SDL_EnterAppMainCallbacks(argc, argv, SDL_AppInit, SDL_AppIterate, SDL_AppEvent, SDL_AppQuit)

#--------------
#--- main porc
#--------------
discard SDL_RunApp(0, nil, SDL_main, nil)
