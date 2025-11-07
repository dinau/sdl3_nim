import sdl3_nim

#--- Add application icon
when defined(windows):
  when not defined(vcc):   # imguinVcc.res TODO WIP
    include ./res/resource

const MainWinWidth  = 640
const MainWinHeight = 480

var window: ptr SDL_Window = nil
var renderer: ptr SDL_Renderer = nil

#----------------
#--- SDL_AppInit
#----------------
proc SDL_AppInit(appstate: ptr pointer, argc: cint, argv: ptr UncheckedArray[cstring]): SDL_AppResult {.cdecl.} =
  SDL_SetAppMetadata("Example Renderer Lines", "1.0", "com.example.renderer-lines")
  if not SDL_Init(SDL_INIT_VIDEO):
    SDL_Log_proc("Couldn't initialize SDL: %s", SDL_GetError())
    return SDL_APP_FAILURE;

  if not SDL_CreateWindowAndRenderer("renderer:lines demo", MainWinWidth, MainWinHeight, SDL_WINDOW_RESIZABLE, addr window, addr renderer):
      SDL_Log_proc("Couldn't create window/renderer: %s", SDL_GetError());
      return SDL_APP_FAILURE
  SDL_SetRenderLogicalPresentation(renderer, MainWinWidth, MainWinHeight, SDL_LOGICAL_PRESENTATION_LETTERBOX);
  return SDL_APP_CONTINUE

#-------------------
#--- SDL_AppIterate
#-------------------
proc SDL_AppIterate(appstate: pointer): SDL_AppResult {.cdecl.} =
  const line_points: array[9, SDL_FPoint]  = [
      SDL_FPoint(x: 100, y: 354 ), SDL_FPoint(x: 220, y: 230 ), SDL_FPoint(x: 140, y: 230 ), SDL_FPoint(x: 320, y: 100 ), SDL_FPoint(x: 500, y: 230 ),
      SDL_FPoint(x: 420, y: 230 ), SDL_FPoint(x: 540, y: 354 ), SDL_FPoint(x: 400, y: 354 ), SDL_FPoint(x: 100, y: 354 )
  ]

  #/* as you can see from this, rendering draws over whatever was drawn before it. */
  SDL_SetRenderDrawColor(renderer, 100, 100, 100, SDL_ALPHA_OPAQUE)  #/* grey, full alpha */
  SDL_RenderClear(renderer)  #/* start with a blank canvas. */

  #/* You can draw lines, one at a time, like these brown ones... */
  SDL_SetRenderDrawColor(renderer, 127, 49, 32, SDL_ALPHA_OPAQUE)
  SDL_RenderLine(renderer, 240, 450, 400, 450)
  SDL_RenderLine(renderer, 240, 356, 400, 356)
  SDL_RenderLine(renderer, 240, 356, 240, 450)
  SDL_RenderLine(renderer, 400, 356, 400, 450)

  #/* You can also draw a series of connected lines in a single batch... */
  SDL_SetRenderDrawColor(renderer, 0, 255, 0, SDL_ALPHA_OPAQUE)
  SDL_RenderLines(renderer, addr line_points[0], line_points.len)

  #/* here's a bunch of lines drawn out from a center point in a circle. */
  #/* we randomize the color of each line, so it functions as animation. */
  for i in 0..<360:
    const size = 30.0
    const x = 320.0f
    const y = 95.0f - (size / 2.0f)
    SDL_SetRenderDrawColor(renderer, SDL_rand(256).uint8, SDL_rand(256).uint8, SDL_rand(256).uint8, SDL_ALPHA_OPAQUE)
    SDL_RenderLine(renderer, x, y, x + SDL_sinf((float) i) * size, y + SDL_cosf((float) i) * size)

  SDL_RenderPresent(renderer)  #/* put it all on the screen! */

  return SDL_APP_CONTINUE  #/* carry on with the program! */

#-----------------
#--- SDL_AppEvent
#-----------------
proc SDL_AppEvent(appstate: pointer, event: ptr SDL_Event): SDL_AppResult {.cdecl.} =
  if event.type_field == SDL_EVENT_QUIT.uint32:
    return SDL_APP_SUCCESS # end the program, reporting success to the OS.
  if event.key.type_field == SDL_EVENT_KEY_DOWN:
    if event.key.key == SDLK_ESCAPE or event.key.key == SDLK_Q:
      return SDL_APP_SUCCESS # end the program, reporting success to the OS.

  return SDL_APP_CONTINUE  # carry on with the program!

#----------------
#--- SDL_AppQuit
#----------------
proc SDL_AppQuit(appstate: pointer, res: SDL_AppResult): void {.cdecl.} =
  SDL_Quit_proc()

#-------------
#--- SDL_main
#-------------
proc SDL_main(argc: cint, argv: ptr UncheckedArray[cstring]): cint {.cdecl.}  =
  return SDL_EnterAppMainCallbacks(argc, argv, SDL_AppInit, SDL_AppIterate, SDL_AppEvent, SDL_AppQuit)

#--------------
#--- main porc
#--------------
discard SDL_RunApp(0, nil, SDL_main, nil);
