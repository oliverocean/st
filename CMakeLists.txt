cmake_minimum_required(VERSION 3.16)

enable_language(ASM)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_BUILD_TYPE Debug)

# Allow switching of target platform
set(BOARD_LIST stm32f407g)
set(BOARD stm32f407g CACHE STRING "Default target platform is stm32f407g")
set_property(CACHE BOARD PROPERTY STRINGS ${BOARD_LIST})

# :
string(JOIN " " CPU_FLAGS
    "-mthumb"
    "-mcpu=cortex-m4"
    "-mfloat-abi=softfp"
    "-mfpu=fpv4-sp-d16"



