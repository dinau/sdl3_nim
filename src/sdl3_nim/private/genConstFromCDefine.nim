import std/[pegs,strutils,strformat]

const SDL_VIDEO_H = "SDL3/x86_64-w64-mingw32/include/SDL3/SDL_video.h"

var seqRes:array[2,string]
let vpeg = peg"^'#define'\s{'SDL'@\s}\s+'SDL_'@\({@}\)@$"

echo ""
for line in readfile(SDL_VIDEO_H).split("\n"):
  if contains(line, vpeg ,seqRes):
    let sConst= fmt"const {seqRes[0]}* = {seqRes[1]}'u64"
    echo sConst
