carrOS.bin: boot.o kernel.o linker.ld
	i686-elf-gcc -T linker.ld -o carrOS.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
	if grub-file --is-x86-multiboot carrOS.bin; then \
		echo multiboot confirmed; \
	else \
		echo the file is not multiboot; \
	fi

boot.o: boot.s
	i686-elf-as boot.s -o boot.o

kernel.o: kernel.c
	i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

run: carrOS.bin
	qemu-system-i386 -kernel carrOS.bin
