#/* THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
# * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
# * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
# * THE AUTHORS SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
# * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER. USE IT AT YOUR OWN RISK */

ARCH = C:\\ARM_GCC\\4.9\\bin\\arm-none-eabi
MBED_VOLUME = /Volumes/MBED

# Tool definitions
CC      = $(ARCH)-gcc
LD      = $(ARCH)-gcc
AR      = $(ARCH)-ar
AS      = $(ARCH)-as
CP      = $(ARCH)-objcopy
OD	= $(ARCH)-objdump
SIZE	= $(ARCH)-size
RM	= rm
Q	= # @./quiet "$@"

# Flags
CPU = -mcpu=cortex-m3 -mthumb
CFLAGS   = $(CPU) -W -Wall -Os --std=gnu99 -fgnu89-inline
CFLAGS  += -ffunction-sections -fdata-sections
ASFLAGS  =
LDFLAGS  = $(CPU) -Wl,--gc-sections --specs=nosys.specs -u _printf_float -u _scanf_float -Wl,--cref
CPFLAGS  =
ODFLAGS  = -x --syms
PRFLAGS ?=

# Source files
LINKER_SCRIPT = LPC1768\\LPC1768.ld
CSRCS += main.c
ASRCS  = 
CSRCS = $(wildcard *.c)


OBJS   = $(CSRCS:.c=.o) $(ASRCS:.s=.o) LPC1768\\cmsis_nvic.o LPC1768\\startup_LPC17xx.o LPC1768\\system_LPC17xx.o

.PHONY: all size clean nuke

all: main.bin main.hex 

isp: main.bin
#	@./quiet $< cp $^ $(MBED_VOLUME)/

size: main.elf
	@$(SIZE) $<

%.hex: %.elf
	$Q $(CP) $(CPFLAGS) -O ihex $< $*.hex

%.bin: %.elf
	$Q $(CP) $(CPFLAGS) -O binary $< $*.bin

main.elf: $(LINKER_SCRIPT) $(OBJS)
	$Q $(LD) $(LDFLAGS) -T $^ -o $@ 
	$Q $(OD) $(ODFLAGS) $@ > $(@:.elf=.dump)
	@$(SIZE) $@

%.o: %.c
	@$(CC) -MM $< -MF $*.d -MP
	$Q $(CC) -c $(CFLAGS) $< -o $@

%.o: %.S
	$Q $(AS) $(ASFLAGS) $< -o $@

clean:
	@-rm -f *.elf
	@-\
for D in "." "**"; do \
  rm -f $$D/*.o $$D/*.d $$D/*.lst $$D/*.dump $$D/*.map; \
done

nuke: clean
	-rm -f *.hex *.bin

-include $(CSRCS:.c=.d)
