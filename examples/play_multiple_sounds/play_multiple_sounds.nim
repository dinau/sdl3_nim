import os
import sdl3_nim, sdl3_mixer_nim

#--- Add application icon
when defined(windows):
  when not defined(vcc): # imguinVcc.res TODO WIP
    include ./res/resource

const MainWinWidth = 640
const MainWinHeight = 480

var window: ptr SDL_Window = nil
var renderer: ptr SDL_Renderer = nil
var mixer: ptr MIX_Mixer = nil
var track1: ptr MIX_Track = nil

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
proc SDL_AppInit(appstate: ptr pointer, argc: cint, argv: ptr UncheckedArray[cstring]): SDL_AppResult {.cdecl.} =
  var music: ptr MIX_Audio = nil
  var sound: ptr MIX_Audio = nil
  var track2: ptr MIX_Track = nil
  var options: SDL_PropertiesID = 0

  SDL_SetAppMetadata("Example Play Multiple Sounds", "1.0", "com.example.play-multiple-sounds")

  # This doesn't have to run very much, so give up tons of CPU time between iterations. Optional!
  discard SDL_SetHint(SDL_HINT_MAIN_CALLBACK_RATE, "5")

  # We don't need video, but we'll make a window for smooth operation.
  if not SDL_Init(SDL_INIT_VIDEO):
    SDL_Log_proc("Couldn't initialize SDL: %s", SDL_GetError())
    return SDL_APP_FAILURE

  if not SDL_CreateWindowAndRenderer("examples/basic/play-multiple-sounds", MainWinWidth, MainWinHeight, SDL_WINDOW_RESIZABLE, addr window, addr renderer):
    SDL_Log_proc("Couldn't create window/renderer: %s", SDL_GetError())
    return SDL_APP_FAILURE

  if not MIX_Init():
    SDL_Log_proc("Couldn't init SDL_mixer library: %s", SDL_GetError())
    return SDL_APP_FAILURE

  # Create a mixer on the default audio device. Don't care about the specific audio format.
  mixer = MIX_CreateMixerDevice(SDL_AUDIO_DEVICE_DEFAULT_PLAYBACK, nil)
  if mixer == nil:
    SDL_Log_proc("Couldn't create mixer on default device: %s", SDL_GetError())
    return SDL_APP_FAILURE

  # Load our audio files. Note that you can use any supported file format!
  music = load_audio("../platformer/resources/platformer.mp3")
  if music == nil:
    return SDL_APP_FAILURE # We reported the error in load_audio
  sound = load_audio("jumpland.wav")
  if sound == nil:
    return SDL_APP_FAILURE # We reported the error in load_audio

  # We need a track on the mixer to play the audio. Each track has audio assigned to it, and
  # all playing tracks are mixed together for the final output.
  track1 = MIX_CreateTrack(mixer)
  if track1 == nil:
    SDL_Log_proc("Couldn't create a mixer track: %s", SDL_GetError())
    return SDL_APP_FAILURE
  discard MIX_SetTrackAudio(track1, music)

  track2 = MIX_CreateTrack(mixer)
  if track2 == nil:
    SDL_Log_proc("Couldn't create a mixer track: %s", SDL_GetError())
    return SDL_APP_FAILURE
  discard MIX_SetTrackAudio(track2, sound)

  options = SDL_CreateProperties()
  if options == 0:
    SDL_Log_proc("Couldn't create play options: %s", SDL_GetError())
    return SDL_APP_FAILURE
  discard SDL_SetNumberProperty(options, MIX_PROP_PLAY_LOOPS_NUMBER, -1) # Loop forever.

  # Start the audio playing! Music plays through once, with the sound effect playing in a loop at the same time.
  discard MIX_PlayTrack(track1, 0) # No extra options this time, so a zero for the second argument.
  discard MIX_PlayTrack(track2, options)
  SDL_DestroyProperties(options) # MIX_PlayTrack makes a copy of the options, so this can go away.

  # We don't save `music`, `sound`, or `track2`; SDL_mixer will clean them up for us during MIX_Quit().

  return SDL_APP_CONTINUE # Carry on with the program!

#-------------------
#--- SDL_AppIterate
#-------------------
proc SDL_AppIterate(appstate: pointer): SDL_AppResult {.cdecl.} =
  # Draw a blank video frame to keep the OS happy
  discard SDL_RenderClear(renderer)
  discard SDL_RenderPresent(renderer)

  # When the music has finished playing, end the program.
  if not MIX_TrackPlaying(track1):
    return SDL_APP_SUCCESS

  return SDL_APP_CONTINUE # Carry on with the program!

#-----------------
#--- SDL_AppEvent
#-----------------
proc SDL_AppEvent(appstate: pointer, event: ptr SDL_Event): SDL_AppResult {.cdecl.} =
  if event.type_field == SDL_EVENT_QUIT.uint32:
    return SDL_APP_SUCCESS # End the program, reporting success to the OS.
  return SDL_APP_CONTINUE # Carry on with the program!

#----------------
#--- SDL_AppQuit
#----------------
proc SDL_AppQuit(appstate: pointer, res: SDL_AppResult): void {.cdecl.} =
  # SDL will clean up the window/renderer for us, MIX_Quit() destroys any mixer objects we made.
  MIX_Quit()

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
