# Build

The BSP folder on the repo only contains ```CMakeLists.txt``` and ```prototype-f4.ioc```.
The ```ioc``` file can be used to generate the necessary bsp files via the STM32CubeMX tool.
(note this is not the same tool as 'STM32CubeIDE').

If you are on Arch Linux, you can install it from the aur with:
```yay -S stm32cubemx```

Open ```prototype-f4.ioc``` and click the 'generate code' button.
The tool should automagically download board-specific firmware and such if needed.

```zsh
# make sure the BSP code was generated
% ls -l bsp/prototype-f4
CMakeLists.txt
Core
Drivers
Makefile
prototype-f4.ioc
startup_stm32f407xx.s
STM32F407VGT_FLASH.ld

# sort .ioc file to avoid extraneous git updates (CubeMX randomly switches line order)
% sort prototype-f4.ioc -o prototype-f4.ioc

# create the build directory
% mkdir build
% cd build

# run cmake: the toolchain file may need to be edited to match your compiler version
% cmake -DBOARD=prototype-f4 -DCMAKE_TOOLCHAIN_FILE=../cmake/clang-arm-none-eabi.cmake ..

-- The ASM compiler identification is GNU
-- Found assembler: /usr/bin/arm-none-eabi-gcc
-- The C compiler identification is Clang 11.1.0
-- The CXX compiler identification is Clang 11.1.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/clang - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/clang++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done
-- Generating done
-- Build files have been written to: ./<project root>/build

# run make
% make # optional add -j<nproc> e.g. 'make -j12' if you have 12 cores

Scanning dependencies of target board
[  5%] Building C object bsp/prototype-f4/...
[ 35%] Building ASM object bsp/prototype-f4/...
[ 95%] Built target board
[100%] Linking C executable prototype-f4
   text   data    bss    dec    hex   filename
   3680   1096    1572   6348   18cc  prototype-f4
[100%] Built target prototype-f4
[100%] Built target prototype-f4.hex
[100%] Built target prototype-f4.bin

```


----

# TODO
- setup cmake build system
- test new build on board
- document: board description, build instructions
- update system diagram, add png to project page
- setup CMSIS/FreeRTOS
- implement peripherals (display, led strip, sd card reader, etc)
