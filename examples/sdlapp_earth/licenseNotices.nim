import std/[os]
import imguin/[cimgui]

const lcRoot = ".." / "utils" / "licenses"
const arryLicenses = [
                   (1, "Dear ImGui",            staticRead(lcRoot / "cimgui" / "imgui" / "LICENSE.txt"), "https://github.com/ocornut/imgui"),
                   (1, "CImGui",                staticRead(lcRoot / "cimgui" / "LICENSE"), "https://github.com/cimgui/cimgui"),
               #   (1, "ImAnim",                staticRead(lcRoot / "cimanim" / "ImAnim" / "LICENSE"), "https://github.com/soufianekhiat/ImAnim"),
               #   (1, "cimanim",               staticRead(lcRoot / "cimanim" / "LICENSE"), "https://github.com/dinau/cimanim"),
               #   (1, "cimCTE",                staticRead(lcRoot / "cimCTE" / "dummy.txt"),"https://github.com/cimgui/cimCTE"),
               #   (1, "ImGuiColorTextEdit",    staticread(lcRoot / "cimCTE" / "ImGuiColorTextEdit" / "LICENSE"), "https://github.com/santaclose/ImGuiColorTextEdit"),
               #   (1, "cimgui_toggle",         staticRead(lcRoot / "cimgui_toggle" / "LICENSE"),"https://github.com/dinau/cimgui_toggle"),
               #   (1, "imgui_toggle",          staticRead(lcRoot / "cimgui_toggle" / "libs" / "imgui_toggle" / "LICENSE"),"https://github.com/cmdwtf/imgui_toggle"),
               #   (1, "cimgui_zoomable_image", staticRead(lcRoot / "cimgui_zoomable_image" / "LICENSE"),"https://github.com/dinau/cimgui_zoomable_image"),
               #   (1, "imgui_zoomable_image",  staticRead(lcRoot / "cimgui_zoomable_image" / "imgui_zoomable_image" / "LICENSE"), "https://github.com/danielm5/imgui_zoomable_image"),
               #   (1, "CImGuiFileDialog",      staticRead(lcRoot / "CImGuiFileDialog" / "LICENSE"),"https://github.com/dinau/CImGuiFileDialog"),
               #   (1, "ImGuiFileDialog",       staticRead(lcRoot / "CImGuiFileDialog" / "libs" / "ImGuiFileDialog" / "LICENSE"), "https://github.com/aiekick/ImGuiFileDialog"),
               #   (1, "dirent",                staticRead(lcRoot / "CImGuiFileDialog" / "libs" / "ImGuiFileDialog" / "dirent" / "LICENSE"), "https://github.com/tronkko/dirent"),
               #   (1, "STB",                   staticRead(lcRoot / "stb" / "LICENSE"),"https://github.com/nothings/stb"),
               #   (1, "cimgui-knobs",          staticRead(lcRoot / "cimgui-knobs" / "LICENSE"),"https://github.com/dinau/imguin/tree/main/src/imguin/private/cimgui-knobs"),
               #   (1, "ImGui Knobs",           staticRead(lcRoot / "cimgui-knobs" / "imgui-knobs" / "LICENSE"), "https://github.com/altschuler/imgui-knobs"),
               #   (1, "CImGuiTextSelect",      staticRead(lcRoot / "CImGuiTextSelect" / "LICENSE"), "https://github.com/dinau/CImGuiTextSelect"),
               #   (1, "ImGuiTextSelect",       staticRead(lcRoot / "CImGuiTextSelect" / "ImGuiTextSelect" / "LICENSE.txt"),"https://github.com/AidanSun05/ImGuiTextSelect"),
               #   (1, "cimguizmo",             staticRead(lcRoot / "cimguizmo" / "LICENSE"),"https://github.com/cimgui/cimguizmo"),
               #   (1, "ImGuizmo",              staticRead(lcRoot / "cimguizmo" / "ImGuizmo" / "LICENSE"),"https://github.com/CedricGuillemet/ImGuizmo"),
               #   (1, "cimnodes",              staticRead(lcRoot / "cimnodes" / "dummy.txt"),"https://github.com/cimgui/cimnodes"),
               #   (1, "ImNodes",               staticRead(lcRoot / "cimnodes" / "imnodes" / "LICENSE.md"),"https://github.com/Nelarius/imnodes"),
               #   (1, "CImPlot",               staticRead(lcRoot / "cimplot" / "LICENSE"),"https://github.com/cimgui/cimplot"),
               #   (1, "ImPlot",                staticRead(lcRoot / "cimplot" / "implot" / "LICENSE"), "https://github.com/epezent/implot"),
               #   (1, "CImPlot3D",             staticRead(lcRoot / "cimplot3d" / "dummy.txt"),"https://github.com/cimgui/cimplot3d"),
               #   (1, "ImPlot3D",              staticRead(lcRoot / "cimplot3d" / "implot3d" / "LICENSE"),"https://github.com/brenocq/implot3d"),
               #   (1, "Font Awesome",          staticRead(lcRoot / "fonticon" / "fa6" / "LICENSE.txt"),"https://github.com/FortAwesome/Font-Awesome"),
               #   (1, "ImSpinner",             staticRead(lcRoot / "imspinner" / "LICENSE.txt"), "https://github.com/dalerank/imspinner"),
               #   (1, "Nim-Platformer",        staticRead(lcRoot / "nim-platformer" / "LICENSE-nim-platformer.txt"), "https://github.com/def-/nim-platformer"),
                   (1, "sdl3_nim",              staticRead(lcRoot / "sdl3_nim" / "LICENSE"), "https://github.com/dinau/sdl3_nim"),
               ]

#----------------
# licenseNotices
#----------------
proc licenseNotices*(pShowLicensesWindow: ptr bool, flags: ImGuiWindowFlags = 0) =
  if pShowLicensesWindow[]:
    igBegin("License Notices (Random order)", pShowLicensesWindow, flags);
    defer: igEnd()
    #
    for lc in arryLicenses:
      if lc[0] == 1:
        if igCollapsingHeader_TreeNodeFlags(lc[1].cstring, 0):
          igTextLinkOpenURL(lc[3].cstring, lc[3].cstring)
          igSeparator()
          igText(lc[2].cstring)
    igSeparator()
    igText("If there are any errors or omissions in the license descriptions above,\nplease contact us at")
    igTextLinkOpenURL("https://github.com/dinau/sdl3_nim/issues","https://github.com/dinau/sdl3_nim/issues")
