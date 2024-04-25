.globl main
.equ N, 6

.data
C: .word 3, 5, 0, 6, 18, 0, 15, 45, 0, 13, 10, 0, 24, 3, 0, 24, 35, 0

.text
gcd:                  # GCD(A, B)
  addi  sp, sp, -16   # stack store GCD
  sw    ra, 0(sp)
  sw    s1, 4(sp)
  sw    s2, 8(sp)
  sw    s3, 12(sp)

repeat2:
  beqz  a1, exit2     # B!=0
  blt   a0, a1, else2 # A < B
  rem   s1, a0, a1    # REM = A%B
  mv    a0, a1        # A = B
  mv    a1, s1        # B = REM
  j     repeat2

else2:
  rem   s1, a1, a0    # REM = B%A
  mv    a1, a0        # B = A
  mv    a0, s1        # A = REM
  j     repeat2

exit2:
  lw    ra, 0(sp)
  lw    s1, 4(sp)
  lw    s2, 8(sp)
  lw    s3, 12(sp)
  addi  sp, sp, 16    # stack load GCD
  ret

check_coprime:        # check_coprime(A[], pos)
  addi  sp, sp, -20   # stack store check_coprime
  sw    ra, 0(sp)
  sw    s1, 4(sp)
  sw    s2, 8(sp)
  sw    s3, 12(sp)
  sw    s4, 16(sp)

  mv    s1, a0        # A[]
  mv    s2, a1        # pos

  li    t0, 12
  mul   t0, t0, s2    # 3*pos_word
  add   s3, t0, s1    # A[] + 3*pos_word 
  lw    a0, 0(s3)     # A[3*pos]
  lw    a1, 4(s3)     # A[3*pos+1]

  jal   gcd           # GCD(A[3*pos], A[3*pos+1])

  mv    s4, a0        # res = GCD(A[3*pos], A[3*pos+1])
  li    t0, 1
  bne   s4, t0, else  # if (res == 1)
  li    t0, 2
  sw    t0, 8(s3)     # A[3*pos+2] = 2
  j     exit

else:
  li   t0, 1
  sw   t0, 8(s3)      # A[3*pos+2] = 1

exit:
  lw   ra, 0(sp)
  lw   s1, 4(sp)
  lw   s2, 8(sp)
  lw   s3, 12(sp)
  lw   s4, 16(sp)
  addi sp, sp, 20     # stack load check_coprime
  ret

main:
  addi sp, sp, -12    # stack store main
  sw   ra, 0(sp)
  sw   s1, 4(sp)
  sw   s2, 8(sp)

  la   s1, C          # C[]
  li   s2, 0          # i=0

repeat1:
  li   t0, N
  bge  s2, t0, done   # i<N
  mv   a0, s1
  mv   a1, s2
  jal  check_coprime  # check_coprime(C[], i)
  addi s2, s2, 1      # i++
  j    repeat1

done:
  lw   ra, 0(sp)
  lw   s1, 4(sp)
  lw   s2, 8(sp)
  addi sp, sp, 12     # stack load main
  ret
.end