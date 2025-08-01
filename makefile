# LEARN ASM

ASM = nasm
ASM_FLAGS = -f bin
QEMU = qemu-system-x86_64

SOURCE_DIR = ./src
BINARY_DIR = ./bin

DISK_IMAGE = $(BINARY_DIR)/learn_asm.img

SOURCES = $(wildcard $(SOURCE_DIR)/*.asm)
BINARYS = $(patsubst $(SOURCE_DIR)/%.asm, $(BINARY_DIR)/%.bin, $(SOURCES))

all: init_project $(BINARYS) gen_image

init_project:
	mkdir -p $(BINARY_DIR)

$(BINARY_DIR)/%.bin: $(SOURCE_DIR)/%.asm | $(BINARY_DIR)
	$(ASM) $(ASM_FLAGS) $< -o $@

gen_image:
	dd if=/dev/zero of=$(DISK_IMAGE) bs=1024 count=64

	dd if=$(BINARY_DIR)/boot.bin of=$(DISK_IMAGE) bs=512 count=1 conv=notrunc

.PHONY:

clean:
	rm -rf $(BINARY_DIR)

run:
	qemu-system-x86_64 -m 64M -drive format=raw,file=$(BINARY_DIR)/learn_asm.img