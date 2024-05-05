# DIGIT_EN    0x80001038
# SEVEN_SEG   0x8000103C
# RPTC_CNTR   0x80001200
# RPTC_HRC    0x80001204
# RPTC_LRC    0x80001208
# RPTC_CTRL   0x8000120C

.globl main
.equ DELAY, 0x10000

main:
  li    t0, 0x80001038
  li    t1, 0x80001200
  li    t2, 0xFF00
  sw    t2, 0(t0)         # WRITE(DIGIT_EN, 0xFF00)
  li    t2, DELAY
  sw    t2, 8(t1)         # WRITE(RPTC_LRC, DELAY);
  li    t2, 0x21
  sw    t2, 12(t1)        # WRITE(RPTC_CTRL, 0x21);
  li    s1, 0             # count = 0;

repeat:
  lw    t2, 12(t1)        # ctrl = READ(RPTC_CTRL);
  andi  t2, t2, 0x40      # ctrl = ctrl & 0x40;
  beqz  t2, print         # if (ctrl != 0)
  li    t2, 0x80
  sw    t2, 12(t1)        # WRITE(RPTC_CTRL, 0x80);
  li    t2, 0x21
  sw    t2, 12(t1)        # WRITE(RPTC_CTRL, 0x21);
  addi  s1, s1, 1         # count++;

print:
  sw    s1, 4(t0)         # WRITE(SEVEN_SEG, count);
  j     repeat