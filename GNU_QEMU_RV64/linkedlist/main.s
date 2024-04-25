.include "linkedlist_struct.s"
.section .text
.globl main
main:
    addi    sp, sp, -16
    sd      ra, 0(sp)
    sd      s0, 8(sp)

    li      a0, 0               # long *ptrRootNode = 0x0
    li      a1, 0x12            # long value = 0x12
    call    linkedlist_push     # ptrRootNode = linkedlist_push(ptrRootNode, value)

    li      a1, 0x23            # value = 0x23
    call    linkedlist_push     # ptrRootNode = linkedlist_push(ptrRootNode, value)

    li      a1, 0x45            # value = 0x45
    call    linkedlist_push     # ptrRootNode = linkedlist_push(ptrRootNode, value)

    call    linkedlist_pop      # ptrRootNode = linkedlist_pop(ptrRootNode)

    li      a1, 0x56            # value = 0x56
    call    linkedlist_push     # ptrRootNode = linkedlist_push(ptrRootNode, value)
    mv      s0, a0

    call    linkedlist_print    # linkedlist_print(ptrRootNode)

    mv      a0, s0
    call    linkedlist_pop      # ptrRootNode = linkedlist_pop(ptrRootNode)
    call    linkedlist_pop      # ptrRootNode = linkedlist_pop(ptrRootNode)
    call    linkedlist_pop      # ptrRootNode = linkedlist_pop(ptrRootNode)

    ld ra, 0(sp)
    ld s0, 8(sp)
    addi sp, sp, 16
    ret
