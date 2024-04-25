.globl main
.equ N, 8

.bss
V: .space 4*N

.text
main:
  la    t0, V
  li    t1, 0        
  sw    t1, 0(t0)     # V[0] = 0
  li    t1, 1
  sw    t1, 4(t0)     # V[1] = 1
  li    t1, 2         # i = 2
  li    t2, N

repeat:
  bge   t1, t2, done  # i < N
  slli  t3, t1, 2     # i_word = i*4
  add   t3, t3, t0    # V[] + i_word
  lw    s1, -4(t3)    # load V[i-1]
  lw    s2, -8(t3)    # load V[i-2]
  add   s3, s2, s1    # V[i] = V[i-1] + V[i-2]
  sw    s3, 0(t3)     # store V[i]
  addi  t1, t1, 1     # i++
  j     repeat
  
done:
  j     done
.end
