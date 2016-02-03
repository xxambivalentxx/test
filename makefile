ARMGNU ?= arm-none-eabi
#ARMGNU ?= arm-linux-gnueabi
BUILD	= build/
SOURCE	= source/
LINKER	= memmap
MAP		= test.map
AFLAGS 	= --warn --fatal-warnings -march=armv6 -mcpu=arm1176jzf-s -mfpu=vfp
CFLAGS 	= -O2 -Wall -Werror -nostdlib -nostartfiles -ffreestanding -std=gnu99 
CFLAGS += -mhard-float -ffast-math -mcpu=arm1176jzf-s -mfpu=vfpv3 
OBJ	=  $(BUILD)test.o

all: $(BUILD)test.mod

rebuild: all

clean :
	rm -f $(BUILD)*.o
	rm -f $(BUILD)*.mod

$(BUILD)test.o :
	$(ARMGNU)-gcc $(CFLAGS) -c $(SOURCE)test.c -o $(BUILD)test.o
	
$(BUILD)test.mod : $(OBJ)
	$(ARMGNU)-ld -r $(OBJ) -T linkscript -Map $(MAP) -o $(BUILD)test.mod
	$(ARMGNU)-objdump -D $(BUILD)test.mod > test.list
	$(ARMGNU)-objdump -h $(BUILD)test.mod > test.dump
	
