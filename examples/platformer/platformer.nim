# This program is based on
#   https://hookrace.net/blog/writing-a-2d-platform-game-in-nim-with-sdl2/#8.
#   See ./LICENSE.nim-platformer.txt

import std/[os,strutils,math,times,strformat]
#
import sdl3_nim
import sdl3_nim/[loadImage]
import basic2d

when defined(windows):
  include ./res/resource

const MainWinWidth  = 1289
const MainWinHeight = 720

const FluidCamera = true
const InnerCamera = false

type
  Color = SDL_Color

proc color( r,g,b,a:uint8): Color =
  return Color(r: r, g: g, b: b, a: a)

when defined(windows):
  const libname {.inject.} = "SDL3_ttf.dll"
else:
  const libname {.inject.} = "libSDL3_ttf.so"

{.push dynlib:libname, discardable, cdecl, importc.}
type
    TTF_Font* = object
proc TTF_Init*(): bool
proc TTF_Quit*()
proc TTF_OpenFont(file: cstring, ptSize: cfloat): ptr TTF_Font
proc TTF_SetFontOutline(font: ptr TTF_Font, outline: cint)
proc TTF_RenderText_Blended(font: ptr TTF_Font, text: cstring,  length:cint, fg: SDL_Color): ptr SDL_Surface
proc TTF_SetFontSizeDPI(font: ptr TTF_Font , ptsize: cfloat, hdpi, vdpi: cint): bool
proc TTF_Version(): cint
{.pop.}

type
  TexturePtr  = ptr SDL_Texture
  RendererPtr = ptr SDL_Renderer
  FontPtr     = ptr TTF_Font
  Rect        = SDL_FRect

type
  Point = tuple
    x, y: cint
  Vec2f = Vector2d

const windowSize:Point = (MainWinHeight.cint, MainWinWidth.cint)

proc vec2f(x,y:cfloat): Vec2f = return Vec2f(x: x, y: y)

proc point2d(x,y:cfloat):Point2d =
  result.x = x
  result.y = y

proc rect(x, y,w,h:cint): Rect =
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

proc currentSourceDir(): string {.compileTime.} =
  result = currentSourcePath().replace("\\", "/")
  result = result[0 ..< result.rfind("/")]

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

proc renderText(renderer: RendererPtr, font: FontPtr, text: string, x, y, outline: cint, color: Color) =
  font.TTF_SetFontOutline(outline)
  let surface = font.TTF_RenderText_Blended(text.cstring, text.len.cint, color)
  if surface.isNil:
    echo "Could not render text surface in TTF_RenderText_Blended()"
    quit 1
  discard surface.SDL_SetSurfaceAlphaMod(color.a)
  var source = rect(0, 0, surface.w, surface.h)
  var dest = rect(x - outline, y - outline, surface.w, surface.h)
  let texture = renderer.SDL_CreateTextureFromSurface(surface)
  if texture.isNil:
    echo "Could not create texture from rendered text in SDL_CreateTextureFromSurface()"
    quit 1
  surface.SDL_DestroySurface()
  renderer.SDL_RenderTextureRotated(texture, source.addr , dest.addr, angle = 0.0, center = nil, flip = SDL_FLIP_NONE)
  texture.SDL_DestroyTexture()

proc renderText(game: Game, text: string, x, y: cint, color: Color) =
  const outlineColor = color(0, 0, 0, 0x8f)
  game.renderer.renderText(game.font, text, x, y, outline = 2, outlineColor)
  game.renderer.renderText(game.font, text, x, y, outline = 0, color)

proc restartPlayer(player: var Player) =
  player.pos = point2d(170, 500)
  player.vel = vec2f(0,   0)
  player.time.begin = -1
  player.time.finish = -1

proc newTime: Time =
  result.finish = -1
  result.best = -1

proc newPlayer(texture: TexturePtr): Player =
  result.texture = texture
  result.time = newTime()
  result.restartPlayer()

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
    w,h: int
    texture, texture2:  TexturePtr
  const imageName = joinPath(currentSourceDir(), "Mipi.png")
  discard loadTextureFromFile(imageName, renderer, texture, w, h )

  const imageName2 = joinPath(currentSourceDir(), "grass.png")
  discard loadTextureFromFile(imageName2, renderer, texture2, w, h)

  let font = TTF_OpenFont("DejaVuSans.ttf", 14)
  if font.isNil:
    echo "Failed to load font"
    quit 1
  if not font.TTF_SetFontSizeDPI( 18, 96,96):
    echo"Error !: TTF_SetFontSizeDPI()"
  return Game(renderer    : renderer,
              player      : newPlayer(texture),
              map         : newMap(texture2, "default.map"),
              font        : font,
             )

