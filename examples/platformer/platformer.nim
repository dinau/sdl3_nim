# This program is based on
#   https://hookrace.net/blog/writing-a-2d-platform-game-in-nim-with-sdl2/#8.
#   https://github.com/def-/nim-platformer
#   See ./LICENSE.nim-platformer.txt

import std/[os, strutils, math, times, strformat]
import sdl3_nim, sdl3_ttf_nim, sdl3_mixer_nim
import basic2d
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

const MainWinWidth = 1289
const MainWinHeight = 720

const FluidCamera = true
const InnerCamera = false

var mixer: ptr MIX_Mixer = nil
var bgmTrack: ptr MIX_Track = nil
var jumpTrack: ptr MIX_Track = nil
var enable_jumpTrack = false
var fbgmStart = true

#-----------
#---dbgEcho
#-----------
proc dbgEcho(strs: varargs[string]) =
  if true:
    for str in strs:
      echo str
type
  Color = SDL_Color

#----------
#--- color
#----------
proc color(r, g, b, a: uint8): Color =
  return Color(r: r, g: g, b: b, a: a)

type
  TexturePtr = ptr SDL_Texture
  RendererPtr = ptr SDL_Renderer
  FontPtr = ptr TTF_Font
  Rect = SDL_FRect

type
  Point = tuple
    x, y: cint
  Vec2f = Vector2d

const windowSize: Point = (MainWinHeight.cint, MainWinWidth.cint)

#----------
#--- vec2f
#----------
proc vec2f(x, y: cfloat): Vec2f = return Vec2f(x: x, y: y)

#------------
#--- point2d
#------------
proc point2d(x, y: cfloat): Point2d =
  result.x = x
  result.y = y

#---------
#--- rect
#---------
proc rect(x, y, w, h: cint): Rect =
  result.x = x.cfloat
  result.y = y.cfloat
  result.w = w.cfloat
  result.h = h.cfloat

type
  Collision {.pure.} = enum x, y, corner
  Input = enum none, left, right, jump, restart, quitx

  Player = object
    texture: TexturePtr
    pos: Point2d
    vel: Vec2f
    time: Time

  Map = object
    texture: TexturePtr
    width, height: int
    tiles: seq[uint8]

  Time = object
    begin, finish, best: int

  Game = object
    inputs: array[Input, bool]
    renderer: RendererPtr
    font: FontPtr
    player: Player
    map: Map
    camera: Vec2f

const
  tilesPerRow = 16.cint
  tileSize: Point = (64.cint, 64.cint)
  playerSize = vec2f(64, 64)

  air = 0
  start = 78
  finish = 110

#--------------
#--- renderTee
#--------------
proc renderTee(renderer: RendererPtr, texture: TexturePtr, pos: Point2d) =
  let
    x = pos.x.cint
    y = pos.y.cint

  var bodyParts: array[8, tuple[source, dest: Rect, flip: int]] = [
    (rect(192,  64, 64, 32), rect(x-60,    y, 96, 48), SDL_FLIP_NONE.int),      # back feet shadow
    (rect( 96,   0, 96, 96), rect(x-48, y-48, 96, 96), SDL_FLIP_NONE.int),      # body shadow
    (rect(192,  64, 64, 32), rect(x-36,    y, 96, 48), SDL_FLIP_NONE.int),      # front feet shadow
    (rect(192,  32, 64, 32), rect(x-60,    y, 96, 48), SDL_FLIP_NONE.int),      # back feet
    (rect(  0,   0, 96, 96), rect(x-48, y-48, 96, 96), SDL_FLIP_NONE.int),      # body
    (rect(192,  32, 64, 32), rect(x-36,    y, 96, 48), SDL_FLIP_NONE.int),      # front feet
    (rect( 64,  96, 32, 32), rect(x-18, y-21, 36, 36), SDL_FLIP_NONE.int),      # left eye
    (rect( 64,  96, 32, 32), rect( x-6, y-21, 36, 36), SDL_FLIP_HORIZONTAL.int) # right eye
  ]

  for part in bodyParts:
    SDL_RenderTextureRotated(renderer
      , texture
      , part.source.unsafeaddr
      , part.dest.unsafeaddr
      , angle = 0.0
      , center = nil
      , flip = part.flip.SDL_FlipMode)

