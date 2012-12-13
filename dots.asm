
start:
   jsr clear
loop:
   jsr draw
   jsr move
   jsr bounce
end:
   jmp loop




move:
   ldx #0
moveloop:
   clc
   lda px,x
   adc dx,x
   sta px,x
   clc
   lda py,x
   adc dy,x
   sta py,x
   inx
   cpx n
   bne moveloop
   rts

bounce:
   ldx #0
bounceloop:
   lda px,x
   ;cmp #32
   sec
   sbc #32
   bcc pxok
negdx:
   lda dx,x
   clc
   eor #$ff
   adc #1
   sta dx,x
   lda px,x
   clc
   adc dx,x
   clc
   adc dx,x
   sta px,x
   jmp checkpy
pxok:
   lda px,x
   ;cmp #0
   sec
   sbc #0
   bcc negdx
checkpy:   
   lda py,x
   sec
   sbc #32
;   cmp #32
   bcc pyok
negdy:
   lda dy,x
   clc
   eor #$ff
   adc #1
   sta dy,x
   lda py,x
   clc
   adc dy,x
   clc
   adc dy,x
   sta py,x
   jmp next
pyok:
   lda py,x
   sec
   sbc #0
   ;cmp #1
   bcc negdy
next:   
   inx
   cpx n
   bne bounceloop
   rts

background:
   ldx #31
   lda #$b
fill:
   sta $200,x
   sta $5e0,x
   dex
   bpl fill
   rts


draw:
   ldx #0
drawloop:
   lda old0,x
   sta $0
   lda old1,x
   sta $1
   ldy #0
   lda #0
   sta ($00),y

   lda #0
   sta $1
   lda py,x
   asl
   rol $1
   asl
   rol $1
   asl
   rol $1
   asl
   rol $1
   asl
   rol $1
   sta $0
   ;clc
   ;lda $1
   ;adc #$02
   ;sta $1
   inc $1
   inc $1
   lda col,x
   ldy px,x
   sta ($00),y
   lda $0
   clc
   adc px,x
   sta old0,x
   lda $1
   sta old1,x

   inx
   cpx n
   bne drawloop
   rts


clear:
   lda #$00
   ldx #$00
cloop:
   sta $200,x
   sta $300,x
   sta $400,x
   sta $500,x
   dex
   bne cloop
   rts

n: dcb 7
px: dcb 28,7,25,13,0,25,26,30,24,22,1,1,19,6,9,24,31,2,31,7,2,28,26,14,19,18,6,17,3,8,3,31,10,2,2,5,30,13,9,4
py: dcb 25,10,14,21,25,6,29,18,19,7,0,28,8,26,1,24,23,2,27,31,31,2,26,23,4,24,15,6,14,29,30,14,8,12,30,11,10,30,17,22
dx: dcb $ff,1,$ff,$ff,$ff,$ff,$ff,$ff,$ff,1,1,$ff,$ff,$ff,$ff,1,$ff,$ff,$ff,1,1,$ff,1,1,$ff,$ff,$ff,1,1,$ff,1,$ff,1,$ff,1,1,$ff,1,1,1
dy: dcb $ff,$ff,$ff,$ff,$ff,1,1,$ff,$ff,1,1,$ff,$ff,$ff,1,$ff,$ff,1,$ff,$ff,1,$ff,$ff,$ff,$ff,$ff,1,1,1,$ff,$ff,1,$ff,$ff,$ff,$ff,$ff,1,1,$ff
col: dcb 10,13,11,8,15,13,3,6,11,15,7,10,2,10,9,10,1,1,4,7,10,7,14,11,15,9,6,8,12,9,15,2,15,13,2,15,14,10,8,3
old0: dcb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
old1: dcb 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2



