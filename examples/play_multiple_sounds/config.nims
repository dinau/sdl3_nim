switch "path", "../../sdl3_nim/src"

switch "define", "release"
switch "opt", "size"

switch "nimcache", ".nimcache_app"
when defined(windows):
  switch "passC", "-static"   # Avoid depencency on libgcc_s_seh-1.dll
  switch "passL", "-static "  # Same as above
