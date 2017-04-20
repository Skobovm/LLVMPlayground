@echo off

IF /i "%GCC_BIN%"=="" (
    ECHO GCC_BIN is not defined. Trying not-so-default location. 
    SET GCC_BIN="C:\ARM_GCC\4.9\bin\"
)

ECHO.
ECHO Trying to start pyOCD for Windows
kill pyocd_win.exe
START /I pyocd_win.exe

PAUSE

ECHO.
ECHO Trying to attach to remote target on port 3333
"%GCC_BIN%arm-none-eabi-gdb.exe" BUILD\mbed_blinky.elf %* -ex "target remote :3333" -ex "monitor halt reset" -ex "ni"

exit /b