#--------------
#--- renderMap
#--------------
proc renderMap(renderer: RendererPtr, map: Map, camera: Vec2f) =
  var
    clip = rect(0, 0, tileSize.x, tileSize.y)
    dest = rect(0, 0, tileSize.x, tileSize.y)

  for i, tileNr in map.tiles:
    if tileNr == 0: continue

    clip.x = cfloat((tileNr.int mod tilesPerRow) * tileSize.x)
    clip.y = cfloat((tileNr.int div tilesPerRow) * tileSize.y)
    dest.x = cfloat((i mod map.width) * tileSize.x - camera.x.int)
    dest.y = cfloat((i div map.width) * tileSize.y - camera.y.int)

    renderer.SDL_RenderTexture(map.texture, clip.addr, dest.addr)

#---------------
#--- renderText
#---------------
proc renderText(renderer: RendererPtr, font: ptr TTF_Font, text: cstring, x, y, outline: cint, color: Color) =
  font.TTF_SetFontOutline(outline)
  let surface = font.TTF_RenderText_Blended(text, (text.len).csize_t, color)
  if surface.isNil:
    dbgEcho "Could not render text surface in TTF_RenderText_Blended()"
    quit 1
  discard SDL_SetSurfaceAlphaMod(surface, color.a)
  var source = rect(0, 0, surface.w, surface.h)
  var dest = rect(x - outline, y - outline, surface.w, surface.h)
  let texture = renderer.SDL_CreateTextureFromSurface(surface)
  if texture.isNil:
    dbgEcho "Could not create texture from rendered text in SDL_CreateTextureFromSurface()"
    quit 1
  surface.SDL_DestroySurface()
  renderer.SDL_RenderTextureRotated(texture, source.addr, dest.addr, angle = 0.0, center = nil, flip = SDL_FLIP_NONE)
  texture.SDL_DestroyTexture()

#---------------
#--- renderText
#---------------
proc renderText(game: Game, text: string, x, y: cint, color: Color) =
  const outlineColor = color(0, 0, 0, 0x8f)
  game.renderer.renderText(game.font, text, x, y, outline = 2, outlineColor)
  game.renderer.renderText(game.font, text, x, y, outline = 0, color)

#------------------
#--- restartPlayer
#------------------
proc restartPlayer(player: var Player) =
  player.pos = point2d(170, 500)
  player.vel = vec2f(0, 0)
  player.time.begin = -1
  player.time.finish = -1

#------------
#--- newTime
#------------
proc newTime: Time =
  result.finish = -1
  result.best = -1

#--------------
#--- newPlayer
#--------------
proc newPlayer(texture: TexturePtr): Player =
  result.texture = texture
  result.time = newTime()
  result.restartPlayer()

#-----------
#--- newMap
#-----------
proc newMap(texture: TexturePtr, file: string): Map =
  result.texture = texture
  result.tiles = @[]

  for line in file.lines:
    var width = 0
    for word in line.split(' '):
      if word == "": continue
      let value = parseUInt(word)
      if value > uint(uint8.high):
        raise ValueError.newException(
          "Invalid value " & word & " in map " & file)
      result.tiles.add value.uint8
      inc width

    if result.width > 0 and result.width != width:
      raise ValueError.newException(
        "Incompatible line length in map " & file)
    result.width = width
    inc result.height

