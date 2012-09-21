PROJECT=template



LSCRIPT=core/stm32_flash.ld

OPTIMIZATION = -O2
DEBUG = 

#########################################################################

SRC=$(wildcard core/*.c *.c) 
ASRC=$(wildcard core/*.s)
OBJECTS= $(SRC:.c=.o) $(ASRC:.s=.o)
LSTFILES= $(SRC:.c=.lst)
HEADERS=$(wildcard core/*.h *.h)

#  Compiler Options
GCFLAGS=  $(OPTIMIZATION) -mthumb -Icore -I. 
GCFLAGS+= -funsigned-char -Wundef -Wunreachable-code -Wstrict-prototypes
GCFLAGS+= -mcpu=cortex-m3 -Wl,--gc-sections -fsingle-precision-constant -DARM_MATH_CM3 
GCFLAGS+= -Wa,-adhlns=$(<:.c=.lst)
GCFLAGS+= -ffreestanding -nostdlib -Wa,-adhlns=$(<:.c=.lst) -fno-math-errno


#1803               <Define>ARM_MATH_CM4, ARM_MATH_MATRIX_CHECK, ARM_MATH_ROUNDING, __FPU_PRESENT = 1</Define>
# -ffunction-sections -fdata-sections -fmessage-length=0   -fno-builtin


LDFLAGS = -mcpu=cortex-m3 -mthumb $(OPTIMIZATION) -nostartfiles  -T$(LSCRIPT) 


#  Compiler/Assembler Paths
GCC = arm-none-eabi-gcc
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy
REMOVE = rm -f
SIZE = arm-none-eabi-size

#########################################################################

all: $(PROJECT).bin Makefile stats
#	arm-none-eabi-objdump -d $(PROJECT).elf > out.dump


tools/stm32flash:
	make -C tools

$(PROJECT).bin: $(PROJECT).elf Makefile
	$(OBJCOPY) -R .stack -O binary $(PROJECT).elf $(PROJECT).bin

$(PROJECT).elf: $(OBJECTS) Makefile
	$(GCC) $(OBJECTS) $(LDFLAGS)  -o $(PROJECT).elf

stats: $(PROJECT).elf Makefile
	$(SIZE) $(PROJECT).elf

clean:
	$(REMOVE) $(OBJECTS)
	$(REMOVE) $(LSTFILES)
	$(REMOVE) $(PROJECT).bin
	$(REMOVE) $(PROJECT).elf
	make -C tools clean

#########################################################################

%.o: %.c Makefile $(HEADERS)
	$(GCC) $(GCFLAGS) -o $@ -c $<

%.o: %.s Makefile 
	$(AS) $(ASFLAGS) -o $@  $< 

#########################################################################

flash: tools/stm32flash all
	tools/stm32flash -e 255 -v -w  $(PROJECT).bin -g 0x0 /dev/cu.usbserial-AE018X8R
