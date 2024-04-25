.globl main
.equ N, 12

.data
A: .word 0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3

.bss
B: .space 4*N

.text
main:
  la    t0, A
  la    t1, B
  li    a0, 0           # sizeB = 0
  li    s1, 0           # i = 0
  li    t2, N

repeat:
  bge   s1, t2, done    # i < 12
  slli  t3, s1, 2       # i_word = i*4
  add   t3, t3, t0      # A[i] address = A address + i_word
  lw    s2, 0(t3)       # load A[i]
  addi  t3, zero, 2
  rem   t3, s2, t3      # A[i]%2

  bne   t3, zero, else  # A[i]%2 == 0
  bge   zero, s2, else  # A[i] > 0
  slli  t3, a0, 2       # sizeB_word = sizeB*4
  add   t3, t3, t1      # B[sizeB] address = B address + sizeB_word
  sw    s2, 0(t3)       # B[sizeB] = A[i]
  addi  a0, a0, 1       # sizeB ++

else:
  addi  s1, s1, 1       # i++
  j     repeat

done:
  j    done
.end