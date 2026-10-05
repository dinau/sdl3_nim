import sdl3_nim

type
  enum_TTF_HintingFlags* {.size: sizeof(cint).} = enum
    TTF_HINTING_INVALID = -1, TTF_HINTING_NORMAL = 0, TTF_HINTING_LIGHT = 1,
    TTF_HINTING_MONO = 2, TTF_HINTING_NONE = 3, TTF_HINTING_LIGHT_SUBPIXEL = 4
type
  enum_TTF_HorizontalAlignment* {.size: sizeof(cint).} = enum
    TTF_HORIZONTAL_ALIGN_INVALID = -1, TTF_HORIZONTAL_ALIGN_LEFT = 0,
    TTF_HORIZONTAL_ALIGN_CENTER = 1, TTF_HORIZONTAL_ALIGN_RIGHT = 2
type
  enum_TTF_Direction* {.size: sizeof(cuint).} = enum
    TTF_DIRECTION_INVALID = 0, TTF_DIRECTION_LTR = 4, TTF_DIRECTION_RTL = 5,
    TTF_DIRECTION_TTB = 6, TTF_DIRECTION_BTT = 7
type
  enum_TTF_ImageType* {.size: sizeof(cuint).} = enum
    TTF_IMAGE_INVALID = 0, TTF_IMAGE_ALPHA = 1, TTF_IMAGE_COLOR = 2,
    TTF_IMAGE_SDF = 3
type
  enum_TTF_GPUTextEngineWinding* {.size: sizeof(cint).} = enum
    TTF_GPU_TEXTENGINE_WINDING_INVALID = -1,
    TTF_GPU_TEXTENGINE_WINDING_CLOCKWISE = 0,
    TTF_GPU_TEXTENGINE_WINDING_COUNTER_CLOCKWISE = 1
type
  enum_TTF_DrawCommand* {.size: sizeof(cuint).} = enum
    TTF_DRAW_COMMAND_NOOP = 0, TTF_DRAW_COMMAND_FILL = 1,
    TTF_DRAW_COMMAND_COPY = 2
type
  struct_TTF_Font* = object
type
  struct_TTF_TextLayout* = object
type
  TTF_Font* = struct_TTF_Font
  TTF_FontStyleFlags* = Uint32
  TTF_HintingFlags* = enum_TTF_HintingFlags
  TTF_HorizontalAlignment* = enum_TTF_HorizontalAlignment
  TTF_Direction* = enum_TTF_Direction
  TTF_ImageType* = enum_TTF_ImageType
  TTF_TextEngine* = struct_TTF_TextEngine
  struct_TTF_TextEngine* {.pure, inheritable, bycopy.} = object
    version*: Uint32
    userdata*: pointer
    CreateText*: proc (a0: pointer; a1: ptr TTF_Text): bool {.cdecl.}
    DestroyText*: proc (a0: pointer; a1: ptr TTF_Text): void {.cdecl.}
  TTF_TextData* = struct_TTF_TextData
  struct_TTF_TextData* {.pure, inheritable, bycopy.} = object
    font*: ptr TTF_Font
    color*: SDL_FColor
    needs_layout_update*: bool
    layout*: ptr TTF_TextLayout
    x*: cint
    y*: cint
    w*: cint
    h*: cint
    num_ops*: cint
    ops*: ptr TTF_DrawOperation
    num_clusters*: cint
    clusters*: ptr TTF_SubString
    props*: SDL_PropertiesID
    needs_engine_update*: bool
    engine*: ptr TTF_TextEngine
    engine_text*: pointer
  struct_TTF_Text* {.pure, inheritable, bycopy.} = object
    text*: cstring
    num_lines*: cint
    refcount*: cint
    internal*: ptr TTF_TextData
  TTF_Text* = struct_TTF_Text
  struct_TTF_GPUAtlasDrawSequence* {.pure, inheritable, bycopy.} = object
    atlas_texture*: ptr SDL_GPUTexture
    xy*: ptr SDL_FPoint
    uv*: ptr SDL_FPoint
    num_vertices*: cint
    indices*: ptr cint
    num_indices*: cint
    image_type*: TTF_ImageType
    next*: ptr struct_TTF_GPUAtlasDrawSequence
  SDL_GPUTexture* = struct_SDL_GPUTexture
  TTF_GPUAtlasDrawSequence* = struct_TTF_GPUAtlasDrawSequence
  TTF_GPUTextEngineWinding* = enum_TTF_GPUTextEngineWinding
  Uint8* = uint8
  TTF_SubStringFlags* = Uint32
  struct_TTF_SubString* {.pure, inheritable, bycopy.} = object
    flags*: TTF_SubStringFlags
    offset*: cint
    length*: cint
    line_index*: cint
    cluster_index*: cint
    rect*: SDL_Rect
  TTF_SubString* = struct_TTF_SubString
  TTF_DrawCommand* = enum_TTF_DrawCommand
  struct_TTF_FillOperation* {.pure, inheritable, bycopy.} = object
    cmd*: TTF_DrawCommand
    rect*: SDL_Rect
  TTF_FillOperation* = struct_TTF_FillOperation
  struct_TTF_CopyOperation* {.pure, inheritable, bycopy.} = object
    cmd*: TTF_DrawCommand
    text_offset*: cint
    glyph_font*: ptr TTF_Font
    glyph_index*: Uint32
    src*: SDL_Rect
    dst*: SDL_Rect
    reserved*: pointer
  TTF_CopyOperation* = struct_TTF_CopyOperation
  union_TTF_DrawOperation* {.union, bycopy.} = object
    cmd*: TTF_DrawCommand
    fill*: TTF_FillOperation
    copy*: TTF_CopyOperation
  TTF_DrawOperation* = union_TTF_DrawOperation
  TTF_TextLayout* = struct_TTF_TextLayout
