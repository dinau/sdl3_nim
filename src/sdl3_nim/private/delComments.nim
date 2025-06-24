const DEFS_NAME = "sdl3_defs.nim"
import std/[pegs,strutils]
var sOut:string
var seqRes:array[2,string]
for line in readfile(DEFS_NAME).split("\n"):
  if contains(line, peg"{@}'##'@$",seqRes):
    sOut.add seqRes[0] & "\n"
  else:
    sOut.add line & "\n"

writefile(DEFS_NAME, sOut)
