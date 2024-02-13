# riscv32-bare-metal-qemu
Simple riscv32 bare metal 'Hello World' on qemu. Source files are heavily commented for learning.

Heavily inspired by the resources from https://github.com/freedomtan/aarch64-bare-metal-qemu

Running riscv64 is very similar, except that you use the 64 bit toolchain instead of the 32 bit one. It can be installed with `sudo apt install gcc-riscv64-unknown-elf`

1. First, we need the riscv32 toolchain found here: https://github.com/riscv-collab/riscv-gnu-toolchain
    - Build the riscv32 toolchain
        ```
        git clone https://github.com/riscv/riscv-gnu-toolchain
        sudo apt-get install autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build
        ./configure --prefix=/opt/riscv --with-arch=rv32gc --with-abi=ilp32d
        sudo make linux
        export PATH="/opt/riscv/bin:$PATH"
        ```
    - Install qemu for riscv32
        `sudo apt install qemu-system-riscv32`
2. We need an entry point. Since the stack pointer is not set up yet, we will need to write some assembly ([entry.s](entry.s)) to bootstrap C.
3. We then will write a C file ([main.c](main.c)) to print our string to the QEMU UART. I found the address of the "virt" uart here: https://gitlab.com/qemu-project/qemu/-/blob/master/hw/riscv/virt.c?ref_type=heads#L75
4. Now we need to link all of our symbols with a linker script ([link.ld](link.ld))
5. Now we write a [makefile](makefile) to facilitate simple, consistent builds.
    - The makefile is simply running the commands
        ```
        riscv32-unknown-elf-as -g entry.s -o entry.o
        riscv32-unknown-elf-gcc -g -nostdlib -nostartfiles -mcmodel=medany -c main.c -o main.o
        riscv32-unknown-elf-ld -T link.ld entry.o main.o -o main.elf
        qemu-system-riscv32.exe -M virt -m 128M -nographic -kernel main.elf
        ```