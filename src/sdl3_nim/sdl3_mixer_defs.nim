import sdl3_nim

type
  struct_MIX_AudioDecoder* = object
type
  struct_MIX_Mixer* = object
type
  struct_MIX_Track* = object
type
  struct_MIX_Audio* = object
type
  struct_SDL_IOStream* = object
type
  struct_MIX_Group* = object
type
  MIX_Mixer* = struct_MIX_Mixer
  MIX_Audio* = struct_MIX_Audio
  MIX_Track* = struct_MIX_Track
  MIX_Group* = struct_MIX_Group
  struct_MIX_StereoGains* {.pure, inheritable, bycopy.} = object
    left*: cfloat
    right*: cfloat
  MIX_StereoGains* = struct_MIX_StereoGains
  struct_MIX_Point3D* {.pure, inheritable, bycopy.} = object
    x*: cfloat
    y*: cfloat
    z*: cfloat
  MIX_Point3D* = struct_MIX_Point3D
  MIX_TrackStoppedCallback* = proc (a0: pointer; a1: ptr MIX_Track): void {.
      cdecl.}
  MIX_TrackMixCallback* = proc (a0: pointer; a1: ptr MIX_Track;
                                a2: ptr SDL_AudioSpec; a3: ptr cfloat; a4: cint): void {.
      cdecl.}
  MIX_GroupMixCallback* = proc (a0: pointer; a1: ptr MIX_Group;
                                a2: ptr SDL_AudioSpec; a3: ptr cfloat; a4: cint): void {.
      cdecl.}
  MIX_PostMixCallback* = proc (a0: pointer; a1: ptr MIX_Mixer;
                               a2: ptr SDL_AudioSpec; a3: ptr cfloat; a4: cint): void {.
      cdecl.}
  MIX_AudioDecoder* = struct_MIX_AudioDecoder
when 3 is static:
  const
    SDL_MIXER_MAJOR_VERSION* = 3
else:
  let SDL_MIXER_MAJOR_VERSION* = 3
when 3 is static:
  const
    SDL_MIXER_MINOR_VERSION* = 3
else:
  let SDL_MIXER_MINOR_VERSION* = 3
when 0 is static:
  const
    SDL_MIXER_MICRO_VERSION* = 0
else:
  let SDL_MIXER_MICRO_VERSION* = 0
when "SDL_mixer.mixer.device" is static:
  const
    MIX_PROP_MIXER_DEVICE_NUMBER* = "SDL_mixer.mixer.device"
else:
  let MIX_PROP_MIXER_DEVICE_NUMBER* = "SDL_mixer.mixer.device"
when "SDL_mixer.audio.load.iostream" is static:
  const
    MIX_PROP_AUDIO_LOAD_IOSTREAM_POINTER* = "SDL_mixer.audio.load.iostream"
else:
  let MIX_PROP_AUDIO_LOAD_IOSTREAM_POINTER* = "SDL_mixer.audio.load.iostream"
when "SDL_mixer.audio.load.closeio" is static:
  const
    MIX_PROP_AUDIO_LOAD_CLOSEIO_BOOLEAN* = "SDL_mixer.audio.load.closeio"
else:
  let MIX_PROP_AUDIO_LOAD_CLOSEIO_BOOLEAN* = "SDL_mixer.audio.load.closeio"
when "SDL_mixer.audio.load.predecode" is static:
  const
    MIX_PROP_AUDIO_LOAD_PREDECODE_BOOLEAN* = "SDL_mixer.audio.load.predecode"
else:
  let MIX_PROP_AUDIO_LOAD_PREDECODE_BOOLEAN* = "SDL_mixer.audio.load.predecode"
when "SDL_mixer.audio.load.preferred_mixer" is static:
  const
    MIX_PROP_AUDIO_LOAD_PREFERRED_MIXER_POINTER* = "SDL_mixer.audio.load.preferred_mixer"
else:
  let MIX_PROP_AUDIO_LOAD_PREFERRED_MIXER_POINTER* = "SDL_mixer.audio.load.preferred_mixer"