#------------
#--- newGame   -- Game type
#------------
proc newGame(renderer: RendererPtr): Game =
  var
    texture, texture2: TexturePtr
    surface: ptr SDL_Surface
  const resourceDir = "resources"
  const imageName = resourceDir / "Mipi.png"
  surface = SDL_LoadPNG(imageName)
  if not isNil surface:
    texture = SDL_CreateTextureFromSurface(renderer, surface)
  else:
    dbgEcho "Error!: SDL_LoadPNG() NG!: " & "\"" & imageName & "\""

  const imageName2 = resourceDir / "grass.png"
  surface = SDL_LoadPNG(imageName2)
  if not isNil surface:
    texture2 = SDL_CreateTextureFromSurface(renderer, surface)
  else:
    dbgEcho "Error!: SDL_LoadPNG() NG!: " & "\"" & imageName2 & "\""

  let font = TTF_OpenFont((resourceDir / "DejaVuSans.ttf").cstring, 14)
  if font.isNil:
    dbgEcho "Failed to load font"
    quit 1
  if not font.TTF_SetFontSizeDPI(18, 96, 96):
    echo"Error !: TTF_SetFontSizeDPI()"
  return Game(renderer: renderer,
              player: newPlayer(texture),
              map: newMap(texture2, resourceDir / "default.map"),
              font: font,
    )

# -----------
# -- toInput
# -----------
proc toInput(key: SDL_Scancode): Input =
  case key
  of SDL_SCANCODE_A, SDL_SCANCODE_H, SDL_SCANCODE_LEFT:
    return Input.left
  of SDL_SCANCODE_D, SDL_SCANCODE_L,SDL_SCANCODE_RIGHT:
    return Input.right
  of SDL_SCANCODE_UP, SDL_SCANCODE_SPACE, SDL_SCANCODE_J, SDL_SCANCODE_K, SDL_SCANCODE_W:
    return Input.jump
  of SDL_SCANCODE_R:
    return Input.restart
  of SDL_SCANCODE_Q, SDL_SCANCODE_ESCAPE:
    when defined(emscripten):
      return Input.none
    else:
      return Input.quitx
  else:
    return Input.none

#----------------
#--- handleInput
#----------------
proc handleInput(self: var Game, event: ptr SDL_Event) =
  let kind = event.type_field.int
  if kind == SDL_EVENT_QUIT.int:
    self.inputs[Input.quitx] = true
  elif kind == SDL_EVENT_KEYDOWN.int:
    self.inputs[toInput(event.key.scancode)] = true
  elif kind == SDL_EVENT_KEYUP.int:
    self.inputs[toInput(event.key.scancode)] = false

#---------------
#--- formatTime
#---------------
proc formatTime(ticks: int): string =
  let
    mins = (ticks div 50) div 60
    secs = (ticks div 50) mod 60
    cents = (ticks mod 50) * 2
  return fmt"{mins:02}:{secs:02}:{cents:02}"

#-----------
#--- render
#-----------
proc render(game: Game, tick: int) =
  game.renderer.SDL_RenderClear()
  game.renderer.renderTee(game.player.texture, game.player.pos - game.camera)
  game.renderer.renderMap(game.map, game.camera)

  let time = game.player.time
  const white = color(255, 255, 255, 255)
  const green = color(0, 255, 0, 255)
  const blue = color(0x00, 0xff, 0xff, 0xff)
  if time.begin >= 0:
    game.renderText(formatTime(tick - time.begin), 50, 100, white)
    if fbgmStart:
      fbgmStart = false
      let options: SDL_PropertiesID = SDL_CreateProperties()
      if options == 0:
        SDL_Log_proc("Couldn't create play options: %s", SDL_GetError())
      SDL_SetNumberProperty(options, MIX_PROP_PLAY_LOOPS_NUMBER, -1) # Loop forever.
      MIX_PlayTrack(bgmTrack, options)
      SDL_DestroyProperties(options) # MIX_PlayTrack makes a copy of the options, so this can go away.
  elif time.finish >= 0:
    game.renderText("Finished in: " & formatTime(time.finish), 50, 100, white)
  if time.best >= 0:
    game.renderText("Best time  : " & formatTime(time.best), 50, 150, green)
  if time.begin < 0:
    const base = 230
    const colm = 30
    game.renderText("Jump   : Space, Up, J, K, W",                    50, base+colm*1,  white)
    game.renderText("Left     : A, H, Left",                          50, base+colm*2,  white)
    game.renderText("Right   : D, L, Right",                          50, base+colm*3,  white)
    game.renderText("Restart: R",                                     50, base+colm*4,  white)
    when defined(emscripten):
      discard
    else:
      game.renderText("Quit     : Q, Esc",                            50, base+colm*5,  white)
    game.renderText("Nim-" & NimVersion,                              50, base+colm*7,  white)
    var ver = SDL_GetVersion()
    game.renderText(fmt"SDL: {ver div 1000000}.{(ver div 1000) mod 1000}.{ver mod 100}",    50, base+colm*8,  white)
    ver = TTF_Version()
    game.renderText(fmt"SDL_ttf: {ver div 1000000}.{(ver div 1000) mod 1000}.{ver mod 100}",  50, base+colm*9,  white)
    ver = MIX_Version()
    game.renderText(fmt"SDL_mixer: {ver div 1000000}.{(ver div 1000) mod 1000}.{ver mod 100}",  50, base+colm*10,  white)

    game.renderText("Nim-Platformer-SDL3",                            50, base+colm*14, blue)

  # Show the result on screen
  #game.renderer.SDL_RenderPresent() # moved to SDL_AppIterate() for Dear ImGui

