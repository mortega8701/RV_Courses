// memory-mapped I/O addresses
#define DIGIT_EN    0x80001038
#define SEVEN_SEG   0x8000103C
#define RPTC_CNTR   0x80001200
#define RPTC_HRC    0x80001204
#define RPTC_LRC    0x80001208
#define RPTC_CTRL   0x8000120C
// {CAPTE, CNTRRST, INT, INTE, SINGLE, OE, NEC, ECLK, EN}
#define DELAY 0x10000

#define READ(dir) (*(volatile unsigned *)dir)
#define WRITE(dir, value) { (*(volatile unsigned *)dir) = (value); }

int main ( void )
{
  WRITE(DIGIT_EN, 0xFF00);
  WRITE(RPTC_LRC, DELAY);
  WRITE(RPTC_CTRL, 0x21);         // INTE=1, EN=1
  int count=0, ctrl;

  while (1) {
    ctrl = READ(RPTC_CTRL);
    ctrl = ctrl & 0x40;           // get INT
    if (ctrl != 0) {
      WRITE(RPTC_CTRL, 0x80);     // CNTRRST = 1
      WRITE(RPTC_CTRL, 0x21);     // INTE=1, EN=1
      count++;
    }
    WRITE(SEVEN_SEG, count);
  }

  return(0);
}
