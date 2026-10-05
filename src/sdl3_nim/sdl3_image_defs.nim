import sdl3_nim

type
  enum_IMG_AnimationDecoderStatus* {.size: sizeof(cint).} = enum
    IMG_DECODER_STATUS_INVALID = -1, IMG_DECODER_STATUS_OK = 0,
    IMG_DECODER_STATUS_FAILED = 1, IMG_DECODER_STATUS_COMPLETE = 2
type
  struct_IMG_AnimationDecoder* = object
type
  struct_IMG_AnimationEncoder* = object
type
  struct_IMG_Animation* {.pure, inheritable, bycopy.} = object
    w*: cint
    h*: cint
    count*: cint
    #frames*: ptr ptr SDL_Surface
    #delays*: ptr cint
    frames*: ptr UncheckedArray[ptr SDL_Surface]
    delays*: ptr UncheckedArray[cint]
  IMG_Animation* = struct_IMG_Animation
  IMG_AnimationEncoder* = struct_IMG_AnimationEncoder
  IMG_AnimationDecoderStatus* = enum_IMG_AnimationDecoderStatus
  IMG_AnimationDecoder* = struct_IMG_AnimationDecoder
when 3 is static:
  const
    SDL_IMAGE_MAJOR_VERSION* = 3
else:
  let SDL_IMAGE_MAJOR_VERSION* = 3
when 4 is static:
  const
    SDL_IMAGE_MINOR_VERSION* = 4
else:
  let SDL_IMAGE_MINOR_VERSION* = 4
when 6 is static:
  const
    SDL_IMAGE_MICRO_VERSION* = 6
else:
  let SDL_IMAGE_MICRO_VERSION* = 6
when "SDL_image.animation_encoder.create.filename" is static:
  const
    IMG_PROP_ANIMATION_ENCODER_CREATE_FILENAME_STRING* = "SDL_image.animation_encoder.create.filename"
else:
  let IMG_PROP_ANIMATION_ENCODER_CREATE_FILENAME_STRING* = "SDL_image.animation_encoder.create.filename"
when "SDL_image.animation_encoder.create.iostream" is static:
  const
    IMG_PROP_ANIMATION_ENCODER_CREATE_IOSTREAM_POINTER* = "SDL_image.animation_encoder.create.iostream"
else:
  let IMG_PROP_ANIMATION_ENCODER_CREATE_IOSTREAM_POINTER* = "SDL_image.animation_encoder.create.iostream"
when "SDL_image.animation_encoder.create.iostream.autoclose" is static:
  const
    IMG_PROP_ANIMATION_ENCODER_CREATE_IOSTREAM_AUTOCLOSE_BOOLEAN* = "SDL_image.animation_encoder.create.iostream.autoclose"
else:
  let IMG_PROP_ANIMATION_ENCODER_CREATE_IOSTREAM_AUTOCLOSE_BOOLEAN* = "SDL_image.animation_encoder.create.iostream.autoclose"
when "SDL_image.animation_encoder.create.type" is static:
  const
    IMG_PROP_ANIMATION_ENCODER_CREATE_TYPE_STRING* = "SDL_image.animation_encoder.create.type"
else:
  let IMG_PROP_ANIMATION_ENCODER_CREATE_TYPE_STRING* = "SDL_image.animation_encoder.create.type"
when "SDL_image.animation_encoder.create.quality" is static:
  const
    IMG_PROP_ANIMATION_ENCODER_CREATE_QUALITY_NUMBER* = "SDL_image.animation_encoder.create.quality"
else:
  let IMG_PROP_ANIMATION_ENCODER_CREATE_QUALITY_NUMBER* = "SDL_image.animation_encoder.create.quality"
when "SDL_image.animation_encoder.create.timebase.numerator" is static:
  const
    IMG_PROP_ANIMATION_ENCODER_CREATE_TIMEBASE_NUMERATOR_NUMBER* = "SDL_image.animation_encoder.create.timebase.numerator"
else:
  let IMG_PROP_ANIMATION_ENCODER_CREATE_TIMEBASE_NUMERATOR_NUMBER* = "SDL_image.animation_encoder.create.timebase.numerator"