#------------
#--- getTile
#------------
proc getTile(map: Map, x, y: int): uint8 =
  let
    nx = clamp(x div tileSize.x, 0, map.width - 1)
    ny = clamp(y div tileSize.y, 0, map.height - 1)
    pos = ny * map.width + nx

  map.tiles[pos]

#------------
#--- getTile
#------------
proc getTile(map: Map, pos: Point2d): uint8 =
  map.getTile(pos.x.round.int, pos.y.round.int)

#------------
#--- isSolid
#------------
proc isSolid(map: Map, x, y: int): bool =
  map.getTile(x, y) notin {air, start, finish}

#------------
#--- isSolid
#------------
proc isSolid(map: Map, point: Point2d): bool =
  map.isSolid(point.x.round.int, point.y.round.int)

#-------------
#--- onGround
#-------------
proc onGround(map: Map, pos: Point2d, size: Vec2f): bool =
  let size = size * 0.5
  result =
    map.isSolid(point2d(pos.x - size.x, pos.y + size.y + 1)) or
    map.isSolid(point2d(pos.x + size.x, pos.y + size.y + 1))

#------------
#--- testBox
#------------
proc testBox(map: Map, pos: Point2d, size: Vec2f): bool =
  let size = size * 0.5
  result =
    map.isSolid(point2d(pos.x - size.x, pos.y - size.y)) or
    map.isSolid(point2d(pos.x + size.x, pos.y - size.y)) or
    map.isSolid(point2d(pos.x - size.x, pos.y + size.y)) or
    map.isSolid(point2d(pos.x + size.x, pos.y + size.y))

#------------
#--- moveBox
#------------
proc moveBox(map: Map, pos: var Point2d, vel: var Vec2f, size: Vec2f): set[Collision] {.discardable.} =
  let distance = vel.len
  let maximum = distance.int

  if distance < 0:
    return

  let fraction = 1.0 / float(maximum + 1)

  for i in 0 .. maximum:
    var newPos = pos + vel * fraction

    if map.testBox(newPos, size):
      var hit = false

      if map.testBox(point2d(pos.x, newPos.y), size):
        result.incl Collision.y
        newPos.y = pos.y
        vel.y = 0
        hit = true

      if map.testBox(point2d(newPos.x, pos.y), size):
        result.incl Collision.x
        newPos.x = pos.x
        vel.x = 0
        hit = true

      if not hit:
        result.incl Collision.corner
        newPos = pos
        vel = vec2f(0, 0)

    pos = newPos

#------------
#--- physics
#------------
proc physics(game: var Game) =
  if game.inputs[Input.restart]:
    restartPlayer(game.player)
    MIX_PauseTrack(bgmTrack)

  let ground = game.map.onGround(game.player.pos, playerSize)

  if game.inputs[Input.jump]:
    if not MIX_TrackPlaying(jumpTrack) and enable_jumpTrack:
      MIX_PlayTrack(jumpTrack, 0)
      enable_jumpTrack = false
    if ground:
      game.player.vel.y = -21
  else:
    enable_jumpTrack = true

  let direction = float(game.inputs[Input.right].int -
                        game.inputs[Input.left].int)

  game.player.vel.y += 0.75
  if ground:
    game.player.vel.x = 0.5 * game.player.vel.x + 4.0 * direction
  else:
    game.player.vel.x = 0.95 * game.player.vel.x + 2.0 * direction
  game.player.vel.x = clamp(game.player.vel.x, -8, 8)

  game.map.moveBox(game.player.pos, game.player.vel, playerSize)

