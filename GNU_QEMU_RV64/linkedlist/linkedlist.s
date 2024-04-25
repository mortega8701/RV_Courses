.include "linkedlist_struct.s"
.section .text
.globl linkedlist_push
linkedlist_push:                    # long linkedlist_push(long* ptrRootNode, long value)
    addi    sp, sp, -24
    sd      ra, 0(sp)
    sd      s0, 8(sp)
    sd      s1, 16(sp)

    mv      s0, a0
    mv      s1, a1
    li      a0, node_size
    call    malloc                  # long *ptrNewNode = malloc(sizeof(Node))
    beqz    a0, .L0err              # if (ptrNewNode==0x0)

    sd      s1, node_val(a0)        # ptrNewNode.value = value
    sd      s0, node_next(a0)       # ptrNewNode.ptrNextNode = ptrRootNode

    j .L0exit
.L0err:
	li      a0, -1                  # return -1
.L0exit:
	ld      ra, 0(sp)
    ld      s0, 8(sp)
    ld      s1, 16(sp)
	addi    sp, sp, 24
	ret                             # return ptrNewNode

.globl linkedlist_pop
linkedlist_pop:                     # long linkedlist_pop(long* ptrRootNode)
    addi    sp, sp, -16
    sd      ra, 0(sp)
    sd      s0, 8(sp)
    beqz    a0, .L1err              # if(ptrRootNode==0x0)

    ld      s0, node_next(a0)       # long ptrNode = *ptrRootNode.ptrNextNode

    call    free                    # free(ptrRootNode)

    mv      a0, s0                  # return ptrNode
    j       .L1exit

.L1err:
    li      a0, -1                  # return -1

.L1exit:
    ld      ra, 0(sp)
    ld      s0, 8(sp)
    addi    sp, sp, 16
    ret

.globl linkedlist_print
linkedlist_print:                   # void linkedlist_print(long* ptrRootNode)
    addi    sp, sp, -16
    sd      ra, 0(sp)
    sd      s0, 8(sp)

    mv      s0, a0                  # long *ptrNode = ptrRootNode

.L2loop:
    beqz    s0, .L2exit             # if(ptrNode==0)
    ld      a1, node_val(s0)        # long value = *ptrNode.value
    la      a0, .L2prompt
    call    printf                  # printf("%u", value) 

    ld      s0, node_next(s0)       # ptrNode = *ptrNode.ptrNextNode
    j       .L2loop

.L2exit:
    ld      ra, 0(sp)
    ld      s0, 8(sp)
    addi    sp, sp, 16
    ret
.section .rodata
.L2prompt: 
	.asciz "%u \n"
