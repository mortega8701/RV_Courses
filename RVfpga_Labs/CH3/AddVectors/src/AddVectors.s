.globl main
.equ N, 12

.data
A: .word 0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3
B: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12

.bss
C: .space 4*N

.text
main:
  la    t0, A
  la    t1, B
  la    t2, C
  li    s1, 0           # i = 0

repeat:
  addi  t3, zero, N     # N = 12
  bge   s1, t3, done    # i < N
  slli  t3, s1, 2       # i_word = i*4
  add   t4, t3, t0      # A[] + i_word
  lw    s2, 0(t4)       # load A[i]
  sub   t4, zero, t3    # -i_word
  addi  t4, t4, 4*N     # N_word - i_word
  add   t4, t4, t1      # B[] + N_word - i_word
  lw    s3, -4(t4)      # load B[N-i-1]
  add   t4, t3, t2      # C[] + i_word
  add   s4, s3, s2      # C[i] = A[i] + B[N-i-1]
  sw    s4, 0(t4)       # store C[i]
  addi  s1, s1, 1       # i++
  j     repeat

done:
  j    done
.end