#---------------
#--- moveCamera
#---------------
proc moveCamera(game: var Game) =
  const halfWin = float(windowSize.x div 2)
  if FluidCamera:
    let dist = game.camera.x - game.player.pos.x + halfWin
    game.camera.x -= 0.05 * dist
  elif InnerCamera:
    let
      leftArea = game.player.pos.x - halfWin - 100
      rightArea = game.player.pos.x - halfWin + 100
    game.camera.x = clamp(game.camera.x, leftArea, rightArea)
  else:
    game.camera.x = game.player.pos.x - halfWin

#----------
#--- logic
#----------
proc logic(game: var Game, tick: int) =
  template time: untyped = game.player.time
  case game.map.getTile(game.player.pos)
  of start:
    time.begin = tick
    MIX_ResumeTrack(bgmTrack)
  of finish:
    if time.begin >= 0:
      time.finish = tick - time.begin
      time.begin = -1
      if time.best < 0 or time.finish < time.best:
        time.best = time.finish
      dbgEcho "Finished in ", formatTime(time.finish)
      MIX_PauseTrack(bgmTrack)
  else: discard

#-------------
# for SDL_App
#-------------
type
  AppContext = ref object
    window: ptr SDL_Window
    glContext: SDL_GLContext
    renderer: ptr SDL_Renderer
    game: Game
    startTime: float
    lastTick: int
    imguiReady: bool
    showDemo: bool
    showAbout: bool
    showLicenseNotices: bool
    font: ptr ImFont

#-------------
#--- drawMenu
#-------------
proc showImGuiMenu(ctx: AppContext) =
  if igBeginMainMenuBar():
    if igBeginMenu(ICON_FA_TRIANGLE_EXCLAMATION & " Licenses", true):
      if igMenuItem_Bool("Show", "S", false, true):
        ctx.showLicenseNotices = true
      igEndMenu()
    if igBeginMenu(ICON_FA_GEAR & " Control", true):
      if igMenuItem_Bool("Restart", "R", false, true):
        restartPlayer(ctx.game.player)
      when not defined(emscripten):
        igSeparator()
        if igMenuItem_Bool("Quit", "Q / Esc", false, true):
          ctx.game.inputs[Input.quitx] = true
      igEndMenu()
    if igBeginMenu(ICON_FA_CIRCLE_QUESTION & " Help", true):
      igMenuItem_BoolPtr("ImGui Demo", nil, ctx.showDemo.addr, true)
      igMenuItem_BoolPtr("About", nil, ctx.showAbout.addr, true)
      igEndMenu()
    igEndMainMenuBar()

  if ctx.showDemo:
    igShowDemoWindow(ctx.showDemo.addr)

  if ctx.showAbout:
    if igBegin("About", ctx.showAbout.addr, 0):
      igText("Nim-Platformer-SDL3 + Dear ImGui \n 2026/09")
    igEnd()
  #-----------------------
  # Show Licenses window
  #-----------------------
  if ctx.showLicenseNotices:
    igStyleColorsLight(nil)
    igSetNextWindowPos(ImVec2(x: 30, y: 30), ImGui_Cond_FirstUseEver.cint, ImVec2(x: 0, y: 0))
    igSetNextWindowSize(ImVec2(x: 600, y: 900), ImGui_Cond_FirstUseEver.cint)
    when defined(emscripten):
      igPushFont(nil, 11)
    else:
      igPushFont(nil, 16)
    licenseNotices(addr ctx.showLicenseNotices, ImGui_WindowFlags_Modal.cint)
    igPopFont()
    igStyleColorsClassic(nil)

#---------------
#--- load_audio
#---------------
proc load_audio(fname: string): ptr MIX_Audio =
  # Build the full file path with Nim string concatenation instead of SDL_asprintf
  let path = $SDL_GetBasePath() & fname
  result = MIX_LoadAudio(mixer, path.cstring, false)
  if result == nil:
    SDL_Log_proc("Couldn't load %s: %s", path.cstring, SDL_GetError())

