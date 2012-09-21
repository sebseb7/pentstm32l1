CC = $(CROSS_COMPILE)gcc
export CC

all: stm32flash

stm32flash:
	$(CC) -o stm32flash -I./ \
		main.c \
		utils.c \
		stm32.c \
		serial_common.c \
		serial_platform.c \
		parsers/binary.c \
		parsers/hex.c \
		stm32/stmreset_binary.c \
		-Wall

clean:
	rm -f stm32flash

