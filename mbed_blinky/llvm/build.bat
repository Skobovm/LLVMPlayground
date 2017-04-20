@echo off
ECHO Compiling to bitcode

clang -emit-llvm simple.cpp -c

ECHO Disassembling to human readable format
llvm-dis simple.bc

ECHO Creating object
llc -code-model=small -data-sections -relocation-model=pic -march=thumb -mcpu=cortex-m3 -mtriple=Thumb-NoSubArch-UnknownVendor-UnknownOS-GNUEABI-ELF -filetype=obj -o=simple.o simple.bc

ECHO Copy object one directory up
copy simple.o ..\simple.o