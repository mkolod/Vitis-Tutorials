#!/bin/bash

# Software emulation
g++ -Wall -g -std=c++11 ../../src/host.cpp -o app.exe -I${XILINX_XRT}/include/ -L${XILINX_XRT}/lib/ -lOpenCL -lpthread -lrt -lstdc++
emconfigutil --platform Xilinx_u50_gen3x16_xdma_201920_3 --nd 1
v++ -c -t sw_emu --config ../../src/u50.cfg -k vadd -I../../src ../../src/vadd.cpp -o vadd.xo
v++ -l -t sw_emu --config ../../src/u50.cfg ./vadd.xo -o vadd.xclbin
XCL_EMULATION_MODE=sw_emu ./app.exe

