ENTRY(_Reset)
SECTIONS
{
    . = 0x80100000; /* Beginning of DRAM in the QEMU virt device, but right after OpenSBI */
    .startup . : { entry.o(.text) } /* Set our assembly to be the entrypoint */
    .text : { *(.text) }
    .data : { *(.data) }
    .bss : { *(.bss COMMON) }
    . = ALIGN(8);
    . = . + 0x1000; /* 4kB of stack memory */
    stack_top = .; /* Set the stack_top symbol to refer to the top of the memory allocated for the stack */
}