import std/[pegs, strutils, strformat]

var
  seqRes:array[5,string]
  vpeg: Peg

let genScript = "Definitions added by ../private/genConstFromCDefine.nim"

#-------------
# SDL_video.h
#-------------
const SDL_VIDEO_H = "SDL3/x86_64-w64-mingw32/include/SDL3/SDL_video.h"
vpeg = peg"^'#define'\s{'SDL'@\s}\s+'SDL_'@\({@}\)@$"

echo ""
echo "#-------------"
echo "# SDL_video.h      $#" % [genScript]
echo "#-------------"
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

#-----------
# SDL_gpu.h
#-----------
const SDL_GPU_H = "SDL3/x86_64-w64-mingw32/include/SDL3/SDL_gpu.h"
vpeg = peg"^'#define'\s{'SDL_GPU'@\s+}{@}$"

echo ""
echo "#-----------"
echo "# SDL_gpu.h      $#" % [genScript]
echo "#-----------"
for line in readfile(SDL_GPU_H).split("\n"):
  if contains(line, vpeg ,seqRes):
    var sOut    =  seqRes[0].strip & "*"
    var operand =  seqRes[1].strip
    let constName = fmt"const {sOut:<45}"
    if operand.contains(peg"\({@}\)", seqRes):
      operand = seqRes[0].replace("<<", "shl").replace("1u", "1'u32")
      echo constName & fmt" = {operand}"
