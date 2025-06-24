import std/[strformat]
import sdl3_nim

import stb_image/read as stbi

#--- Forawrd definition
proc SDL_CreateRGBSurfaceFrom(pixels: pointer , width:int, height:int , depth:int, pitch:int , Rmask: uint32, Gmask:uint32, Bmask:uint32, Amask:uint32): ptr SDL_Surface

#---------------------
# loadTextureFromFile
#---------------------
proc loadTextureFromFile*(filename: string, renderer: ptr SDL_Renderer, outTexture: var ptr SDL_Texture, outWidth: var int, outHeight: var int): bool =
  var channels: int
  var image_data: seq[byte]
  try:
    image_data = stbi.load(filename, outWidth, outHeight, channels, 0)
  except STBIException as e:
    echo fmt"{e.msg}: {filename}"
    quit 1

  var surface = SDL_CreateRGBSurfaceFrom(cast[pointer](addr image_data[0])
                                       , outWidth, outHeight
                                       , channels * 8
                                       , channels * outWidth
                                       , 0x000000ff'u32, 0x0000ff00'u32, 0x00ff0000'u32, 0xff000000'u32)
  if isNil surface:
    echo "Error!: SDL_CreateRGBSurfaceFrom() in loadImage.nim"
    return false
  defer: SDL_DestroySurface(surface)

  outTexture = SDL_CreateTextureFromSurface(renderer, surface)
  if isNil outTexture:
    echo "Error!: SDL_CreateTextureFromSurface() in loadImage.nim"
    return false
  return true

#----------------------
# SDL_CreateRGBSurface      # For Compatibility with SDL2
#----------------------
proc SDL_CreateRGBSurfaceFrom(pixels: pointer , width:int, height:int , depth:int, pitch:int , Rmask: uint32, Gmask:uint32, Bmask:uint32, Amask:uint32): ptr SDL_Surface =
  return SDL_CreateSurfaceFrom(width.cint, height.cint,
          SDL_GetPixelFormatForMasks(depth.cint, Rmask, Gmask, Bmask, Amask),
          pixels, pitch.cint)
