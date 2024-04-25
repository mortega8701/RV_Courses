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
#define MAX_PATTERN 15
 
#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value) { (*(volatile unsigned *)dir) = (value); }

void IOsetup();
unsigned int getSwitchesVal();
void writeValtoLEDs(unsigned int val);
void delay(int num);
void setupRand();
void playGame();
void setPattern();
void displayPattern(int turn);
int getUserInput(int turn);
void resetGame();

int pattern[MAX_PATTERN];

int main ( void )
{

  IOsetup();
  uartInit();
  setupRand();

  writeValtoLEDs(0);
  while (1) {
    playGame();
    resetGame();
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
  while((getSwitchesVal() & 0x8000)!=0) 
    Ticks++;
  srand(Ticks);
}

void playGame() {
  setPattern();
  for (int turn=0; turn<MAX_PATTERN; turn++) {
    displayPattern(turn);
    if(getUserInput(turn)==0) {
      printfNexys("Failed at turn %d\n", turn);
      turn+=MAX_PATTERN;
    }
  }
  writeValtoLEDs(0x7);
}

void setPattern() {
  for (int i=0; i<MAX_PATTERN; i++) {
    pattern[i] = 0x1 << (rand()%3);
  }
}

void displayPattern(int turn) {
  for (int i=0; i<turn+1; i++) {
    writeValtoLEDs(pattern[i]);
    delay(1000);
    writeValtoLEDs(0);
    delay(1000);
  }
}

int getUserInput(int turn) {
  for (int i=0; i<turn+1; i++) {
    while((getSwitchesVal() & 0x7)!=0);
    while((getSwitchesVal() & 0x7)==0);
    if ((getSwitchesVal() & 0x7)!=pattern[i]) {
      return 0;
    }
  }
  return 1;
}

void resetGame() {
  while((getSwitchesVal() & 0x8000)!=0); 
  while((getSwitchesVal() & 0x8000)==0); 
  writeValtoLEDs(0);
}