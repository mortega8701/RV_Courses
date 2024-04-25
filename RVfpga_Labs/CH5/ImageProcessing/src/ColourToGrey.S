.globl ColourToGrey
.equ N, 256
.equ M, 256

.text

ColourToGrey:           # void ColourToGrey(RGB Colour[N][M], unsigned char Grey[N][M])
  addi  sp, sp, -24
  sw    ra, 0(sp)
  sw    s1, 4(sp)
  sw    s2, 8(sp)
  sw    s3, 12(sp)
  sw    s4, 16(sp)
  sw    s5, 20(sp)

  mv    s1, a0          # RGB Colour[N][M]
  mv    s2, a1          # unsigned char Grey[N][M]
  li    s3, 0           # i=0

repeati:
  li    t0, N
  bge   s3, t0, exiti   # i<N
  li    s4, 0           # j=0

repeatj:
  li    t1, M
  bge   s4, t1, exitj   # j<M
  mul   s5, s3, t1      # i*M
  add   s5, s5, s4      # i*M+j
  li    t2, 3
  mul   t2, s5, t2      # (i*M+j)*3
  add   t2, t2, s1      # Colour[][] + (i*M+j)*3
  lbu   a0, 0(t2)       # Colour[i][j].R
  lbu   a1, 1(t2)       # Colour[i][j].G
  lbu   a2, 2(t2)       # Colour[i][j].B
  jal   ColourToGrey_Pixel
  add   t2, s5, s2      # Grey[][] + i*M+j
  sb    a0, 0(t2)       # Grey[i][j] =  ColourToGrey_Pixel(Colour[i][j].R, Colour[i][j].G, Colour[i][j].B); 

  addi  s4, s4, 1       # j++
  j     repeatj

exitj:
  addi  s3, s3, 1       # i++
  j     repeati

exiti:
  lw    ra, 0(sp)
  lw    s1, 4(sp)
  lw    s2, 8(sp)
  lw    s3, 12(sp)
  lw    s4, 16(sp)
  lw    s5, 20(sp)
  addi  sp, sp, 24
  ret
.end
