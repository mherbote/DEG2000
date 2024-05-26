; druckerausgabe ueber   DEG2000 Version 1.2 ---  EPROM 7C
; --------------------------------------------------------
;
lo.reset::
	push	ix
	setkmb
	ld	ix,eadr+3
	ld	(ix+3),058h		;l(ir)
	call	dinit
	reskmb
	pop	ix
	ret
;
lo.ch:
	push	ix
	setkmb
	ld	ix,eadr+3
 if dr54
	push	af
	ld	a,c
	cp	00dh
	jr	z,loch1
	cp	00ah
	jr	nz,loch2
	ld	c,01eh
loch2:
 endif
	call	dout
 if dr54
loch1:	pop	af
 endif
	reskmb
	pop	ix
	ret
;
