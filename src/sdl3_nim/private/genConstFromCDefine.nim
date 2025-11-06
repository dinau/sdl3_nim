import std/[pegs,strutils,strformat]

const SDL_VIDEO_H = "SDL3/x86_64-w64-mingw32/include/SDL3/SDL_video.h"

var seqRes:array[2,string]
let vpeg = peg"^'#define'\s{'SDL'@\s}\s+'SDL_'@\({@}\)@$"

echo ""
for line in readfile(SDL_VIDEO_H).split("\n"):
  if contains(line, vpeg ,seqRes):
    let sOut = seqRes[0].strip & "*"
    let sConst= fmt"const {sOut:<33} = {seqRes[1]}'u64"
    echo sConst
  if contains(line,"SDL_WINDOW_NOT_FOCUSABLE"):
    break


echo """

const SDL_WINDOWPOS_UNDEFINED* = 0x1FFF0000'u64
const SDL_WINDOWPOS_CENTERED*  = 0x2FFF0000'u64
"""