when "SDL_image.animation_encoder.create.timebase.denominator" is static:
  const
    IMG_PROP_ANIMATION_ENCODER_CREATE_TIMEBASE_DENOMINATOR_NUMBER* = "SDL_image.animation_encoder.create.timebase.denominator"
else:
  let IMG_PROP_ANIMATION_ENCODER_CREATE_TIMEBASE_DENOMINATOR_NUMBER* = "SDL_image.animation_encoder.create.timebase.denominator"
when "SDL_image.animation_encoder.create.avif.max_threads" is static:
  const
    IMG_PROP_ANIMATION_ENCODER_CREATE_AVIF_MAX_THREADS_NUMBER* = "SDL_image.animation_encoder.create.avif.max_threads"
else:
  let IMG_PROP_ANIMATION_ENCODER_CREATE_AVIF_MAX_THREADS_NUMBER* = "SDL_image.animation_encoder.create.avif.max_threads"
when "SDL_image.animation_encoder.create.avif.keyframe_interval" is static:
  const
    IMG_PROP_ANIMATION_ENCODER_CREATE_AVIF_KEYFRAME_INTERVAL_NUMBER* = "SDL_image.animation_encoder.create.avif.keyframe_interval"
else:
  let IMG_PROP_ANIMATION_ENCODER_CREATE_AVIF_KEYFRAME_INTERVAL_NUMBER* = "SDL_image.animation_encoder.create.avif.keyframe_interval"
when "SDL_image.animation_encoder.create.gif.use_lut" is static:
  const
    IMG_PROP_ANIMATION_ENCODER_CREATE_GIF_USE_LUT_BOOLEAN* = "SDL_image.animation_encoder.create.gif.use_lut"
else:
  let IMG_PROP_ANIMATION_ENCODER_CREATE_GIF_USE_LUT_BOOLEAN* = "SDL_image.animation_encoder.create.gif.use_lut"
when "SDL_image.animation_decoder.create.filename" is static:
  const
    IMG_PROP_ANIMATION_DECODER_CREATE_FILENAME_STRING* = "SDL_image.animation_decoder.create.filename"
else:
  let IMG_PROP_ANIMATION_DECODER_CREATE_FILENAME_STRING* = "SDL_image.animation_decoder.create.filename"
when "SDL_image.animation_decoder.create.iostream" is static:
  const
    IMG_PROP_ANIMATION_DECODER_CREATE_IOSTREAM_POINTER* = "SDL_image.animation_decoder.create.iostream"
else:
  let IMG_PROP_ANIMATION_DECODER_CREATE_IOSTREAM_POINTER* = "SDL_image.animation_decoder.create.iostream"
when "SDL_image.animation_decoder.create.iostream.autoclose" is static:
  const
    IMG_PROP_ANIMATION_DECODER_CREATE_IOSTREAM_AUTOCLOSE_BOOLEAN* = "SDL_image.animation_decoder.create.iostream.autoclose"
else:
  let IMG_PROP_ANIMATION_DECODER_CREATE_IOSTREAM_AUTOCLOSE_BOOLEAN* = "SDL_image.animation_decoder.create.iostream.autoclose"
when "SDL_image.animation_decoder.create.type" is static:
  const
    IMG_PROP_ANIMATION_DECODER_CREATE_TYPE_STRING* = "SDL_image.animation_decoder.create.type"
else:
  let IMG_PROP_ANIMATION_DECODER_CREATE_TYPE_STRING* = "SDL_image.animation_decoder.create.type"
when "SDL_image.animation_decoder.create.timebase.numerator" is static:
  const
    IMG_PROP_ANIMATION_DECODER_CREATE_TIMEBASE_NUMERATOR_NUMBER* = "SDL_image.animation_decoder.create.timebase.numerator"
else:
  let IMG_PROP_ANIMATION_DECODER_CREATE_TIMEBASE_NUMERATOR_NUMBER* = "SDL_image.animation_decoder.create.timebase.numerator"
when "SDL_image.animation_decoder.create.timebase.denominator" is static:
  const
    IMG_PROP_ANIMATION_DECODER_CREATE_TIMEBASE_DENOMINATOR_NUMBER* = "SDL_image.animation_decoder.create.timebase.denominator"
