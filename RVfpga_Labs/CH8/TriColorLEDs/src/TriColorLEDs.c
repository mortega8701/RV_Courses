// memory-mapped I/O addresses
#define GPIO_SWs    0x80001400
#define GPIO_LEDs   0x80001404
#define GPIO_INOUT  0x80001408
#define RPTC2_CNTR  0x80001240
#define RPTC2_HRC   0x80001244
#define RPTC2_LRC   0x80001248
#define RPTC2_CTRL  0x8000124C
#define RPTC3_CNTR  0x80001280
#define RPTC3_HRC   0x80001284
#define RPTC3_LRC   0x80001288
#define RPTC3_CTRL  0x8000128C
#define RPTC4_CNTR  0x800012C0
#define RPTC4_HRC   0x800012C4
#define RPTC4_LRC   0x800012C8
#define RPTC4_CTRL  0x800012CC
// {CAPTE, CNTRRST, INT, INTE, SINGLE, OE, NEC, ECLK, EN}

#define READ(dir) (*(volatile unsigned *)dir)
#define WRITE(dir, value) { (*(volatile unsigned *)dir) = (value); }

int main ( void )
{
  int switches_value;
  int R_val=0x20, G_val=0x20, B_val=0x20;

  WRITE(GPIO_INOUT, 0xFFFF);
  WRITE(RPTC4_CTRL, 0x9);     // INTE=1, OE=1, EN=1
  WRITE(RPTC3_CTRL, 0x9);     // INTE=1, OE=1, EN=1
  WRITE(RPTC2_CTRL, 0x9);     // INTE=1, OE=1, EN=1

  while (1) {
    switches_value = READ(GPIO_SWs);
    switches_value = switches_value >> 16;
    WRITE(GPIO_LEDs, switches_value);

    /*
    The PWM has a duty cycle between 0% and 50%. More exactly 1/32 to 31/63.
    It frecuency isn't cosntant but it still quick between 32 and 64 clock cycles
    syncronized method to assure expected behaviour
    */

    WRITE(RPTC4_HRC, 0x1F);
    R_val = (switches_value >> 10) & 0x1F;
    R_val = R_val + 0x20;
    WRITE(RPTC4_CTRL, 0x80);    // CNTRRST = 1
    WRITE(RPTC4_CTRL, 0x9);     // INTE=1, OE=1, EN=1
    WRITE(RPTC4_LRC, R_val);

    WRITE(RPTC3_HRC, 0x1F);
    G_val = (switches_value >> 5) & 0x1F;
    G_val = G_val + 0x20;
    WRITE(RPTC3_CTRL, 0x80);    // CNTRRST = 1
    WRITE(RPTC3_CTRL, 0x9);     // INTE=1, OE=1, EN=1
    WRITE(RPTC3_LRC, G_val);

    WRITE(RPTC2_HRC, 0x1F);
    B_val = switches_value & 0x1F;
    B_val = B_val + 0x20; 
    WRITE(RPTC2_CTRL, 0x80);    // CNTRRST = 1
    WRITE(RPTC2_CTRL, 0x9);     // INTE=1, OE=1, EN=1
    WRITE(RPTC2_LRC, B_val);
  }

  return(0);
}