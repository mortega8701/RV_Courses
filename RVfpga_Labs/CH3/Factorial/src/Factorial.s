.globl main
.equ N, 7

.text
main:
  li    s1, N         # i = N
  li    s2, 1         # accum = 1

repeat:
  li    t0, 2
  blt   s1, t0, done  # i > 1
  mul   s2, s2, s1    # accum = accum * i
  addi  s1, s1, -1    # i++
  j     repeat

done:
  j     done
.end