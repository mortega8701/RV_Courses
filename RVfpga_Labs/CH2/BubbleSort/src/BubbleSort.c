#if defined(D_NEXYS_A7)
  #include <bsp_printf.h>
  #include <bsp_mem_map.h>
  #include <bsp_version.h>
#else
  PRE_COMPILED_MSG("no platform was defined")
#endif
#include <psp_api.h>

#define N 7

int main(void)
{
  int A[N] = {64,34,25,12,22,11,90};
  int i;
  int swap, aux;

  uartInit();
  do {
    swap = 0;
    for(i=0; i<N-1; i++) {
      if(A[i]>A[i+1]){
        aux = A[i];
        A[i] = A[i+1];
        A[i+1] = aux;
        swap = 1;
      }
    }
  } while(swap);

  for(i=0; i<N; i++) {
    printfNexys("Term number %d is %d\n", i, A[i]);
  }
  while (1);
}
