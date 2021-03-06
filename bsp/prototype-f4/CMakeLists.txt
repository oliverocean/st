# <--[ CMakeLists.txt ]--------------------------------------------------------------> #
project(board)
cmake_minimum_required(VERSION 3.16)
enable_language(ASM)


# <--[ Linking ]---------------------------------------------------------------------> #
# TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO #
# does this linker script make sense here sequentially?
# <--[ Use MCU-specific storage characteristics ]--> #
set(LINKER_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/STM32F407VGTx_FLASH.ld)


# <--[ Source + Include ]------------------------------------------------------------> #

# <--[ STM32 Startup (ASM) ]--> #
list(APPEND ${PROJECT_NAME}_SOURCE_FILES
    startup_stm32f407xx.s
)

# <--[ STM32 Core ]--> #
set (CORE_DIR Core)

list(APPEND ${PROJECT_NAME}_SOURCE_FILES
    ${CORE_DIR}/Src/main.c
    ${CORE_DIR}/Src/stm32f4xx_it.c
    ${CORE_DIR}/Src/stm32f4xx_hal_msp.c
    ${CORE_DIR}/Src/system_stm32f4xx.c
)

list(APPEND ${PROJECT_NAME}_INCLUDE_DIRS
    ${CORE_DIR}/Inc
)

# <--[ STM32 HAL Drivers ]--> #
set (STM32HAL_DIR Drivers/STM32F4xx_HAL_Driver)

list(APPEND ${PROJECT_NAME}_SOURCE_FILES
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_tim.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_tim_ex.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_rcc.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_rcc_ex.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_flash.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_flash_ex.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_flash_ramfunc.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_gpio.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_dma_ex.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_dma.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_pwr.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_pwr_ex.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_cortex.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal.c
    ${STM32HAL_DIR}/Src/stm32f4xx_hal_exti.c
)

list(APPEND ${PROJECT_NAME}_INCLUDE_DIRS
    ${STM32HAL_DIR}/Inc
    ${STM32HAL_DIR}/Inc/Legacy
)

# <--[ CMSIS ]--> #
set (CMSIS_DIR Drivers/CMSIS)

list(APPEND ${PROJECT_NAME}_INCLUDE_DIRS
    ${CMSIS_DIR}/Device/ST/STM32F4xx/Include
    ${CMSIS_DIR}/Include
)


# <--[ Library ]---------------------------------------------------------------------> #

# TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO #
# what does "EXCLUDE_FROM_ALL" imply?

# <--[ Compile an object library with appended source list ]--> #
add_library(${PROJECT_NAME} OBJECT EXCLUDE_FROM_ALL
    ${${PROJECT_NAME}_SOURCE_FILES}
)

# TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO #
# are these symbols defined in ARM or ST?
# a link would be nice
# <--[ Pre-defined ARM symbols/defines mandatory for MCU macro and driver API access ]--> #
target_compile_definitions(${PROJECT_NAME} PUBLIC
    USE_HAL_DRIVER
    STM32F407xx
)

# <--[ Compile target with appended includes list ]--> #
target_include_directories(${PROJECT_NAME} PUBLIC
    ${${PROJECT_NAME}_INCLUDE_DIRS}
)

# <--[ eof ]-------------------------------------------------------------------------> #
