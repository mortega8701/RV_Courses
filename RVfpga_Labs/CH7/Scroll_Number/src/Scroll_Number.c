// memory-mapped I/O addresses
#define DIGIT_EN    0x80001038
#define SEVEN_SEG   0x8000103C
#define DELAY 50000

#define READ(dir) (*(volatile unsigned *)dir)
#define WRITE(dir, value) { (*(volatile unsigned *)dir) = (value); }

int main ( void )
{
  int seg_en=0xFF00;
  int number=0x01234567;
  volatile int i, newNumber, digit;

  WRITE(DIGIT_EN, seg_en);

  while (1) {
    newNumber=0x0;

    for(i=0; i<8; i++) {
      digit = number >> i*4;
      digit = digit & 0xF;
      digit++;
      if(digit > 8){
        digit = 0;
      }
      digit = digit << i*4;
      newNumber = newNumber | digit;
    }

    number = newNumber;
    WRITE(SEVEN_SEG, number);
    i = DELAY;
    while (i>=0) i--;
  }

  return(0);
}