when "SDL_mixer.audio.load.skip_metadata_tags" is static:
  const
    MIX_PROP_AUDIO_LOAD_SKIP_METADATA_TAGS_BOOLEAN* = "SDL_mixer.audio.load.skip_metadata_tags"
else:
  let MIX_PROP_AUDIO_LOAD_SKIP_METADATA_TAGS_BOOLEAN* = "SDL_mixer.audio.load.skip_metadata_tags"
when "SDL_mixer.audio.load.ignore_loops" is static:
  const
    MIX_PROP_AUDIO_LOAD_IGNORE_LOOPS_BOOLEAN* = "SDL_mixer.audio.load.ignore_loops"
else:
  let MIX_PROP_AUDIO_LOAD_IGNORE_LOOPS_BOOLEAN* = "SDL_mixer.audio.load.ignore_loops"
when "SDL_mixer.audio.decoder" is static:
  const
    MIX_PROP_AUDIO_DECODER_STRING* = "SDL_mixer.audio.decoder"
else:
  let MIX_PROP_AUDIO_DECODER_STRING* = "SDL_mixer.audio.decoder"
when "SDL_mixer.metadata.title" is static:
  const
    MIX_PROP_METADATA_TITLE_STRING* = "SDL_mixer.metadata.title"
else:
  let MIX_PROP_METADATA_TITLE_STRING* = "SDL_mixer.metadata.title"
when "SDL_mixer.metadata.artist" is static:
  const
    MIX_PROP_METADATA_ARTIST_STRING* = "SDL_mixer.metadata.artist"
else:
  let MIX_PROP_METADATA_ARTIST_STRING* = "SDL_mixer.metadata.artist"
when "SDL_mixer.metadata.album" is static:
  const
    MIX_PROP_METADATA_ALBUM_STRING* = "SDL_mixer.metadata.album"
else:
  let MIX_PROP_METADATA_ALBUM_STRING* = "SDL_mixer.metadata.album"
when "SDL_mixer.metadata.copyright" is static:
  const
    MIX_PROP_METADATA_COPYRIGHT_STRING* = "SDL_mixer.metadata.copyright"
else:
  let MIX_PROP_METADATA_COPYRIGHT_STRING* = "SDL_mixer.metadata.copyright"
when "SDL_mixer.metadata.track" is static:
  const
    MIX_PROP_METADATA_TRACK_NUMBER* = "SDL_mixer.metadata.track"
else:
  let MIX_PROP_METADATA_TRACK_NUMBER* = "SDL_mixer.metadata.track"
when "SDL_mixer.metadata.total_tracks" is static:
  const
    MIX_PROP_METADATA_TOTAL_TRACKS_NUMBER* = "SDL_mixer.metadata.total_tracks"
else:
  let MIX_PROP_METADATA_TOTAL_TRACKS_NUMBER* = "SDL_mixer.metadata.total_tracks"
when "SDL_mixer.metadata.year" is static:
  const
    MIX_PROP_METADATA_YEAR_NUMBER* = "SDL_mixer.metadata.year"
else:
  let MIX_PROP_METADATA_YEAR_NUMBER* = "SDL_mixer.metadata.year"
when "SDL_mixer.metadata.duration_frames" is static:
  const
    MIX_PROP_METADATA_DURATION_FRAMES_NUMBER* = "SDL_mixer.metadata.duration_frames"
else:
  let MIX_PROP_METADATA_DURATION_FRAMES_NUMBER* = "SDL_mixer.metadata.duration_frames"
when "SDL_mixer.metadata.duration_infinite" is static:
  const
    MIX_PROP_METADATA_DURATION_INFINITE_BOOLEAN* = "SDL_mixer.metadata.duration_infinite"
else:
  let MIX_PROP_METADATA_DURATION_INFINITE_BOOLEAN* = "SDL_mixer.metadata.duration_infinite"
when -1 is static:
  const
    MIX_DURATION_UNKNOWN* = -1
else:
  let MIX_DURATION_UNKNOWN* = -1
when -2 is static:
  const
    MIX_DURATION_INFINITE* = -2
else:
  let MIX_DURATION_INFINITE* = -2
