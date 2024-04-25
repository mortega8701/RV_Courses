.globl main
.equ N, 12

.data
V: .word 5, 6, 13, 18, 1, 11, 10, 15, 16, 9, 12, 3

.text
main:
  la   t0, V

while:
  li    s1, 0           # i = 0
  li    s2, 1           # swap = 1

repeat:
  li    t2, N-1         # N = 11
  bge   s1, t2, done    # i < N
  slli  t2, s1, 2       # i_word = i*4
  add   t2, t2, t0      # V[] + i_word
  lw    s3, 0(t2)       # load V[i]
  lw    s4, 4(t2)       # load V[i+1]
  bge   s4, s3, noswap  # V[i] > V[i+1]
  sw    s4, 0(t2)       # store V[i] = V[i+1]
  sw    s3, 4(t2)       # store V[i+1] = V[i]
  li    s2, 0           # swap = 0

noswap:
  beq   s2, zero, while # swap == 0
  addi  s1, s1, 1       # i++
  j     repeat

done:
  j     done
.end
