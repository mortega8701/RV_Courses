# GPIO_SWs    = 0x80001400
# GPIO_LEDs   = 0x80001404
# GPIO_INOUT  = 0x80001408
# GPIO2_BTN   = 0x80001800
# GPIO2_INOUT = 0x80001808

.globl main
.equ SDELAY, 1000
.equ LDELAY, 10000

main:
  li    t0, 0x80001400
  li    t1, 0x80001800
  li    t2, 0xFFFF
  sw    t2, 8(t0)         # WRITE_GPIO(GPIO_INOUT, 0xFFFF)
  sw    t2, 8(t1)         # WRITE_GPIO(GPIO2_INOUT, 0xFFFF)
  li    s1, 0             # count = 0

repeat:
  lw    s2, 0(t1)         # btn_read = READ_GPIO(GPIO2_BTN)
  andi  t2, s2, 0x2       # btnread & 0x2
  beqz  t2, else1         # (btnread & 0x2) == 0
  add   s1, zero, zero    # count = 0
  j     if2

else1:
  addi  s1, s1, 1         # count++

if2:
  andi  t2, s2, 0x1       # btnread & 0x1
  beqz  t2, else2         # (btnread & 0x1) == 0
  li    t2, SDELAY        # delay = DELAY
  j     delay

else2:
  li  t2, LDELAY          # delay = DELAY

delay:
  addi  t2, t2, -1        # delay--
  bgez  t2, delay         # while(delay>=0)

end:
  sw    s1, 4(t0)         # WRITE_GPIO(GPIO_LEDs, count)   
  j     repeat