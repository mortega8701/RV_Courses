.section .text
.globl main                 # run in C 'environment' 
main:
    addi    sp, sp, -8
    sd      ra, 0(sp)

    la      a0, prompt
    call    printf          # printf("Enter text: ")

    la      a0, scanfmt
    la      a1, input       # long *ptrInput
    call    scanf           # scanf("%127[^\n]", ptrInput)

    la      a0, input
    call    djb2            # long retHash = djb2(ptrInput)
    mv      a1, a0

    la      a0, result
    call    printf          # printf("Hash is %lu\n", retHash)

    li      a0, 0           # return 0

    ld      ra, 0(sp)
    addi    sp, sp,8
    ret

djb2:                       # long djb2(char* ptrInput)
    li      t1, 5381        # long hash = 5381
djb2_loop:
    lb      t0, 0(a0)       # char c = *ptrInput // c = input[]
    beqz    t0, djb2_end    # if(c==0)

    mv      t2, t1          # long tempHash = hash
    slliw   t2, t2, 5       # tempHash = tempHash * 32
    addw    t1, t1, t2      # hash = hash + tempHash
    addw    t1, t1, t0      # hash = hash + c

    addi    a0, a0, 1       # ptrInput+1 
    j       djb2_loop 
djb2_end:
    mv      a0, t1          # return hash
    ret

.section .rodata
prompt:
.asciz "Enter text: "
scanfmt:
.asciz "%127[^\n]"          # scan the next 127 bytes until read a newline
result:
.asciz "Hash is %lu\n"
.section .bss
input:
.zero 128
