.globl main

.data
A: .word 192
B: .word 270

.bss
GCD: .space 4

.text
main:
  la    t0, A
  la    t1, B
  lw    s1, 0(t0)       # load A
  lw    s2, 0(t1)       # load B

repeat:
  beq   s2, zero, exit  # B!=0
  blt   s1, s2, next    # A < B
  rem   s3, s1, s2      # REM = A%B
  mv    s1, s2          # A = B
  mv    s2, s3          # B = REM
  j     repeat

next:
  rem   s3, s2, s1      # REM = B%A
  mv    s2, s1          # B = A
  mv    s1, s3          # A = REM
  j     repeat

exit:
  la    t2, GCD
  sw    s1, 0(t2)       # store GCD = A

done:
  j     done
.end
