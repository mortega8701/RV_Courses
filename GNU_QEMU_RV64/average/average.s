.equ maxnb, 100
.section .text
.globl main
main:
    addi    sp, sp, -16
    sd      ra, 0(sp)
    sd      s0, 8(sp)

    li      s0, 0               # int i=0

.L0input:
    la      a0, scanfmt
    la      a1, buffer          # long *ptrBuffer
    slli    t0, s0, 2           # int i_word = i*4
    add     a1, a1, t0          # long ptrTempBuf = ptrBuffer + i_word // buffer[i]
    call    scanf               # num = scanf("%f", ptrTempBuf)
    blez    a0, .L0avg          # if(num<=0)
    addi    s0, s0, 1           # i++
    li      t0, maxnb
    blt     s0, t0, .L0input    # if(i<MAXNB)

.L0avg:
    beqz    s0, .L0err          # if(i==0)
    fcvt.s.w    ft0, s0         # float div = (float)i
    fcvt.s.w    ft1, zero       # float acum = 0.0

.L0avgloop:
    beqz    s0, .L0out          # if(i==0)
    addi    s0, s0, -1          # i--
    slli    t1, s0, 2           # i_word = i*4
    la      t0, buffer
    add     t0, t0, t1          # ptrTempBuf = ptrBuffer + i_word // buffer[i]

    flw     ft2, 0(t0)          # float nextNum = *ptrTempBuf
    fadd.s  ft1, ft1, ft2       # accum = accum + nextNum
    j       .L0avgloop

.L0out:
    fdiv.s  ft1, ft1, ft0       # accum = acum/div //implicit float division
    la      a0, resultfmt
    fcvt.d.s    ft1, ft1
    fmv.x.d     a1, ft1
    call printf                 # printf(%f, (double)accum)

.L0err:
    li a0, 0                    # return 0

    ld s0, 8(sp)
    ld ra, 0(sp)
    addi sp, sp,16
    ret

.section .rodata
scanfmt:
.asciz "%f"
resultfmt:
.asciz "Average: %f\n"

.section .bss
buffer:
.zero 4*maxnb   #buffer[MAXNB]
