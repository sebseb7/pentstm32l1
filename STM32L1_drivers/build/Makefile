LIB = libSTM32L1xx_drivers.a

CC = arm-none-eabi-gcc
AR = arm-none-eabi-ar
RANLIB = arm-none-eabi-ranlib

CFLAGS = -Wall -O2 -mlittle-endian -mthumb
CFLAGS += -mcpu=cortex-m3 -ffreestanding -nostdlib -Wl,--gc-sections -fsingle-precision-constant -funsigned-char -Wundef -Wsign-compare -Wunreachable-code -Wstrict-prototypes
CFLAGS += -I../inc -I../../core -DARM_MATH_CM3 -DUSE_STDPERIPH_DRIVER

SRCS = \
../src/misc.c \
../src/stm32l1xx_adc.c \
../src/stm32l1xx_aes.c \
../src/stm32l1xx_aes_util.c \
../src/stm32l1xx_comp.c \
../src/stm32l1xx_crc.c \
../src/stm32l1xx_dac.c \
../src/stm32l1xx_dbgmcu.c \
../src/stm32l1xx_dma.c \
../src/stm32l1xx_exti.c \
../src/stm32l1xx_flash.c \
../src/stm32l1xx_flash_ramfunc.c \
../src/stm32l1xx_fsmc.c \
../src/stm32l1xx_gpio.c \
../src/stm32l1xx_i2c.c \
../src/stm32l1xx_iwdg.c \
../src/stm32l1xx_lcd.c \
../src/stm32l1xx_opamp.c \
../src/stm32l1xx_pwr.c \
../src/stm32l1xx_rcc.c \
../src/stm32l1xx_rtc.c \
../src/stm32l1xx_sdio.c \
../src/stm32l1xx_spi.c \
../src/stm32l1xx_syscfg.c \
../src/stm32l1xx_tim.c \
../src/stm32l1xx_usart.c \
../src/stm32l1xx_wwdg.c 

OBJS = $(SRCS:.c=.o)

all: $(LIB)

$(LIB): $(OBJS)
	$(AR) -r $(LIB) $(OBJS)
	$(RANLIB) $(LIB)

%.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $^

clean:
	-rm -f $(OBJS)
	-rm -f $(LIB)

.PHONY: all clean
