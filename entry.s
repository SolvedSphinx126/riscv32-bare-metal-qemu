// Externel symbol for the linker
.global _Reset
_Reset:
    // load the address in the stack_top linker symbol into the x2 register
    // which is used as a link register in the risc V abi
    la x2, stack_top

    // jump to the symbol c_entry to be resolved by the linker and
    // put the return address (pc + 4) in x1
    jal x1, c_entry

    // infinite loop
    j .