else:
  let IMG_PROP_ANIMATION_DECODER_CREATE_TIMEBASE_DENOMINATOR_NUMBER* = "SDL_image.animation_decoder.create.timebase.denominator"
when "SDL_image.animation_decoder.create.avif.max_threads" is static:
  const
    IMG_PROP_ANIMATION_DECODER_CREATE_AVIF_MAX_THREADS_NUMBER* = "SDL_image.animation_decoder.create.avif.max_threads"
else:
  let IMG_PROP_ANIMATION_DECODER_CREATE_AVIF_MAX_THREADS_NUMBER* = "SDL_image.animation_decoder.create.avif.max_threads"
when "SDL_image.animation_decoder.create.avif.allow_incremental" is static:
  const
    IMG_PROP_ANIMATION_DECODER_CREATE_AVIF_ALLOW_INCREMENTAL_BOOLEAN* = "SDL_image.animation_decoder.create.avif.allow_incremental"
else:
  let IMG_PROP_ANIMATION_DECODER_CREATE_AVIF_ALLOW_INCREMENTAL_BOOLEAN* = "SDL_image.animation_decoder.create.avif.allow_incremental"
when "SDL_image.animation_decoder.create.avif.allow_progressive" is static:
  const
    IMG_PROP_ANIMATION_DECODER_CREATE_AVIF_ALLOW_PROGRESSIVE_BOOLEAN* = "SDL_image.animation_decoder.create.avif.allow_progressive"
else:
  let IMG_PROP_ANIMATION_DECODER_CREATE_AVIF_ALLOW_PROGRESSIVE_BOOLEAN* = "SDL_image.animation_decoder.create.avif.allow_progressive"
when "SDL_image.animation_encoder.create.gif.transparent_color_index" is static:
  const
    IMG_PROP_ANIMATION_DECODER_CREATE_GIF_TRANSPARENT_COLOR_INDEX_NUMBER* = "SDL_image.animation_encoder.create.gif.transparent_color_index"
else:
  let IMG_PROP_ANIMATION_DECODER_CREATE_GIF_TRANSPARENT_COLOR_INDEX_NUMBER* = "SDL_image.animation_encoder.create.gif.transparent_color_index"
when "SDL_image.animation_encoder.create.gif.num_colors" is static:
  const
    IMG_PROP_ANIMATION_DECODER_CREATE_GIF_NUM_COLORS_NUMBER* = "SDL_image.animation_encoder.create.gif.num_colors"
else:
  let IMG_PROP_ANIMATION_DECODER_CREATE_GIF_NUM_COLORS_NUMBER* = "SDL_image.animation_encoder.create.gif.num_colors"
when "SDL_image.metadata.ignore_props" is static:
  const
    IMG_PROP_METADATA_IGNORE_PROPS_BOOLEAN* = "SDL_image.metadata.ignore_props"
else:
  let IMG_PROP_METADATA_IGNORE_PROPS_BOOLEAN* = "SDL_image.metadata.ignore_props"
when "SDL_image.metadata.description" is static:
  const
    IMG_PROP_METADATA_DESCRIPTION_STRING* = "SDL_image.metadata.description"
else:
  let IMG_PROP_METADATA_DESCRIPTION_STRING* = "SDL_image.metadata.description"
when "SDL_image.metadata.copyright" is static:
  const
    IMG_PROP_METADATA_COPYRIGHT_STRING* = "SDL_image.metadata.copyright"
else:
  let IMG_PROP_METADATA_COPYRIGHT_STRING* = "SDL_image.metadata.copyright"
when "SDL_image.metadata.title" is static:
  const
    IMG_PROP_METADATA_TITLE_STRING* = "SDL_image.metadata.title"
else:
  let IMG_PROP_METADATA_TITLE_STRING* = "SDL_image.metadata.title"
when "SDL_image.metadata.author" is static:
  const
    IMG_PROP_METADATA_AUTHOR_STRING* = "SDL_image.metadata.author"
else:
  let IMG_PROP_METADATA_AUTHOR_STRING* = "SDL_image.metadata.author"