when 3 is static:
  const
    SDL_TTF_MAJOR_VERSION* = 3
else:
  let SDL_TTF_MAJOR_VERSION* = 3
when 2 is static:
  const
    SDL_TTF_MINOR_VERSION* = 2
else:
  let SDL_TTF_MINOR_VERSION* = 2
when 2 is static:
  const
    SDL_TTF_MICRO_VERSION* = 2
else:
  let SDL_TTF_MICRO_VERSION* = 2
when "SDL_ttf.font.create.filename" is static:
  const
    TTF_PROP_FONT_CREATE_FILENAME_STRING* = "SDL_ttf.font.create.filename"
else:
  let TTF_PROP_FONT_CREATE_FILENAME_STRING* = "SDL_ttf.font.create.filename"
when "SDL_ttf.font.create.iostream" is static:
  const
    TTF_PROP_FONT_CREATE_IOSTREAM_POINTER* = "SDL_ttf.font.create.iostream"
else:
  let TTF_PROP_FONT_CREATE_IOSTREAM_POINTER* = "SDL_ttf.font.create.iostream"
when "SDL_ttf.font.create.iostream.offset" is static:
  const
    TTF_PROP_FONT_CREATE_IOSTREAM_OFFSET_NUMBER* = "SDL_ttf.font.create.iostream.offset"
else:
  let TTF_PROP_FONT_CREATE_IOSTREAM_OFFSET_NUMBER* = "SDL_ttf.font.create.iostream.offset"
when "SDL_ttf.font.create.iostream.autoclose" is static:
  const
    TTF_PROP_FONT_CREATE_IOSTREAM_AUTOCLOSE_BOOLEAN* = "SDL_ttf.font.create.iostream.autoclose"
else:
  let TTF_PROP_FONT_CREATE_IOSTREAM_AUTOCLOSE_BOOLEAN* = "SDL_ttf.font.create.iostream.autoclose"
when "SDL_ttf.font.create.size" is static:
  const
    TTF_PROP_FONT_CREATE_SIZE_FLOAT* = "SDL_ttf.font.create.size"
else:
  let TTF_PROP_FONT_CREATE_SIZE_FLOAT* = "SDL_ttf.font.create.size"
when "SDL_ttf.font.create.face" is static:
  const
    TTF_PROP_FONT_CREATE_FACE_NUMBER* = "SDL_ttf.font.create.face"
else:
  let TTF_PROP_FONT_CREATE_FACE_NUMBER* = "SDL_ttf.font.create.face"
when "SDL_ttf.font.create.hdpi" is static:
  const
    TTF_PROP_FONT_CREATE_HORIZONTAL_DPI_NUMBER* = "SDL_ttf.font.create.hdpi"
else:
  let TTF_PROP_FONT_CREATE_HORIZONTAL_DPI_NUMBER* = "SDL_ttf.font.create.hdpi"
when "SDL_ttf.font.create.vdpi" is static:
  const
    TTF_PROP_FONT_CREATE_VERTICAL_DPI_NUMBER* = "SDL_ttf.font.create.vdpi"
else:
  let TTF_PROP_FONT_CREATE_VERTICAL_DPI_NUMBER* = "SDL_ttf.font.create.vdpi"
when "SDL_ttf.font.create.existing_font" is static:
  const
    TTF_PROP_FONT_CREATE_EXISTING_FONT* = "SDL_ttf.font.create.existing_font"
else:
  let TTF_PROP_FONT_CREATE_EXISTING_FONT* = "SDL_ttf.font.create.existing_font"
