ARMGNU ?= arm-none-eabi
#ARMGNU ?= arm-linux-gnueabi
BUILD	= build/
SOURCE	= source/
LINKER	= memmap
MAP		= test.map
AFLAGS 	= --warn --fatal-warnings -march=armv6 -mcpu=arm1176jzf-s -mfpu=vfp
CFLAGS	= -O2 -Wall -Werror -nostdlib -nostartfiles -ffreestanding \
		-mhard-float -ffast-math -mcpu=arm1176jzf-s -mfpu=vfpv3 \
		-fno-pic

OBJ	=  $(BUILD)test.o

all: $(BUILD)test.o

rebuild: all

clean :
	rm -f $(BUILD)*.o
	rm -f $(BUILD)*.m
	rm -f *.list
	rm -f *.dump
	rm -f *.rf
	rm -f *.map
	
$(BUILD)test.o : $(OBJ)
	$(ARMGNU)-gcc $(CFLAGS) -c $(SOURCE)test.c -o $(BUILD)test.o
	#$(ARMGNU)-gcc $(CFLAGS) $(BUILD)test.o -o test.o -Wl,-r,-T linkscript 
	#-lgcc -static
	$(ARMGNU)-ld -q -r $(OBJ) -T linkscript -Map $(MAP) -o $(BUILD)test.m
	$(ARMGNU)-objdump -D $(BUILD)test.m > test.list
	$(ARMGNU)-objdump -hrt $(BUILD)test.m > test.dump
	readelf --all $(BUILD)test.m > test.rf
	
