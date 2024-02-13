volatile unsigned int * const UART0DR = (unsigned int *) 0x10000000;
 
void print_uart0(const char *s) {
    while(*s) { 		/* Loop until end of string */
         *UART0DR = (unsigned int)(*s); /* Transmit char */
          s++;			        /* Next char */
    }
}
 
void c_entry() {
    print_uart0("Hello, world!\n");
}