// memory-mapped I/O addresses
#include <stdlib.h>

#if defined(D_NEXYS_A7)
  #include <bsp_printf.h>
  #include <bsp_mem_map.h>
  #include <bsp_version.h>
#else
  PRE_COMPILED_MSG("no platform was defined")
#endif
#include <psp_api.h>

#define GPIO_SWs    0x80001400
#define GPIO_LEDs   0x80001404
#define GPIO_INOUT  0x80001408
#define MS_DELAY 5
#define MAX_WAIT 3000
#define BAR_LIMIT 1000
 
#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value) { (*(volatile unsigned *)dir) = (value); }

void IOsetup();
unsigned int getSwitchesVal();
void writeValtoLEDs(unsigned int val);
void delay(int num);
void setupRand();
void InitGame();
void SetupGame();
int GameTimer();
void DisplayResults(int time);

int main ( void )
{
  int timer;

  IOsetup();
  uartInit();
  setupRand();

  while (1) {
    InitGame();
    SetupGame();
    timer = GameTimer();
    DisplayResults(timer/MS_DELAY);
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

void setupRand() {
  int Ticks=0;
  while((getSwitchesVal() & 0x1)!=0) 
    Ticks++;
  srand(Ticks);
}

void InitGame() {
  while((getSwitchesVal() & 0x1)==0);
  while((getSwitchesVal() & 0x1)!=0);
  writeValtoLEDs(0);
}

void SetupGame() {
  int waitTime;
  waitTime = rand()%MAX_WAIT;
  delay(waitTime);
  writeValtoLEDs(0xFFFF);
}

int GameTimer() {
  int timer = 0;
  while((getSwitchesVal() & 0x1)==0)
    timer++;
  return timer;
}

void DisplayResults(int time) {
  if (time > BAR_LIMIT)             writeValtoLEDs(0xFFFF);
  else if (time > BAR_LIMIT*15/16)  writeValtoLEDs(0x7FFF);
  else if (time > BAR_LIMIT*14/16)  writeValtoLEDs(0x3FFF);
  else if (time > BAR_LIMIT*13/16)  writeValtoLEDs(0x1FFF);
  else if (time > BAR_LIMIT*12/16)  writeValtoLEDs(0x0FFF);
  else if (time > BAR_LIMIT*11/16)  writeValtoLEDs(0x07FF);
  else if (time > BAR_LIMIT*10/16)  writeValtoLEDs(0x03FF);
  else if (time > BAR_LIMIT* 9/16)  writeValtoLEDs(0x01FF);
  else if (time > BAR_LIMIT* 8/16)  writeValtoLEDs(0x00FF);
  else if (time > BAR_LIMIT* 7/16)  writeValtoLEDs(0x007F);
  else if (time > BAR_LIMIT* 6/16)  writeValtoLEDs(0x003F);
  else if (time > BAR_LIMIT* 5/16)  writeValtoLEDs(0x001F);
  else if (time > BAR_LIMIT* 4/16)  writeValtoLEDs(0x000F);
  else if (time > BAR_LIMIT* 3/16)  writeValtoLEDs(0x0007);
  else if (time > BAR_LIMIT* 2/16)  writeValtoLEDs(0x0003);
  else if (time > BAR_LIMIT* 1/16)  writeValtoLEDs(0x0001);
  else writeValtoLEDs(0xFFFF);
  printfNexys("Reaction Time: %d ms\n", time);
}