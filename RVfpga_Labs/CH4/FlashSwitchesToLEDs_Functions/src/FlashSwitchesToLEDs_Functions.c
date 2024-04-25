// memory-mapped I/O addresses
#define GPIO_SWs    0x80001400
#define GPIO_LEDs   0x80001404
#define GPIO_INOUT  0x80001408
#define MS_DELAY 5

#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value) { (*(volatile unsigned *)dir) = (value); }

void IOsetup();
unsigned int getSwitchesVal();
void writeValtoLEDs(unsigned int val);
void delay(int num);

int main ( void )
{
  unsigned int switches_val;

  IOsetup();
  while (1) { 
    switches_val = getSwitchesVal();
    writeValtoLEDs(switches_val);
    delay(1000);
    writeValtoLEDs(0);
    delay(1000);
  }

  return(0);
}

void IOsetup()
{
  int En_Value=0xFFFF;
  WRITE_GPIO(GPIO_INOUT, En_Value);
}

unsigned int getSwitchesVal()
{ 
  unsigned int val;

  val = READ_GPIO(GPIO_SWs);      
  val = val >> 16;

  return val;
}

void writeValtoLEDs(unsigned int val)
{
  WRITE_GPIO(GPIO_LEDs, val);
}

void delay(int num) {
  volatile int i;
  int delay;

  i=0;
  delay=num*MS_DELAY;
  while(i<delay) i++;
}