#----------------
#--- SDL_AppInit
#----------------
proc SDL_AppInit(appstate: ptr pointer, argc: cint, argv: ptr UncheckedArray[cstring]): SDL_AppResult {.cdecl} =
  var ctx = new(AppContext)
  appstate[] = cast[pointer](ctx)

  if not SDL_Init(SDL_INIT_VIDEO or SDL_INIT_GAMEPAD):
    dbgEcho("SDL_Init Error: ", $SDL_GetError())
    return SDL_APP_FAILURE

  if not TTF_Init():
    dbgEcho("TTF_Init Error: ", $SDL_GetError())
    return SDL_APP_FAILURE
  else:
    dbgEcho "TTF_Init() OK!"

  let flags =
    when defined(emscripten): SDL_WINDOW_RESIZABLE
    else: SDL_WINDOW_RESIZABLE or SDL_WINDOW_OPENGL

  ctx.window = SDL_CreateWindow("[ SDL3 ]: nim_sdl3 platformer", MainWinWidth, MainWinHeight, flags.SDL_WindowFlags)

  if isNil ctx.window:
    dbgEcho("SDL_CreateWindow Error: ", $SDL_GetError())
    return SDL_APP_FAILURE

  when not defined(emscripten):
    ctx.glContext = SDL_GL_CreateContext(ctx.window)
    if isNil ctx.glContext:
      dbgEcho("SDL_GL_CreateContext Error: ", $SDL_GetError())
      return SDL_APP_FAILURE
    SDL_GL_MakeCurrent(ctx.window, ctx.glContext)

  dbgEcho("SDL3 version : ",  $SDL_GetVersion())
  when defined(emscripten):
    discard
  else:
    dbgEcho("SDL3 revision : ", $SDL_GetRevision())

  ctx.renderer = SDL_CreateRenderer(ctx.window, nil)
  if isNil ctx.renderer:
    dbgEcho("SDL_CreateRenderer Error: ", $SDL_GetError())
    return SDL_APP_FAILURE

  if not SDL_SetRenderVSync(ctx.renderer, 1):
    dbgEcho("SDL_SetRenderVSync Error: ", $SDL_GetError())
    return SDL_APP_FAILURE

  ctx.game = newGame(ctx.renderer)
  ctx.startTime = epochTime()
  ctx.lastTick = 0

  SDL_SetRenderDrawColor(ctx.renderer, 110, 132, 174, 255)

  # Dear ImGui
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

  if not ImGui_ImplSDL3_InitForSDLRenderer(ctx.window, ctx.renderer):
    dbgEcho("ImGui_ImplSDL3_InitForSDLRenderer failed")
    return SDL_APP_FAILURE
  if not ImGui_ImplSDLRenderer3_Init(ctx.renderer):
    dbgEcho("ImGui_ImplSDLRenderer3_Init failed")
    return SDL_APP_FAILURE
  ctx.imguiReady = true

  setupFonts()

  #------------
  # SDL3_mixer
  #------------
  var bgmSound: ptr MIX_Audio = nil
  var jumpSound: ptr MIX_Audio = nil
  if not MIX_Init():
    SDL_Log_proc("Couldn't init SDL_mixer library: %s", SDL_GetError())
    return SDL_APP_FAILURE

  # Create a mixer on the default audio device. Don't care about the specific audio format.
  mixer = MIX_CreateMixerDevice(SDL_AUDIO_DEVICE_DEFAULT_PLAYBACK, nil)
  if mixer == nil:
    SDL_Log_proc("Couldn't create mixer on default device: %s", SDL_GetError())
    return SDL_APP_FAILURE

  # Load our audio files. Note that you can use any supported file format!
  bgmSound = load_audio("resources/platformer.mp3")
  if bgmSound == nil:
    return SDL_APP_FAILURE # We reported the error in load_audio
  jumpSound = load_audio("resources/jump02.wav")
  if jumpSound == nil:
    return SDL_APP_FAILURE # We reported the error in load_audio

  bgmTrack = MIX_CreateTrack(mixer)
  if bgmTrack == nil:
    SDL_Log_proc("Couldn't create a mixer track: %s", SDL_GetError())
    return SDL_APP_FAILURE
  discard MIX_SetTrackAudio(bgmTrack, bgmSound)
  discard MIX_SetTrackGain(bgmTrack, 0.7)

  jumpTrack = MIX_CreateTrack(mixer)
  if jumpTrack == nil:
    SDL_Log_proc("Couldn't create a mixer track: %s", SDL_GetError())
    return SDL_APP_FAILURE
  discard MIX_SetTrackAudio(jumpTrack, jumpSound)
  discard MIX_SetTrackGain(jumpTrack, 0.2)

  when false:
    var options: SDL_PropertiesID = 0
    options = SDL_CreateProperties()
    if options == 0:
      SDL_Log_proc("Couldn't create play options: %s", SDL_GetError())
      return SDL_APP_FAILURE
    discard SDL_SetNumberProperty(options, MIX_PROP_PLAY_LOOPS_NUMBER, -1) # Loop forever.

    discard MIX_PlayTrack(bgmTrack, options) # No extra options this time, so a zero for the second argument.
    SDL_DestroyProperties(options) # MIX_PlayTrack makes a copy of the options, so this can go away.

  return SDL_APP_CONTINUE

