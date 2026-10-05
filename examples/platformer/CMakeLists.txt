# Builds SDL3 / SDL3_image / SDL3_mixer / SDL3_ttf as static libraries with Emscripten.
# No executable is built here; Nim does the final link.
cmake_minimum_required(VERSION 3.21)
project(sdl3_libs C CXX)

include(FetchContent)

set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(SDL_SHARED OFF CACHE BOOL "" FORCE)
set(SDL_STATIC ON  CACHE BOOL "" FORCE)
set(SDL_TEST_LIBRARY OFF CACHE BOOL "" FORCE)

# Use the bundled (vendored) dependencies: libpng, libjpeg, freetype, harfbuzz, codecs...
set(SDLIMAGE_VENDORED ON  CACHE BOOL "" FORCE)
set(SDLIMAGE_SAMPLES  OFF CACHE BOOL "" FORCE)
set(SDLMIXER_VENDORED ON  CACHE BOOL "" FORCE)
set(SDLMIXER_SAMPLES  OFF CACHE BOOL "" FORCE)
set(SDLMIXER_PLAYER   OFF CACHE BOOL "" FORCE)
set(SDLTTF_VENDORED   ON  CACHE BOOL "" FORCE)
set(SDLTTF_SAMPLES    OFF CACHE BOOL "" FORCE)

# Replace release-3.x.x with the latest release tag of each repository.
FetchContent_Declare(SDL3       GIT_REPOSITORY https://github.com/libsdl-org/SDL.git       GIT_TAG release-3.4.18)
FetchContent_Declare(SDL3_image GIT_REPOSITORY https://github.com/libsdl-org/SDL_image.git GIT_TAG release-3.4.6 GIT_SUBMODULES_RECURSE TRUE)
FetchContent_Declare(SDL3_mixer GIT_REPOSITORY https://github.com/libsdl-org/SDL_mixer.git GIT_TAG release-3.2.4 GIT_SUBMODULES_RECURSE TRUE)
FetchContent_Declare(SDL3_ttf   GIT_REPOSITORY https://github.com/libsdl-org/SDL_ttf.git   GIT_TAG release-3.2.2 GIT_SUBMODULES_RECURSE TRUE)

FetchContent_MakeAvailable(SDL3)
FetchContent_MakeAvailable(SDL3_image SDL3_mixer SDL3_ttf)
