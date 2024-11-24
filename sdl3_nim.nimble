# Package

version       = "0.1.0"
author        = "dinau"
description   = "SDL3 library wrapper"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 2.0.12"
requires "nimgl == 1.3.2"
requires "stb_image == 2.5"
#requires "futhark == 0.13.7"

import strformat
let CACHE = "--nimcache:.nimcache"

# For futhark options
var OPT_GEN:string
OPT_GEN &= CACHE
OPT_GEN &= " -d:useFuthark --maxLoopIterationsVM:50000000"
OPT_GEN &= " -d:futharkRebuild"
OPT_GEN &= " -d:nodeclguards"

task gen,"Generate SDL3 definition file ":
  withdir "src":
    exec(fmt"nim c -c {OPT_GEN} sdl3_nim.nim")

task make,"Build test exexutable":
  withdir "tests":
    exec(fmt"nim c -r -d:strip test_sdl3.nim")
