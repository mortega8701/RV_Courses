# GPIO_SWs   = 0x80001400
# GPIO_LEDs  = 0x80001404
# GPIO_INOUT = 0x80001408

.globl main

main:
  li    t0, 0x80001400
  li    t1, 0xFFFF
  sw    t1, 8(t0)       # WRITE_GPIO(GPIO_INOUT, 0xFFFF)

repeat:
  lw    t1, 0(t0)       # switches_value = READ_GPIO(GPIO_SWs)
  srli  t1, t1, 16      # switches_value = switches_value >> 16
  srli  t2, t1, 12      # right_sw = (switches_value >> 12)
  andi  t2, t2, 0xF     # right_sw = right_sw & 0xF
  andi  t3, t1, 0xF     # left_sw = switches_value & 0xF
  add   t4, t2, t3      # sum = right_sw + left_sw
  sw    t4, 4(t0)       # WRITE_GPIO(GPIO_LEDs, sum)
  j     repeat
