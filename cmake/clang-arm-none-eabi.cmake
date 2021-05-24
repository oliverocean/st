# <--[ clang-arm-none-eabi.cmake ]---------------------------------------------------> #

cmake_minimum_required(VERSION 3.16)

# Append current directory to CMAKE_MODULE_PATH for making device specific cmake modules visible
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(TOOLCHAIN_TRIPLE arm-none-eabi)

set(CMAKE_C_COMPILER_ID "Clang")

set(CMAKE_C_COMPILER clang)
set(CMAKE_C_COMPILER_TARGET ${TOOLCHAIN_TRIPLE})

set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_COMPILER_TARGET ${TOOLCHAIN_TRIPLE})

set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
set(CMAKE_ASM_COMPILER_TARGET ${TOOLCHAIN_TRIPLE})

set(CMAKE_C_LINK_EXECUTABLE "arm-none-eabi-gcc <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_CXX_LINK_EXECUTABLE "arm-none-eabi-g++ <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")

include_directories(BEFORE /usr/arm-none-eabi/include/c++/11.1.0
                           /usr/arm-none-eabi/include/c++/11.1.0/arm-none-eabi
                           /usr/arm-none-eabi/include)

# Without following flag, CMake is not able to pass test compilation check.
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_SYSROOT /usr/arm-none-eabi)
set(CMAKE_FIND_ROOT_PATH /usr/arm-none-eabi)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# <--[ eof ]-------------------------------------------------------------------------> #