# -----------
# -- toInput
# -----------
proc toInput(key:SDL_Scancode): Input =
  if key == SDL_SCANCODE_A or key == SDL_SCANCODE_H or key == SDL_SCANCODE_LEFT:
    return Input.left
  elif key == SDL_SCANCODE_D or key == SDL_SCANCODE_L or key == SDL_SCANCODE_RIGHT :
    return Input.right
  elif key == SDL_SCANCODE_UP or key == SDL_SCANCODE_SPACE or key == SDL_SCANCODE_J or key == SDL_SCANCODE_K :
    return Input.jump
  elif key == SDL_SCANCODE_R :
    return Input.restart
  elif key == SDL_SCANCODE_Q or key == SDL_SCANCODE_ESCAPE:
    return Input.quitx
  else:
    return Input.none

#----------------
#--- handleInput
#----------------
proc handleInput(self: var Game) =
  var event: SDL_Event
  while SDL_PollEvent(addr event):
    let kind = event.type_field.enum_SDL_EventType
    if kind == SDL_EVENT_QUIT:
      self.inputs[Input.quitx] = true
    elif kind == SDL_EVENT_KEYDOWN:
      self.inputs[toInput(event.key.scancode)] = true
    elif kind == SDL_EVENT_KEYUP:
      self.inputs[toInput(event.key.scancode)] = false

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
  game.renderer.renderTee(game.player.texture , game.player.pos - game.camera)
  game.renderer.renderMap(game.map, game.camera)

  let time = game.player.time
  const white = color(255, 255, 255, 255)
  const green = color(0, 255, 0, 255)
  const blue  = color(0x00, 0xff, 0xff, 0xff)
  if time.begin >= 0:
    game.renderText(formatTime(tick - time.begin), 50, 100, white)
  elif time.finish >= 0:
    game.renderText("Finished in: " & formatTime(time.finish), 50, 100, white)
  if time.best >= 0:
    game.renderText("Best time  : " & formatTime(time.best), 50, 150, green)
  if time.begin < 0:
    let ver = SDL_GetVersion()
    const base = 230
    const colm = 30
    game.renderText("Jump   : Space, Up, J, K",                     50, base+colm*1,  white)
    game.renderText("Left     : A, H, Left",                        50, base+colm*2,  white)
    game.renderText("Right   : D, L, Right",                        50, base+colm*3,  white)
    game.renderText("Restart: R",                                   50, base+colm*4,  white)
    game.renderText("Quit     : Q, Esc",                            50, base+colm*5,  white)
    game.renderText("Nim-" & NimVersion,                            50, base+colm*7,  white)
    game.renderText(fmt"SDL: {($SDL_GetRevision()).split('-')[1]}", 50, base+colm*8,  white)
    game.renderText("SDL_ttf: " &  $TTF_Version(),                  50, base+colm*9,  white)
    game.renderText("Nim-Platformer-SDL3",                          50, base+colm*14, blue)

  # Show the result on screen
  game.renderer.SDL_RenderPresent()

proc getTile(map: Map, x, y: int): uint8 =
  let
    nx = clamp(x div tileSize.x, 0, map.width - 1)
    ny = clamp(y div tileSize.y, 0, map.height - 1)
    pos = ny * map.width + nx

  map.tiles[pos]

proc getTile(map: Map, pos: Point2d): uint8 =
  map.getTile(pos.x.round.int, pos.y.round.int)

proc isSolid(map: Map, x, y: int): bool =
  map.getTile(x, y) notin {air, start, finish}

proc isSolid(map: Map, point: Point2d): bool =
  map.isSolid(point.x.round.int, point.y.round.int)

proc onGround(map: Map, pos: Point2d, size: Vec2f): bool =
  let size = size * 0.5
  result =
    map.isSolid(point2d(pos.x - size.x, pos.y + size.y + 1)) or
    map.isSolid(point2d(pos.x + size.x, pos.y + size.y + 1))