#-----------------
#--- SDL_AppEvent
#-----------------
proc SDL_AppEvent(appstate: pointer, event: ptr SDL_Event): SDL_AppResult {.cdecl.} =
  let ctx = cast[AppContext](appstate)

  # Dear ImGui
  discard ImGui_ImplSDL3_ProcessEvent(event)
  let pio = igGetIO_Nil()

  let kind = event.type_field.int
  if not (kind == SDL_EVENT_KEYDOWN.int and pio.WantCaptureKeyboard):
    ctx.game.handleInput(event)
  #

  if ctx.game.inputs[Input.quitx]:
      return SDL_APP_SUCCESS

  return SDL_APP_CONTINUE

#-------------------
#--- SDL_AppIterate
#-------------------
proc SDL_AppIterate(appstate: pointer): SDL_AppResult {.cdecl.} =
  let ctx = cast[AppContext](appstate)

  if ctx.game.inputs[Input.quitx]:
    return SDL_APP_SUCCESS

  let newTick = int((epochTime() - ctx.startTime) * 50)
  for tick in ctx.lastTick + 1 .. newTick:
    ctx.game.physics()
    ctx.game.moveCamera()
    ctx.game.logic(tick)
  ctx.lastTick = newTick

  ctx.game.render(ctx.lastTick)

  # Dear ImGui
  ImGui_ImplSDLRenderer3_NewFrame()
  ImGui_ImplSDL3_NewFrame()
  igNewFrame()

  ctx.showImGuiMenu()

  igRender()

  # Render Dear ImGui
  ImGui_ImplSDLRenderer3_RenderDrawData(cast[ptr impl_sdlrenderer3.ImDrawData](igGetDrawData()), ctx.renderer)

  # Render
  discard SDL_RenderPresent(ctx.renderer)   # Present

  return SDL_APP_CONTINUE

#----------------
#--- SDL_AppQuit
#----------------
proc SDL_AppQuit(appstate: pointer, result: SDL_AppResult) {.cdecl.} =
  if not isNil appstate:
    let ctx = cast[AppContext](appstate)

    if ctx.imguiReady:
      ImGui_ImplSDLRenderer3_Shutdown()
      ImGui_ImplSDL3_Shutdown()
      igDestroyContext(nil)

    if not isNil ctx.renderer:
      SDL_DestroyRenderer(ctx.renderer)
    if not isNil ctx.glContext:
      discard SDL_GL_DeleteContext_renamed_SDL_GL_DestroyContext()
    if not isNil ctx.window:
      SDL_DestroyWindow(ctx.window)

    TTF_Quit()
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
discard SDL_RunApp(paramCount().cint, cast[ptr UncheckedArray[cstring]](unsafeAddr argv[0]), SDL_main, nil)
