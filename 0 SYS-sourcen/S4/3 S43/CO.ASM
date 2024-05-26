;
; direkte cursorbedienung
;
;  1b 01,0d  CR    zum Zeilenanfang
;  1b 02,0a  LF    Kursor eine Zeile tiefer; evt. rollen
;  1b 1e     HOME  Kursor in Zeile 1, Spalte 1
;  08        BS    setzt Kursor eine Position zurueck; in homepos. wirkungslos
;  1b 10     EOS   loescht den Bildschirm ab Kursorpos. bis Bildschirmende
;  1b 0b     UP    setzt den Kursor zyklisch eine Zeile hoeher
;  1b 0c     RIGHT setzt den Kursor zyklische eine Position weiter
;  1b 1f     NL    setzt Kursor in die naechste Zeile auf den Anfang
;  09        TAB   setzt Kursor auf naechste durch 8 teilbare Position
;  1a        CLEAR loescht den gesamten Bildschirm und setzt Kursor home
;  1b ':'    EOS   loescht den Bildschirm und laesst Kursor unveraendert
;  1b 'R'    DELL  stellt Kursor auf Z.anf., loescht die Zeile und rollt Z. nach
;  1b 'E'    INSL  stellt Kursor auf Z.anf., rollt Zeilen eins tiefer und loescht die Zeile
;  1b 'T'    EOL   loescht die Zeile ab Kursorposition bis Zeilenende
;  1b '=' rc POS   positioniert den Kursor auf Zeile r-20h und Spalte c-20h
;  1b '1'    SRMOD setzt speziellen Rollmodus
;  1b '0'    RRMOD setzt normalen   Rollmodus
;
co.ch::	call	rescur
	push	bc		; zeichen in c muss erhalten bleiben
	ld	a,c
	ld	hl,qesc
	bit	qesc0,(hl)	; lauft steuerfolge?
	jr	nz,m106		; -> ja
	cp	esc		; beginnt steuerfolge?
	jr	nz,m108		; -> nein
;
	set	qesc0,(hl)	; es beginnt steuerfolge
co.c1::	res	qesc1,(hl)
	jp	m19y
;
m106::	bit	qesc1,(hl)	; ist steuerzeichen schon eingetroffen?
co.c2::	jr	nz,m107		; -> ja, es folgt r oder c
	cp	'='		; nein, es folgt steuerzeichen
	jr	z,m1078		; -> 1b '=' rc
	call	evtrol		; evtl. verzoegertes rollen ausfuehren
	res	qesc0,(hl)	; bearbeitung der steuerfolge beendet
	cp	'T'
	jp	z,m20		; -> EOL
	cp	'E'
	jp	z,m21		; -> INS LINE
	cp	'R'
	jp	z,m22		; -> DEL LINE
	cp	':'
	jp	z,m23		; -> EOS
	cp	1fh		; nl
	jp	z,m16
	cp	1		; cr-ersatz
	jp	z,m15
	cp	2		; lf-ersatz
	jp	z,m14
	cp	1eh		; home
	jp	z,m18
	cp	10h		; eos
	jp	z,m19
	cp	0bh		; up
	jp	z,m19a
	cp	0ch		; right
	jp	z,m19b
	cp	'1'		; spezieller Rollmodus an
	jp	z,m24
	cp	'0'		; normaler   Rollmodus an
	jp	z,m25
	jp	m109		; -> nicht auswertbares steuerzeichen
;
m107::	bit	qesc2,(hl)	; 1b '=' r c
	set	qesc2,(hl)
	jr	nz,m1072	; -> es ist c eingetroffen
co.c3::	sub	20h
	jr	c,m1074		; -> zeile war <= 1fh
	ld	(zeil),a
	jr	m1076
m1072::	sub	20h
	jr	c,m1074		; -> spalte war <= 1fh
	ld	(spalt),a
m1074::	res	qesc0,(hl)	; bearbeitung ist beendet
m1076::	call	bsadr
	jp	m19x
;
m1078::	set	qesc1,(hl)
	res	qesc2,(hl)	; es wird r erwartet
	jp	m19x
;
;--------------------------------
;
m108::	call	evtrol		; evtl. verzoegertes rollen ausfuehren
	cp	7		; bell
	jp	z,m17
	cp	8		; backspace
	jp	z,m12
	cp	lf		; lf
	jp	z,m14
	cp	cr		; cr
	jp	z,m15
	cp	tab
	jr	z,m11
