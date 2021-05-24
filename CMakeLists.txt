# <--[ CMakeLists.txt ]--------------------------------------------------------------> #
cmake_minimum_required(VERSION 3.16)

enable_language(ASM)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_BUILD_TYPE Debug)

# <--[ Allow switching of target platform ]--> #
set(BOARD_LIST prototype-f4 prototype-g0)
set(BOARD prototype-f4 CACHE STRING "Default target platform is prototype-f4")
set_property(CACHE BOARD PROPERTY STRINGS ${BOARD_LIST})


# <--[ Flags ]-----------------------------------------------------------------------> #

# <--[ CPU ]--> #
string(JOIN " " CPU_FLAGS
    "-mcpu=cortex-m4"       # cpu
    "-mfpu=fpv4-sp-d16"     # fpu
    "-mfloat-abi=hard"      # float-abi
    "-mthumb"               # mcu
)

# <--[ Debug ]--> #
string(JOIN " " DEBUG_FLAGS
    "-Og"       # optimized debugging experience
    "-ggdb"     # produce debugging information for use by GDB
    "-g3"       # include extra info such as macro definitions, macro expansion support
)

# TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO #
# add comments on flags

# <--[ Warnings ]--> #
list(APPEND WARNING_FLAGS
    "-Wall"
    "-Wextra"
    "-Wno-unused-parameter"
)

if (CMAKE_C_COMPILER_ID MATCHES "GNU")
    list(APPEND WARNING_FLAGS
        "-Wno-pointer-compare"
    )
elseif (CMAKE_C_COMPILER_ID MATCHES "Clang")
    list(APPEND WARNING_FLAGS
        "-Wno-parentheses-equality"
        "-Wno-deprecated-register"
        "-Wno-gnu-include-next"
        "-Wno-format-security"
    )
else()
    message(FATAL_ERROR "Toolchain '${CMAKE_C_COMPILER_ID}' not supported")
endif()

string(JOIN " " WARNING_FLAGS ${WARNING_FLAGS})

# <--[ Options ]--> #
string(JOIN " " OPTION_FLAGS
    "-fno-builtin"
    "-ffunction-sections"
    "-fdata-sections"
    "-fomit-frame-pointer"
    "-fno-exceptions"
    "-fno-unroll-loops"
    "-ffast-math"
    "-ftree-vectorize"
    "-fshort-enums"
    "-fno-common"
)

# <--[ C ]--> #
string(JOIN " " CMAKE_C_FLAGS
    "-std=gnu11"
    ${CPU_FLAGS}
    ${DEBUG_FLAGS}
    ${WARNING_FLAGS}
    ${OPTION_FLAGS}
)

# <--[ CXX ]--> #
string(JOIN " " CMAKE_CXX_FLAGS
    "-std=c++17"
    ${CPU_FLAGS}
    ${DEBUG_FLAGS}
    ${WARNING_FLAGS}
    ${OPTION_FLAGS}
)

# <--[ ASM ]--> #
string(JOIN " " CMAKE_ASM_FLAGS
    "-x assembler-with-cpp"
    ${CPU_FLAGS}
    ${WARNING_FLAGS}
    ${OPTION_FLAGS}
)


# TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO #
# whats happening here?
# <--[ ?? ]-----------------------------------------------------------------------> #
set(BSP_DIR ${CMAKE_CURRENT_SOURCE_DIR}/bsp/${BOARD})
add_subdirectory(${BSP_DIR})

get_directory_property(LINKER_SCRIPT DIRECTORY ${BSP_DIR} DEFINITION LINKER_SCRIPT)
string(JOIN " " CMAKE_EXE_LINKER_FLAGS
    "-Wl,--gc-sections"
    "--specs=nosys.specs"
    ${CPU_FLAGS}
    "-T${LINKER_SCRIPT}"
)


# TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO #
# <--[ Source Files ]----------------------------------------------------------------> #
#list(APPEND SOURCE_FILES
#    src/foo/foo.cpp
#)


# TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO #
# whats happening here?
# <--[ ?? ]-----------------------------------------------------------------------> #
project(${BOARD})
add_executable(${PROJECT_NAME}
    ${SOURCE_FILES}
    $<TARGET_OBJECTS:board>
)

target_include_directories(${PROJECT_NAME} PUBLIC
    inc
    $<TARGET_PROPERTY:board,INTERFACE_INCLUDE_DIRECTORIES>
)

target_compile_definitions(${PROJECT_NAME} PUBLIC
    $<TARGET_PROPERTY:board,INTERFACE_COMPILE_DEFINITIONS>
)

target_link_libraries(${PROJECT_NAME} PRIVATE c m nosys)


# <--[ Generate OpenOCD Script ]-----------------------------------------------------> #

include(gdb-helper)
generate_run_gdb_openocd(${PROJECT_NAME})


# <--[ Generate output via objcopy tool ]--------------------------------------------> #

include(binutils-arm-none-eabi)
create_bin_output(${PROJECT_NAME})
create_hex_output(${PROJECT_NAME})
print_section_sizes(${PROJECT_NAME})


# <--[ eof ]-------------------------------------------------------------------------> #
