

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
   lda dx,x
   beq left
   dec px,x
   jmp vert
left:
   inc px,x
vert:
   lda dy,x
   beq down
   dec py,x
   jmp movenext
down:
   inc py,x
movenext:
   inx
   cpx n
   bne moveloop
   rts


bounce:
   ldx #0
bounceloop:
   lda px,x
   cmp #31
   bne pxok
negdx: 
   lda dx,x
   eor #1
   sta dx,x
   jmp checkpy
pxok:
   cmp #0
   beq negdx
checkpy:
   lda py,x
   cmp #31
   bne pyok
negdy:
   lda dy,x
   eor #1
   sta dy,x
   jmp nextbounce
pyok:
   cmp #0
   beq negdy
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

   ldy py,x
   lda ylo,y
   sta $0
   lda yhi,y
   sta $1
   lda col,x
   ldy px,x
   sta ($00),y

   tya
   clc
   adc $0
   sta old0,x
   lda $1
   sta old1,x

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

n: dcb 30
px: dcb 21,26,13,7,27,22,10,11,15,22,6,28,15,3,29,5,7,23,4,2,17,14,24,13,28,14,10,16,30,29
py: dcb 23,5,13,7,1,30,23,26,10,2,6,10,23,13,4,9,23,30,9,23,15,10,11,4,24,6,27,9,2,16
dx: dcb 0,1,1,0,0,0,1,0,1,0,1,0,0,1,0,0,0,0,0,1,0,1,0,0,1,1,1,0,0,0
dy: dcb 1,0,1,0,0,0,1,0,1,1,1,0,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1
col: dcb 5,4,14,4,9,6,6,11,13,6,8,4,4,3,9,0,14,6,4,15,5,10,15,4,5,12,7,7,5,9
old0: dcb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
old1: dcb 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
