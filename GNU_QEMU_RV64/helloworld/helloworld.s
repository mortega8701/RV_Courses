.equ write, 64
.equ exit, 93

.section .text
.globl  _start
_start:
    li      a0, 1
    la      a1, msgbegin    # char *ptrMsg = "Hello World!\n"
    lbu     a2, msgsize     # int len = strlen(*ptrMsg)
    li      a7, write       # syscall
    ecall                   # write(1, ptrMsg, len)
  
    li      a0, 0
    li      a7, exit        # exit(0)
    ecall

.section .rodata
msgbegin:
.ascii  "Hello World!\n"
msgsize:
.byte   .-msgbegin