proc testBox(map: Map, pos: Point2d, size: Vec2f): bool =
  let size = size * 0.5
  result =
    map.isSolid(point2d(pos.x - size.x, pos.y - size.y)) or
    map.isSolid(point2d(pos.x + size.x, pos.y - size.y)) or
    map.isSolid(point2d(pos.x - size.x, pos.y + size.y)) or
    map.isSolid(point2d(pos.x + size.x, pos.y + size.y))

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

proc physics(game: var Game) =
  if game.inputs[Input.restart]:
    restartPlayer(game.player)

  let ground = game.map.onGround(game.player.pos, playerSize)

  if game.inputs[Input.jump]:
    if ground:
      game.player.vel.y = -21

  let direction = float(game.inputs[Input.right].int -
                        game.inputs[Input.left].int)

  game.player.vel.y += 0.75
  if ground:
    game.player.vel.x = 0.5 * game.player.vel.x + 4.0 * direction
  else:
    game.player.vel.x = 0.95 * game.player.vel.x + 2.0 * direction
  game.player.vel.x = clamp(game.player.vel.x, -8, 8)

  game.map.moveBox(game.player.pos, game.player.vel, playerSize)

proc moveCamera(game: var Game) =
  const halfWin = float(windowSize.x div 2)
  if FluidCamera:
    let dist = game.camera.x - game.player.pos.x + halfWin
    game.camera.x -= 0.05 * dist
  elif InnerCamera:
    let
      leftArea  = game.player.pos.x - halfWin - 100
      rightArea = game.player.pos.x - halfWin + 100
    game.camera.x = clamp(game.camera.x, leftArea, rightArea)
  else:
    game.camera.x = game.player.pos.x - halfWin

proc logic(game: var Game, tick: int) =
  template time: untyped = game.player.time
  case game.map.getTile(game.player.pos)
  of start:
    time.begin = tick
  of finish:
    if time.begin >= 0:
      time.finish = tick - time.begin
      time.begin = -1
      if time.best < 0 or time.finish < time.best:
        time.best = time.finish
      echo "Finished in ", formatTime(time.finish)
  else: discard

#-----------
#--- main()
#-----------
proc main() =
  if not SDL_Init(SDL_INIT_VIDEO or SDL_INIT_GAMEPAD): raise newException(Exception, "SDL_Init()")
  defer: SDL_Quit_proc()
  if not TTF_Init():
    raise newException(Exception, "TTF_Init()")
  else:
    echo "TTF_Init() OK!"
  defer: TTF_Quit()

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

  var window = SDL_CreateWindow("[ SDL3 ]:   nim_sdl3 test window", MainWinWidth, MainWinHeight, flags.SDL_WindowFlags)
  if isNil window: raise newException(Exception, "SDL_CreateWindow()")
  defer: SDL_DestroyWindow(window)

  let glContext = SDL_GL_CreateContext(window)
  if isNil glContext: raise newException(Exception, "SDL_GL_CreateContext()")
  defer: discard SDL_GL_DeleteContext_renamed_SDL_GL_DestroyContext()

  SDL_GL_MakeCurrent(window, glContext);

  echo "SDL3 version : ",SDL_GetVersion()
  echo "SDL3 revision : ",SDL_GetRevision()

  #-------------
  #--- Renderer
  #-------------
  var renderer = SDL_CreateRenderer(window,nil)
  if isNil renderer: raise newException(Exception, "SDL_CreateRenderer()")
  defer: SDL_DestroyRenderer(renderer)

  #------------------
  #--- Vsync setting
  #------------------
  if not SDL_SetRenderVSync(renderer, 1):
    raise newException(Exception, "SDL_SetRenderVSync()")

  #--------------
  #--- Main loop
  #--------------
  var
    game = newGame(renderer)
    startTime = epochTime()
    lastTick = 0

  SDL_SetRenderDrawColor(renderer,110,132,174,255) # Background color

  while not game.inputs[Input.quitx]:
    game.handleInput()
    let newTick = int((epochTime() - startTime) * 50)
    for tick in lastTick+1 .. newTick:
      game.physics()
      game.moveCamera()
      game.logic(tick)
    lastTick = newTick

    game.render(lastTick)

#---------
#--- main
#---------
main()
