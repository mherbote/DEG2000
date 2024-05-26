; tastaturbedienung ueber DEG2000 Version 1.2  ---  EPROM 6C
; ----------------------------------------------------------
;
tta1	equ	ttinit+3
tta2	equ	ttinit+6
ttfe	equ	ttinit+12
ttbel	equ	ttinit+15h
;
umerk:	defb	0ffh
;
;
ta	macro	up
	ld	a,ptast
	set12
	call	up
	res12
	endm
;
tinit::	ta	ttinit
	ret
;
ta1::	ta	tta1
	ld	(umerk),a
	ret
;
ta2::	ta	tta2
	push	bc
	ld	b,a
 if not talt
	ld	a,(umerk)
	bit	2,a
	jr	nz,ta21
 endif
	ld	a,b
 if talt
	cp	0f0h
 else
	cp	60h
 endif
	jr	nc,ta21
 if talt
	cp	0d0h
 else
	cp	40h
 endif
	jr	c,ta21
 if talt
	sub	0d0h
 else
	sub	40h
 endif
	ld	b,a
ta21:	ld	a,b
	pop	bc
	ret
;
tfe::	ta	ttfe
	ret
;
tbel::	ta	ttbel
	ret
;
;
ci.kalt::
ci.warm::
	call	tinit
	ret
;
;
ci.sta::
	push	bc
	call	ta1		; taste       gedrueckt --> z=1
	pop	bc
	ret			; taste nicht gedrueckt --> z=0
;
;
ci.ch::
	call	ta2
	ld	hl,degtab
	ld	bc,degend-degtab
	cpir
	jr	nz,ci1
	ld	bc,cpmtab-degtab-1
	add	hl,bc
	ld	a,(hl)
	jr	ci5
ci1:	push	af
	ld	a,(umerk)
	bit	2,a
	pop	bc
	ld	a,b
	jr	z,ci5
ci2:	cp	41h		; gross- / kleinumwandlung
	jr	c,ci3
	cp	5bh
	jr	c,ci4
ci3:	cp	61h
	jr	c,ci5
	cp	7bh
	jr	nc,ci5
ci4:	ld	b,a
	ld	a,(umsch)	; maske fuer umwandlung
	xor	b
ci5:	ld	b,a
	ret
;
;
ci.bell::
	ld	b,40h
	call	tbel
	ret
;
; umschluesseltabelle
;
degtab:	defb	0b1h,0f0h,0f1h
	defb	0b2h,0f2h,0f3h
	defb	0f4h,0f5h,0f6h
	defb	0f7h,0f8h,0f9h
	defb	01eh,0fah,0fbh,0b0h
degend:
cpmtab:	defb	009h,01bh,07fh
	defb	009h,00ah,015h
	defb	017h,005h,012h
	defb	008h,00ch,004h
	defb	00dh,01ah,018h,003h
;
