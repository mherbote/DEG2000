; routinen fuer   1. zentralstation
;                 2.      TRAM - Disk
;                 3. 16k - OPS - Disk
; -----------------------------------
;
 if opsdk
opsmac	macro
op1111::
	ld	(opssp1),sp
	ld	sp,opssp
	ld	hl,zsm
	ld	de,zsm+1
	ld	bc,7
	ld	(hl),0
	ldir
	out	(0c4h),a
	ld	a,00111100b
	out	(0c0h),a
	ld	hl,0c000h
	ld	d,01000011b
	ld	ix,zsm
	ld	b,8
ops1:	ld	a,d
	and	00011100b
	rrca
	rrca
	inc	a
	push	bc
	ld	b,a
	ld	a,10000000b
	rlca
	djnz	$-1
	pop	bc
	out	(0c2h),a
	ld	hl,0c000h
	ld	a,(hl)
	ld	c,a
	cpl
	ld	(hl),a
	cp	(hl)
	ld	a,c
	ld	(hl),a
	jr	nz,ops2
	ld	(ix+0),d
ops2:	ld	a,d
	add	a,4
	ld	d,a
	xor	a
	out	(0c2h),a
	inc	ix
	djnz	ops1
	xor	a
	out	(0c0h),a
	out	(0c3h),a
	ld	hl,zsm
	ld	bc,800h
ops3:	ld	a,(hl)
	or	a
	inc	hl
	jr	z,ops4
	inc	c
ops4:	djnz	ops3
	ld	a,c
	ld	sp,(opssp1)
	jp	ops13

opszu:	push	bc
	push	hl
	ld	a,(trk)
	ld	b,a
	inc	b
	out	(0c4h),a
	ld	a,00110000b
	out	(0c0h),a
	ld	hl,zsm
opsz1:	ld	a,(hl)
	inc	hl
	or	a
	jr	z,opsz1
	djnz	opsz1
	dec	hl
	ld	a,(hl)
	and	00011100b
	rrca
	rrca
	inc	a
	ld	b,a
	ld	a,10000000b
	rlca
	djnz	$-1
	out	(0c2h),a
	pop	hl
	pop	bc
	ret

opsab:	xor	a
	out	(0c2h),a
	out	(0c0h),a
	out	(0c3h),a
	ret

inp1:	xor	a
	ld	(trk),a
	ld	(opssp1),sp
	ld	sp,opssp
	call	opszu
	ld	hl,0c000h
	ld	de,0c001h
	ld	bc,007ffh
	ld	(hl),0e5h
	ldir
	ld	hl,0c000h
	ld	de,0c001h
	ld	bc,01fh
	ld	(hl),0
	ldir
	ld	hl,opssp
	ld	de,0c000h
	ld	bc,12
	ldir
	call	opsab
	ld	sp,(opssp1)
	jp	inp9

wro1:	ld	(opssp1),sp
	ld	sp,opssp
	push	hl
	ld	hl,trdma
	ld	de,opdma
	ld	bc,128
	ldir
	call	opszu
	ld	hl,opdma
	pop	de
	ld	bc,128
	ldir
	call	opsab
	ld	sp,(opssp1)
	jp	wro2

rdo1:	ld	(opssp1),sp
	ld	sp,opssp
	call	opszu
	ld	de,opdma
	ld	bc,128
	ldir
	call	opsab
	ld	hl,opdma
	ld	de,trdma
	ld	bc,128
	ldir
	ld	sp,(opssp1)
	jp	rdo2

zsm:	defs	8
opdma:	defs	128
opssp1:	defw	0
	defs	10h
opssp	equ	$
	endm
 endif
;
;
;
md.kalt::
 if tramdk
	ld	a,28h
	ld	(tram),a
	xor	a
	ld	(ttanz),a
	ld	b,4
mdk20:	push	bc
	xor	a
	call	up11
	call	up21
	ld	(stkret),sp
	ld	sp,stk12
	call	up2
	ld	hl,04000h
	ld	a,(hl)
	ld	d,a
	cpl
	ld	(hl),a
	cp	(hl)
	ld	a,d
	ld	(hl),a
	call	up3
	ld	sp,(stkret)
	pop	bc
	jr	nz,mdk21
	ld	a,(ttanz)
	add	a,4
	ld	(ttanz),a
	ld	a,(tram)
	sub	8
	ld	(tram),a
	djnz	mdk20
;
mdk21:	ld	a,(ttanz)
	or	a
	jr	z,mdk22
	ld	h,0		; laufwerkskapazitaet bestimmen
	ld	l,a
	rept	4
	add	hl,hl
	endm
	dec	hl
	ld	(dpblko+5),hl
	ld	hl,dpho1	; laufwerk aktivieren
	ld	(dpho),hl
