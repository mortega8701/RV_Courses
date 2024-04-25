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
  int A[12] = {0,1,2,7,-8,4,5,12,11,-2,6,3};
  int B[12];
  int sizeB=0;

  for (int i=0; i<12; i++){
    if (A[i]%2==0 && A[i]>0) {
      B[sizeB] = A[i];
      sizeB++;
    }
  }

  uartInit();
  printfNexys("The number of elements in B = %d\n", sizeB);

  while (1);
}