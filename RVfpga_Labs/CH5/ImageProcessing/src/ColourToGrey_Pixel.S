.globl ColourToGrey_Pixel

.text

ColourToGrey_Pixel: # int ColourToGrey_Pixel(int R, int G, int B)
  li  x28, 306
  mul a0, a0, x28   # R = R * 306

  li  x28, 601
  mul a1, a1, x28   # G = G * 601

  li  x28, 117
  mul a2, a2, x28   # B = B * 117

  add a0, a0, a1
  add a0, a0, a2    # Pixel = R + G + B

  srl a0, a0, 10    # Pixel = (R+G+B)/2^10

  ret               # return Pixel
.end