when "SDL_mixer.play.loops" is static:
  const
    MIX_PROP_PLAY_LOOPS_NUMBER* = "SDL_mixer.play.loops"
else:
  let MIX_PROP_PLAY_LOOPS_NUMBER* = "SDL_mixer.play.loops"
when "SDL_mixer.play.max_frame" is static:
  const
    MIX_PROP_PLAY_MAX_FRAME_NUMBER* = "SDL_mixer.play.max_frame"
else:
  let MIX_PROP_PLAY_MAX_FRAME_NUMBER* = "SDL_mixer.play.max_frame"
when "SDL_mixer.play.max_milliseconds" is static:
  const
    MIX_PROP_PLAY_MAX_MILLISECONDS_NUMBER* = "SDL_mixer.play.max_milliseconds"
else:
  let MIX_PROP_PLAY_MAX_MILLISECONDS_NUMBER* = "SDL_mixer.play.max_milliseconds"
when "SDL_mixer.play.start_frame" is static:
  const
    MIX_PROP_PLAY_START_FRAME_NUMBER* = "SDL_mixer.play.start_frame"
else:
  let MIX_PROP_PLAY_START_FRAME_NUMBER* = "SDL_mixer.play.start_frame"
when "SDL_mixer.play.start_millisecond" is static:
  const
    MIX_PROP_PLAY_START_MILLISECOND_NUMBER* = "SDL_mixer.play.start_millisecond"
else:
  let MIX_PROP_PLAY_START_MILLISECOND_NUMBER* = "SDL_mixer.play.start_millisecond"
when "SDL_mixer.play.start_order" is static:
  const
    MIX_PROP_PLAY_START_ORDER_NUMBER* = "SDL_mixer.play.start_order"
else:
  let MIX_PROP_PLAY_START_ORDER_NUMBER* = "SDL_mixer.play.start_order"
when "SDL_mixer.play.loop_start_frame" is static:
  const
    MIX_PROP_PLAY_LOOP_START_FRAME_NUMBER* = "SDL_mixer.play.loop_start_frame"
else:
  let MIX_PROP_PLAY_LOOP_START_FRAME_NUMBER* = "SDL_mixer.play.loop_start_frame"
when "SDL_mixer.play.loop_start_millisecond" is static:
  const
    MIX_PROP_PLAY_LOOP_START_MILLISECOND_NUMBER* = "SDL_mixer.play.loop_start_millisecond"
else:
  let MIX_PROP_PLAY_LOOP_START_MILLISECOND_NUMBER* = "SDL_mixer.play.loop_start_millisecond"
when "SDL_mixer.play.fade_in_frames" is static:
  const
    MIX_PROP_PLAY_FADE_IN_FRAMES_NUMBER* = "SDL_mixer.play.fade_in_frames"
else:
  let MIX_PROP_PLAY_FADE_IN_FRAMES_NUMBER* = "SDL_mixer.play.fade_in_frames"
when "SDL_mixer.play.fade_in_milliseconds" is static:
  const
    MIX_PROP_PLAY_FADE_IN_MILLISECONDS_NUMBER* = "SDL_mixer.play.fade_in_milliseconds"
else:
  let MIX_PROP_PLAY_FADE_IN_MILLISECONDS_NUMBER* = "SDL_mixer.play.fade_in_milliseconds"
when "SDL_mixer.play.fade_in_start_gain" is static:
  const
    MIX_PROP_PLAY_FADE_IN_START_GAIN_FLOAT* = "SDL_mixer.play.fade_in_start_gain"
else:
  let MIX_PROP_PLAY_FADE_IN_START_GAIN_FLOAT* = "SDL_mixer.play.fade_in_start_gain"
when "SDL_mixer.play.append_silence_frames" is static:
  const
    MIX_PROP_PLAY_APPEND_SILENCE_FRAMES_NUMBER* = "SDL_mixer.play.append_silence_frames"
else:
  let MIX_PROP_PLAY_APPEND_SILENCE_FRAMES_NUMBER* = "SDL_mixer.play.append_silence_frames"