when "SDL_image.metadata.creation_time" is static:
  const
    IMG_PROP_METADATA_CREATION_TIME_STRING* = "SDL_image.metadata.creation_time"
else:
  let IMG_PROP_METADATA_CREATION_TIME_STRING* = "SDL_image.metadata.creation_time"
when "SDL_image.metadata.frame_count" is static:
  const
    IMG_PROP_METADATA_FRAME_COUNT_NUMBER* = "SDL_image.metadata.frame_count"
else:
  let IMG_PROP_METADATA_FRAME_COUNT_NUMBER* = "SDL_image.metadata.frame_count"
when "SDL_image.metadata.loop_count" is static:
  const
    IMG_PROP_METADATA_LOOP_COUNT_NUMBER* = "SDL_image.metadata.loop_count"
else:
  let IMG_PROP_METADATA_LOOP_COUNT_NUMBER* = "SDL_image.metadata.loop_count"
proc IMG_Version*(): cint {.cdecl, importc: "IMG_Version".}
proc IMG_Load*(file: cstring): ptr SDL_Surface {.cdecl, importc: "IMG_Load".}
proc IMG_Load_IO*(src: ptr SDL_IOStream; closeio: bool): ptr SDL_Surface {.
    cdecl, importc: "IMG_Load_IO".}
proc IMG_LoadTyped_IO*(src: ptr SDL_IOStream; closeio: bool; type_arg: cstring): ptr SDL_Surface {.
    cdecl, importc: "IMG_LoadTyped_IO".}
proc IMG_LoadTexture*(renderer: ptr SDL_Renderer; file: cstring): ptr SDL_Texture {.
    cdecl, importc: "IMG_LoadTexture".}
proc IMG_LoadTexture_IO*(renderer: ptr SDL_Renderer; src: ptr SDL_IOStream;
                         closeio: bool): ptr SDL_Texture {.cdecl,
    importc: "IMG_LoadTexture_IO".}
proc IMG_LoadTextureTyped_IO*(renderer: ptr SDL_Renderer; src: ptr SDL_IOStream;
                              closeio: bool; type_arg: cstring): ptr SDL_Texture {.
    cdecl, importc: "IMG_LoadTextureTyped_IO".}
proc IMG_LoadGPUTexture*(device: ptr SDL_GPUDevice;
                         copy_pass: ptr SDL_GPUCopyPass; file: cstring;
                         width: ptr cint; height: ptr cint): ptr SDL_GPUTexture {.
    cdecl, importc: "IMG_LoadGPUTexture".}
proc IMG_LoadGPUTexture_IO*(device: ptr SDL_GPUDevice;
                            copy_pass: ptr SDL_GPUCopyPass;
                            src: ptr SDL_IOStream; closeio: bool;
                            width: ptr cint; height: ptr cint): ptr SDL_GPUTexture {.
    cdecl, importc: "IMG_LoadGPUTexture_IO".}
proc IMG_LoadGPUTextureTyped_IO*(device: ptr SDL_GPUDevice;
                                 copy_pass: ptr SDL_GPUCopyPass;
                                 src: ptr SDL_IOStream; closeio: bool;
                                 type_arg: cstring; width: ptr cint;
                                 height: ptr cint): ptr SDL_GPUTexture {.cdecl,
    importc: "IMG_LoadGPUTextureTyped_IO".}
proc IMG_GetClipboardImage*(): ptr SDL_Surface {.cdecl,
    importc: "IMG_GetClipboardImage".}
