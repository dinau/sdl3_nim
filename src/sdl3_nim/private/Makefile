SDL_VIDEO_H   = SDL3/x86_64-w64-mingw32/include/SDL3/SDL_video.h
SDL3_DEFS_NIM = ../sdl3_defs.nim
SDL3_TTF_DEFS_NIM = ../sdl3_ttf_defs.nim
SDL3_IMAGE_DEFS_NIM = ../sdl3_image_defs.nim
# Mixer
SDL3_MIXER_DEFS_NIM = ../sdl3_mixer_defs.nim
SDL3_MIXER_POST_NIM = ./sdl3_mixer_post.nim

all: run fmt

run:
	nim c -r delComments.nim  $(SDL3_DEFS_NIM)
	nim c -r delComments.nim  $(SDL3_TTF_DEFS_NIM)
	nim c -r delComments.nim  $(SDL3_IMAGE_DEFS_NIM)
	nim c -r delComments.nim  $(SDL3_MIXER_DEFS_NIM)
	nim c genConstFromCDefine.nim
	./genConstFromCDefine >> $(SDL3_DEFS_NIM)
	#cat $(SDL3_MIXER_POST_NIM) >> $(SDL3_MIXER_DEFS_NIM)


fmt:
	nimpretty --maxLineLen:1000 $(SDL3_DEFS_NIM)
	nimpretty --maxLineLen:1000 $(SDL3_MIXER_POST_NIM)
