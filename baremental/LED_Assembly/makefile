.PHONY: help
help:
	@echo "Usage: make <op>"
	@echo "option list: "
	@echo "	list	"
	@echo "	all "
	@echo "	clean "

SRCS := $(shell find . -name "*.s")
TARGETS := $(patsubst %.s,%.bin,$(SRCS))

# Compiler 
CC := arm-linux-gnueabihf-gcc
LD := arm-linux-gnueabihf-ld
CP := arm-linux-gnueabihf-objcopy
DP := arm-linux-gnueabihf-objdump

ASFLAGS := -g -c
LDFLAGS := -Ttext 0x87800000
CPFLAGS := -O binary
DPFLAGS := -D

# Build directory
BUILD_DIR := ./build

# 生成构建目录中的路径
OBJS := $(patsubst %.s,$(BUILD_DIR)/%.o,$(SRCS))
ELFS := $(patsubst %.s,$(BUILD_DIR)/%.elf,$(SRCS))
BINS := $(patsubst %.s,$(BUILD_DIR)/%.bin,$(SRCS))
DUMP := $(patsubst %.s,$(BUILD_DIR)/%.dis,$(SRCS))

# 默认规则：.bin -> dump
$(BUILD_DIR)/%.dis: $(BUILD_DIR)/%.elf
	$(DP) $(DPFLAGS) $< > $@

# 默认规则：.s -> .bin
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf
	$(CP) $(CPFLAGS) $< $@

# 规则：.o -> .elf
$(BUILD_DIR)/%.elf: $(BUILD_DIR)/%.o
	$(LD) $(LDFLAGS) $< -o $@

# 规则：.s -> .o
$(BUILD_DIR)/%.o: %.s
	@mkdir -p $(dir $@)
	$(CC) $(ASFLAGS) $< -o $@

.PHONY: all
all: $(BINS) $(DUMP)
	@echo "All binaries are in $(BUILD_DIR)/"

.PHONY: list
list:
	@echo "Make list: "
	@for src in $(SRCS); do \
		target=$$(echo $$src | sed 's/\.s$$/.bin/'); \
		echo "	$$target"; 	\
	done

.PHONY: debug
debug: $(OBJS) $(ELFS) $(BINS) $(DUMP)
	@echo "All files generated in $(BUILD_DIR)/"
	@echo "  Object files: $(words $(OBJS))"
	@echo "  ELF files: $(words $(ELFS))"
	@echo "  Binary files: $(words $(BINS))"

.PHONY: clean
clean:
	@echo "Clean build files..."
	@rm -rf $(BUILD_DIR)
	@rm -rf load.imx
	@echo "Done."