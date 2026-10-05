@echo off
rem Step 1: build the SDL3 libraries once. Adjust the emsdk path.
:: call C:\emsdk\emsdk_env.bat

:: mkdir libs_build\build

emcmake cmake -S libs_build -B libs_build\build -G Ninja -DCMAKE_BUILD_TYPE=Release || exit /b 1
cmake --build libs_build\build || exit /b 1
cmake -DBUILD_DIR=libs_build/build -DOUT=libs -P libs_build/collect.cmake
