#if defined(D_NEXYS_A7)
  #include <bsp_printf.h>
  #include <bsp_mem_map.h>
  #include <bsp_version.h>
#else
  PRE_COMPILED_MSG("no platform was defined")
#endif
#include <psp_api.h>
#define DELAY 500000

#define N 10

int main(void)
{
  int A[N] = {0,1,2,3,4,5,6,7,8,9};
  int B[N] = {0,1,2,3,4,5,6,7,8,9};
  int C[N];
  int i;

  uartInit();
  for(i=0; i<N; i++) {
    C[i] = A[i] + B[N-1-i];
    printfNexys("Term number %d is %d\n", i, C[i]);
  }
  
  while (1);
}
