# DIGIT_EN    = 0x80001038
# SEVEN_SEG   = 0x8000103C

.globl main
.equ DELAY, 50000

main:
  li    t0, 0x80001038
  li    t1, 0xFF00
  sw    t1, 0(t0)         # WRITE(DIGIT_EN, 0xFF00)
  li    s1, 0x01234567    # number=0x01234567

repeat:
  li    s2, 0x0           # newNumber = 0
  li    s3, 0             # i=0
  li    t2, 8

num_cycl:
  bge   s3, t2, cycl_done # if(i<8)
  slli  t3, s3, 2         # i*4
  srl   s4, s1, t3        # digit = number >> i*4
  andi  s4, s4, 0xF       # digit = digit & 0xF
  addi  s4, s4, 1         # digit++
  bge   t2, s4, skip      # if(digit > 8)
  add   s4, zero, zero    # digit=0

skip:
  sll   s4, s4, t3        # digit = digit << i*4
  or    s2, s2, s4        # newNumber = newNumber | digit
  addi  s3, s3, 1         # i++
  j     num_cycl

cycl_done:
  mv    s1, s2
  sw    s1, 4(t0)         # WRITE(SEVEN_SEG, number)

  li    s3, DELAY         # i=DELAY
delay:
  bltz  s3, exit          # while (i>=0)
  addi  s3, s3, -1        # i--
  j     delay

exit:
  j     repeat