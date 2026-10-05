import std/[os, strutils]
import sdl3_nim
import ./licenseNotices
import ./setupFonts

# Use Dear ImGui bindings
# Run on MSys2/MinGW: $ pacman -S mingw-w64-ucrt-x86_64-sdl3
import imguin/[sdl3_renderer, cimgui]

#--- Add application icon
when defined(windows):
  when not defined(vcc): # imguinVcc.res TODO WIP
    include ./res/resource

const fDocking  = true
const fViewport = false

const MainWinWidth = 800
const MainWinHeight = 800

const Speed1 = 0.3
const StartupDelay = 90 # 60 frame

var
  window: ptr SDL_Window = nil
  renderer: ptr SDL_Renderer = nil
  angle: cdouble = 0
  running = true                 # Start / Stop
  speedBase: cfloat = Speed1     #
  delayAtStartup = StartupDelay
  showLicenseNotices = false

# for ImGui
var
  showDemoWindow = false
  showAboutWindow = false
  menuBarHeight: cfloat = 0
  quitRequested = false

#-------------------
#--- png as textrue
#-------------------
const ImageNames = ["1a.png", "2a.png", "3a.png", "4a.png"]
var
  textures: array[ImageNames.len, ptr SDL_Texture]
  textureWidth: cfloat
  textureHeight: cfloat

#-----------------
#--- helper procs
#-----------------
proc restartAnimation() =
  angle = 0
  delayAtStartup = StartupDelay

proc toggleRunning() =
  running = not running
  if angle > 360:
    angle = 0
    running = true

#--------------------------
#--- ImGui: menu / windows
#--------------------------
proc showImGuiMenu() =
  if igBeginMainMenuBar():
    if igBeginMenu(ICON_FA_TRIANGLE_EXCLAMATION & " Licenses", true):
      if igMenuItem_Bool("Show", "S", false, true):
        showLicenseNotices = true
      igEndMenu()
    if igBeginMenu(ICON_FA_GEAR & " Control", true):
      if igMenuItem_Bool( ICON_FA_PERSON_RUNNING & " Run", "Space", running, true):
        toggleRunning()
      if igMenuItem_Bool("Restart", "R / Enter", false, true):
        restartAnimation()
      igSeparator()
      igText(ICON_FA_FORWARD & " Speed")
      igSetNextItemWidth(160)
      igSliderFloat("##speed", addr speedBase, 0.05, 4.0, "%.2f", 0)
      if igMenuItem_Bool(ICON_FA_ARROW_ROTATE_LEFT & " Reset speed", nil, false, true):
        speedBase = Speed1
      when not defined(emscripten):
        igSeparator()
        if igMenuItem_Bool("Quit", "Q / Esc", false, true):
          quitRequested = true
      igEndMenu()

    if igBeginMenu(ICON_FA_CIRCLE_QUESTION & " Help", true):
      igMenuItem_BoolPtr("ImGui Demo window", nil, addr showDemoWindow, true)
      igMenuItem_BoolPtr("About", nil, addr showAboutWindow, true)
      igEndMenu()

    menuBarHeight = igGetFrameHeight()
    igEndMainMenuBar()

  if showDemoWindow:
    igShowDemoWindow(addr showDemoWindow)

  if showAboutWindow:
    if igBegin("About", addr showAboutWindow, ImGuiWindowFlags_AlwaysAutoResize.cint):
      igText("SDL3 + Dear ImGui (imguin) demo")
      igText("Nim %s", NimVersion.cstring)
      igText("Dear ImGui %s", igGetVersion())
    igEnd()

  #-----------------------
  # Show Licenses window
  #-----------------------
  if showLicenseNotices:
    igStyleColorsLight(nil)
    igSetNextWindowPos(ImVec2(x: 30, y: 30), ImGui_Cond_FirstUseEver.cint, ImVec2(x: 0, y: 0))
    igSetNextWindowSize(ImVec2(x: 600, y: 900), ImGui_Cond_FirstUseEver.cint)
    licenseNotices(addr showLicenseNotices, ImGui_WindowFlags_Modal.cint)
    igStyleColorsClassic(nil)

#----------------
#--- SDL_AppInit
#----------------
proc SDL_AppInit*(appstate: ptr pointer, argc: cint, argv: ptr UncheckedArray[cstring]): SDL_AppResult {.cdecl.} =
  SDL_SetAppMetadata("Example Renderer Textures", "1.0", "sdl3_nim")
  if not SDL_Init(SDL_INIT_VIDEO):
    SDL_Log_proc("Couldn't initialize SDL: %s", SDL_GetError())
    return SDL_APP_FAILURE;

  if not SDL_CreateWindowAndRenderer("SDL3: sdlapp_earth", MainWinWidth, MainWinHeight, SDL_WINDOW_RESIZABLE, addr window, addr renderer):
    SDL_Log_proc("Couldn't create window/renderer: %s", SDL_GetError());
    return SDL_APP_FAILURE
  if not SDL_SetRenderVSync(renderer, 1):
    SDL_Log_proc("Fail!: VSync setting : %s", SDL_GetError())

  # Setup Dear ImGui context
  igCreateContext(nil)
  let pio = igGetIO_Nil()
  if fDocking:
    pio.ConfigFlags = pio.ConfigFlags or ImGui_ConfigFlags_DockingEnable.cint
    if fViewport:
      pio.ConfigFlags = pio.ConfigFlags or ImGui_ConfigFlags_ViewportsEnable.cint
      pio.ConfigViewports_NoAutomerge = true

  when defined(emscripten):
    pio.IniFilename = nil        # not save inifile in browser
  igStyleColorsClassic(nil)

  # Setup Platform/Renderer backends
  ImGui_ImplSDL3_InitForSDLRenderer(window, renderer)
  ImGui_ImplSDLRenderer3_Init(renderer)

  for i, imageName in ImageNames:
    const funcname = "SDL_LoadPNG()"
    let surface = SDL_LoadPNG(imageName.cstring)
    if not isNil surface:
      textures[i] = SDL_CreateTextureFromSurface(renderer, surface)
      echo "$# OK !: $#" % [funcname, imageName]
      SDL_GetTextureSize(textures[i], addr textureWidth, addr textureHeight)
    else:
      echo "Error!: $#", imageName

  setupFonts()

  return SDL_APP_CONTINUE

