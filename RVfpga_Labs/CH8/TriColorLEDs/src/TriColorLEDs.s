# GPIO_SWs    0x80001400
# GPIO_LEDs   0x80001404
# GPIO_INOUT  0x80001408
# RPTC2_CNTR  0x80001240
# RPTC2_HRC   0x80001244
# RPTC2_LRC   0x80001248
# RPTC2_CTRL  0x8000124C
# RPTC3_CNTR  0x80001280
# RPTC3_HRC   0x80001284
# RPTC3_LRC   0x80001288
# RPTC3_CTRL  0x8000128C
# RPTC4_CNTR  0x800012C0
# RPTC4_HRC   0x800012C4
# RPTC4_LRC   0x800012C8
# RPTC4_CTRL  0x800012CC

.globl main

main:
  li    t0, 0x80001400
  li    t1, 0xFFFF
  sw    t1, 8(t0)         # WRITE(GPIO_INOUT, 0xFFFF);
  li    t4, 0x9
  li    t1, 0x80001240
  sw    t4, 12(t1)        # WRITE(RPTC2_CTRL, 0x9);
  li    t2, 0x80001280
  sw    t4, 12(t2)        # WRITE(RPTC3_CTRL, 0x9);
  li    t3, 0x800012C0
  sw    t4, 12(t3)        # WRITE(RPTC4_CTRL, 0x9);

  li    s1, 0x20          # B_LED
  li    s2, 0x20          # G_LED
  li    s3, 0x20          # R_LED

repeat:
  lw    s4, 0(t0)         # switches_value = READ(GPIO_SWs);
  srli  s4, s4, 16        # switches_value = switches_value >> 16;
  sw    s4, 4(t0)         # WRITE(GPIO_LEDs, switches_value);
  li    t4, 0x1F

  sw    t4, 4(t1)         # WRITE(RPTC2_HRC, 0x1F);
  sw    s1, 8(t1)         # WRITE(RPTC2_LRC, B_val);
  andi  s1, s4, 0x1F      # B_val = switches_value & 0x1F;
  add   s1, s1, t4
  addi  s1, s1, 1         # B_val = B_val + 0x20;
  li    t5, 0x80
  sw    t5, 12(t1)        # WRITE(RPTC2_CTRL, 0x80);
  li    t5, 0x9
  sw    t5, 12(t1)        # WRITE(RPTC2_CTRL, 0x9);

G_LED:
  sw    t4, 4(t2)         # WRITE(RPTC3_HRC, 0x1F);
  sw    s2, 8(t2)         # WRITE(RPTC3_LRC, G_val);
  srli  s2, s4, 5         # G_val = switches_value >> 5;
  andi  s2, s2, 0x1F      # G_val = G_val & 0x1F;
  add   s2, s2, t4
  addi  s2, s2, 1         # G_val = G_val + 0x20;
  li    t5, 0x80
  sw    t5, 12(t2)        # WRITE(RPTC3_CTRL, 0x80);
  li    t5, 0x9
  sw    t5, 12(t2)        # WRITE(RPTC3_CTRL, 0x9);

R_LED:
  sw    t4, 4(t3)         # WRITE(RPTC4_HRC, 0x1F);
  sw    s3, 8(t3)         # WRITE(RPTC4_LRC, R_val);
  srli  s3, s4, 10        # R_val = switches_value >> 5;
  andi  s3, s3, 0x1F      # R_val = R_val & 0x1F;
  add   s3, s3, t4
  addi  s3, s3, 1         # R_val = R_val + 0x20;
  li    t5, 0x80
  sw    t5, 12(t3)        # WRITE(RPTC4_CTRL, 0x80);
  li    t5, 0x9
  sw    t5, 12(t3)        # WRITE(RPTC4_CTRL, 0x9);

B_LED:
  j     repeat