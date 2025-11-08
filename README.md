<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [sdl3_nim](#sdl3_nim)
  - [Install](#install)
  - [For Linux OS](#for-linux-os)
  - [For Windows11](#for-windows11)
  - [Build and run examples](#build-and-run-examples)
  - [About auto renaming](#about-auto-renaming)
  - [Develeopment](#develeopment)
  - [My tools version](#my-tools-version)
  - [Other SDL game tutorial platfromer project](#other-sdl-game-tutorial-platfromer-project)
  - [Other examples project for Dear ImGui](#other-examples-project-for-dear-imgui)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### sdl3_nim

---

![alt](https://github.com/dinau/sdl3_nim/actions/workflows/windows.yml/badge.svg) 
![alt](https://github.com/dinau/sdl3_nim/actions/workflows/linux.yml/badge.svg)

SDL3 wrapper for Nim language with [futhark](https://github.com/PMunch/futhark#installation) converter.

- SDL3: 3.2.24 (2025/11)
- SDL_ttf:  3.2.2
- Windows OS 11 
- Linux Debian13 Trixie / Ubuntu families 
- Try to use [ImGuin SDL3 example](https://github.com/dinau/imguin_examples/tree/main/sdl3_renderer)


#### Install

---

First delete old version 

```sh
nimble uninstall sdl3_nim
```

then

```sh
nimble install sdl3_nim 
```

#### For Linux OS

---

- If the package manager of the OS has SDL3 and SDL_ttf packages, install them with the package manager
- Otherwise install them from source code as follows (on Debian12 / Ubuntu families),  
   1. Download source code from [SDL3](https://github.com/libsdl-org/SDL/archive/refs/tags/release-3.2.24.zip) and [SDL3_ttf](https://github.com/libsdl-org/SDL_ttf/archive/refs/tags/release-3.2.2.zip)
   1. Install build tool **Ninja**

      ```sh
      sudo apt install ninja-build
      ```

   1. Extract SDL3 zip file and 
   
      ```sh
      cd SDL-release-3.2.24 
      mkdir build
      cd build 
      cmake .. -GNinja -DCMAKE_INSTALL_PREFIX=/usr/local
      ninja
      sudo ninja install
      sudo ldconfig
      ```

   1. Extract SDL3_ttf zip file and 
   
      ```sh
      cd SDL_ttf-release-3.2.2 
      mkdir build
      cd build 
      cmake .. -GNinja -DCMAKE_INSTALL_PREFIX=/usr/local
      ninja
      sudo ninja install
      sudo ldconfig
      ```

#### For Windows11

---

Download SDL3.dll from [here](https://github.com/libsdl-org/SDL/releases/), extracts SDL3-3.x.xx-win32-x64.zip  
then copy SDL3.dll to your application folder.


#### Build and run examples

---

```sh
git clone https://github.com/dinau/sdl3_nim
```

```sh
cd sdl3_nim
make 
```

or 

```sh
cd examples/basic
make run
```

[basic.nim](examples/basic/basic.nim)

![alt](https://github.com/dinau/sdl3_nim/blob/main/src/sdl3_nim/private/img/basic-nim-sdl3.gif?raw=true)

or

```sh
cd examples/platformer
make run
```

[platformer.nim](examples/platformer/platformer.nim)

![alt](https://github.com/dinau/sdl3_nim/blob/main/src/sdl3_nim/private/img/platformer-nim-sdl3.gif?raw=true)

or

```sh
cd examples/sdlapp_lines
make run
```

[sdlapp_lines.nim](examples/sdlapp_lines/sdlapp_lines.nim)

Refer to https://github.com/libsdl-org/SDL/tree/main/examples/renderer/03-lines

![alt](https://github.com/libsdl-org/SDL/blob/main/examples/renderer/03-lines/thumbnail.png?raw=true)


or

```sh
cd examples/sdlapp
make run
```

[sdlapp.nim](examples/sdlapp/sdlapp.nim)

![alt](https://github.com/dinau/sdl3_nim/blob/main/src/sdl3_nim/private/img/earth4.gif?raw=true)

#### About auto renaming 

---

Notice: [Futhark](https://github.com/PMunch/futhark) converter has automatically renamed these symbols.

```nim
Renaming "type" to "type_field"
Renaming "PRIX32" to "PRIX32_const"
Renaming "SDLK_MEDIASELECT" to "SDLK_MEDIASELECT_const"
Renaming "SDLK_a" to "SDLK_a_const"
Renaming "SDLK_b" to "SDLK_b_const"
Renaming "SDLK_c" to "SDLK_c_const"
Renaming "SDLK_d" to "SDLK_d_const"
Renaming "SDLK_e" to "SDLK_e_const"
Renaming "SDLK_f" to "SDLK_f_const"
Renaming "SDLK_g" to "SDLK_g_const"
Renaming "SDLK_h" to "SDLK_h_const"
Renaming "SDLK_i" to "SDLK_i_const"
Renaming "SDLK_j" to "SDLK_j_const"
Renaming "SDLK_k" to "SDLK_k_const"
Renaming "SDLK_l" to "SDLK_l_const"
Renaming "SDLK_m" to "SDLK_m_const"
Renaming "SDLK_n" to "SDLK_n_const"
Renaming "SDLK_o" to "SDLK_o_const"
Renaming "SDLK_p" to "SDLK_p_const"
Renaming "SDLK_q" to "SDLK_q_const"
Renaming "SDLK_r" to "SDLK_r_const"
Renaming "SDLK_s" to "SDLK_s_const"
Renaming "SDLK_t" to "SDLK_t_const"
Renaming "SDLK_u" to "SDLK_u_const"
Renaming "SDLK_v" to "SDLK_v_const"
Renaming "SDLK_w" to "SDLK_w_const"
Renaming "SDLK_x" to "SDLK_x_const"
Renaming "SDLK_y" to "SDLK_y_const"
Renaming "SDLK_z" to "SDLK_z_const"
Renaming "SDL_EventAction" to "SDL_EventAction_typedef"
Renaming "SDL_GLAttr" to "SDL_GLAttr_typedef"
Renaming "SDL_GLContextFlag" to "SDL_GLContextFlag_typedef"
Renaming "SDL_GLContextReleaseFlag" to "SDL_GLContextReleaseFlag_typedef"
Renaming "SDL_GLProfile" to "SDL_GLProfile_typedef"
Renaming "SDL_GL_CONTEXT_RESET_NOTIFICATION" to "SDL_GL_CONTEXT_RESET_NOTIFICATION_enumval"
Renaming "SDL_Log" to "SDL_Log_proc"
Renaming "SDL_Mutex" to "SDL_Mutex_typedef"
Renaming "SDL_PRIX32" to "SDL_PRIX32_const"
Renaming "SDL_PRIX64" to "SDL_PRIX64_const"
Renaming "SDL_Quit" to "SDL_Quit_proc"
Renaming "SDL_SCALEMODE_LINEAR" to "SDL_SCALEMODE_LINEAR_enumval"
Renaming "SDL_SCALEMODE_NEAREST" to "SDL_SCALEMODE_NEAREST_enumval"
Renaming "SDL_SCANCODE_MEDIA_SELECT" to "SDL_SCANCODE_MEDIA_SELECT_enumval"
Renaming "SDL_SensorUpdate" to "SDL_SensorUpdate_const"
Renaming "SDL_ThreadID" to "SDL_ThreadID_typedef"
Renaming "SDL_UserEvent" to "SDL_UserEvent_typedef"
Renaming "SDL_strtok_r" to "SDL_strtok_r_proc"
Renaming "block" to "block_arg"
Renaming "end" to "end_field" in struct_SDL_HapticRamp
Renaming "func" to "func_arg"
Renaming "mod" to "mod_field" in struct_SDL_KeyboardEvent
Renaming "proc" to "proc_arg"
Renaming "ptr" to "ptr_arg"
Renaming "type" to "type_arg"
```

#### Develeopment 

---

Generating SDL3 Nim header files with Futhark.

[The definition file of SDL3](src/sdl3_defs.nim) can be updated by yourself as follows, 

1. Replace [src/private/SDL3](src/private/SDL3) with  [latest officail SDL3 library](https://github.com/libsdl-org/SDL/releases)
1. [Install Futhark](https://github.com/PMunch/futhark#installation)
1. Generate definition file

   ```sh
   pwd 
   sdl3_nim
   make gen
   ```

   `src/sdl3_defs.nim` updated will be generated.

#### My tools version 

---

- Futhark 0.15.0
- nim-2.2.6
- Gcc.exe (Rev2, Built by MSYS2 project) 15.2.0

#### Other SDL game tutorial platfromer project

---

![ald](https://github.com/dinau/luajit-platformer/raw/main/img/platformer-luajit-sdl2.gif)

| Language             |          | SDL         | Project                                                                                                                                               |
| -------------------: | :---:    | :---:       | :----------------------------------------------------------------:                                                                                    |
| **LuaJIT**           | Script   | SDL2        | [LuaJIT-Platformer](https://github.com/dinau/luajit-platformer)                                                                                       |
| **Nelua**            | Compiler | SDL2        | [NeLua-Platformer](https://github.com/dinau/nelua-platformer)                                                                                         |
| **Nim**              | Compiler | SDL3 / SDL2 | [Nim-Platformer-sdl2](https://github.com/def-/nim-platformer)/ [Nim-Platformer-sdl3](https://github.com/dinau/sdl3_nim/tree/main/examples/platformer) |
| **Ruby**             | Script   | SDL3        | [Ruby-Platformer](https://github.com/dinau/ruby-platformer)                                                                                           |
| **Zig**              | Compiler | SDL2        | [Zig-Platformer](https://github.com/dinau/zig-platformer)                                                                                             |


#### Other examples project for Dear ImGui

---

| Language             |          | Project                                                                                                                                         |
| -------------------: | :---:    | :----------------------------------------------------------------:                                                                              |
| **Lua**              | Script   | [LuaJITImGui](https://github.com/dinau/luajitImGui)                                                                                             |
| **NeLua**            | Compiler | [NeLuaImGui](https://github.com/dinau/neluaImGui) / [NeLuaImGui2](https://github.com/dinau/neluaImGui2)                                         |
| **Nim**              | Compiler | [ImGuin](https://github.com/dinau/imguin), [Nimgl_test](https://github.com/dinau/nimgl_test), [Nim_implot](https://github.com/dinau/nim_implot) |
| **Python**           | Script   | [DearPyGui for 32bit WindowsOS Binary](https://github.com/dinau/DearPyGui32/tree/win32)                                                         |
| **Ruby**             | Script   | [igRuby_Examples](https://github.com/dinau/igruby_examples)                                                                                     |
| **Zig**, C lang.     | Compiler | [Dear_Bindings_Build](https://github.com/dinau/dear_bindings_build)                                                                             |
| **Zig**              | Compiler | [ImGuinZ](https://github.com/dinau/imguinz)                                                                                                     |