when "SDL_ttf.font.outline.line_cap" is static:
  const
    TTF_PROP_FONT_OUTLINE_LINE_CAP_NUMBER* = "SDL_ttf.font.outline.line_cap"
else:
  let TTF_PROP_FONT_OUTLINE_LINE_CAP_NUMBER* = "SDL_ttf.font.outline.line_cap"
when "SDL_ttf.font.outline.line_join" is static:
  const
    TTF_PROP_FONT_OUTLINE_LINE_JOIN_NUMBER* = "SDL_ttf.font.outline.line_join"
else:
  let TTF_PROP_FONT_OUTLINE_LINE_JOIN_NUMBER* = "SDL_ttf.font.outline.line_join"
when "SDL_ttf.font.outline.miter_limit" is static:
  const
    TTF_PROP_FONT_OUTLINE_MITER_LIMIT_NUMBER* = "SDL_ttf.font.outline.miter_limit"
else:
  let TTF_PROP_FONT_OUTLINE_MITER_LIMIT_NUMBER* = "SDL_ttf.font.outline.miter_limit"
when 0 is static:
  const
    TTF_STYLE_NORMAL* = 0
else:
  let TTF_STYLE_NORMAL* = 0
when 1 is static:
  const
    TTF_STYLE_BOLD* = 1
else:
  let TTF_STYLE_BOLD* = 1
when 2 is static:
  const
    TTF_STYLE_ITALIC* = 2
else:
  let TTF_STYLE_ITALIC* = 2
when 4 is static:
  const
    TTF_STYLE_UNDERLINE* = 4
else:
  let TTF_STYLE_UNDERLINE* = 4
when 8 is static:
  const
    TTF_STYLE_STRIKETHROUGH* = 8
else:
  let TTF_STYLE_STRIKETHROUGH* = 8
when 100 is static:
  const
    TTF_FONT_WEIGHT_THIN* = 100
else:
  let TTF_FONT_WEIGHT_THIN* = 100
when 200 is static:
  const
    TTF_FONT_WEIGHT_EXTRA_LIGHT* = 200
else:
  let TTF_FONT_WEIGHT_EXTRA_LIGHT* = 200
when 300 is static:
  const
    TTF_FONT_WEIGHT_LIGHT* = 300
else:
  let TTF_FONT_WEIGHT_LIGHT* = 300
when 400 is static:
  const
    TTF_FONT_WEIGHT_NORMAL* = 400
else:
  let TTF_FONT_WEIGHT_NORMAL* = 400
when 500 is static:
  const
    TTF_FONT_WEIGHT_MEDIUM* = 500
else:
  let TTF_FONT_WEIGHT_MEDIUM* = 500
when 600 is static:
  const
    TTF_FONT_WEIGHT_SEMI_BOLD* = 600
else:
  let TTF_FONT_WEIGHT_SEMI_BOLD* = 600
when 700 is static:
  const
    TTF_FONT_WEIGHT_BOLD* = 700
else:
  let TTF_FONT_WEIGHT_BOLD* = 700
when 800 is static:
  const
    TTF_FONT_WEIGHT_EXTRA_BOLD* = 800
else:
  let TTF_FONT_WEIGHT_EXTRA_BOLD* = 800
when 900 is static:
  const
    TTF_FONT_WEIGHT_BLACK* = 900
else:
  let TTF_FONT_WEIGHT_BLACK* = 900
when 950 is static:
  const
    TTF_FONT_WEIGHT_EXTRA_BLACK* = 950
else:
  let TTF_FONT_WEIGHT_EXTRA_BLACK* = 950
when "SDL_ttf.renderer_text_engine.create.renderer" is static:
  const
    TTF_PROP_RENDERER_TEXT_ENGINE_RENDERER* = "SDL_ttf.renderer_text_engine.create.renderer"
else:
  let TTF_PROP_RENDERER_TEXT_ENGINE_RENDERER* = "SDL_ttf.renderer_text_engine.create.renderer"
when "SDL_ttf.renderer_text_engine.create.atlas_texture_size" is static:
  const
    TTF_PROP_RENDERER_TEXT_ENGINE_ATLAS_TEXTURE_SIZE* = "SDL_ttf.renderer_text_engine.create.atlas_texture_size"
else:
  let TTF_PROP_RENDERER_TEXT_ENGINE_ATLAS_TEXTURE_SIZE* = "SDL_ttf.renderer_text_engine.create.atlas_texture_size"
when "SDL_ttf.gpu_text_engine.create.device" is static:
  const
    TTF_PROP_GPU_TEXT_ENGINE_DEVICE* = "SDL_ttf.gpu_text_engine.create.device"
