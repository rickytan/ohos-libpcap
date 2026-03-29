# CMake toolchain file for OHOS cross-compilation
# Expects OHOS_NDK_HOME and OHOS_TARGET_TRIPLE to be set in the environment.

set(CMAKE_SYSTEM_NAME OHOS)

set(OHOS_NDK_HOME "$ENV{OHOS_NDK_HOME}" CACHE PATH "OHOS NDK path")
set(OHOS_TARGET_TRIPLE "$ENV{OHOS_TARGET_TRIPLE}" CACHE STRING "OHOS target triple")
set(OHOS_ARCH "$ENV{OHOS_ARCH}" CACHE STRING "OHOS architecture")

set(OHOS_LLVM_BIN "${OHOS_NDK_HOME}/native/llvm/bin")
set(OHOS_SYSROOT "${OHOS_NDK_HOME}/native/sysroot")

# C Compiler
set(CMAKE_C_COMPILER "${OHOS_LLVM_BIN}/clang")
set(CMAKE_C_FLAGS_INIT "-target ${OHOS_TARGET_TRIPLE} --sysroot=${OHOS_SYSROOT} -D__MUSL__")

# C++ Compiler
set(CMAKE_CXX_COMPILER "${OHOS_LLVM_BIN}/clang++")
set(CMAKE_CXX_FLAGS_INIT "-target ${OHOS_TARGET_TRIPLE} --sysroot=${OHOS_SYSROOT} -D__MUSL__")

# Tools
set(CMAKE_AR "${OHOS_LLVM_BIN}/llvm-ar" CACHE FILEPATH "Archiver")
set(CMAKE_RANLIB "${OHOS_LLVM_BIN}/llvm-ranlib" CACHE FILEPATH "Ranlib")
set(CMAKE_STRIP "${OHOS_LLVM_BIN}/llvm-strip" CACHE FILEPATH "Strip")
set(CMAKE_NM "${OHOS_LLVM_BIN}/llvm-nm" CACHE FILEPATH "NM")
set(CMAKE_OBJCOPY "${OHOS_LLVM_BIN}/llvm-objcopy" CACHE FILEPATH "Objcopy")
set(CMAKE_OBJDUMP "${OHOS_LLVM_BIN}/llvm-objdump" CACHE FILEPATH "Objdump")
set(CMAKE_LINKER "${OHOS_LLVM_BIN}/ld.lld" CACHE FILEPATH "Linker")

# Sysroot
set(CMAKE_SYSROOT "${OHOS_SYSROOT}")

# Search paths: find libraries/headers in sysroot, never on host
set(CMAKE_FIND_ROOT_PATH "${OHOS_SYSROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# armeabi-v7a extra flags
if("$ENV{OHOS_ARCH}" STREQUAL "armeabi-v7a")
    set(CMAKE_C_FLAGS_INIT "${CMAKE_C_FLAGS_INIT} -march=armv7-a -mfloat-abi=softfp -mtune=generic-armv7-a -mthumb")
    set(CMAKE_CXX_FLAGS_INIT "${CMAKE_CXX_FLAGS_INIT} -march=armv7-a -mfloat-abi=softfp -mtune=generic-armv7-a -mthumb")
endif()
