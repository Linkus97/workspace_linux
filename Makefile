.PHONY: help
help:
	@echo "Usage: make <op>"
	@echo "option list: "
	@echo "	list	"
	@echo " all "
	@echo "	clean "

SRCS := $(shell find . -name "*.c")

TARGETS := $(SRCS:.c=)

# Compiler 
CC := gcc
CFLAGS := -Wall -O2
LDFLAGS := 

#THREAD
ifdef TH
	CFLAGS += -lpthread
	TH_SUFFIX := _thread
else
	TH_SUFFIX :=
endif

# Build directory
BUILD_DIR := ./build

%:%.c 
	@mkdir -p build
	@$(CC) $< -o ./build/$@$(TH_SUFFIX) $(CFLAGS)
	@echo "Build: $@"

.PHONY: all
all: $(TARGETS)

.PHONY: list
list:
	@echo "Make list: "
	@for target in $(TARGETS); do \
		echo "	$$target"; 	\
	done

.PHONY: clean
clean:
	@echo "Clean exec files..."
	@rm -rf ./build
	@find . -type f -perm /111 -exec rm -f {} + 2>/dev/null
	@echo "Done."