@echo off
ECHO Compiling to bitcode

@REM clang -emit-llvm simple.cpp -c
@REM WORKING VERSION clang -emit-llvm simple.c -c 
clang -emit-llvm simple.c -g -c -std=gnu99 -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -fmessage-length=0 -fno-exceptions -fno-builtin -ffunction-sections -fdata-sections -funsigned-char -MMD -fno-delete-null-pointer-checks -fomit-frame-pointer -mcpu=cortex-m3 -mthumb -target thumbv7-none-none-eabi
@REM add -Os above for debug info

PAUSE

ECHO Disassembling to human readable format
llvm-dis simple.bc

ECHO Running Transform
opt -hello3 simple.bc -S -o simple_opt.ll

ECHO Creating object
llc -code-model=small -data-sections -relocation-model=pic -march=thumb -mcpu=cortex-m3 -mtriple=Thumb-NoSubArch-UnknownVendor-UnknownOS-GNUEABI-ELF -filetype=obj -o=simple.o simple.bc

ECHO Copy object one directory up
copy simple.o ..\simple.o

ECHO Reconstructing C++ IR
@REM llc -march=cpp -o reconstructed.cpp simple.ll