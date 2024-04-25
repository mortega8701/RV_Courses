.globl main
.equ N, 6

.data
A: .word 48, 64, 56, 80, 96, 48

.bss
B: .space 4*(N-1)

.text
myFilter:             # myFilter(int num1, int num2)
  addi  sp, sp, -12   # stack store myFilter
  sw    ra, 0(sp)
  sw    s1, 4(sp)
  sw    s2, 8(sp)

  mv    s1, a0        # A[i]
  mv    s2, a1        # A[i+1]

  rem   t0, s1, 16    # A[i]%16
  bnez  t0, skip      # A[i]%16 == 0
  bge   s1, s2, skip  # A[i] < A[i+1]
  addi  a0, zero, 1   # return 1
  j     return

skip:
  add   a0, zero, 0   # return 0

return:
  lw    ra, 0(sp)
  lw    s1, 4(sp)
  lw    s2, 8(sp)
  addi  sp, sp, 16    # stack load myFilter
  ret

main:
  addi  sp, sp, -28   # stack store main
  sw    ra, 0(sp)
  sw    s1, 4(sp)
  sw    s2, 8(sp)
  sw    s3, 12(sp)
  sw    s4, 16(sp)
  sw    s5, 20(sp)
  sw    s6, 24(sp)

  la    s1, A
  la    s2, B
  li    s3, 0         # i=0
  li    s4, 0         # j=0

repeat:
  li    t0, N-1
  bge   s3, t0, done  # i<(N-1)
  slli  t1, s3, 2     # i_word = i*4
  add   t1, s1, t1    # A[] + i_word
  lw    s5, 0(t1)     # Load A[i]
  lw    s6, 4(t1)     # Load A[i+1]

  mv    a0, s5
  mv    a1, s6
  jal   myFilter      # myFilter(A[i],A[i+1])

  addi  t0, zero, 1
  bne   a0, t0, endif # myFilter(A[i], A[i+1]) == 1
  slli  t2, s4, 2     # j_word = j*4
  add   t2, s2, t2    # B[] + j_word
  add   t3, s5, s6    # A[i] + A[i+1]
  addi  t3, t3, 2     # A[i] + A[i+1] + 2
  sw    t3, 0(t2)     # store B[j] = A[i] + A[i+1] + 2
  addi  s4, s4, 1     # j++

endif:
  addi  s3, s3, 1     # i++
  j     repeat

done:
  lw    ra, 0(sp)
  lw    s1, 4(sp)
  lw    s2, 8(sp)
  lw    s3, 12(sp)
  lw    s4, 16(sp)
  lw    s5, 20(sp)
  lw    s6, 24(sp)
  addi  sp, sp, 32    # stack load main
  ret
.end
