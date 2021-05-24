# <--[ gdb-helper.cmake ]------------------------------------------------------------> #

set(CURRENT_MODULE_DIR ${CMAKE_CURRENT_LIST_DIR})

set(GDB_BIN arm-none-eabi-gdb CACHE STRING "GDB executable")
set(OPENOCD_BIN openocd CACHE STRING "OpenOCD executable")


# <--[ Generate GDB run script for debug with OpenOCD ]--> #
function(generate_run_gdb_openocd TARGET)
    get_target_property(TARGET_NAME ${TARGET} NAME)
    configure_file(${CURRENT_MODULE_DIR}/openocd-run.gdb.in ${PROJECT_BINARY_DIR}/openocd-run.gdb @ONLY)
endfunction()


# <--[ eof ]-------------------------------------------------------------------------> #