co.c4::	cp	1ah		; clear
	jp	z,m185
m109::	ld	hl,(bsaddr)
	set12
	ld	(hl),a		; zeichen auf bildschirm schreiben
	res12
	call	incad		; schreiben in letzte pos. rollt nicht!!
	jp	m19y
;
;
m11::	ld	hl,(bsaddr)	; tab
	set12
	ld	(hl),20h
	res12
	call	incad
	ld	a,(spalt)
	and	7
	jp	z,m19y
	call	evtrol		; evtl. verzoegertes rollen ausfuehren
	jr	m11
;
m12::	ld	a,(spalt)	; backspace
	or	a
	jr	z,m13
	dec	a
	ld	(spalt),a
m121::	ld	hl,(bsaddr)
	dec	hl
	ld	(bsaddr),hl
	jr	m19x
;
m13::	ld	a,(zeil)
	or	a
	jr	z,m19x		; -> bs nicht ausfuehrbar, da homeposition
	dec	a
	ld	(zeil),a
	ld	a,maxs-1
	ld	(spalt),a
	jr	m121
;
m14::	ld	hl,zeil		; lf
	inc	(hl)
m141::	call	bsadr		; evtl. rollen ausfuehren
	call	evtrol
	jr	m19y
;
m15::	xor	a		; cr
	ld	(spalt),a
	jr	m141
;
m16::	ld	hl,zeil		; nl
	inc	(hl)
	jr	m15
;
m17::	call	ci.bell
	jp	m19y
;
m18::	xor	a		; home
	ld	(zeil),a
	ld	(spalt),a
	jr	m141
;
m185::	xor	a		; clear
	ld	(zeil),a
	ld	(spalt),a
	call	bsadr
;
m19::	ld	hl,(bsaddr)	; eos ab cursorposition
	set12
m191::	ld	(hl),20h
	inc	hl
	ld	a,h
	cp	high (bsanf+maxz*maxs)
	jr	nz,m191
	ld	a,l
	cp	low (bsanf+maxz*maxs)
	jr	nz,m191
	res12
	jr	m19x
;
m19a::	ld	hl,zeil		; up
	ld	a,(hl)
	or	a
	jr	nz,m19a1	; -> cursor stand nicht in 1. zeile
	ld	(hl),maxz
m19a1::	dec	(hl)
	jr	m141
;
m19b::	ld	a,(spalt)	; right zyklisch in zeile
	inc	a
	cp	maxs
	jr	nz,m19b1
	xor	a
m19b1::	ld	(spalt),a
	jr	m141
;
m19x::	xor	a
	ld	(qroll),a
m19y::	pop	bc
	call	setcur
	ret
;
;-----------------------------------------
;
m20::	ld	hl,spalt	; EOL
	ld	a,maxs
	sub	(hl)
	ld	b,a
	ld	hl,(bsaddr)
	set12
m201::	ld	(hl),20h
	inc	hl
	djnz	m201
	res12
	jr	m19x
;
m21::	xor	a		; INS LINE
	ld	(spalt),a
	call	bsadr
	ld	hl,zeil
	ld	a,maxz
	sub	(hl)
	dec	a
	jr	z,m20		; -> kursor stand in letzter zeile; diese loeschen
	ld	b,a
	ld	hl,0
	ld	de,maxs
m211::	add	hl,de		; anzahl der zeilen bestimmen, die nach
	djnz	m211		; unten gerollt werden muessen
	ld	b,h
	ld	c,l
	ld	hl,bsanf+maxz*maxs-1-maxs
	ld	de,bsanf+maxz*maxs-1
	set12
	lddr
	res12
	jr	m20		; -> zeile loeschen, in der cursor steht
;
m22::	xor	a		; DEL LINE
	ld	(spalt),a
	call	bsadr
	ld	hl,zeil
	ld	a,maxz
	sub	(hl)
	dec	a
	jr	z,m222		; -> kursor stand in letzter zeile
	ld	b,a
	ld	hl,0
	ld	de,maxs
m221::	add	hl,de		; anzahl der zeilen bestimmen, die nach
	djnz	m221		; oben gerollt werden muessen
	ld	b,h
	ld	c,l
	ld	hl,(bsaddr)
	ex	de,hl
	add	hl,de
	set12
	ldir
	res12
m222::	ld	hl,bsanf+maxz*maxs-maxs ; letzte zeile loeschen
	ld	de,bsanf+maxz*maxs-maxs+1
	ld	bc,maxs-1
