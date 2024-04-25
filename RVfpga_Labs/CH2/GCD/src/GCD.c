#if defined(D_NEXYS_A7)
  #include <bsp_printf.h>
  #include <bsp_mem_map.h>
  #include <bsp_version.h>
#else
  PRE_COMPILED_MSG("no platform was defined")
#endif
#include <psp_api.h>

int main(void)
{
  int a = 270, b = 192, rem=0;

  uartInit();

  while (b!=0)
  {
    if(a>b) {
      rem=a%b;
      a=b;
      b=rem;
    } else {
      rem=b%a;
      b=a;
      a=rem;
    }
  }

  printfNexys("GCD is %d\n", a);

  while (1);
}