when "SDL_mixer.play.append_silence_milliseconds" is static:
  const
    MIX_PROP_PLAY_APPEND_SILENCE_MILLISECONDS_NUMBER* = "SDL_mixer.play.append_silence_milliseconds"
else:
  let MIX_PROP_PLAY_APPEND_SILENCE_MILLISECONDS_NUMBER* = "SDL_mixer.play.append_silence_milliseconds"
when "SDL_mixer.play.halt_when_exhausted" is static:
  const
    MIX_PROP_PLAY_HALT_WHEN_EXHAUSTED_BOOLEAN* = "SDL_mixer.play.halt_when_exhausted"
else:
  let MIX_PROP_PLAY_HALT_WHEN_EXHAUSTED_BOOLEAN* = "SDL_mixer.play.halt_when_exhausted"
proc MIX_Version*(): cint {.cdecl, importc: "MIX_Version".}
proc MIX_Init*(): bool {.cdecl, importc: "MIX_Init".}
proc MIX_Quit*(): void {.cdecl, importc: "MIX_Quit".}
proc MIX_GetNumAudioDecoders*(): cint {.cdecl,
                                        importc: "MIX_GetNumAudioDecoders".}
proc MIX_GetAudioDecoder*(index: cint): cstring {.cdecl,
    importc: "MIX_GetAudioDecoder".}
proc MIX_CreateMixerDevice*(devid: SDL_AudioDeviceID; spec: ptr SDL_AudioSpec): ptr MIX_Mixer {.
    cdecl, importc: "MIX_CreateMixerDevice".}
proc MIX_CreateMixer*(spec: ptr SDL_AudioSpec): ptr MIX_Mixer {.cdecl,
    importc: "MIX_CreateMixer".}
proc MIX_DestroyMixer*(mixer: ptr MIX_Mixer): void {.cdecl,
    importc: "MIX_DestroyMixer".}
proc MIX_GetMixerProperties*(mixer: ptr MIX_Mixer): SDL_PropertiesID {.cdecl,
    importc: "MIX_GetMixerProperties".}
proc MIX_GetMixerFormat*(mixer: ptr MIX_Mixer; spec: ptr SDL_AudioSpec): bool {.
    cdecl, importc: "MIX_GetMixerFormat".}
proc MIX_LockMixer*(mixer: ptr MIX_Mixer): void {.cdecl,
    importc: "MIX_LockMixer".}
proc MIX_UnlockMixer*(mixer: ptr MIX_Mixer): void {.cdecl,
    importc: "MIX_UnlockMixer".}
proc MIX_LoadAudio_IO*(mixer: ptr MIX_Mixer; io: ptr SDL_IOStream;
                       predecode: bool; closeio: bool): ptr MIX_Audio {.cdecl,
    importc: "MIX_LoadAudio_IO".}
proc MIX_LoadAudio*(mixer: ptr MIX_Mixer; path: cstring; predecode: bool): ptr MIX_Audio {.
    cdecl, importc: "MIX_LoadAudio".}
proc MIX_LoadAudioNoCopy*(mixer: ptr MIX_Mixer; data: pointer; datalen: csize_t;
                          free_when_done: bool): ptr MIX_Audio {.cdecl,
    importc: "MIX_LoadAudioNoCopy".}
proc MIX_LoadAudioWithProperties*(props: SDL_PropertiesID): ptr MIX_Audio {.
    cdecl, importc: "MIX_LoadAudioWithProperties".}
proc MIX_LoadRawAudio_IO*(mixer: ptr MIX_Mixer; io: ptr SDL_IOStream;
                          spec: ptr SDL_AudioSpec; closeio: bool): ptr MIX_Audio {.
    cdecl, importc: "MIX_LoadRawAudio_IO".}
proc MIX_LoadRawAudio*(mixer: ptr MIX_Mixer; data: pointer; datalen: csize_t;
                       spec: ptr SDL_AudioSpec): ptr MIX_Audio {.cdecl,
    importc: "MIX_LoadRawAudio".}
