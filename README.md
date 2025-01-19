<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [sdl3_nim](#sdl3_nim)
  - [Install](#install)
  - [Build and run examples](#build-and-run-examples)
  - [Develeopment : Generating SDL3 Nim header files with Futhark](#develeopment--generating-sdl3-nim-header-files-with-futhark)
  - [My tools version](#my-tools-version)
  - [Other SDL game tutorial platfromer project](#other-sdl-game-tutorial-platfromer-project)
  - [Other project](#other-project)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### sdl3_nim

---

![alt](https://github.com/dinau/sdl3_nim/actions/workflows/windows.yml/badge.svg)  

SDL3 wrapper for Nim language

This is highly work in progress and my experiment project.


- SDL3-3.1.10
- SDL_ttf 3.0.0
- Only on Windows OS at this moment
- Trying to use [ImGuin SDL3 example](https://github.com/dinau/imguin_examples#glfw_opengl3_image_load--sdl2_opengl3---sdl3_opengl3)


#### Install

---


First delete old version 

```sh
nimble uninstall sdl3_nim
```

then

```sh
nimble install https://github.com/dinau/sdl3_nim 
```

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
pwd sdl3_nim
cd examples/basic
make run
```

![alt](https://github.com/dinau/sdl3_nim/raw/main/src/private/img/basic-nim-sdl3.gif)  

or

```sh
pwd 
sdl3_nim
cd examples/platformer
make run
```

![alt](https://github.com/dinau/sdl3_nim/raw/main/src/private/img/platformer-nim-sdl3.gif)  

#### Develeopment : Generating SDL3 Nim header files with Futhark

---

[The definition file of SDL3](src/sdl3_defs.nim) can be updated by yourself as follows, 

1. Replace [src/private/SDL3](src/private/SDL3) with  [latest officail SDL3 library](https://github.com/libsdl-org/SDL/releases)
1. [Install Futhark](https://github.com/PMunch/futhark#installation)
1. Generate definition file

   ```sh
   pwd 
   sdl3_nim
   make gen
   ```

   `src/sdl3_defs.nim` will be generated.

#### My tools version 

---

- Futhark 0.13.7
- nim-2.2.0
- Gcc.exe (Rev2, Built by MSYS2 project) 14.2.0

#### Other SDL game tutorial platfromer project

---

![ald](https://github.com/dinau/luajit-platformer/raw/main/img/platformer-luajit-sdl2.gif)

| Language             |          | Project                                                                                                   |
| -------------------: | :---:    | :----------------------------------------------------------------:                                        |
| **Nim**              | Compiler | [Nim-Platformer](https://github.com/dinau/nim-platformer) / [sdl3_nim](https://github.com/dinau/sdl3_nim) |
| **LuaJIT**           | Script   | [LuaJIT-Platformer](https://github.com/dinau/luajit-platformer)                                           |
| **Nelua**            | Compiler | [NeLua-Platformer](https://github.com/dinau/nelua-platformer)                                             |
| **Zig**              | Compiler | [Zig-Platformer](https://github.com/dinau/zig-platformer) WIP                                             |

#### Other project

---

| Language             |          | Project                                                                                                                                         |
| -------------------: | :---:    | :----------------------------------------------------------------:                                                                              |
| **Nim**              | Compiler | [ImGuin](https://github.com/dinau/imguin), [Nimgl_test](https://github.com/dinau/nimgl_test), [Nim_implot](https://github.com/dinau/nim_implot) |
| **Lua**              | Script   | [LuaJITImGui](https://github.com/dinau/luajitImGui)                                                                                             |
| **Zig**, C lang.     | Compiler | [Dear_Bindings_Build](https://github.com/dinau/dear_bindings_build)                                                                             |
| **Zig**              | Compiler | [ImGuinZ](https://github.com/dinau/imguinz)                                                                                                     |
| **NeLua**            | Compiler | [NeLuaImGui](https://github.com/dinau/neluaImGui)                                                                                               |
| **Python**           | Script   | [DearPyGui for 32bit WindowsOS Binary](https://github.com/dinau/DearPyGui32/tree/win32)                                                         |
