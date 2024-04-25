.globl main
.equ N, 12
.equ M, N/3

.data
A: .word 0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3

.bss
B: .space 4*M

.text
abs:                  # abs(int num)
  bgez  a0, positive  # num<0
  neg   a0, a0        # num=|num|

positive: 
  ret                 # return num

res_triplet:
  addi  sp, sp, -20
  sw    ra, 0(sp)
  sw    s1, 4(sp)
  sw    s2, 8(sp)
  sw    s3, 12(sp)
  sw    s4, 16(sp)

  li    s1, 0         # i=0
  li    s2, 0         # sum=0
  mv    s3, a0        # A[]
  mv    s4, a1        # j

repeat2:
  li    t0, 3
  bge   s1, t0, stop2 # i<3
  add   t1, s4, s1    # j+i
  slli  t1, t1, 2     # (j+i)_word = (j+i)*4
  add   t1, s3, t1    # A[] + (j+i)_word
  lw    t2, 0(t1)     # A[j+i]
  add   s2, s2, t2    # sum = sum + A[j+i]
  addi  s1, s1, 1     # i++
  j     repeat2

stop2:
  mv    a0, s2        # sum
  jal   abs           # sum = abs(sum)
  lw    s1, 0(sp)
  lw    s2, 4(sp)
  lw    s3, 8(sp)
  lw    s4, 12(sp)
  lw    ra, 16(sp)
  addi  sp, sp, 32
  ret                 # return sum

main:
  addi  sp, sp, -32
  sw    s1, 0(sp)
  sw    s2, 4(sp)
  sw    s3, 8(sp)
  sw    s4, 12(sp)
  sw    ra, 16(sp)

  la    s1, A
  la    s2, B
  li    s3, 0         # i=0
  li    s4, 0         # j=0

repeat1:
  li    t0, M
  bge   s3, t0, done  # i<M
  mv    a0, s1        # A[]
  mv    a1, s4        # j
  jal   res_triplet   # int res_triplet(A[], j)
  slli  t1, s3, 2     # i_word = i*4
  add   t1, s2, t1    # B[] + i_word
  sw    a0, 0(t1)     # store B[i] = res_triplet()
  addi  s4, s4, 3     # j = j+3
  addi  s3, s3, 1     # i++
  j     repeat1

done:
  lw    s1, 0(sp)
  lw    s2, 4(sp)
  lw    s3, 8(sp)
  lw    s4, 12(sp)
  lw    ra, 16(sp)
  addi  sp, sp, 32
  ret
.end