proc MIX_LoadRawAudioNoCopy*(mixer: ptr MIX_Mixer; data: pointer;
                             datalen: csize_t; spec: ptr SDL_AudioSpec;
                             free_when_done: bool): ptr MIX_Audio {.cdecl,
    importc: "MIX_LoadRawAudioNoCopy".}
proc MIX_CreateSineWaveAudio*(mixer: ptr MIX_Mixer; hz: cint; amplitude: cfloat;
                              ms: Sint64): ptr MIX_Audio {.cdecl,
    importc: "MIX_CreateSineWaveAudio".}
proc MIX_GetAudioProperties*(audio: ptr MIX_Audio): SDL_PropertiesID {.cdecl,
    importc: "MIX_GetAudioProperties".}
proc MIX_GetAudioDuration*(audio: ptr MIX_Audio): Sint64 {.cdecl,
    importc: "MIX_GetAudioDuration".}
proc MIX_GetAudioFormat*(audio: ptr MIX_Audio; spec: ptr SDL_AudioSpec): bool {.
    cdecl, importc: "MIX_GetAudioFormat".}
proc MIX_DestroyAudio*(audio: ptr MIX_Audio): void {.cdecl,
    importc: "MIX_DestroyAudio".}
proc MIX_CreateTrack*(mixer: ptr MIX_Mixer): ptr MIX_Track {.cdecl,
    importc: "MIX_CreateTrack".}
proc MIX_DestroyTrack*(track: ptr MIX_Track): void {.cdecl,
    importc: "MIX_DestroyTrack".}
proc MIX_GetTrackProperties*(track: ptr MIX_Track): SDL_PropertiesID {.cdecl,
    importc: "MIX_GetTrackProperties".}
proc MIX_GetTrackMixer*(track: ptr MIX_Track): ptr MIX_Mixer {.cdecl,
    importc: "MIX_GetTrackMixer".}
proc MIX_SetTrackAudio*(track: ptr MIX_Track; audio: ptr MIX_Audio): bool {.
    cdecl, importc: "MIX_SetTrackAudio".}
proc MIX_SetTrackAudioStream*(track: ptr MIX_Track; stream: ptr SDL_AudioStream): bool {.
    cdecl, importc: "MIX_SetTrackAudioStream".}
proc MIX_SetTrackIOStream*(track: ptr MIX_Track; io: ptr SDL_IOStream;
                           closeio: bool): bool {.cdecl,
    importc: "MIX_SetTrackIOStream".}
proc MIX_SetTrackRawIOStream*(track: ptr MIX_Track; io: ptr SDL_IOStream;
                              spec: ptr SDL_AudioSpec; closeio: bool): bool {.
    cdecl, importc: "MIX_SetTrackRawIOStream".}
proc MIX_TagTrack*(track: ptr MIX_Track; tag: cstring): bool {.cdecl,
    importc: "MIX_TagTrack".}
proc MIX_UntagTrack*(track: ptr MIX_Track; tag: cstring): void {.cdecl,
    importc: "MIX_UntagTrack".}
proc MIX_GetTrackTags*(track: ptr MIX_Track; count: ptr cint): ptr cstring {.
    cdecl, importc: "MIX_GetTrackTags".}
proc MIX_GetTaggedTracks*(mixer: ptr MIX_Mixer; tag: cstring; count: ptr cint): ptr ptr MIX_Track {.
    cdecl, importc: "MIX_GetTaggedTracks".}
proc MIX_SetTrackPlaybackPosition*(track: ptr MIX_Track; frames: Sint64): bool {.
    cdecl, importc: "MIX_SetTrackPlaybackPosition".}
proc MIX_GetTrackPlaybackPosition*(track: ptr MIX_Track): Sint64 {.cdecl,
    importc: "MIX_GetTrackPlaybackPosition".}
proc MIX_GetTrackFadeFrames*(track: ptr MIX_Track): Sint64 {.cdecl,
    importc: "MIX_GetTrackFadeFrames".}
proc MIX_GetTrackLoops*(track: ptr MIX_Track): cint {.cdecl,
    importc: "MIX_GetTrackLoops".}
proc MIX_SetTrackLoops*(track: ptr MIX_Track; num_loops: cint): bool {.cdecl,
    importc: "MIX_SetTrackLoops".}
