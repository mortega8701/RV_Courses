// memory-mapped I/O addresses
#define DIGITS3TO0  0x80001038
#define DIGITS7TO4  0x8000103C

#define READ(dir) (*(volatile unsigned *)dir)
#define WRITE(dir, value) { (*(volatile unsigned *)dir) = (value); }

int main ( void )
{
  WRITE(DIGITS7TO4, 0xFFFFFFC8);
  WRITE(DIGITS3TO0, 0xB0F1F181);

  while(1);
  return(0);
}