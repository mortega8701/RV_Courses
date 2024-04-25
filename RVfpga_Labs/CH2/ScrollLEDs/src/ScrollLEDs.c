// memory-mapped I/O addresses
#define GPIO_SWs    0x80001400
#define GPIO_LEDs   0x80001404
#define GPIO_INOUT  0x80001408
#define DELAY 10000

#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value) { (*(volatile unsigned *)dir) = (value); }

int main ( void )
{
  int i;
  int En_Value=0xFFFF;
  int LEDs_value=1;

  WRITE_GPIO(GPIO_INOUT, En_Value);

  while (1) { 

    do {
      WRITE_GPIO(GPIO_LEDs, LEDs_value);
      i=0;
      while (i<DELAY) i++;
      LEDs_value = LEDs_value << 1;
    } while (LEDs_value < 0x8000);

    do {
      WRITE_GPIO(GPIO_LEDs, LEDs_value);
      i=0;
      while (i<DELAY) i++;
      LEDs_value = LEDs_value >> 1;
    } while ((LEDs_value & 1) < 1);

    if(LEDs_value >= 0xFFFF) {
      LEDs_value = 1;
    } else {
      LEDs_value = (LEDs_value << 1) | 1;
    }
  }
  return(0);
}