else:
  let TTF_PROP_GPU_TEXT_ENGINE_DEVICE* = "SDL_ttf.gpu_text_engine.create.device"
when "SDL_ttf.gpu_text_engine.create.atlas_texture_size" is static:
  const
    TTF_PROP_GPU_TEXT_ENGINE_ATLAS_TEXTURE_SIZE* = "SDL_ttf.gpu_text_engine.create.atlas_texture_size"
else:
  let TTF_PROP_GPU_TEXT_ENGINE_ATLAS_TEXTURE_SIZE* = "SDL_ttf.gpu_text_engine.create.atlas_texture_size"
when 255 is static:
  const
    TTF_SUBSTRING_DIRECTION_MASK* = 255
else:
  let TTF_SUBSTRING_DIRECTION_MASK* = 255
when 256 is static:
  const
    TTF_SUBSTRING_TEXT_START* = 256
else:
  let TTF_SUBSTRING_TEXT_START* = 256
when 512 is static:
  const
    TTF_SUBSTRING_LINE_START* = 512
else:
  let TTF_SUBSTRING_LINE_START* = 512
when 1024 is static:
  const
    TTF_SUBSTRING_LINE_END* = 1024
else:
  let TTF_SUBSTRING_LINE_END* = 1024
when 2048 is static:
  const
    TTF_SUBSTRING_TEXT_END* = 2048
else:
  let TTF_SUBSTRING_TEXT_END* = 2048
proc TTF_Version*(): cint {.cdecl, importc: "TTF_Version".}
proc TTF_GetFreeTypeVersion*(major: ptr cint; minor: ptr cint; patch: ptr cint): void {.
    cdecl, importc: "TTF_GetFreeTypeVersion".}
proc TTF_GetHarfBuzzVersion*(major: ptr cint; minor: ptr cint; patch: ptr cint): void {.
    cdecl, importc: "TTF_GetHarfBuzzVersion".}
proc TTF_Init*(): bool {.cdecl, importc: "TTF_Init".}
proc TTF_OpenFont*(file: cstring; ptsize: cfloat): ptr TTF_Font {.cdecl,
    importc: "TTF_OpenFont".}
proc TTF_OpenFontIO*(src: ptr SDL_IOStream; closeio: bool; ptsize: cfloat): ptr TTF_Font {.
    cdecl, importc: "TTF_OpenFontIO".}
proc TTF_OpenFontWithProperties*(props: SDL_PropertiesID): ptr TTF_Font {.cdecl,
    importc: "TTF_OpenFontWithProperties".}
proc TTF_CopyFont*(existing_font: ptr TTF_Font): ptr TTF_Font {.cdecl,
    importc: "TTF_CopyFont".}
proc TTF_GetFontProperties*(font: ptr TTF_Font): SDL_PropertiesID {.cdecl,
    importc: "TTF_GetFontProperties".}
proc TTF_GetFontGeneration*(font: ptr TTF_Font): Uint32 {.cdecl,
    importc: "TTF_GetFontGeneration".}
proc TTF_AddFallbackFont*(font: ptr TTF_Font; fallback: ptr TTF_Font): bool {.
    cdecl, importc: "TTF_AddFallbackFont".}
proc TTF_RemoveFallbackFont*(font: ptr TTF_Font; fallback: ptr TTF_Font): void {.
    cdecl, importc: "TTF_RemoveFallbackFont".}
proc TTF_ClearFallbackFonts*(font: ptr TTF_Font): void {.cdecl,
    importc: "TTF_ClearFallbackFonts".}
proc TTF_SetFontSize*(font: ptr TTF_Font; ptsize: cfloat): bool {.cdecl,
    importc: "TTF_SetFontSize".}
proc TTF_SetFontSizeDPI*(font: ptr TTF_Font; ptsize: cfloat; hdpi: cint;
                         vdpi: cint): bool {.cdecl,
    importc: "TTF_SetFontSizeDPI".}
proc TTF_GetFontSize*(font: ptr TTF_Font): cfloat {.cdecl,
    importc: "TTF_GetFontSize".}
proc TTF_GetFontDPI*(font: ptr TTF_Font; hdpi: ptr cint; vdpi: ptr cint): bool {.
    cdecl, importc: "TTF_GetFontDPI".}
proc TTF_SetFontStyle*(font: ptr TTF_Font; style: TTF_FontStyleFlags): void {.
    cdecl, importc: "TTF_SetFontStyle".}
proc TTF_GetFontStyle*(font: ptr TTF_Font): TTF_FontStyleFlags {.cdecl,
    importc: "TTF_GetFontStyle".}
