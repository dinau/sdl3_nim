SDL_VIDEO_H = SDL3/x86_64-w64-mingw32/include/SDL3/SDL_video.h
SDL3_DEFS_NIM = ../sdl3_defs.nim

all:
	nim c -r delComments .nim
	nim c -d:debug genConstFromCDefine.nim
	./genConstFromCDefine >> $(SDL3_DEFS_NIM)