mdk22:
 endif

 if opsdk
	set12
	ld	hl,biosxx
	ld	de,00c00h
	ld	bc,op12-op11
	ldir
	ld	hl,dirgo
	ld	bc,12
	ldir
	jp	00c00h

ops13:	res12
	ld	(zsma),a
	or	a
	jr	z,ops5
	ld	h,0
	ld	l,a
	rept	4
	add	hl,hl
	endm
	dec	hl
	ld	(dpblkp+5),hl
	ld	hl,dphp1
	ld	(dphp),hl
ops5:
 endif

 if zst
	call	ri.ata
mdw3:	xor	a		; warten bis keine Daten mehr da
	out	(ptast+11h),a
	in	a,(ptast+11h)
	bit	0,a
	jr	z,mdw2
	in	a,(ptast+10h)
	jr	mdw3
mdw2:
 endif

md.warm::
 if zst
	xor	a
	out	(ptast+11h),a
	in	a,(ptast+11h)
	bit	0,a
	jr	z,mdw1
	in	a,(ptast+10h)
	cp	11h		; DC1
	jr	nz,mdw1
	out	(ptast+10h),a
	ld	hl,00014h	; DC4 NUL
	call	ldpuhl
	call	ldhlri
	call	ldhlri		; sec/trk
	ld	(dpblkn),hl
	call	ldhlri		; kapazitaet
	ld	(dpblkn+5),hl
	call	ldhlri		; anzahl_dir_entries
	ld	(dpblkn+7),hl
	call	ldhlri		; dir_bloecke
	ld	(dpblkn+9),hl
	call	ldhlri		; dir_entries_pruefen
	ld	(dpblkn+11),hl
	ld	hl,dphn1
	ld	(dphn),hl
	ret
mdw1:	ld	hl,0
	ld	(dpblkn+5),hl
	ret

ldhlri:	call	ri1.ch
	ld	l,a
	call	ri1.ch
	ld	h,a
	ret
ldpuhl:	ld	c,l
	call	pu1.ch
	ld	c,h
	call	pu1.ch
 endif

	ret
;
; 1.  routinen fuer    Z e n t r a l s t a t i o n
; ------------------------------------------------
;
 if zst
wrzst::
	ld	hl,(dpblkn+5)
	ld	a,h
	or	l
	jp	z,wrmem0
	ld	a,11h
	out	(ptast+10h),a
	ld	hl,00112h	; DC2 01
	call	ldpuhl
	ld	hl,(trk)	; trk
	call	ldpuhl
	ld	hl,(sec)	; sec
	call	ldpuhl
wrz1:	call	ri1.ch		; DC2
	call	ri1.ch		; Quittierung
				; = 1  ...  nicht verfuegbar
				; = 2  ...        verfuegbar
	cp	2
	jp	c,wrmem0
	ld	hl,00212h	; DC2 02
	call	ldpuhl
	ld	hl,(dma)
	ld	b,128
wrz2:	ld	c,(hl)
	inc	hl
	call	pu1.ch
	djnz	wrz2
	xor	a
	ret


rdzst::
	ld	hl,(dpblkn+5)
	ld	a,h
	or	l
	jp	z,rdmem0
	ld	a,11h		; DC1
	out	(ptast+10h),a
	ld	hl,00113h	; DC3 01
	call	ldpuhl
	ld	hl,(trk)	; trk
	call	ldpuhl	
	ld	hl,(sec)	; sec
	call	ldpuhl
rdz1:	call	ri1.ch		; DC3
	call	ri1.ch		; Qittierung
				; = 1  ...  nicht verfuegbar
				; = 2  ...        verfuegbar; es folgen
				;           die Daten
	cp	2
	jp	c,wrmem0
	ld	hl,(dma)
	ld	b,128
rdz2:	call	ri1.ch
	ld	(hl),a
	inc	hl
	djnz	rdz2
	xor	a
	ret
 endif
;
; 2.  routinen fuer    T R A M   -   P s e u d o d i s k
; ------------------------------------------------------
;
 if tramdk
wrtram::
	ld	a,(ttanz)	; trkanz > 0 ?
	or	a
	jp	z,wrmem0	; nein
	call	tdadr
	jp	c,wrmem0
	ld	(stkret),sp
	ld	sp,stk12
	push	hl
	ld	hl,(dma)
	ld	de,trdma
	ld	bc,128
	ldir
	call	up2
	ld	hl,trdma
	pop	de
	ld	bc,128
	ldir
	call	up3
	ld	sp,(stkret)
	xor	a
	ret