proc TTF_SetFontOutline*(font: ptr TTF_Font; outline: cint): bool {.cdecl,
    importc: "TTF_SetFontOutline".}
proc TTF_GetFontOutline*(font: ptr TTF_Font): cint {.cdecl,
    importc: "TTF_GetFontOutline".}
proc TTF_SetFontHinting*(font: ptr TTF_Font; hinting: TTF_HintingFlags): void {.
    cdecl, importc: "TTF_SetFontHinting".}
proc TTF_GetNumFontFaces*(font: ptr TTF_Font): cint {.cdecl,
    importc: "TTF_GetNumFontFaces".}
proc TTF_GetFontHinting*(font: ptr TTF_Font): TTF_HintingFlags {.cdecl,
    importc: "TTF_GetFontHinting".}
proc TTF_SetFontSDF*(font: ptr TTF_Font; enabled: bool): bool {.cdecl,
    importc: "TTF_SetFontSDF".}
proc TTF_GetFontSDF*(font: ptr TTF_Font): bool {.cdecl,
    importc: "TTF_GetFontSDF".}
proc TTF_GetFontWeight*(font: ptr TTF_Font): cint {.cdecl,
    importc: "TTF_GetFontWeight".}
proc TTF_SetFontWrapAlignment*(font: ptr TTF_Font;
                               align: TTF_HorizontalAlignment): void {.cdecl,
    importc: "TTF_SetFontWrapAlignment".}
proc TTF_GetFontWrapAlignment*(font: ptr TTF_Font): TTF_HorizontalAlignment {.
    cdecl, importc: "TTF_GetFontWrapAlignment".}
proc TTF_GetFontHeight*(font: ptr TTF_Font): cint {.cdecl,
    importc: "TTF_GetFontHeight".}
proc TTF_GetFontAscent*(font: ptr TTF_Font): cint {.cdecl,
    importc: "TTF_GetFontAscent".}
proc TTF_GetFontDescent*(font: ptr TTF_Font): cint {.cdecl,
    importc: "TTF_GetFontDescent".}
proc TTF_SetFontLineSkip*(font: ptr TTF_Font; lineskip: cint): void {.cdecl,
    importc: "TTF_SetFontLineSkip".}
proc TTF_GetFontLineSkip*(font: ptr TTF_Font): cint {.cdecl,
    importc: "TTF_GetFontLineSkip".}
proc TTF_SetFontKerning*(font: ptr TTF_Font; enabled: bool): void {.cdecl,
    importc: "TTF_SetFontKerning".}
proc TTF_GetFontKerning*(font: ptr TTF_Font): bool {.cdecl,
    importc: "TTF_GetFontKerning".}
proc TTF_FontIsFixedWidth*(font: ptr TTF_Font): bool {.cdecl,
    importc: "TTF_FontIsFixedWidth".}
proc TTF_FontIsScalable*(font: ptr TTF_Font): bool {.cdecl,
    importc: "TTF_FontIsScalable".}
proc TTF_GetFontFamilyName*(font: ptr TTF_Font): cstring {.cdecl,
    importc: "TTF_GetFontFamilyName".}
proc TTF_GetFontStyleName*(font: ptr TTF_Font): cstring {.cdecl,
    importc: "TTF_GetFontStyleName".}
proc TTF_SetFontDirection*(font: ptr TTF_Font; direction: TTF_Direction): bool {.
    cdecl, importc: "TTF_SetFontDirection".}
proc TTF_GetFontDirection*(font: ptr TTF_Font): TTF_Direction {.cdecl,
    importc: "TTF_GetFontDirection".}
proc TTF_StringToTag*(string: cstring): Uint32 {.cdecl,
    importc: "TTF_StringToTag".}
proc TTF_TagToString*(tag: Uint32; string: cstring; size: csize_t): void {.
    cdecl, importc: "TTF_TagToString".}
proc TTF_SetFontScript*(font: ptr TTF_Font; script: Uint32): bool {.cdecl,
    importc: "TTF_SetFontScript".}
proc TTF_GetFontScript*(font: ptr TTF_Font): Uint32 {.cdecl,
    importc: "TTF_GetFontScript".}
proc TTF_GetGlyphScript*(ch: Uint32): Uint32 {.cdecl,
    importc: "TTF_GetGlyphScript".}
proc TTF_SetFontLanguage*(font: ptr TTF_Font; language_bcp47: cstring): bool {.
    cdecl, importc: "TTF_SetFontLanguage".}
proc TTF_FontHasGlyph*(font: ptr TTF_Font; ch: Uint32): bool {.cdecl,
    importc: "TTF_FontHasGlyph".}
