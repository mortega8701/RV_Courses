# GPIO_SWs   = 0x80001400
# GPIO_LEDs  = 0x80001404
# GPIO_INOUT = 0x80001408

.globl main

main:
  li    t0, 0x80001400
  li    t1, 0xFFFF
  sw    t1, 8(t0)         # WRITE_GPIO(GPIO_INOUT, 0xFFFF)

start:
	li    s1, 1             # LEDs_value=1

leftshft:
  sw    s1, 4(t0)         # WRITE_GPIO(GPIO_LEDs, LEDs_value)
  li    t1, 0x5000        # i = 0x5000

delay1: 
  addi  t1, t1, -1        # i--
  bge   t1, zero, delay1  # while(i!=0)

  slli  s1, s1, 1         # LEDs_value = LEDs_value << 1
  li    t2, 0x8000
  blt   s1, t2, leftshft  # while (LEDs_value < 0x8000)

rightshft:
  sw    s1, 4(t0)         # WRITE_GPIO(GPIO_LEDs, LEDs_value)
  li    t1, 0x5000        # i = 0x5000

delay2: 
  addi  t1, t1, -1        # i--
  bge   t1, zero, delay2  # while(i!=0)

	srli  s1, s1, 1         # LEDs_value = LEDs_value >> 1
	andi  t2, s1, 0x1
	li    t3, 1
	blt   t2, t3, rightshft # while ((LEDs_value & 1) < 1)

	li    t2, 0xFFFF
	bge   s1, t2, start     # LEDs_value >= 0xFFFF
	mv    t2, s1
	slli  t3, t2, 1
	ori   s1, t3, 1         # LEDs_value = (LEDs_value << 1) | 1;
	j     leftshft
