#define GPIO_SWs    0x80001400
#define GPIO_LEDs   0x80001404
#define GPIO_INOUT  0x80001408
#define SLOW_DELAY 20000
#define QUICK_DELAY 5000

#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value) { (*(volatile unsigned *)dir) = (value); }

int main ( void )
{
  int En_Value=0xFFFF, switches_value, LEDs_value = 0xF;
  int speed, i;

  WRITE_GPIO(GPIO_INOUT, En_Value);

  while (1) { 
    switches_value = READ_GPIO(GPIO_SWs);
    switches_value = switches_value >> 16;
    if ((switches_value & 0x1) != 0){
      speed = QUICK_DELAY;
    } else {
      speed = SLOW_DELAY;
    }

    if ((switches_value & 0x2) != 0){
      if (LEDs_value & 0x8000) {
        LEDs_value = LEDs_value << 1;
        LEDs_value = LEDs_value | 0x1;
      } else {
        LEDs_value = LEDs_value << 1;
      }
    } else {
      if ((LEDs_value & 0x1) != 0) {
        LEDs_value = LEDs_value >> 1;
        LEDs_value = LEDs_value | 0x8000;
      } else {
        LEDs_value = LEDs_value >> 1;
      }
    }
    WRITE_GPIO(GPIO_LEDs, LEDs_value);
    i=0;
    while (i<speed) i++;
  }

  return(0);
}