;
rdtram::
	ld	a,(ttanz)	; trkanz > 0 ?
	or	a
	jp	z,rdmem0	; nein
	call	tdadr
	jp	c,wrmem0
	ld	(stkret),sp
	ld	sp,stk12
	call	up2
	ld	de,trdma
	ld	bc,128
	ldir
	call	up3
	ld	hl,trdma
	ld	de,(dma)
	ld	bc,128
	ldir
	ld	sp,(stkret)
	xor	a
	ret
;
;
tdadr::	ld	a,(trk)		; trk = > trkanz
	ld	hl,ttanz
	cp	(hl)
	ccf
	ret	c		; ja
	inc	hl
	ld	(hl),28h	; tram - adresse
tdadr1:	sub	4
	jr	c,tdadr2
	rept	8
	dec	(hl)
	endm
	jr	tdadr1

tdadr2:	add	a,4
	inc	hl
	ld	(hl),a		; ttrk
	call	up11
	call	up21
	ld	hl,(sec)
	rept	7
	add	hl,hl
	endm
	ld	de,03f80h
	add	hl,de
	scf
	ccf
	ret
;
;
;
up11:	ld	b,40h		; a <==  TRAM-Track   0 ... 3
up12:	add	a,a
	add	a,a
	ld	d,16
up13:	push	af
	ld	a,(tram)
	ld	c,a
	pop	af
	inc	c
	inc	c
up14:	out	(c),a
	inc	a
	ld	e,a
	ld	a,b
	add	a,10h
	ld	b,a
	ld	a,e
	dec	d
	jr	nz,up14
up15:	ld	b,0
	ld	e,16
	call	up33
	ret

up21:	ld	b,40h
up22:	ld	e,4
up23:	ld	a,(tram)
	ld	c,a
up24:	xor	a
	out	(c),a
	ld	a,b
	add	a,10h
	ld	b,a
	dec	e
	jr	nz,up24
	ret

up25:	push	af
	ld	a,(tram)
	ld	c,a
	pop	af
	inc	c
	inc	c
	inc	c
	out	(c),a
	ret
;
up31:	ld	b,40h
up32:	ld	e,4
up33:	ld	a,(tram)
	ld	c,a
up35:	ld	a,00ch
	out	(c),a
	ld	a,b
	add	a,10h
	ld	b,a
	dec	e
	jr	nz,up35
	ret
;
up2:	push	af
	push	bc
	out	(0c4h),a		; RESET-Sperre aus
	ld	a,10000000b
	out	(0c1h),a
	out	(0c3h),a		; RESET-Sperre ein
	ld	a,1
	call	up25
	push	de
	call	up21
up4:	pop	de
	pop	bc
	pop	af
	ret
;
up3:	push	af
	push	bc
	xor	a
	call	up25
	out	(0c4h),a		; RESET-Sperre aus
	ld	a,10000100b
	out	(0c1h),a
	out	(0c3h),a		; RESET-Sperre ein
	push	de
	call	up31
	jr	up4
;
;
md.ino::
	ld	a,(ttanz)
	or	a
	jp	z,0
	ld	a,28h
	ld	(tram),a
	xor	a
	call	up11
	call	up21
	call	up2
	ld	hl,04000h
	ld	de,04001h
	ld	bc,007ffh
	ld	(hl),0e5h
	ldir
	ld	hl,04000h
	ld	de,04001h
	ld	bc,01fh
	ld	(hl),0
	ldir
	ld	hl,dirgo
	ld	de,04000h
	ld	bc,12
	ldir
	call	up3
	ret
;
;
;
ttanz::	defb	0		; TRAM - Trackanzahl
tram::	defb	0		; TRAM - Adresse
ttrk::	defb	0		; TRAM - Track
trdma::	defs	128
 endif
;
; 3.  routinen fuer	16k - O P S   -   P s e u d o d i s k
; -----------------------------------------------------------
;
 if opsdk
wrops::
	ld	a,(zsma)
	or	a
	jp	z,wrmem0
	call	opadr
	jp	c,wrmem0
	push	hl
	ld	hl,(dma)
	ld	de,trdma
	ld	bc,128
	ldir
	pop	hl
	set12
	jp	wro1

wro2:	res12
	xor	a
	ret

rdo2:	res12
	ld	hl,trdma
	ld	de,(dma)
	ld	bc,128
	ldir
	xor	a
	ret

rdops::
	ld	a,(zsma)
	or	a
	jp	z,rdmem0
	call	opadr
	jp	c,rdmem0
	set12
	jp	rdo1

opadr::	ld	a,(trk)
	ld	hl,zsma
	cp	(hl)
	ccf
	ret	c
	ld	hl,(sec)
	rept	7
	add	hl,hl
	endm
	ld	de,0bf80h
	add	hl,de
	scf
	ccf
	ret

md.inp::
	ld	a,(zsma)
	or	a
	jp	z,0
	set12
	jp	inp1

inp9:	res12
	ret

zsma:	defb	0

 endif
;
