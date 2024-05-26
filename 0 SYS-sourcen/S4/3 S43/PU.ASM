; lochbandstanzerbedienung ueber  DEG2000 Version 1.2  ---  EPROM 70
; ------------------------------------------------------------------
;
 if tap
pu.ch::	push	ix
	set12
	ld	ix,ealbs+3
	call	lbs
	res12
	pop	ix
	ret
 else
pu.ch::	ret
 endif
;
; S I O -  uebertragung ueber ATS
; -------------------------------
;
 if eq.sio ne 0
pu1.ch::			;ATS-Kanal A (Passiv)
	push	af
pu.ch1:	xor	a		;warten auf Bereitschaftszeichen
	out	(ptast+11h),a
	in	a,(ptast+11h)
	bit	0,a
	jr	z,pu.ch1
	in	a,(ptast+10h)
	cp	010h
	jr	nz,pu.ch1
	ld	a,c		;Ausgabezeichen ausgeben
	out	(ptast+10h),a
	pop	af
	ret
;
;
;
pu2.ch::			;ATS-Kanal B (Aktiv)
	push	af
pu.ch2:	xor	a		;warten auf Bereitschaftszeichen
	out	(ptast+13h),a
	in	a,(ptast+13h)
	bit	0,a
	jr	z,pu.ch2
	in	a,(ptast+12h)
	cp	10h
	jr	nz,pu.ch2
	ld	a,c		;Ausgabezeichen ausgeben
	out	(ptast+12h),a
	pop	af
	ret
;
;
 else
pu1.ch::
pu2.ch::
	ret
 endif
;
