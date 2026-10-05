
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
