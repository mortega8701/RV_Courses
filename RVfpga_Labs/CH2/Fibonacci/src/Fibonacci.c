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
  int V[n];
  int i;

  uartInit();

  V[0] = 0;
  printfNexys("The F(%d) is %d\n", 0, V[0]);

  V[1] = 1;
  printfNexys("The F(%d) is %d\n", 1, V[1]);

  for(i=2; i<=n; i++) {
    V[i] = V[i-1] + V[i-2];
    printfNexys("The F(%d) is %d\n", i, V[i]);
  }

  while (1);
}