proc MIX_GetTrackAudio*(track: ptr MIX_Track): ptr MIX_Audio {.cdecl,
    importc: "MIX_GetTrackAudio".}
proc MIX_GetTrackAudioStream*(track: ptr MIX_Track): ptr SDL_AudioStream {.
    cdecl, importc: "MIX_GetTrackAudioStream".}
proc MIX_GetTrackRemaining*(track: ptr MIX_Track): Sint64 {.cdecl,
    importc: "MIX_GetTrackRemaining".}
proc MIX_TrackMSToFrames*(track: ptr MIX_Track; ms: Sint64): Sint64 {.cdecl,
    importc: "MIX_TrackMSToFrames".}
proc MIX_TrackFramesToMS*(track: ptr MIX_Track; frames: Sint64): Sint64 {.cdecl,
    importc: "MIX_TrackFramesToMS".}
proc MIX_AudioMSToFrames*(audio: ptr MIX_Audio; ms: Sint64): Sint64 {.cdecl,
    importc: "MIX_AudioMSToFrames".}
proc MIX_AudioFramesToMS*(audio: ptr MIX_Audio; frames: Sint64): Sint64 {.cdecl,
    importc: "MIX_AudioFramesToMS".}
proc MIX_MSToFrames*(sample_rate: cint; ms: Sint64): Sint64 {.cdecl,
    importc: "MIX_MSToFrames".}
proc MIX_FramesToMS*(sample_rate: cint; frames: Sint64): Sint64 {.cdecl,
    importc: "MIX_FramesToMS".}
proc MIX_PlayTrack*(track: ptr MIX_Track; options: SDL_PropertiesID): bool {.
    cdecl, importc: "MIX_PlayTrack".}
proc MIX_PlayTag*(mixer: ptr MIX_Mixer; tag: cstring; options: SDL_PropertiesID): bool {.
    cdecl, importc: "MIX_PlayTag".}
proc MIX_PlayAudio*(mixer: ptr MIX_Mixer; audio: ptr MIX_Audio): bool {.cdecl,
    importc: "MIX_PlayAudio".}
proc MIX_StopTrack*(track: ptr MIX_Track; fade_out_frames: Sint64): bool {.
    cdecl, importc: "MIX_StopTrack".}
proc MIX_StopAllTracks*(mixer: ptr MIX_Mixer; fade_out_ms: Sint64): bool {.
    cdecl, importc: "MIX_StopAllTracks".}
proc MIX_StopTag*(mixer: ptr MIX_Mixer; tag: cstring; fade_out_ms: Sint64): bool {.
    cdecl, importc: "MIX_StopTag".}
proc MIX_PauseTrack*(track: ptr MIX_Track): bool {.cdecl,
    importc: "MIX_PauseTrack".}
proc MIX_PauseAllTracks*(mixer: ptr MIX_Mixer): bool {.cdecl,
    importc: "MIX_PauseAllTracks".}
proc MIX_PauseTag*(mixer: ptr MIX_Mixer; tag: cstring): bool {.cdecl,
    importc: "MIX_PauseTag".}
proc MIX_ResumeTrack*(track: ptr MIX_Track): bool {.cdecl,
    importc: "MIX_ResumeTrack".}
proc MIX_ResumeAllTracks*(mixer: ptr MIX_Mixer): bool {.cdecl,
    importc: "MIX_ResumeAllTracks".}
proc MIX_ResumeTag*(mixer: ptr MIX_Mixer; tag: cstring): bool {.cdecl,
    importc: "MIX_ResumeTag".}
proc MIX_TrackPlaying*(track: ptr MIX_Track): bool {.cdecl,
    importc: "MIX_TrackPlaying".}
proc MIX_TrackPaused*(track: ptr MIX_Track): bool {.cdecl,
    importc: "MIX_TrackPaused".}
proc MIX_SetMixerGain*(mixer: ptr MIX_Mixer; gain: cfloat): bool {.cdecl,
    importc: "MIX_SetMixerGain".}
