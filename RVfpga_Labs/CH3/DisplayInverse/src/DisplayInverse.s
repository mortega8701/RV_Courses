# GPIO_SWs   = 0x80001400
# GPIO_LEDs  = 0x80001404
# GPIO_INOUT = 0x80001408

.globl main

main:
  li t0, 0x80001400
  li t1, 0xFFFF
  sw t1, 8(t0)        # WRITE_GPIO(GPIO_INOUT, 0xFFFF)

repeat:
  lw   t1, 0(t0)      # switches_value = READ_GPIO(GPIO_SWs)
  srli t1, t1, 16     # switches_value = switches_value >> 16
  not  t1, t1         # switches_value = ~switches_value
  sw   t1, 4(t0)      # # WRITE_GPIO(GPIO_LEDs, switches_value)

  jal  repeat