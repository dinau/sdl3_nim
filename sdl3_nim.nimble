# Package

version       = "3.4.18.0"
author        = "dinau"
description   = "SDL3 library wrapper"
license       = "MIT"
srcDir        = "src"
skipDirs = @["src/sdl3_nim/private","examples"]


# Dependencies

requires "nim >= 2.0.16"
requires "basic2d"
#requires "futhark == 0.16.0"

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
    exec("rm -fr .nimcache")
    exec(fmt"nim c -c {OPT_GEN} sdl3_nim.nim")
    #exec(fmt"nim c -c {OPT_GEN} sdl3_ttf_nim.nim")
    #exec(fmt"nim c -c {OPT_GEN} sdl3_image_nim.nim")
    #exec(fmt"nim c -c {OPT_GEN} sdl3_mixer_nim.nim")
    withdir "sdl3_nim/private":
      exec("make")
