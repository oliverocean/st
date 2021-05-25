# Build
- open ```prototype-f4.ioc``` with STM32CubeMX and generate BSP code
- create the ```build``` directory in the project root
- cd to build folder and run:
```cmake -DBOARD=prototype-f4 -DCMAKE_TOOLCHAIN_FILE=../cmake/clang-arm-none-eabi.cmake```
- run ```make```

--

# TODO
- setup cmake build system
- test new build on board
- document: board description, build instructions
- update system diagram, add png to project page
- setup CMSIS/FreeRTOS
- implement peripherals (display, led strip, sd card reader, etc)
