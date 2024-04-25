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
  int n = 7;
  int acum=1;

  uartInit();

  for (int i=n; i>1; i=i-1) {
    acum = acum * i;
  }

  printfNexys("The factorial of %d is %d\n", n, acum);
  while (1);
}