#-------------------
#--- SDL_AppIterate
#-------------------
proc SDL_AppIterate*(appstate: pointer): SDL_AppResult {.cdecl.} =
  if quitRequested:
    return SDL_APP_SUCCESS

  # Start the Dear ImGui frame
  ImGui_ImplSDLRenderer3_NewFrame()
  ImGui_ImplSDL3_NewFrame()
  igNewFrame()

  showImGuiMenu()

  # as you can see from this, rendering draws over whatever was drawn before it.
  SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255)
  SDL_RenderClear(renderer) #/* start with a blank canvas. */

  var
    w, h: cfloat
    iw, ih: cint
  let width = textureWidth/2
  let height = textureHeight/2
  SDL_GetWindowSizeInPixels(window, addr iw, addr ih)
  w = iw.cfloat
  h = ih.cfloat
  type Attr = object
    texture: ptr SDL_Texture
    xs, ys: cfloat
    ws, hs: cfloat
  let attribs = [
      Attr(texture: textures[0], xs: (w - textureWidth)/2, ys: (h - textureHeight)/2, ws: width, hs: height)
    , Attr(texture: textures[1], xs: w/2, ys: (h - textureHeight)/2, ws: width, hs: height)
    , Attr(texture: textures[2], xs: (w - textureWidth)/2, ys: h/2, ws: width, hs: height)
    , Attr(texture: textures[3], xs: w/2, ys: h/2, ws: width, hs: height)
  ]
  for attrib in attribs:
    var rectDst = SDL_FRect(x: attrib.xs, y: attrib.ys, w: attrib.ws, h: attrib.hs)
    SDL_RenderTextureRotated(renderer, attrib.texture, nil, addr rectDst, angle, nil, SDL_FLIP_NONE)

  if angle < 360.0:
    if running:
      angle = angle + speedBase.cdouble
  else:
    angle = 0
    delayAtStartup = StartupDelay
  if delayAtStartup > 0:
    dec delayAtStartup
    angle = 0

  if not running:
    SDL_SetRenderDrawColor(renderer, 255, 200, 0, 255); # Orange
    SDL_RenderDebugText(renderer, 100, 500, "Stop")

  let ty = menuBarHeight + 10
  SDL_SetRenderDrawColor(renderer, 0, 180, 0, 255); #  Green
  SDL_RenderDebugText(renderer, 10, ty,      "Start / Stop: SPACE")
  SDL_RenderDebugText(renderer, 10, ty + 10, "Restart     : R or ENTER")
  when not defined(emscripten):
    SDL_RenderDebugText(renderer, 10, ty + 30, "Quit        : Q or ESC")

  # Render Dear ImGui
  igRender()
  ImGui_ImplSDLRenderer3_RenderDrawData(cast[ptr impl_sdlrenderer3.ImDrawData](igGetDrawData()), renderer)

  # Render
  SDL_RenderPresent(renderer)

  return SDL_APP_CONTINUE # carry on with the program!

#-----------------
#--- SDL_AppEvent
#-----------------
proc SDL_AppEvent*(appstate: pointer, event: ptr SDL_Event): SDL_AppResult {.cdecl.} =
  ImGui_ImplSDL3_ProcessEvent(event)

  if event.type_field == SDL_EVENT_QUIT.uint32:
    return SDL_APP_SUCCESS # end the program, reporting success to the OS.
  #
  let io = igGetIO_Nil()
  if io.WantTextInput:
    return SDL_APP_CONTINUE

  if event.key.type_field == SDL_EVENT_KEY_DOWN:
    when not defined(emscripten):
      if event.key.key == SDLK_ESCAPE or event.key.key == SDLK_Q:
        return SDL_APP_SUCCESS # ESC or Q: end the program.
    if event.key.key == SDLK_R or event.key.key == SDLK_RETURN:
      restartAnimation()
    if event.key.key == SDLK_SPACE:
      toggleRunning()
  return SDL_APP_CONTINUE # carry on with the program!

#----------------
#--- SDL_AppQuit
#----------------
proc SDL_AppQuit*(appstate: pointer, res: SDL_AppResult): void {.cdecl.} =
  #--- Cleanup ImGui
  ImGui_ImplSDLRenderer3_Shutdown()
  ImGui_ImplSDL3_Shutdown()
  igDestroyContext(nil)
  SDL_Quit_proc()

#-------------
#--- SDL_main
#-------------
proc SDL_main(argc: cint, argv: ptr UncheckedArray[cstring]): cint {.cdecl.} =
  return SDL_EnterAppMainCallbacks(argc, argv, SDL_AppInit, SDL_AppIterate, SDL_AppEvent, SDL_AppQuit)

#--------------
#--- main proc
#--------------
var argv: seq[cstring]
for str in commandLineParams():
  argv.add str.cstring
argv.add nil
SDL_RunApp(paramCount().cint, cast[ptr UncheckedArray[cstring]](unsafeAddr argv[0]), SDL_main, nil)
