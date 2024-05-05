# GPIO_SWs    = 0x80001400
# GPIO_LEDs   = 0x80001404
# GPIO_INOUT  = 0x80001408
# DIGIT_EN    = 0x80001038
# SEVEN_SEG   = 0x8000103C

.globl main

main:
  li    t0, 0x80001400
  li    t1, 0x80001038
  li    t2, 0xFFFF
  li    t3, 0xFFF0
  sw    t2, 8(t0)         # WRITE(GPIO_INOUT, 0xFFFF)
  sw    t3, 0(t1)         # WRITE(DIGIT_EN, 0xFFF0)

repeat:
  lw    s1, 0(t0)         # switches_value = READ(GPIO_SWs)
  srli  s1, s1, 16        # switches_value = switches_value >> 16
  sw    s1, 4(t1)         # WRITE(SEVEN_SEG, switches_value)
  j     repeat