proc MIX_GetMixerGain*(mixer: ptr MIX_Mixer): cfloat {.cdecl,
    importc: "MIX_GetMixerGain".}
proc MIX_SetTrackGain*(track: ptr MIX_Track; gain: cfloat): bool {.cdecl,
    importc: "MIX_SetTrackGain".}
proc MIX_GetTrackGain*(track: ptr MIX_Track): cfloat {.cdecl,
    importc: "MIX_GetTrackGain".}
proc MIX_SetTagGain*(mixer: ptr MIX_Mixer; tag: cstring; gain: cfloat): bool {.
    cdecl, importc: "MIX_SetTagGain".}
proc MIX_SetMixerFrequencyRatio*(mixer: ptr MIX_Mixer; ratio: cfloat): bool {.
    cdecl, importc: "MIX_SetMixerFrequencyRatio".}
proc MIX_GetMixerFrequencyRatio*(mixer: ptr MIX_Mixer): cfloat {.cdecl,
    importc: "MIX_GetMixerFrequencyRatio".}
proc MIX_SetTrackFrequencyRatio*(track: ptr MIX_Track; ratio: cfloat): bool {.
    cdecl, importc: "MIX_SetTrackFrequencyRatio".}
proc MIX_GetTrackFrequencyRatio*(track: ptr MIX_Track): cfloat {.cdecl,
    importc: "MIX_GetTrackFrequencyRatio".}
proc MIX_SetTrackOutputChannelMap*(track: ptr MIX_Track; chmap: ptr cint;
                                   count: cint): bool {.cdecl,
    importc: "MIX_SetTrackOutputChannelMap".}
proc MIX_SetTrackStereo*(track: ptr MIX_Track; gains: ptr MIX_StereoGains): bool {.
    cdecl, importc: "MIX_SetTrackStereo".}
proc MIX_SetTrack3DPosition*(track: ptr MIX_Track; position: ptr MIX_Point3D): bool {.
    cdecl, importc: "MIX_SetTrack3DPosition".}
proc MIX_GetTrack3DPosition*(track: ptr MIX_Track; position: ptr MIX_Point3D): bool {.
    cdecl, importc: "MIX_GetTrack3DPosition".}
proc MIX_CreateGroup*(mixer: ptr MIX_Mixer): ptr MIX_Group {.cdecl,
    importc: "MIX_CreateGroup".}
proc MIX_DestroyGroup*(group: ptr MIX_Group): void {.cdecl,
    importc: "MIX_DestroyGroup".}
proc MIX_GetGroupProperties*(group: ptr MIX_Group): SDL_PropertiesID {.cdecl,
    importc: "MIX_GetGroupProperties".}
proc MIX_GetGroupMixer*(group: ptr MIX_Group): ptr MIX_Mixer {.cdecl,
    importc: "MIX_GetGroupMixer".}
proc MIX_SetTrackGroup*(track: ptr MIX_Track; group: ptr MIX_Group): bool {.
    cdecl, importc: "MIX_SetTrackGroup".}
proc MIX_SetTrackStoppedCallback*(track: ptr MIX_Track;
                                  cb: MIX_TrackStoppedCallback;
                                  userdata: pointer): bool {.cdecl,
    importc: "MIX_SetTrackStoppedCallback".}
proc MIX_SetTrackRawCallback*(track: ptr MIX_Track; cb: MIX_TrackMixCallback;
                              userdata: pointer): bool {.cdecl,
    importc: "MIX_SetTrackRawCallback".}
proc MIX_SetTrackCookedCallback*(track: ptr MIX_Track; cb: MIX_TrackMixCallback;
                                 userdata: pointer): bool {.cdecl,
    importc: "MIX_SetTrackCookedCallback".}
proc MIX_SetGroupPostMixCallback*(group: ptr MIX_Group;
                                  cb: MIX_GroupMixCallback; userdata: pointer): bool {.
    cdecl, importc: "MIX_SetGroupPostMixCallback".}
proc MIX_SetPostMixCallback*(mixer: ptr MIX_Mixer; cb: MIX_PostMixCallback;
                             userdata: pointer): bool {.cdecl,
    importc: "MIX_SetPostMixCallback".}
