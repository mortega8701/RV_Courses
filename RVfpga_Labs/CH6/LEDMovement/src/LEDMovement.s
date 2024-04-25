# memory-mapped I/O addresses
# GPIO_SWs   = 0x80001400
# GPIO_LEDs  = 0x80001404
# GPIO_INOUT = 0x80001408

.globl main
.equ FAST, 0x1000
.equ SLOW, 0x4000

main:
  li    t0, 0x80001400   
  li    t1, 0xFFFF       
  sw    t1, 8(t0)       # WRITE_GPIO(GPIO_INOUT, 0xFFFF);
  li    s3, 0xF

repeat:
  lw    s1, 0(t0)       # switches_value = READ_GPIO(GPIO_SWs);
  srli  s1, s1, 16      # switches_value >> 16
  andi  t1, s1, 0x1
  beqz  t1, else_speed  # if (switches_value & 0x1 != 0)
  li    s2, FAST        # speed = FAST
  j     if_dir

else_speed:
  li    s2, SLOW        # speed = SLOW

if_dir:
  andi  t1, s1, 0x2
  beqz  t1, if_leds2    # if (switches_value & 0x2 != 0)

if_leds1:
  li    t1, 0x8000      # 12-bit imm
  and   t1, s3, t1
  beqz  t1, else_leds1  # if (LEDs_value & 0x8000 != 0)
  slli  s3, s3, 1       # LEDs_value = LEDs_value << 1;
  ori   s3, s3, 0x1     # LEDs_value = LEDs_value | 0x1;
  j     exit_else

else_leds1:
  slli  s3, s3, 1       # LEDs_value = LEDs_value << 1;
  j     exit_else

if_leds2:
  andi  t1, s3, 0x1
  beqz  t1, else_leds2  # if (LEDs_value & 0x1 != 0)
  srli  s3, s3, 1       # LEDs_value = LEDs_value >> 1;
  li    t1, 0x8000
  or    s3, s3, t1      # LEDs_value = LEDs_value | 0x8000;
  j     exit_else

else_leds2:
  srli  s3, s3, 1       # LEDs_value = LEDs_value >> 1;

exit_else:
  sw    s3, 4(t0)       # WRITE_GPIO(GPIO_LEDs, LEDs_value);
  li    t1, 0           # i=0

delay:
  addi  t1, t1, 1       # i++
  blt   t1, s2, delay   # while (i<speed) i++;

  j     repeat         # repeat loop