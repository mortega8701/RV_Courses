// memory-mapped I/O addresses
#define GPIO_SWs    0x80001400
#define GPIO_LEDs   0x80001404
#define GPIO_INOUT  0x80001408

#define GPIO2_BTN   0x80001800
#define GPIO2_INOUT 0x80001808
#define DELAY 0x1000

#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value) { (*(volatile unsigned *)dir) = (value); }

int main ( void )
{
  int delay, count=0;
  int En_Value=0xFFFF, btn_value;

  WRITE_GPIO(GPIO_INOUT, En_Value);
  WRITE_GPIO(GPIO2_INOUT, En_Value);

  while (1) {
    btn_value = READ_GPIO(GPIO2_BTN);
    if((btn_value & 0x2)!=0)
      count=0;
    else
      count++;

    if((btn_value & 0x1)!=0)
      delay = DELAY;
    else
      delay = DELAY*10;

    while(delay>0) delay--;
    WRITE_GPIO(GPIO_LEDs, count);
  }

  return(0);
}
