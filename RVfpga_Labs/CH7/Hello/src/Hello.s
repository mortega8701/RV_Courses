# DIGITS3TO0  0x80001038
# DIGITS7TO4  0x8000103C

.globl main

main:
  li    t0, 0x80001038
  li    s1, 0xB0F1F181    # ELLO
  sw    s1, 0(t0)         # WRITE(DIGITS3TO0, 0xB0F1F181)
  li    s1, 0xFFFFFFC8    # ...H
  sw    s1, 4(t0)         # WRITE(DIGITS7TO4, 0xFFFFFFC8)

repeat:
  j     repeat