# Usage: cmake -DBUILD_DIR=libs_build/build -DOUT=libs -P libs_build/collect.cmake
# Copies every static library (.a) produced by the build into one folder.
file(GLOB_RECURSE LIBS "${BUILD_DIR}/*.a")
file(MAKE_DIRECTORY "${OUT}")
foreach(lib ${LIBS})
  get_filename_component(name "${lib}" NAME)
  file(COPY_FILE "${lib}" "${OUT}/${name}" ONLY_IF_DIFFERENT)
  message(STATUS "collected ${name}")
endforeach()
