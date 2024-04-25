.section .text
.globl main
main:
    addi    sp, sp, -40
    sd      ra, 0(sp)
    sd      s0, 8(sp)
    sd      s1, 16(sp)
    sd      s2, 24(sp)
    sd      s3, 32(sp)
 
    li      s0, 0           # int countChar=0
    li      s1, 0           # int countLine=0
    li      s2, 0           # int countWord=0
    li      s3, 0           # int isWord=0
 
 loop:
    call    getchar         # char c = getchar()
    bltz    a0, end         # if(c<0)
 
    addi    s0, s0, 1       # countChar++
 
    li      t0, 0xa
    bne     a0, t0, nolf    # if(c!="\n")
    addi    s1, s1, 1       # countLine++

 nolf:
    addi    t0, a0, -0x30   # unsigned long temp = c - 0x30
    li      t1, 0x9
    bleu    t0, t1, aldi    # if(temp<=9)

    # When we do an unsigned comparison with a negative number 
    # then this become a large positive number so the condition, 
    # later we substract the offset so only number between 0 to 9
    # meet the conditions

    andi    t0, a0, ~0x20   # temp = (c & ~0x20)
    addi    t0, t0, -0x41   # temp = temp - 0x41
    li      t1, 0x19
    bleu    t0, t1, aldi    # if(temp<=0x19)

    # We eliminate the 5th bit with the complement of 0x20, so
    # capital and lower case letters share the same encoding,
    # the we substract the offset and we do the same trick as before

    add     s2, s2, s3      # wordCount = wordCount + isWord
    li      s3, 0           # isWord = 0
    j       loop
 
 aldi:
     li     s3, 1           # isWord = 1
     j      loop

 end:
     la     a0, result      # printf("Lines: %u  Words: %u  Chars: %u\n",
     mv     a1, s1          # countLine,
     mv     a2, s2          # countWord,
     mv     a3, s0          # countChar)
     call   printf
 
     li     a0, 0           # return 0
 
     ld     s3, 32(sp)
     ld     s2, 24(sp)
     ld     s1, 16(sp)
     ld     s0, 8(sp)
     ld     ra, 0(sp)
     addi   sp, sp,40
     ret
 
 .section .rodata
 result:
 .asciz "Lines: %u  Words: %u  Chars: %u\n"
