// memory-mapped I/O addresses
#define GPIO_SWs    0x80001400
#define GPIO_LEDs   0x80001404
#define GPIO_INOUT  0x80001408

#define DIGIT_EN    0x80001038
#define SEVEN_SEG   0x8000103C

#define READ(dir) (*(volatile unsigned *)dir)
#define WRITE(dir, value) { (*(volatile unsigned *)dir) = (value); }

int main ( void )
{
  int gpio_en=0xFFFF;
  int seg_en=0xFFF0;
  int switches_value;

  WRITE(GPIO_INOUT, gpio_en);
  WRITE(DIGIT_EN, seg_en);

  while (1) {
    switches_value = READ(GPIO_SWs);
    switches_value = switches_value >> 16;
    WRITE(SEVEN_SEG, switches_value);
  }

  return(0);
}