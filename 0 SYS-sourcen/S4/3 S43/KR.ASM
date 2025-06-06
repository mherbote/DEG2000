; lesen / schreiben kassetten geblockt
;
; schreiben
; +++++++++
;
wrkmb::	ld	a,(ix+gelade)	; test, ob kassette noch geladen ist
	or	a
	jr	z,wrk02		; -> nein
	ld	a,(trk)
	or	a
	jp	nz,block	; -> nicht nach dir im hs schreiben
;
	call	diradr
	ex	de,hl		; in dpuf schreiben
	ld	hl,(dma)
	ld	(ix+eadzei),1	; es wurde in directory geschrieben
	ld	b,128
wrk01::	ld	a,(hl)
	set12
	ld	(de),a
	res12
	inc 	hl
	inc	de
	djnz	wrk01
	xor	a
	ret
;
wrk02::	xor	a
	inc	a
	ret
;
hwrkmb::call	cposx
	jr	nz,wrk02	; -> fehler melden
	ld	(ix+ealen),1
	ld	(ix+ealen+1),0
	ld	a,(ix+hstbuf)
	ld	(ix+eaadr),a
	ld	a,(ix+hstbuf+1)
	ld	(ix+eaadr+1),a
 if kmbvers eq 13
	ld	a,80h		; schreiben ohne fehlerwiederholung
 else
	ld	a,0		; schreiben mit fehlerwiederholung
 endif
	call	kmb
	ret	z		; -> alles ok
	ld	a,(rderr)	; weiterer versuch?
	dec	a
	ld	(rderr),a
	jr	nz,hwrkmb
	jr	wrk02		; -> nein
;
	page	
; lesen
; +++++
;
rdkmb::	ld	a,(ix+gelade)	; test, ob kassette noch geladen ist
	or	a
	jr	z,wrk02
	ld	a,(trk)
	or	a
	jp	nz,deblck	; -> nicht aus hs lesen
	ld	de,(dma)	; aus dpuf lesen
	call	diradr
	ld	b,128
rdk01::	set12
	ld	a,(hl)
	res12
	ld	(de),a
	inc	hl
	inc	de
	djnz	rdk01
	xor	a
	ret
;
hrdkmb::call	cposx
	jr	nz,rdk03	; -> fehler melden
	call	lesen
	jr	z,rdk04
rdk02::	ld	a,(rderr)	; weitere versuch?
	dec	a
	ld	(rderr),a
	jr	nz,hrdkmb	; -> ja
rdk03::	xor	a		; fehler melden
	inc	a
	ret
rdk04::	ld	a,(ix+ealen)
	cp	1
	jr	nz,rdk02
	ld	b,a
	ld	a,(ix+ealen+1)
	or	a
	jr	nz,rdk02
	ld	c,a
	ld	l,(ix+eaadr)
	ld	h,(ix+eaadr+1)
	ld	e,(ix+hstbuf)
	ld	d,(ix+hstbuf+1)
	set12
	ldir
	res12
	xor	a
	ret
;
	page	
; unterprogramme lesen/schreiben
; ++++++++++++++++++++++++++++++
;
cposx::	ld	l,(ix+hstsec)
	ld	h,(ix+hsttrk)
	ld	(was),hl
	call	cpos
	ret
;
;----------------------------------------------------------------------
;
diradr::ld	a,(trk)		; in hl diradr bilden
	ld	l,a
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl		; 16*trk
	ld	bc,(sec)
	dec	bc
	add	hl,bc		; 16*trk + sec - 1
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	c,(ix+eadpuf)	; bc = dpuf
	ld	b,(ix+eadpuf+1)
	add	hl,bc
	ret
;
	page
;   kassettenroutinen   laden / entladen / positionieren
;   ----------------------------------------------------
;
; kassette laden geblockt
; +++++++++++++++++++++++
;
clad::	ld	a,31h		; reservieren ein
	call	kmb
	bit	4,(ix+eastat)
	jr	nz,sp26
;
	call	rucksp		; rueckspulen
	call	endruc		; auf ende warten
;
	call	filpar
sp21::	push	de		; dirpufferadresse
	call	readhst		; 8 mal 256 byte lesen
	pop	de
	jr	nz,sp25		; -> fehler
	ld	l,(ix+hstbuf)
	ld	h,(ix+hstbuf+1)
	ld	bc,256
	set12
	ldir			; von hostbuf auf cpu in dirbuf uebertr.
	res12
	inc	(ix+hstsec)
	bit	3,(ix+hstsec)	; 0/8 schon erreicht?
	jr	z,sp21		; -> nein
;
	xor	a		; laden ok
	ld	(ix+eadzei),a	; in directory wurde noch nicht geschrieben
	ld	(ix+hstact),a	; host buffer inactive
	ld	(ix+unacnt),a	; no unallocated recs
	ld	(ix+gelade),1	; kassette ist geladen
	ret
