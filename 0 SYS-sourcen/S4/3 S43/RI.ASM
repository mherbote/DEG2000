; lochbandleserbedienung ueber  DEG2000 Version 1.2  --- EPROM 70
; ---------------------------------------------------------------
;
 if tap
ri.ch::	push	ix
	set12
	ld	ix,ealbl+3
	call	lbl
	res12
	pop	ix
	ret
 else
ri.ch::	ld	a,1ah
	ret
 endif
;
; S I O -  uebertragung ueber die ATS
; -----------------------------------
;
 if eq.sio ne 0
ri1.ch::			;ATS-Kanal A (Passiv)
	push	bc
	push	hl
	rept	4		;SIO-Empfangspuffer leeren
	in	a,(ptast+10h)
	endm
	ld	a,010h		;Bereitschaftszeichen ausgeben
	out	(ptast+10h),a
ri.ch1:	xor	a		;warten auf Eingabezeichen
	out	(ptast+11h),a
	in	a,(ptast+11h)
	bit	0,a
	jr	z,ri.ch1
	in	a,(ptast+10h)	;Eingabezeichen einlesen
	pop	hl
	pop	bc
	ret
;
;
;
ri2.ch::			;ATS-Kanal B (Aktiv)
	push	bc
	push	hl
	rept	4		;SIO-Empfangspuffer leeren
	in	a,(ptast+12h)
	endm
	ld	a,010h		;Bereitschaftszeichen ausgeben
	out	(ptast+12h),a
ri.ch2:	xor	a		;warten auf Eingabezeichen
	out	(ptast+13h),a
	in	a,(ptast+13h)
	bit	0,a
	jr	z,ri.ch2
	in	a,(ptast+12h)	;Eingabezeichen einlesen
	pop	hl
	pop	bc
	ret
;
;
;
ri.ata::
	ld	hl,ri.siot	;SIO initialisieren
	ld	b,9
	ld	c,ptast+11h
	otir
	ld	b,2		;CTC initialisieren
	ld	c,ptast+18h
	otir
	ld	hl,ri.ctct
	ld	b,2
	ld	c,ptast+19h
	otir
	rept	4		;SIO-Empfangspuffer leeren
	in	a,(ptast+10h)
	endm
	ret
;
ri.atb::
	ld	hl,ri.siot	;SIO initialisieren
	ld	b,9
	ld	c,13h
	otir
	ld	b,2		;CTC initialisieren
	ld	c,ptast+1ah
	otir
	rept	4		;SIO-Empfangspuffer leeren
	in	a,(ptast+12h)
	endm
	ret
;
ri.siot:db	0d0h,4,44h,1,0,3,0c1h,35h,68h
ri.ctct:db	7,1
;
;
 else
ri1.ch::
ri2.ch::
	ld	a,01ah
	ret
 endif
;
