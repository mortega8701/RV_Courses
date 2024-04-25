// memory-mapped I/O addresses
#define GPIO_SWs    0x80001400
#define GPIO_LEDs   0x80001404
#define GPIO_INOUT  0x80001408

#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value) { (*(volatile unsigned *)dir) = (value); }

int main ( void )
{
  int En_Value=0xFFFF;
  int switches_value;
  int right_sw=0, left_sw=0;
  int sum=0;

  WRITE_GPIO(GPIO_INOUT, En_Value);

  while (1) { 
    switches_value = READ_GPIO(GPIO_SWs);
    switches_value = switches_value >> 16;
    right_sw = (switches_value >> 12) & 0xF;
    left_sw = switches_value & 0xF;
    sum = right_sw + left_sw;
    WRITE_GPIO(GPIO_LEDs, sum);
  }
  return(0);
}