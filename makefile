.PHONY: default clean run

default: main.elf

main.elf: entry.o main.o link.ld
	riscv32-unknown-elf-ld -T link.ld entry.o main.o -o main.elf

entry.o: entry.s
	riscv32-unknown-elf-as -g entry.s -o entry.o

main.o: main.c
	riscv32-unknown-elf-gcc -g -nostdlib -nostartfiles -mcmodel=medany -c main.c -o main.o

run: main.elf
	qemu-system-riscv32.exe -M virt -m 128M -nographic -kernel main.elf

clean:
	$(RM) entry.o main.o main.elf
