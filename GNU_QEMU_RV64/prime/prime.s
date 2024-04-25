.equ maxnb, 0x100000
.section .text
.globl main
main:
    addi    sp, sp, -8
    sd      ra, 0(sp)

    la      a0, prompt
    call    printf          # printf("Enter number (<1048576): ")

    la      a0, scanfmt
    la      a1, input       # long *ptrInput
    call    scanf           # int retVal = scanf("%u", ptrInput)

    blez    a0, .Lerr       # if(retVal<=0)
    la      a1, input
    lw      a1, 0(a1)       # int num = *ptrInput
    li      t0, maxnb
    bge     a1, t0, .Lerr   # if(num>=MAXNB)
    la      a0, input
    call    sieve           # int isPrime = sieve(ptrInput)
    bnez    a0, .Lp1        # if(isPrime!=0)

.Lp0:
    la      a0, outno       # char *outMsg = "is not a prime number.\n"
    j       .Lpp

.Lp1:
    la      a0, outyes      # char *outMsg = "is a prime number.\n"
    j       .Lpp

.Lerr: 
    la      a0, error       # char *outMsg = "wrong input.\n"

.Lpp:
    call    printf          # printf(*outMsg)
    li      a0, 0           # return 0
    ld      ra, 0(sp)
    addi    sp, sp,8
    ret

sieve:                      # int sieve(int *ptrNumber)
    lw      t1, 0(a0)       # int inputNum = *ptrNumber
    li      t2, 2           # num1 = 2
    la      t3, array       # long *ptrArray = array[]

.Ls0:
    sw      t2, 8(t3)       # *(ptrArray+2)=num1
    addi    t3, t3, 4       # ptrArray++
    addi    t2, t2, 1       # num1++
    ble     t2, t1, .Ls0    # if(num1<=inputNum)
    li      t2, 2           # num1 = 2
    la      t3, array       # long *ptrArray = array[]

.Ls1:
    lw      t4, 8(t3)       # int num2 = *(ptrArray+2)
    beqz    t4, .Ls3        # if(num2==0)
    mul     t4, t2, t2      # num2 = num1 * num1

.Ls2:
    slli    t5, t4, 2       # int num2_word = num2*4
    add     t5, t3, t5
    sw      zero, 0(t5)     # *(num2_word + ptrArray) = 0 // array[num2] = 0
    add     t4, t4, t2      # num2 = num2 + num1
    ble     t4, t1, .Ls2    # if(num2<=inputNum)

.Ls3:
    addi    t2, t2, 1       # num1++
    mul     t0, t2, t2      # int temp = num1 * num1
    ble     t0, t1, .Ls1    # if(temp<=inputNum)
    slli    t0, t1, 2       # int inputNum_word = inputNum * 4
    add     t0, t3, t0
    lw      t0, 0(t0)       # int num3 = *(inputNum_word + ptrArray) // array[inputNum]
    snez    a0, t0          # if(num3!=0) return 1 else return 0
    ret

.section .rodata
prompt:
.asciz "Enter number (<1048576): "
scanfmt:
.asciz "%u"
outyes:
.asciz "is a prime number.\n"
outno:
.asciz "is not a prime number.\n"
error:
.asciz "wrong input.\n"

.section .bss
input:
.word 0
array:
.zero 4*maxnb