;
;--------------------------------
;
sp25::	call	rucksp		; fehler beim laden
sp26::	ld	a,41h		; reservieren aus
	call	kmb
	xor	a
	ld	(ix+gelade),a	; kassette ist nicht geladen
	inc	a
	ret
;
	page	
; kassette entladen geblockt
; ++++++++++++++++++++++++++
;
centl::	ld	a,(ix+hstact)	; ist puffer aktiv?
	or	a
	jr	z,sp301		; -> nein
	ld	a,(ix+hstwrt)	; wurde in puffer geschrieben?
	or	a
	jr	z,sp301
	call	writehst	; ja, puffer entleeren
	jr	z,sp301
	ld	hl,ceerro
	ld	b,ceerre-ceerro
centle::push	bc
	ld	c,(hl)
	inc	hl
	push	hl
	call	co.ch
	pop	hl
	pop	bc
	djnz	centle
sp301::	ld	a,(ix+eadzei)	; wurde directory veraendert?
	or	a
	jr	z,sp32		; -> nein
	call	rucksp		; rueckspulen
	call	endruc		; auf ende warten
	call	filpar
	ex	de,hl		; dirpufferadresse
sp31::	ld	e,(ix+hstbuf)	; aus dirpuffer in host buffer uebertragen
	ld	d,(ix+hstbuf+1)
	ld	bc,256
	set12
	ldir			; aus dirbuf in hostbuf auf cpu uebertragen
	res12
	push	hl
	call	writehst
	pop	hl
	jr	nz,sp25		; -> fehler
	inc	(ix+hstsec)
	bit	3,(ix+hstsec)	; 0/8 erreicht?
	jr	z,sp31		; -> nein
;
sp32::	call	rucksp		; rueckspulen
	ld	a,41h		; reservieren aus
	call	kmb
	ld	(ix+gelade),0	; kassette ist nicht geladen
	ret
;
ceerro::defb	lf,'Fehler beim Entladen des Puffers',cr,lf
ceerre::
	page	
; up's
; ++++
;
rucksp::ld	a,21h
	call	kmb
	jr	nz,rucksp
	ret
endruc::setkmb 
edruc:	call	kmbruc		; kmb-bereitroutine
	jr	c,edruc		; -> nicht bereit
	reskmb
	ret
lesen::	xor	a
	ld	(richtu),a
 if kmbvers eq 13
	ld	a,82h		; lesen ohne fehlerwiederholung
 else
	ld	a,2
 endif
	call	kmb
	ret
konlen::ld	a,(ix+ealen)
	cp	b
	ret	nz
	ld	a,(ix+ealen+1)
	cp	c
	ret
konsent::push	bc
	ld	bc,12
	call	konlen
	pop	bc
	ret	nz
	push	hl
	ld	l,(ix+eaadr)	; iy := (adr)
	ld	h,(ix+eaadr+1)
	ld	(arb),hl
	ld	iy,(arb)
	pop	hl
	set12
	ld	a,(iy+1)
	res12
	cp	d
	ret	nz
	set12
	ld	a,(iy+2)
	res12
	cp	e
	ret
filpar::ld	(ix+hstsec),0
	ld	(ix+hsttrk),0
	ld	(ix+eawovo),0
	ld	(ix+eawovo+1),0
	ld	e,(ix+eadpuf)
	ld	d,(ix+eadpuf+1)
	ret
	page	
; kassette positionieren
; ++++++++++++++++++++++
;
cpos::	ld	a,erranz	; nach erranz fehlversuchen abbruch
	ld	(errcou),a
;
sp40::	ld	bc,(was)
	ld	e,(ix+eawovo)
	ld	d,(ix+eawovo+1)
	ld	a,e		; steht mb vor bandmarke?
	cp	8
	jr	c,sp41
;
	call	lesen		; ja
	inc	d
	ld	e,0
;
sp41::	ld	a,b
	cp	d
	jr	nz,sp45
	ld	a,c
	cp	e
	jr	nz,sp43
;
; === was = wovor
;
	call	lesen
	jr	nz,sp42		; -> fehler: beim lesen
	call	konsent
	jr	nz,sp42		; -> fehler: mb stand an falscher stelle
;
	inc	e
	ld	(ix+eawovo),e
	ld	(ix+eawovo+1),d
	xor	a
	ret
;
;----------------
;
sp42::	call	fehler		; fehlerbehandlung
	ld	hl,errcou	; nochmaliger versuch?
	dec	(hl)
	jr	nz,sp40		; -> ja
;
	xor	a		; fehler zurueckmelden
	inc	a
	ret
;
;----------------
;
sp43::	ld	a,c
	cp	e
	jr	nc,sp44
;
; === was.blk = wovor.blk  and  was.rec < wovor.rec
;
	ld	a,1
	ld	(richtu),a
	ld	a,15h		; 2 bloecke ruecksetzen
	call	kmb
	jr	nz,sp42		; -> fehler: beim record ruecksetzen
	ld	a,15h
	call	kmb
	jr	nz,sp42		; -> fehler: beim record ruecksetzen
	dec	e		; wovor.rec := wovor.rec - 1
	jr	sp41
