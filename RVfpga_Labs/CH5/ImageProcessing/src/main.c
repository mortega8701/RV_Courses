#if defined(D_NEXYS_A7)
  #include "bsp_printf.h"
  #include "bsp_mem_map.h"
  #include "bsp_version.h"
#else
  PRE_COMPILED_MSG("no platform was defined")
#endif

#include "psp_api.h"


typedef struct {
  unsigned char R;
  unsigned char G;
  unsigned char B;
} RGB;


#define N 256
#define M 256
//extern unsigned char VanGogh_128x128[];
extern unsigned char TheScream_256x256[];
RGB ColourImage[N][M];
unsigned char GreyImage[N][M];

void initColourImage(RGB image[N][M]) {
  int i,j;

  for (i=0;i<N;i++) {
    for (j=0; j<M; j++) {
      /*
      image[i][j].R = VanGogh_128x128[(i*M + j)*3];
      image[i][j].G = VanGogh_128x128[(i*M + j)*3 + 1];
      image[i][j].B = VanGogh_128x128[(i*M + j)*3 + 2];
      /*/
      image[i][j].R = TheScream_256x256[(i*M + j)*3];
      image[i][j].G = TheScream_256x256[(i*M + j)*3 + 1];
      image[i][j].B = TheScream_256x256[(i*M + j)*3 + 2];
      
    }
  }
}

extern int ColourToGrey_Pixel(int R, int G, int B);

extern void ColourToGrey(RGB Colour[N][M], unsigned char Grey[N][M]);

/*int ColourToGrey_Pixel(int R, int G, int B) {
  int Pixel;
  Pixel = (306*R + 601*G + 117*B) >> 10;
  return Pixel;
}*/

/*void ColourToGrey(RGB Colour[N][M], unsigned char Grey[N][M]) {
  int i,j;
    
  for (i=0;i<N;i++)
    for (j=0; j<M; j++)
      Grey[i][j] =  ColourToGrey_Pixel(Colour[i][j].R, Colour[i][j].G, Colour[i][j].B); 
}*/

void CountGreys(unsigned char Grey[N][M]){

  int blackCount = 0, whiteCount = 0;
  int i,j;
  for (i=0;i<N;i++) {
    for (j=0; j<M; j++) {
      if(Grey[i][j] < 20) {
        blackCount++;
      }
      if(Grey[i][j] > 235) {
        whiteCount++;
      }
    }
  }
  printfNexys("Number of whiter pixels: %d", whiteCount);
  printfNexys("Number of blacker pixels: %d", blackCount);
}

int main(void) {
  // Create an NxM matrix using the input image
  initColourImage(ColourImage);

  // Transform Colour Image to Grey Image
  ColourToGrey(ColourImage,GreyImage);

  // Initialize Uart
  uartInit();
  CountGreys(GreyImage);
  // Print message on the serial output

  printfNexys("Created Grey Image");

  while(1);

  return 0;
}


