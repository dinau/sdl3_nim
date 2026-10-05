@echo off
rem Step 2: build the Nim app for the web.
:: call C:\emsdk\emsdk_env.bat
if not exist build mkdir build

nim c -d:emscripten -d:release -o:build/index.html paa.nim || exit /b 1
emrun build\index.html