proc IMG_isANI*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isANI".}
proc IMG_isAVIF*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isAVIF".}
proc IMG_isCUR*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isCUR".}
proc IMG_isBMP*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isBMP".}
proc IMG_isGIF*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isGIF".}
proc IMG_isICO*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isICO".}
proc IMG_isJPG*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isJPG".}
proc IMG_isJXL*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isJXL".}
proc IMG_isLBM*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isLBM".}
proc IMG_isPCX*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isPCX".}
proc IMG_isPNG*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isPNG".}
proc IMG_isPNM*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isPNM".}
proc IMG_isQOI*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isQOI".}
proc IMG_isSVG*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isSVG".}
proc IMG_isTIF*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isTIF".}
proc IMG_isWEBP*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isWEBP".}
proc IMG_isXCF*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isXCF".}
proc IMG_isXPM*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isXPM".}
proc IMG_isXV*(src: ptr SDL_IOStream): bool {.cdecl, importc: "IMG_isXV".}
proc IMG_LoadAVIF_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadAVIF_IO".}
proc IMG_LoadBMP_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadBMP_IO".}
proc IMG_LoadCUR_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadCUR_IO".}
proc IMG_LoadGIF_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadGIF_IO".}
proc IMG_LoadICO_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadICO_IO".}
proc IMG_LoadJPG_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadJPG_IO".}
proc IMG_LoadJXL_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadJXL_IO".}
proc IMG_LoadLBM_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadLBM_IO".}
proc IMG_LoadPCX_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadPCX_IO".}
proc IMG_LoadPNG_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadPNG_IO".}
proc IMG_LoadPNM_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadPNM_IO".}
proc IMG_LoadSVG_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadSVG_IO".}
proc IMG_LoadSizedSVG_IO*(src: ptr SDL_IOStream; width: cint; height: cint): ptr SDL_Surface {.
    cdecl, importc: "IMG_LoadSizedSVG_IO".}
proc IMG_LoadQOI_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadQOI_IO".}
proc IMG_LoadTGA_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadTGA_IO".}
proc IMG_LoadTIF_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadTIF_IO".}
proc IMG_LoadWEBP_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadWEBP_IO".}
proc IMG_LoadXCF_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadXCF_IO".}
proc IMG_LoadXPM_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadXPM_IO".}
proc IMG_LoadXV_IO*(src: ptr SDL_IOStream): ptr SDL_Surface {.cdecl,
    importc: "IMG_LoadXV_IO".}
proc IMG_ReadXPMFromArray*(xpm: ptr cstring): ptr SDL_Surface {.cdecl,
    importc: "IMG_ReadXPMFromArray".}
proc IMG_ReadXPMFromArrayToRGB888*(xpm: ptr cstring): ptr SDL_Surface {.cdecl,
    importc: "IMG_ReadXPMFromArrayToRGB888".}
proc IMG_Save*(surface: ptr SDL_Surface; file: cstring): bool {.cdecl,
    importc: "IMG_Save".}
proc IMG_SaveTyped_IO*(surface: ptr SDL_Surface; dst: ptr SDL_IOStream;
                       closeio: bool; type_arg: cstring): bool {.cdecl,
    importc: "IMG_SaveTyped_IO".}
proc IMG_SaveAVIF*(surface: ptr SDL_Surface; file: cstring; quality: cint): bool {.
    cdecl, importc: "IMG_SaveAVIF".}
proc IMG_SaveAVIF_IO*(surface: ptr SDL_Surface; dst: ptr SDL_IOStream;
                      closeio: bool; quality: cint): bool {.cdecl,
    importc: "IMG_SaveAVIF_IO".}
proc IMG_SaveBMP*(surface: ptr SDL_Surface; file: cstring): bool {.cdecl,
    importc: "IMG_SaveBMP".}
proc IMG_SaveBMP_IO*(surface: ptr SDL_Surface; dst: ptr SDL_IOStream;
                     closeio: bool): bool {.cdecl, importc: "IMG_SaveBMP_IO".}
proc IMG_SaveCUR*(surface: ptr SDL_Surface; file: cstring): bool {.cdecl,
    importc: "IMG_SaveCUR".}
proc IMG_SaveCUR_IO*(surface: ptr SDL_Surface; dst: ptr SDL_IOStream;
                     closeio: bool): bool {.cdecl, importc: "IMG_SaveCUR_IO".}
proc IMG_SaveGIF*(surface: ptr SDL_Surface; file: cstring): bool {.cdecl,
    importc: "IMG_SaveGIF".}
proc IMG_SaveGIF_IO*(surface: ptr SDL_Surface; dst: ptr SDL_IOStream;
                     closeio: bool): bool {.cdecl, importc: "IMG_SaveGIF_IO".}
proc IMG_SaveICO*(surface: ptr SDL_Surface; file: cstring): bool {.cdecl,
    importc: "IMG_SaveICO".}
