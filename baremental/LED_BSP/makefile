CROSS_COMPILE	?= arm-gcc-gnueabihf-
TARGET			?= bsp

CC				:= $(CROSS_COMPILE)gcc
LD				:= $(CROSS_COMPILE)ld
OBJCOPY			:= $(CROSS_COMPILE)objcopy
OBJDUMP			:= $(CROSS_COMPILE)objdump

INCDIRS			:= imx6ul \
				   bsp/clk \
				   bsp/led \
				   bsp/delay

SRCDIRS			:= project \
				   bsp/clk \
				   bsp/led \
				   bsp/delay

INCLUDE			:= $(patsubst %, -I %,$(INCDIRS))

SFILES			:= $(foreach dir, $(SRCDIRS), $(wildcard $(dir)/*.S))
CFILES			:= $(foreach dir, $(SRCDIRS), $(wildcard $(dir)/*.c))

SFILENDIR		:= $(notdir $(SFILES))
CFILENDIR		:= $(notdir $(CFILES))

SOBJS			:= $(patsubst %, obj/%, $(SFILENDIR:.S=.o))
COBJS			:= $(patsubst %, obj/%, $(CFILENDIR:.c=.o))
OBJS			:= $(SOBJS) $(COBJS)

VPATH			:= $(SRCDIRS)

$(TARGET).bin : $(OBJS)
	$(LD) -Timx6ul.lds -o $(TARGET).elf $^
	$(OBJCOPY) -O binary -S $(TARGET).elf $@
	$(OBJDUMP) -D -m arm $(TARGET).elf > $(TARGET).dis

$(SOBJS) : obj/%.o : %.S
	$(CC) -Wall -nostdlib -c -O2 $(INCLUDE) -o $@ $<

$(COBJS) : obj/%.o : %.c
	$(CC) -Wall -nostdlib -c -O2 $(INCLUDE) -o $@ $<

.PHONY: clean
clean:
	rm -rf $(TARGET).elf $(TARGET).dis $(TARGET).bin $(COBJS) $(SOBJS)

.PHONY: print
print:
	@echo TARGET	=$(TARGET)
	@echo INCDIRS	=$(INCDIRS)
	@echo SRCDIRS	=$(SRCDIRS)
	@echo INCLUDE	=$(INCLUDE)
	@echo SFILES	=$(SFILES)
	@echo CFILES	=$(CFILES)
	@echo SFILENDIR	=$(SFILENDIR)
	@echo CFILENDIR	=$(CFILENDIR)
	@echo SOBJS		=$(SOBJS)
	@echo COBJS		=$(COBJS)
	@echo OBJS		=$(OBJS)
	@echo VPATH		=$(VPATH)
