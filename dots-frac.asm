
start: 
   jsr clear
   jsr init
loop:
   jsr draw
   jsr move
   jsr bounce

end:
   jmp loop
   rts

move:
   ldx #0
moveloop:

   lda vy0,x
   clc
   adc g
   sta vy0,x
   lda vy1,x
   adc #0
   sta vy1,x



   lda px0,x
   clc
   adc vx0,x
   sta px0,x
   lda px1,x
   adc vx1,x
   sta px1,x

   lda py0,x
   clc
   adc vy0,x
   sta py0,x
   lda py1,x
   adc vy1,x
   sta py1,x

movenext:
   inx
   cpx n
   bne moveloop
   rts

bounce:
   ldx #0

bounceloop:

   lda px1,x 
   bpl pxok 

negdx:
   lda vx0,x
   eor #$ff
   clc
   adc #1
   sta vx0,x
   lda vx1,x
   eor #$ff
   adc #0
   sta vx1,x

   lda px0,x
   clc
   adc vx0,x
   sta px0,x
   lda px1,x
   adc vx1,x
   sta px1,x

   jmp checkpy
pxok:
   sec
   sbc #32
   bcs negdx

checkpy:

   lda py1,x 
   bpl pyok 

negdy:
   lda vy0,x
   eor #$ff
   clc
   adc #1
   sta vy0,x
   lda vy1,x
   eor #$ff
   adc #0
   sta vy1,x

   lda py0,x
   clc
   adc vy0,x
   sta py0,x
   lda py1,x
   adc vy1,x
   sta py1,x

   jmp nextbounce 
pyok:
   sec
   sbc #32
   bcs negdy


nextbounce:

   inx
   cpx n 
   bne bounceloop
   rts




draw:
   ldx #0 
drawloop:

   lda old0,x
   sta $0
   lda old1,x
   sta $1
   ldy #0
   lda #1
   sta ($00),y

   ldy py1,x
   lda ylo,y
   sta $0
   lda yhi,y
   sta $1
   lda col,x
   ldy px1,x
   sta ($00),y

   tya
   clc
   adc $0
   sta old0,x
   lda $1
   sta old1,x

nodraw:

   inx
   cpx n
   bne drawloop
   rts


clear:
   lda #1
   ldx #0
cloop:
   sta $200,x
   sta $300,x
   sta $400,x
   sta $500,x
   dex
   bne cloop
   rts


init:
   ldx #0
init0:

   lda #0
   sta px0,x
   sta py0,x
   sta vx1,x
   sta vy0,x
   sta vy1,x

   lda $fe
   and #$f 
   clc
   adc #7
   sta px1,x

   lda $fe
   and #$f
   clc
   adc #7
   sta py1,x

   lda $fe
   and #$f0
   clc
   adc #$80
   sta vx0,x


again:
   lda $fe
   and #$ff
   cmp #1
   beq again
   sta col,x

   inx
   cpx n
   bne init0
   rts




ylo:
dcb $00, $20, $40, $60, $80, $a0, $c0, $e0
dcb $00, $20, $40, $60, $80, $a0, $c0, $e0
dcb $00, $20, $40, $60, $80, $a0, $c0, $e0
dcb $00, $20, $40, $60, $80, $a0, $c0, $e0 

yhi:
dcb $02, $02, $02, $02, $02, $02, $02, $02
dcb $03, $03, $03, $03, $03, $03, $03, $03
dcb $04, $04, $04, $04, $04, $04, $04, $04
dcb $05, $05, $05, $05, $05, $05, $05, $05

g: dcb 10
n: dcb 5
px0: dcb 0,12,5,3,2,5,13,19,28,10,22,21,9,6,26,9,25,23,25,12,15,5,8,28,5,17,13,16,18,5
px1: dcb 29,12,5,3,2,5,13,19,28,10,22,21,9,6,26,9,25,23,25,12,15,5,8,28,5,17,13,16,18,5
py0: dcb 0,13,22,9,22,3,8,14,23,29,3,8,8,14,25,24,12,20,15,18,22,28,16,29,5,13,28,30,5,5
py1: dcb 2,13,22,9,22,3,8,14,23,29,3,8,8,14,25,24,12,20,15,18,22,28,16,29,5,13,28,30,5,5
vx0: dcb 80,10,10,0,10,10,1,0,1,0,0,0,1,1,1,0,0,0,0,0,1,0,1,1,0,1,1,0,0,1
vx1: dcb 0,10,10,0,10,10,1,0,1,0,0,0,1,1,1,0,0,0,0,0,1,0,1,1,0,1,1,0,0,1
vy0: dcb 0,1,0,0,1,1,0,1,1,0,0,0,0,1,0,1,0,0,0,0,1,0,0,0,0,0,1,0,1,1
vy1: dcb 0,1,0,0,1,1,0,1,1,0,0,0,0,1,0,1,0,0,0,0,1,0,0,0,0,0,1,0,1,1
col: dcb 0,3,14,2,7,11,3,12,13,3,2,7,3,2,0,6,11,7,5,9,4,11,3,7,13,5,0,4,11,3
old0: dcb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
old1: dcb 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
