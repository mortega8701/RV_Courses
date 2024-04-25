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
  int En_Value=0xFFFF, switches_value;

  WRITE_GPIO(GPIO_INOUT, En_Value);

  while (1) {
    switches_value = READ_GPIO(GPIO_SWs);
    switches_value = switches_value >> 16;
    WRITE_GPIO(GPIO_LEDs, switches_value);
    i=0;
    while (i<DELAY) i++;
    WRITE_GPIO(GPIO_LEDs, 0);
    i=0;
    while (i<DELAY) i++;
  }

  return(0);
}