proc MIX_Generate*(mixer: ptr MIX_Mixer; buffer: pointer; buflen: cint): cint {.
    cdecl, importc: "MIX_Generate".}
proc MIX_CreateAudioDecoder*(path: cstring; props: SDL_PropertiesID): ptr MIX_AudioDecoder {.
    cdecl, importc: "MIX_CreateAudioDecoder".}
proc MIX_CreateAudioDecoder_IO*(io: ptr SDL_IOStream; closeio: bool;
                                props: SDL_PropertiesID): ptr MIX_AudioDecoder {.
    cdecl, importc: "MIX_CreateAudioDecoder_IO".}
proc MIX_DestroyAudioDecoder*(audiodecoder: ptr MIX_AudioDecoder): void {.cdecl,
    importc: "MIX_DestroyAudioDecoder".}
proc MIX_GetAudioDecoderProperties*(audiodecoder: ptr MIX_AudioDecoder): SDL_PropertiesID {.
    cdecl, importc: "MIX_GetAudioDecoderProperties".}
proc MIX_GetAudioDecoderFormat*(audiodecoder: ptr MIX_AudioDecoder;
                                spec: ptr SDL_AudioSpec): bool {.cdecl,
    importc: "MIX_GetAudioDecoderFormat".}
proc MIX_DecodeAudio*(audiodecoder: ptr MIX_AudioDecoder; buffer: pointer;
                      buflen: cint; spec: ptr SDL_AudioSpec): cint {.cdecl,
    importc: "MIX_DecodeAudio".}


#---------------------
# sdl3_mixer_post.nim
#---------------------
const SDL_AUDIO_MASK_BITSIZE*: cuint = (0xFF'u32)
const SDL_AUDIO_MASK_FLOAT*: cuint = (1'u32 shl 8)
const SDL_AUDIO_MASK_BIG_ENDIAN*: cuint = (1'u32 shl 12)
const SDL_AUDIO_MASK_SIGNED*: cuint = (1'u32 shl 15)

template SDL_DEFINE_AUDIO_FORMAT*(signed, bigendian, flt, size): uint16 =
    (((Uint16)(signed) shl 15) or ((Uint16)(bigendian) shl 12) or ((Uint16)(flt) shl 8) or ((size) and SDL_AUDIO_MASK_BITSIZE))

template SDL_AUDIO_BITSIZE*(x): cuint = ((x) & SDL_AUDIO_MASK_BITSIZE)
template SDL_AUDIO_BYTESIZE*(x): cuint = (SDL_AUDIO_BITSIZE(x) / 8)
template SDL_AUDIO_ISFLOAT*(x): bool = (0 != ((x) and SDL_AUDIO_MASK_FLOAT))
template SDL_AUDIO_ISBIGENDIAN*(x): bool = (0 != ((x) and SDL_AUDIO_MASK_BIG_ENDIAN))
template SDL_AUDIO_ISLITTLEENDIAN*(x): bool = (0 != (not SDL_AUDIO_ISBIGENDIAN(x)))
template SDL_AUDIO_ISSIGNED*(x): bool = (0 != ((x) and SDL_AUDIO_MASK_SIGNED))
template SDL_AUDIO_ISINT*(x): bool = (0 != (not SDL_AUDIO_ISFLOAT(x)))
template SDL_AUDIO_ISUNSIGNED*(x): bool = (0 != (not SDL_AUDIO_ISSIGNED(x)))
template SDL_AUDIO_DEVICE_DEFAULT_PLAYBACK*: cuint = ((SDL_AudioDeviceID)0xFFFFFFFF'u32)
template SDL_AUDIO_DEVICE_DEFAULT_RECORDING*: cuint = ((SDL_AudioDeviceID)0xFFFFFFFE'u32)
template SDL_AUDIO_FRAMESIZE*(x): cuint = (SDL_AUDIO_BYTESIZE((x).format) * (x).channels)

const SDL_PROP_AUDIOSTREAM_AUTO_CLEANUP_BOOLEAN* = "SDL.audiostream.auto_cleanup"




