# Check version between SDL3 and *.nimble

import std/[strutils, strformat]

let fSdlRevison = "src/sdl3_nim/private/SDL3/x86_64-w64-mingw32/include/SDL3/SDL_revision.h"
let fNimble     = "sdl3_nim.nimble"

proc getSdlVer(): string =
  for line in readFile(fSdlRevison).splitLines():
    if line.contains("#define SDL_REVISION "):
      result = line.split("SDL-release-")[1].split("-")[0]
      break

proc getNimbleVer(): string =
  for line in readFile(fNimble).splitLines():
    if line.contains("version"):
      result = line.split("\"")[1]
      break

proc main() =
  let sdlVer = getSdlVer()
  let nimbleVer = getNimbleVer()
  let nimbleVerStd = nimbleVer[0..^(2 + 1)]
  echo    "==================================="
  echo fmt"SDL             : {sdlVer}"
  echo fmt"{fNimble} : {nimbleVerStd} ({nimbleVer})"
  assert nimbleVerStd == sdlVer, "[Error: Nimble version error !]"
  echo fmt"OK: Version check"
  echo    "==================================="

main()
