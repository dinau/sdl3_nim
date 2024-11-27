<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [sdl3_nim](#sdl3_nim)
  - [Build and run](#build-and-run)
  - [Generate SDL3 header files with Futhark](#generate-sdl3-header-files-with-futhark)
  - [My tools version](#my-tools-version)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### sdl3_nim

---

SDL3 wrapper for Nim language

This is highly work in progress and my experiment project.


- SDL3-3.1.6
- SDL_ttf 3.0.0
- Only on Windows OS at this moment


#### Build and run

---

```sh
git clone https://github.com/dinau/sdl3_nim
cd sdl3_nim
make 
```

or 

```sh
pwd sdl3_nim
cd examples/basic
make
```

![alt](https://github.com/dinau/sdl3_nim/raw/main/src/private/img/basic.png)

or

```sh
pwd sdl3_nim
cd examples/platformer
make
```

![alt](https://github.com/dinau/sdl3_nim/raw/main/src/private/img/platformer.png)


#### Generate SDL3 header files with Futhark

---

[Install Futhark](https://github.com/PMunch/futhark#installation)

```sh
pwd sdl3_nim
make gen
```

`src/sdl3_defs.nim` will be generated.


#### My tools version 

---

- Futhark 0.13.7
- nim-2.2.0
- Gcc.exe (Rev2, Built by MSYS2 project) 14.2.0