proc TTF_GetGlyphImage*(font: ptr TTF_Font; ch: Uint32;
                        image_type: ptr TTF_ImageType): ptr SDL_Surface {.cdecl,
    importc: "TTF_GetGlyphImage".}
proc TTF_GetGlyphImageForIndex*(font: ptr TTF_Font; glyph_index: Uint32;
                                image_type: ptr TTF_ImageType): ptr SDL_Surface {.
    cdecl, importc: "TTF_GetGlyphImageForIndex".}
proc TTF_GetGlyphMetrics*(font: ptr TTF_Font; ch: Uint32; minx: ptr cint;
                          maxx: ptr cint; miny: ptr cint; maxy: ptr cint;
                          advance: ptr cint): bool {.cdecl,
    importc: "TTF_GetGlyphMetrics".}
proc TTF_GetGlyphKerning*(font: ptr TTF_Font; previous_ch: Uint32; ch: Uint32;
                          kerning: ptr cint): bool {.cdecl,
    importc: "TTF_GetGlyphKerning".}
proc TTF_GetStringSize*(font: ptr TTF_Font; text: cstring; length: csize_t;
                        w: ptr cint; h: ptr cint): bool {.cdecl,
    importc: "TTF_GetStringSize".}
proc TTF_GetStringSizeWrapped*(font: ptr TTF_Font; text: cstring;
                               length: csize_t; wrap_width: cint; w: ptr cint;
                               h: ptr cint): bool {.cdecl,
    importc: "TTF_GetStringSizeWrapped".}
proc TTF_MeasureString*(font: ptr TTF_Font; text: cstring; length: csize_t;
                        max_width: cint; measured_width: ptr cint;
                        measured_length: ptr csize_t): bool {.cdecl,
    importc: "TTF_MeasureString".}
proc TTF_RenderText_Solid*(font: ptr TTF_Font; text: cstring; length: csize_t;
                           fg: SDL_Color): ptr SDL_Surface {.cdecl,
    importc: "TTF_RenderText_Solid".}
proc TTF_RenderText_Solid_Wrapped*(font: ptr TTF_Font; text: cstring;
                                   length: csize_t; fg: SDL_Color;
                                   wrapLength: cint): ptr SDL_Surface {.cdecl,
    importc: "TTF_RenderText_Solid_Wrapped".}
proc TTF_RenderGlyph_Solid*(font: ptr TTF_Font; ch: Uint32; fg: SDL_Color): ptr SDL_Surface {.
    cdecl, importc: "TTF_RenderGlyph_Solid".}
proc TTF_RenderText_Shaded*(font: ptr TTF_Font; text: cstring; length: csize_t;
                            fg: SDL_Color; bg: SDL_Color): ptr SDL_Surface {.
    cdecl, importc: "TTF_RenderText_Shaded".}
proc TTF_RenderText_Shaded_Wrapped*(font: ptr TTF_Font; text: cstring;
                                    length: csize_t; fg: SDL_Color;
                                    bg: SDL_Color; wrap_width: cint): ptr SDL_Surface {.
    cdecl, importc: "TTF_RenderText_Shaded_Wrapped".}
proc TTF_RenderGlyph_Shaded*(font: ptr TTF_Font; ch: Uint32; fg: SDL_Color;
                             bg: SDL_Color): ptr SDL_Surface {.cdecl,
    importc: "TTF_RenderGlyph_Shaded".}
proc TTF_RenderText_Blended*(font: ptr TTF_Font; text: cstring; length: csize_t;
                             fg: SDL_Color): ptr SDL_Surface {.cdecl,
    importc: "TTF_RenderText_Blended".}
proc TTF_RenderText_Blended_Wrapped*(font: ptr TTF_Font; text: cstring;
                                     length: csize_t; fg: SDL_Color;
                                     wrap_width: cint): ptr SDL_Surface {.cdecl,
    importc: "TTF_RenderText_Blended_Wrapped".}
proc TTF_RenderGlyph_Blended*(font: ptr TTF_Font; ch: Uint32; fg: SDL_Color): ptr SDL_Surface {.
    cdecl, importc: "TTF_RenderGlyph_Blended".}
proc TTF_RenderText_LCD*(font: ptr TTF_Font; text: cstring; length: csize_t;
                         fg: SDL_Color; bg: SDL_Color): ptr SDL_Surface {.cdecl,
    importc: "TTF_RenderText_LCD".}
proc TTF_RenderText_LCD_Wrapped*(font: ptr TTF_Font; text: cstring;
                                 length: csize_t; fg: SDL_Color; bg: SDL_Color;
                                 wrap_width: cint): ptr SDL_Surface {.cdecl,
    importc: "TTF_RenderText_LCD_Wrapped".}