;
;----------------
;
; === was.blk = wovor.blk  and  was.rec > wovor.rec
;
sp44::	call	lesen
	jr	nz,sp42		; -> fehler: beim lesen
;
	call	konsent
	jr	nz,sp42		; -> fehler: mb stand an falscher stelle
;
	call	lesen
	jr	nz,sp42		; -> fehler: beim lesen
;
	inc	e		; wovor.rec := wovor.rec + 1
	jr	sp41
;
;----------------
;
sp45::	jr	nc,sp46
;
; === was.blk < wovor.blk
;
	ld	a,d
	sub	b
	push	af
	ld	a,(errcou)	; falls nur noch erranz/2 Versuche ausstehen
	cp	erranz/2	; um eine bandmarke mehr zuruecksetzen
	jr	c,sp451
	pop	af
	inc	a
	push	af
sp451::	pop	af		; evtl. bei bedarf inc a
	inc	a
	ld	(ix+eabm),a	; (anzbm) := wovor - was + 1
	ld	a,1
	ld	(richtu),a
	ld	a,75h		; um wovor-was+1 bm ruecksetzen
	call	kmb
	jr	nz,sp42		; -> fehler: beim bm-ruecksetzen
;
	ld	d,b
	xor	a
	ld	e,a		; wovor := was.blk / 0
	jr	sp41
;
;----------------
;
sp46::	ld	a,d
	inc	a
	cp	b
	jr	nz,sp48
;
; === was.blk = wovor.blk+1
;
sp47::	call	lesen
	jr	nz,sp42		; -> fehler: beim lesen
;
	push	bc
	ld	bc,0
	call	konlen
	pop	bc
	jr	nz,sp47		; -> keine bandmarke, weitermachen
;
	inc	d
	xor	a
	ld	e,a		; wovor := wovor.blk+1 / 0
	jp	sp41
;
;----------------
;
; === was.blk > wovor.blk+1
;
sp48::	ld	a,(errcou)	; falls nur noch erranz/2 fehlversuche
	cp	erranz/2	; langsam vorpositionieren
	jr	c,sp47
	ld	a,b
	sub	d
	ld	(ix+eabm),a	; (anzbm) := was - wovor
	xor	a
	ld	(richtu),a
	ld	a,71h		; um was-wovor bm vorsetzen
	call	kmb
	jp	nz,sp42		; -> fehler: beim bm-vorsetzen
;
	ld	d,b
	xor	a
	ld	e,a		; wovor := was.blk / 0
	jp	sp41
;
;----------------------------------------------------------------------
;
fehler::ld	a,16h		; fehlerbehandlung
	cp	(ix+eafehl)	; ----------------
	jr	nz,fehl01	; ende der aufzeichnungen auf dieser seite
	ld	a,(richtu)
	or	a
	jr	z,fehl00
	call	rucksp		; am anfang zur sicherheit ruckspulen
	call	endruc
	ld	a,41h		; reservieren aus
	call	kmb
	ld	a,31h		; reservieren ein
	call	kmb
	jr	fehl01
fehl00::ld	b,10h		; um 16 saetze zuruecksetzen
fehl0a::ld	a,15
	call	kmb
	djnz	fehl0a
;
fehl01::call	lesen
	jr	nz,fehler
	ld	bc,12
	call	konlen		;   solange lesen bis sent gefunden
	jr	nz,fehler	;   dann vor sent setzen und wovor
;
	ld	l,(ix+eaadr)	; iy := (adr)
	ld	h,(ix+eaadr+1)
	ld	(arb),hl
	ld	iy,(arb)
	set12
	ld	d,(iy+1)
	ld	e,(iy+2)
	res12
	ld	(ix+eawovo),e
	ld	(ix+eawovo+1),d
;
	ld	a,1
	ld	(richtu),a
	ld	a,15h
	call	kmb		; einen record ruecksetzen
	jr	nz,fehler	; -> fehler: beim record ruecksetzen
	ret
;
;----------------------------------------------------------------------
;
kmb::	ld	(ix+eakom),a	; (kom) := a
	push	bc
	push	de
	push	hl
	xor	a
	ld	(kmwart),a
	setkmb
	call	kmbrob
kmb01::	ld	a,(kmwart)
	or	a
	jr	z,kmb01
	reskmb
;
kmb02::	pop	hl
	pop	de
	pop	bc
	bit	7,(ix+eastat)
	ret
;
kmbep::	push	af
	ld	a,1
	ld	(kmwart),a
	pop	af
	ret
;
;----------------------------------------------------------------------
;
kmwart::defb	0		; 0 - kmb arbeitet noch; 1 - kmb fertig
was::	defw	0
errcou::defb	0		; zaehler fuer fehlversuche
arb::	defw	0
richtu::defb	0		; 0 - es wurde vorwaerts   gelesen
				; 1 - es wurde rueckwaerts gelesen
;
;
;