proc IMG_SaveICO_IO*(surface: ptr SDL_Surface; dst: ptr SDL_IOStream;
                     closeio: bool): bool {.cdecl, importc: "IMG_SaveICO_IO".}
proc IMG_SaveJPG*(surface: ptr SDL_Surface; file: cstring; quality: cint): bool {.
    cdecl, importc: "IMG_SaveJPG".}
proc IMG_SaveJPG_IO*(surface: ptr SDL_Surface; dst: ptr SDL_IOStream;
                     closeio: bool; quality: cint): bool {.cdecl,
    importc: "IMG_SaveJPG_IO".}
proc IMG_SavePNG*(surface: ptr SDL_Surface; file: cstring): bool {.cdecl,
    importc: "IMG_SavePNG".}
proc IMG_SavePNG_IO*(surface: ptr SDL_Surface; dst: ptr SDL_IOStream;
                     closeio: bool): bool {.cdecl, importc: "IMG_SavePNG_IO".}
proc IMG_SaveTGA*(surface: ptr SDL_Surface; file: cstring): bool {.cdecl,
    importc: "IMG_SaveTGA".}
proc IMG_SaveTGA_IO*(surface: ptr SDL_Surface; dst: ptr SDL_IOStream;
                     closeio: bool): bool {.cdecl, importc: "IMG_SaveTGA_IO".}
proc IMG_SaveWEBP*(surface: ptr SDL_Surface; file: cstring; quality: cfloat): bool {.
    cdecl, importc: "IMG_SaveWEBP".}
proc IMG_SaveWEBP_IO*(surface: ptr SDL_Surface; dst: ptr SDL_IOStream;
                      closeio: bool; quality: cfloat): bool {.cdecl,
    importc: "IMG_SaveWEBP_IO".}
proc IMG_LoadAnimation*(file: cstring): ptr IMG_Animation {.cdecl,
    importc: "IMG_LoadAnimation".}
proc IMG_LoadAnimation_IO*(src: ptr SDL_IOStream; closeio: bool): ptr IMG_Animation {.
    cdecl, importc: "IMG_LoadAnimation_IO".}
proc IMG_LoadAnimationTyped_IO*(src: ptr SDL_IOStream; closeio: bool;
                                type_arg: cstring): ptr IMG_Animation {.cdecl,
    importc: "IMG_LoadAnimationTyped_IO".}
proc IMG_LoadANIAnimation_IO*(src: ptr SDL_IOStream): ptr IMG_Animation {.cdecl,
    importc: "IMG_LoadANIAnimation_IO".}
proc IMG_LoadAPNGAnimation_IO*(src: ptr SDL_IOStream): ptr IMG_Animation {.
    cdecl, importc: "IMG_LoadAPNGAnimation_IO".}
proc IMG_LoadAVIFAnimation_IO*(src: ptr SDL_IOStream): ptr IMG_Animation {.
    cdecl, importc: "IMG_LoadAVIFAnimation_IO".}
proc IMG_LoadGIFAnimation_IO*(src: ptr SDL_IOStream): ptr IMG_Animation {.cdecl,
    importc: "IMG_LoadGIFAnimation_IO".}
proc IMG_LoadWEBPAnimation_IO*(src: ptr SDL_IOStream): ptr IMG_Animation {.
    cdecl, importc: "IMG_LoadWEBPAnimation_IO".}
proc IMG_SaveAnimation*(anim: ptr IMG_Animation; file: cstring): bool {.cdecl,
    importc: "IMG_SaveAnimation".}
proc IMG_SaveAnimationTyped_IO*(anim: ptr IMG_Animation; dst: ptr SDL_IOStream;
                                closeio: bool; type_arg: cstring): bool {.cdecl,
    importc: "IMG_SaveAnimationTyped_IO".}
proc IMG_SaveANIAnimation_IO*(anim: ptr IMG_Animation; dst: ptr SDL_IOStream;
                              closeio: bool): bool {.cdecl,
    importc: "IMG_SaveANIAnimation_IO".}
