
start:
   jsr clear
   jsr init
loop:
   jsr draw
   ldx #0

check:
   dec cnt,x
   bne next0
   lda frm,x
   sta cnt,x
   lda #1
   sta mvd,x
   jmp next1
next0:
   lda #0
   sta mvd,x
next1:
   inx
   cpx n
   bne check

   jsr move
   jsr bounce

end:
   jmp loop

move:
   ldx #0
moveloop:

   lda mvd,x
   cmp #1
   bne movenext


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

   lda mvd,x
   cmp #1
   bne nextbounce


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

   lda mvd,x
   cmp #1
   bne nodraw

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

nodraw:
   lda #0
   sta mvd,x

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
   lda $fe
   and #$f
   clc
   adc #7
   sta px,x

   lda $fe
   and #$f
   clc
   adc #7
   sta py,x

   lda $fe
   and #1
   sta dx,x

   lda $fe
   and #1
   sta dy,x

again:
   lda $fe
   and #$f
   cmp #1
   beq again
   sta col,x

   lda $fe
   and #7
   clc
   adc #1
   sta frm,x

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

n: dcb 15
px: dcb 11,12,5,3,2,5,13,19,28,10,22,21,9,6,26,9,25,23,25,12,15,5,8,28,5,17,13,16,18,5
py: dcb 26,13,22,9,22,3,8,14,23,29,3,8,8,14,25,24,12,20,15,18,22,28,16,29,5,13,28,30,5,5
dx: dcb 1,1,1,0,1,1,1,0,1,0,0,0,1,1,1,0,0,0,0,0,1,0,1,1,0,1,1,0,0,1
dy: dcb 0,1,0,0,1,1,0,1,1,0,0,0,0,1,0,1,0,0,0,0,1,0,0,0,0,0,1,0,1,1
col: dcb 0,3,14,2,7,11,3,12,13,3,2,7,3,2,0,6,11,7,5,9,4,11,3,7,13,5,0,4,11,3
old0: dcb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
old1: dcb 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
cnt: dcb 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
mvd: dcb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
frm: dcb 9,7,3,9,3,8,9,5,4,4,6,4,10,3,4,10,1,1,3,3,3,5,5,3,3,1,3,4,6,3
