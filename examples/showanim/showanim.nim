# Refer to
#     https://github.com/libsdl-org/SDL_image/blob/main/examples/showanim.c

#[
  showanim:  A test application for the SDL image loading library.
  Copyright (C) 1997-2026 Sam Lantinga <slouken@libsdl.org>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
]#

import std/os
import sdl3_nim, sdl3_image_nim

## Draw a Gimpish background pattern to show transparency in the image
proc draw_background(renderer: ptr SDL_Renderer) =
  const col = [
    SDL_Color(r: 0x66, g: 0x66, b: 0x66, a: 0xff),
    SDL_Color(r: 0x99, g: 0x99, b: 0x99, a: 0xff)
  ]
  const dx = 8
  const dy = 8
  var rect: SDL_FRect
  var w, h: cint

  discard SDL_GetCurrentRenderOutputSize(renderer, addr w, addr h)

  rect.w = cfloat(dx)
  rect.h = cfloat(dy)
  var y = 0
  while y < int(h):
    var x = 0
    while x < int(w):
      # use an 8x8 checkerboard pattern
      let i = ((x xor y) shr 3) and 1
      discard SDL_SetRenderDrawColor(renderer, col[i].r, col[i].g, col[i].b, col[i].a)

      rect.x = cfloat(x)
      rect.y = cfloat(y)
      discard SDL_RenderFillRect(renderer, addr rect)
      x += dx
    y += dy

proc get_file_path(file: string): string =
  if file.len > 0 and file[0] != '/' and not SDL_GetPathInfo(file.cstring, nil):
    let base = SDL_GetBasePath()
    let path = (if base == nil: "" else: $base) & file
    if SDL_GetPathInfo(path.cstring, nil):
      return path
  return file

proc main(): int =
  var
    window: ptr SDL_Window
    renderer: ptr SDL_Renderer
    anim: ptr IMG_Animation
    textures: seq[ptr SDL_Texture]
    flags: uint64
    w, h: int
    done: bool
    once = false
    played = 0
    loop_count = 0
    current_frame, delay: int
    event: SDL_Event
    saveFile = ""

  var argv: seq[string] = @[getAppFilename()]
  for i in 1 .. paramCount():
    argv.add paramStr(i)
  argv.add ""

  # Check command line usage
  if argv[1] == "":
    SDL_Log_proc("Usage: %s [-fullscreen] [-save file] <image_file> ...\n", argv[0].cstring)
    return 1

  flags = SDL_WINDOW_HIDDEN
  var i = 1
  while argv[i] != "":
    if argv[i] == "-fullscreen":
      discard SDL_HideCursor()
      flags = flags or SDL_WINDOW_FULLSCREEN
    inc i

  if not SDL_Init(SDL_INIT_VIDEO):
    SDL_Log_proc("SDL_Init(SDL_INIT_VIDEO) failed: %s\n", SDL_GetError())
    return 2

  if not SDL_CreateWindowAndRenderer("animation demo", 0, 0, flags,
                                     addr window, addr renderer):
    SDL_Log_proc("SDL_CreateWindowAndRenderer() failed: %s\n", SDL_GetError())
    return 2

  i = 1
  while argv[i] != "":
    block body:
      if argv[i] == "-fullscreen":
        break body

      if argv[i] == "-once":
        once = true
        break body

      if argv[i] == "-save" and argv[i + 1] != "":
        inc i
        saveFile = argv[i]
        break body

      # Open the image file
      anim = IMG_LoadAnimation(get_file_path(argv[i]).cstring)
      if anim == nil:
        SDL_Log_proc("Couldn't load %s: %s\n", argv[i].cstring, SDL_GetError())
        break body
      loop_count = int(SDL_GetNumberProperty(SDL_GetSurfaceProperties(anim.frames[0]), IMG_PROP_METADATA_LOOP_COUNT_NUMBER, -1))
      w = int(anim.w)
      h = int(anim.h)

      if saveFile != "":
        if not IMG_SaveAnimation(anim, saveFile.cstring):
          SDL_Log_proc("Couldn't save animation: %s", SDL_GetError())

      textures = newSeq[ptr SDL_Texture](anim.count)
      for j in 0 ..< int(anim.count):
        textures[j] = SDL_CreateTextureFromSurface(renderer, anim.frames[j])
      played = 0
      current_frame = 0

      # Show the window
      discard SDL_SetWindowTitle(window, argv[i].cstring)
      discard SDL_SetWindowSize(window, cint(w), cint(h))
      discard SDL_ShowWindow(window)

      done = false
      while not done:
        while SDL_PollEvent(addr event):
          let t = event.key.type_field
          if t == SDL_EVENT_KEY_UP:
            let key = event.key.key
            if key == SDLK_LEFT:
              if i > 1:
                i -= 2
                done = true
            elif key == SDLK_RIGHT:
              if argv[i + 1] != "":
                done = true
            elif key == SDLK_ESCAPE or key == SDLK_Q:
              argv[i + 1] = ""
              done = true
            elif key == SDLK_SPACE or key == SDLK_TAB:
              done = true
          elif t == SDL_EVENT_MOUSE_BUTTON_DOWN:
            done = true
          elif t == SDL_EVENT_QUIT:
            argv[i + 1] = ""
            done = true

        # Draw a background pattern in case the image has transparency
        draw_background(renderer)

        # Display the image
        discard SDL_RenderTexture(renderer, textures[current_frame], nil, nil)
        discard SDL_RenderPresent(renderer)

        if anim.delays[current_frame] != 0:
          delay = int(anim.delays[current_frame])
        else:
          delay = 100
        SDL_Delay(uint32(delay))

        if current_frame < int(anim.count) - 1:
          inc current_frame
        else:
          if played != (loop_count - 1):
            inc played
            current_frame = 0

          if once:
            break

      for j in 0 ..< int(anim.count):
        SDL_DestroyTexture(textures[j])
      IMG_FreeAnimation(anim)
    inc i

  SDL_DestroyRenderer(renderer)
  SDL_DestroyWindow(window)

  SDL_Quit_proc()
  return 0

quit(main())