proc IMG_SaveAPNGAnimation_IO*(anim: ptr IMG_Animation; dst: ptr SDL_IOStream;
                               closeio: bool): bool {.cdecl,
    importc: "IMG_SaveAPNGAnimation_IO".}
proc IMG_SaveAVIFAnimation_IO*(anim: ptr IMG_Animation; dst: ptr SDL_IOStream;
                               closeio: bool; quality: cint): bool {.cdecl,
    importc: "IMG_SaveAVIFAnimation_IO".}
proc IMG_SaveGIFAnimation_IO*(anim: ptr IMG_Animation; dst: ptr SDL_IOStream;
                              closeio: bool): bool {.cdecl,
    importc: "IMG_SaveGIFAnimation_IO".}
proc IMG_SaveWEBPAnimation_IO*(anim: ptr IMG_Animation; dst: ptr SDL_IOStream;
                               closeio: bool; quality: cint): bool {.cdecl,
    importc: "IMG_SaveWEBPAnimation_IO".}
proc IMG_CreateAnimatedCursor*(anim: ptr IMG_Animation; hot_x: cint; hot_y: cint): ptr SDL_Cursor {.
    cdecl, importc: "IMG_CreateAnimatedCursor".}
proc IMG_FreeAnimation*(anim: ptr IMG_Animation): void {.cdecl,
    importc: "IMG_FreeAnimation".}
proc IMG_CreateAnimationEncoder*(file: cstring): ptr IMG_AnimationEncoder {.
    cdecl, importc: "IMG_CreateAnimationEncoder".}
proc IMG_CreateAnimationEncoder_IO*(dst: ptr SDL_IOStream; closeio: bool;
                                    type_arg: cstring): ptr IMG_AnimationEncoder {.
    cdecl, importc: "IMG_CreateAnimationEncoder_IO".}
proc IMG_CreateAnimationEncoderWithProperties*(props: SDL_PropertiesID): ptr IMG_AnimationEncoder {.
    cdecl, importc: "IMG_CreateAnimationEncoderWithProperties".}
proc IMG_AddAnimationEncoderFrame*(encoder: ptr IMG_AnimationEncoder;
                                   surface: ptr SDL_Surface; duration: Uint64): bool {.
    cdecl, importc: "IMG_AddAnimationEncoderFrame".}
proc IMG_CloseAnimationEncoder*(encoder: ptr IMG_AnimationEncoder): bool {.
    cdecl, importc: "IMG_CloseAnimationEncoder".}
proc IMG_CreateAnimationDecoder*(file: cstring): ptr IMG_AnimationDecoder {.
    cdecl, importc: "IMG_CreateAnimationDecoder".}
proc IMG_CreateAnimationDecoder_IO*(src: ptr SDL_IOStream; closeio: bool;
                                    type_arg: cstring): ptr IMG_AnimationDecoder {.
    cdecl, importc: "IMG_CreateAnimationDecoder_IO".}
proc IMG_CreateAnimationDecoderWithProperties*(props: SDL_PropertiesID): ptr IMG_AnimationDecoder {.
    cdecl, importc: "IMG_CreateAnimationDecoderWithProperties".}
proc IMG_GetAnimationDecoderProperties*(decoder: ptr IMG_AnimationDecoder): SDL_PropertiesID {.
    cdecl, importc: "IMG_GetAnimationDecoderProperties".}
proc IMG_GetAnimationDecoderFrame*(decoder: ptr IMG_AnimationDecoder;
                                   frame: ptr ptr SDL_Surface;
                                   duration: ptr Uint64): bool {.cdecl,
    importc: "IMG_GetAnimationDecoderFrame".}
proc IMG_GetAnimationDecoderStatus*(decoder: ptr IMG_AnimationDecoder): IMG_AnimationDecoderStatus {.
    cdecl, importc: "IMG_GetAnimationDecoderStatus".}
proc IMG_ResetAnimationDecoder*(decoder: ptr IMG_AnimationDecoder): bool {.
    cdecl, importc: "IMG_ResetAnimationDecoder".}
proc IMG_CloseAnimationDecoder*(decoder: ptr IMG_AnimationDecoder): bool {.
    cdecl, importc: "IMG_CloseAnimationDecoder".}