m223:
	set12
	ld	(hl),20h
	ldir
	res12
	jp	m19x
;
m23::	ld	hl,bsanf	; eos, cursor bleibt unveraendert
	ld	de,bsanf+1
	ld	bc,maxz*maxs-1
	jr	m223
;
m24::	ld	a,1		; spezieller rollmodus an
m241::	ld	(qrmode),a
	jp	m19y
;
m25::	xor	a		; normaler   rollmodus an
	jr	m241
;
;-----------------------------------------------
;
incad::	ld	hl,spalt
	inc	(hl)
	ld	a,(hl)
	cp	maxs
	jr	nz,bsadr
	xor	a
	ld	(hl),a
	ld	hl,zeil
	inc	(hl)
	jr	bsadr
;
;-----------------------------------------------
;
; die position zeil/spalt durch evtl. rollen in den bildschirmbereich
; bringen und physische adresse der position berechnen; dabei rollen
; in letzter position verzoegern, statt dessen qroll stellen, damit vor
; der naechsten ausgabe oder setcur gerollt werden kann
;
bsadr::	push	af
	push	bc
	push	de
	ld	a,(zeil)
m30::	cp	maxz
	jr	c,m31
	jr	z,m307		; -> es koennte letzte position gewesen sein
m303::	call	bsrol
	jr	m30
m307::	ld	a,(spalt)	; ist spalte = 0?
	or	a
	ld	a,maxz
	jr	nz,m303		; -> nein, rollen
	dec	a
	ld	hl,qroll	; rollmerker setzen
	ld	(hl),1
m31::	ld	b,a		; physische adresse berechnen
	ld	hl,0
	ld	de,maxs
	or	a
	jr	z,m33
m32::	add	hl,de
	djnz	m32
m33::	ld	a,(spalt)
	ld	c,a
	ld	b,0
	add	hl,bc
	ld	bc,bsanf
	add	hl,bc
	pop	de
	pop	bc
	pop	af
	ld	(bsaddr),hl
	ret
;
;-----------------------------------------------
;
bsrol::	ld	de,bsanf	; bild hochschieben
	ld	hl,bsanf+maxs
	ld	bc,maxs*(maxz-1)
	set12
	ldir
	ld	h,d
	ld	l,e
	inc	de		; letzte zeile loeschen
	ld	bc,maxs-1
	ld	(hl),20h
	ldir
	res12
;
	ld	hl,zeil
	dec	(hl)
	ld	a,(hl)
	ret
;
;-----------------------------------------------
;
evtrol::push	hl
	ld	hl,qroll
	bit	0,(hl)
	res	0,(hl)
	pop	hl
	ret	z
	push	af
	push	bc
	push	de
	push	hl
	call	bsrol
	pop	hl
	pop	de
	pop	bc
	pop	af
	ret
;
;-----------------------------------------------
;
setcur::push	hl
	ld	hl,qrmode
	bit	0,(hl)
	call	z,evtrol	; evtl. verzoegertes rollen ausfuehren
	ld	hl,(bsaddr)
	set12
	set	7,(hl)
	res12
	pop	hl
	ret
;
rescur::push	hl
	ld	hl,(bsaddr)
	set12
	res	7,(hl)
	res12
	pop	hl
	ret
;
co.bcu::ld	a,0ceh
	ld	(co.c1+1),a
	ld	hl,co.c2+2
	ld	(co.c1+3),hl
	ld	a,018h
	ld	(co.c2),a
	ld	hl,096cbh
	ld	(co.c2+2),hl
	ld	a,0c3h
	ld	(co.c2+4),a
	ld	hl,m19y
	ld	(co.c2+5),hl
	ld	hl,0
	ld	(co.c3),hl
	ld	(m1072),hl
	ld	a,00ch
	ld	(co.c4+1),a
	ld	(bootms),a
	ret
;
co.deg::ld	a,08eh
	ld	(co.c1+1),a
	ld	hl,m19y
	ld	(co.c1+3),hl
	ld	a,020h
	ld	(co.c2),a
	ld	hl,03dfeh	;cp '='
	ld	(co.c2+2),hl
	ld	a,28h		;jr z,m1078
	ld	(co.c2+4),a
	ld	hl,0cd67h
	ld	(co.c2+5),hl
	ld	hl,020d6h	;sub 20h
	ld	(co.c3),hl
	ld	(m1072),hl
	ld	a,01ah
	ld	(co.c4+1),a
	ld	(bootms),a
	ret
;