proc TTF_RenderGlyph_LCD*(font: ptr TTF_Font; ch: Uint32; fg: SDL_Color;
                          bg: SDL_Color): ptr SDL_Surface {.cdecl,
    importc: "TTF_RenderGlyph_LCD".}
proc TTF_CreateSurfaceTextEngine*(): ptr TTF_TextEngine {.cdecl,
    importc: "TTF_CreateSurfaceTextEngine".}
proc TTF_DrawSurfaceText*(text: ptr TTF_Text; x: cint; y: cint;
                          surface: ptr SDL_Surface): bool {.cdecl,
    importc: "TTF_DrawSurfaceText".}
proc TTF_DestroySurfaceTextEngine*(engine: ptr TTF_TextEngine): void {.cdecl,
    importc: "TTF_DestroySurfaceTextEngine".}
proc TTF_CreateRendererTextEngine*(renderer: ptr SDL_Renderer): ptr TTF_TextEngine {.
    cdecl, importc: "TTF_CreateRendererTextEngine".}
proc TTF_CreateRendererTextEngineWithProperties*(props: SDL_PropertiesID): ptr TTF_TextEngine {.
    cdecl, importc: "TTF_CreateRendererTextEngineWithProperties".}
proc TTF_DrawRendererText*(text: ptr TTF_Text; x: cfloat; y: cfloat): bool {.
    cdecl, importc: "TTF_DrawRendererText".}
proc TTF_DestroyRendererTextEngine*(engine: ptr TTF_TextEngine): void {.cdecl,
    importc: "TTF_DestroyRendererTextEngine".}
proc TTF_CreateGPUTextEngine*(device: ptr SDL_GPUDevice): ptr TTF_TextEngine {.
    cdecl, importc: "TTF_CreateGPUTextEngine".}
proc TTF_CreateGPUTextEngineWithProperties*(props: SDL_PropertiesID): ptr TTF_TextEngine {.
    cdecl, importc: "TTF_CreateGPUTextEngineWithProperties".}
proc TTF_GetGPUTextDrawData*(text: ptr TTF_Text): ptr TTF_GPUAtlasDrawSequence {.
    cdecl, importc: "TTF_GetGPUTextDrawData".}
proc TTF_DestroyGPUTextEngine*(engine: ptr TTF_TextEngine): void {.cdecl,
    importc: "TTF_DestroyGPUTextEngine".}
proc TTF_SetGPUTextEngineWinding*(engine: ptr TTF_TextEngine;
                                  winding: TTF_GPUTextEngineWinding): void {.
    cdecl, importc: "TTF_SetGPUTextEngineWinding".}
proc TTF_GetGPUTextEngineWinding*(engine: ptr TTF_TextEngine): TTF_GPUTextEngineWinding {.
    cdecl, importc: "TTF_GetGPUTextEngineWinding".}
proc TTF_CreateText*(engine: ptr TTF_TextEngine; font: ptr TTF_Font;
                     text: cstring; length: csize_t): ptr TTF_Text {.cdecl,
    importc: "TTF_CreateText".}
proc TTF_GetTextProperties*(text: ptr TTF_Text): SDL_PropertiesID {.cdecl,
    importc: "TTF_GetTextProperties".}
proc TTF_SetTextEngine*(text: ptr TTF_Text; engine: ptr TTF_TextEngine): bool {.
    cdecl, importc: "TTF_SetTextEngine".}
proc TTF_GetTextEngine*(text: ptr TTF_Text): ptr TTF_TextEngine {.cdecl,
    importc: "TTF_GetTextEngine".}
proc TTF_SetTextFont*(text: ptr TTF_Text; font: ptr TTF_Font): bool {.cdecl,
    importc: "TTF_SetTextFont".}
proc TTF_GetTextFont*(text: ptr TTF_Text): ptr TTF_Font {.cdecl,
    importc: "TTF_GetTextFont".}
proc TTF_SetTextDirection*(text: ptr TTF_Text; direction: TTF_Direction): bool {.
    cdecl, importc: "TTF_SetTextDirection".}
proc TTF_GetTextDirection*(text: ptr TTF_Text): TTF_Direction {.cdecl,
    importc: "TTF_GetTextDirection".}
proc TTF_SetTextScript*(text: ptr TTF_Text; script: Uint32): bool {.cdecl,
    importc: "TTF_SetTextScript".}
proc TTF_GetTextScript*(text: ptr TTF_Text): Uint32 {.cdecl,
    importc: "TTF_GetTextScript".}
proc TTF_SetTextColor*(text: ptr TTF_Text; r: Uint8; g: Uint8; b: Uint8;
                       a: Uint8): bool {.cdecl, importc: "TTF_SetTextColor".}
