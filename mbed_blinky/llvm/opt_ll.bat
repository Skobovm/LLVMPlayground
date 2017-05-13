@echo off

ECHO Creating object
@REM llc -code-model=small -data-sections -relocation-model=pic -march=thumb -mcpu=cortex-m3 -mtriple=Thumb-NoSubArch-UnknownVendor-UnknownOS-GNUEABI-ELF -filetype=obj -o=simple_opt.o simple_opt.ll
llc -code-model=small -data-sections -relocation-model=pic -march=thumb -mcpu=cortex-m3 -mtriple=arm-none-eabi -filetype=obj -o=simple_opt.o simple_opt.ll

ECHO Copy object one directory up
copy simple_opt.o ..\simple_opt.o