proc TTF_SetTextColorFloat*(text: ptr TTF_Text; r: cfloat; g: cfloat; b: cfloat;
                            a: cfloat): bool {.cdecl,
    importc: "TTF_SetTextColorFloat".}
proc TTF_GetTextColor*(text: ptr TTF_Text; r: ptr Uint8; g: ptr Uint8;
                       b: ptr Uint8; a: ptr Uint8): bool {.cdecl,
    importc: "TTF_GetTextColor".}
proc TTF_GetTextColorFloat*(text: ptr TTF_Text; r: ptr cfloat; g: ptr cfloat;
                            b: ptr cfloat; a: ptr cfloat): bool {.cdecl,
    importc: "TTF_GetTextColorFloat".}
proc TTF_SetTextPosition*(text: ptr TTF_Text; x: cint; y: cint): bool {.cdecl,
    importc: "TTF_SetTextPosition".}
proc TTF_GetTextPosition*(text: ptr TTF_Text; x: ptr cint; y: ptr cint): bool {.
    cdecl, importc: "TTF_GetTextPosition".}
proc TTF_SetTextWrapWidth*(text: ptr TTF_Text; wrap_width: cint): bool {.cdecl,
    importc: "TTF_SetTextWrapWidth".}
proc TTF_GetTextWrapWidth*(text: ptr TTF_Text; wrap_width: ptr cint): bool {.
    cdecl, importc: "TTF_GetTextWrapWidth".}
proc TTF_SetTextWrapWhitespaceVisible*(text: ptr TTF_Text; visible: bool): bool {.
    cdecl, importc: "TTF_SetTextWrapWhitespaceVisible".}
proc TTF_TextWrapWhitespaceVisible*(text: ptr TTF_Text): bool {.cdecl,
    importc: "TTF_TextWrapWhitespaceVisible".}
proc TTF_SetTextString*(text: ptr TTF_Text; string: cstring; length: csize_t): bool {.
    cdecl, importc: "TTF_SetTextString".}
proc TTF_InsertTextString*(text: ptr TTF_Text; offset: cint; string: cstring;
                           length: csize_t): bool {.cdecl,
    importc: "TTF_InsertTextString".}
proc TTF_AppendTextString*(text: ptr TTF_Text; string: cstring; length: csize_t): bool {.
    cdecl, importc: "TTF_AppendTextString".}
proc TTF_DeleteTextString*(text: ptr TTF_Text; offset: cint; length: cint): bool {.
    cdecl, importc: "TTF_DeleteTextString".}
proc TTF_GetTextSize*(text: ptr TTF_Text; w: ptr cint; h: ptr cint): bool {.
    cdecl, importc: "TTF_GetTextSize".}
proc TTF_GetTextSubString*(text: ptr TTF_Text; offset: cint;
                           substring: ptr TTF_SubString): bool {.cdecl,
    importc: "TTF_GetTextSubString".}
proc TTF_GetTextSubStringForLine*(text: ptr TTF_Text; line: cint;
                                  substring: ptr TTF_SubString): bool {.cdecl,
    importc: "TTF_GetTextSubStringForLine".}
proc TTF_GetTextSubStringsForRange*(text: ptr TTF_Text; offset: cint;
                                    length: cint; count: ptr cint): ptr ptr TTF_SubString {.
    cdecl, importc: "TTF_GetTextSubStringsForRange".}
proc TTF_GetTextSubStringForPoint*(text: ptr TTF_Text; x: cint; y: cint;
                                   substring: ptr TTF_SubString): bool {.cdecl,
    importc: "TTF_GetTextSubStringForPoint".}
proc TTF_GetPreviousTextSubString*(text: ptr TTF_Text;
                                   substring: ptr TTF_SubString;
                                   previous: ptr TTF_SubString): bool {.cdecl,
    importc: "TTF_GetPreviousTextSubString".}
proc TTF_GetNextTextSubString*(text: ptr TTF_Text; substring: ptr TTF_SubString;
                               next: ptr TTF_SubString): bool {.cdecl,
    importc: "TTF_GetNextTextSubString".}
proc TTF_UpdateText*(text: ptr TTF_Text): bool {.cdecl,
    importc: "TTF_UpdateText".}
proc TTF_DestroyText*(text: ptr TTF_Text): void {.cdecl,
    importc: "TTF_DestroyText".}
proc TTF_CloseFont*(font: ptr TTF_Font): void {.cdecl, importc: "TTF_CloseFont".}
proc TTF_Quit*(): void {.cdecl, importc: "TTF_Quit".}
proc TTF_WasInit*(): cint {.cdecl, importc: "TTF_WasInit".}











