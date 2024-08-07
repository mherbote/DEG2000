; e/a tabellen-aufbau
; -------------------
;
isblk	equ	5		; 0 - geraet arbeitet ungeblockt
ixrd	equ	4		; read/write-anspruenge
ixwr	equ	2

eastat	equ	0		; bamos-arbeitszellen kmb
eafehl	equ	1
eakom	equ	4
eaep	equ	5
eaadr	equ	7
ealen	equ	9
eabm	equ	10
eawied	equ	11
eaverl	equ	12

eadpuf	equ	13		; directorypufferung kassetten
eadzei	equ	15

eawovo	equ	16		; positionierung kassetten

hstbuf	equ	18		; blockung/entblockung arbeitszellen
hsttrk	equ	20
hstsec	equ	22
hstact	equ	23
hstwrt	equ	24
unacnt	equ	25
unatrk	equ	26
unasec	equ	28

gelade	equ	29

hrd	equ	30		; blockung/entblockung parameter
hwr	equ	32
blklog	equ	34
cpmspt	equ	35
secshf	equ	36
secmsk	equ	37
;
	page	
; e/a-tabelle tpa-disk
;
	defb	0		; ungeblocktes geraet
	defw	rdmem
	defw	wrmem
eataba::
;
; e/a-tabellen kassetten
;
	defb	1		; geraet arbeitet geblockt
	defw	rdkmb
	defw	wrkmb
eatab1::defb	0,0,pkmb,1	; laufwerk 1
	defb	0		; ==========
	defw	kmbep		;    ep
	defw	0		;    adr
	defw	0		;    len , anzbm
	defw	0		;    anz.versuche , anz. ext.gap
	defw	dir1
	defb	0		; anzeiger, ob in directory geschrieben
;				; wurde ( =1 es wurde )
	defw	0		; wovor blk/rec
	defw	kasbu1		; adresse des hostbuffer
	defw	0		; nr. des pufferinhaltes als hostwert
	defb	0		;               - " -
	defb	0		; puffer gefuellt (=0 nein)
	defb	0		; puffer beschrieben (=1 es wurde)
	defb	0		; anzahl der noch unalloc. recs
	defw	0		; spurnr. des naechsten unalloc. recs
	defb	0		; sektornr.     - " -
	defb	0		; 0 laufwerk entladen; 1 laufwerk geladen
	defw	hrdkmb		; leseroutine vom kmb in hostbuffer
	defw	hwrkmb		; writeroutine vom hostbuffer auf kmb
	defb	8,16,1,1	; parameter blockung/entblockung
;
	defb	1
	defw	rdkmb
	defw	wrkmb
eatab2::defb	0,0,pkmb,2	; laufwerk 2
	defb	0		; ==========
	defw	kmbep,0
	defw	0,0
	defw	dir2
	defb	0
	defw	0
	defw	kasbu2
	defw	0
	defb	0,0,0,0
	defw	0
	defb	0
	defb	0
	defw	hrdkmb
	defw	hwrkmb
	defb	8,16,1,1
;
 if anzakb gt 1
	defb	1
	defw	rdkmb
	defw	wrkmb
eatab3::defb	0,0,pkmb2,1	; laufwerk 3
	defb	0		; ==========
	defw	kmbep,0
	defw	0,0
	defw	dir3
	defb	0
	defw	0
	defw	kasbu3
	defw	0
	defb	0,0,0,0
	defw	0
	defb	0
	defb	0
	defw	hrdkmb
	defw	hwrkmb
	defb	8,16,1,1
;
	defb	1
	defw	rdkmb
	defw	wrkmb
eatab4::defb	0,0,pkmb2,2	; laufwerk 4
	defb	0		; ==========
	defw	kmbep,0
	defw	0,0
	defw	dir4
	defb	0
	defw	0
	defw	kasbu4
	defw	0
	defb	0,0,0,0
	defw	0
	defb	0
	defb	0
	defw	hrdkmb
	defw	hwrkmb
	defb	8,16,1,1
 endif
;
 if anzakb gt 2
	defb	1
	defw	rdkmb
	defw	wrkmb
eatab5::defb	0,0,pkmb3,1	; laufwerk 5
	defb	0		; ==========
	defw	kmbep,0
	defw	0,0
	defw	dir5
	defb	0
	defw	0
	defw	kasbu5
	defw	0
	defb	0,0,0,0
	defw	0
	defb	0
	defb	0
	defw	hrdkmb
	defw	hwrkmb
	defb	8,16,1,1
;
	defb	1
	defw	rdkmb
	defw	wrkmb
eatab6::defb	0,0,pkmb3,2	; laufwerk 6
	defb	0		; ==========
	defw	kmbep,0
	defw	0,0
	defw	dir6
	defb	0
	defw	0
	defw	kasbu6
	defw	0
	defb	0,0,0,0
	defw	0
	defb	0
	defb	0
	defw	hrdkmb
	defw	hwrkmb
	defb	8,16,1,1
 endif

 if mindk
;
; e/a-tabellen minidisk
;
	defb	0
	defw	rdmd
	defw	wrmd
eamd1::	

	defb	0
	defw	rdmd
	defw	wrmd
eamd2::

	defb	0
	defw	rdmd
	defw	wrmd
eamd3::

	defb	0
	defw	rdmd
	defw	wrmd
eamd4::
 endif

 if stadk
;
; e/a-tabellen standarddisk
;
	defb	0
	defw	rdsd
	defw	wrsd
easd1::

	defb	0
	defw	rdsd
	defw	wrsd
easd2::
 endif

 if zst
;
; e/a-tabelle zentralstation
;
	defb	0
	defw	rdzst
	defw	wrzst
eazst::
 endif

 if tramdk
;
; e/a-tabelle TRAM-Disk
;
	defb	0
	defw	rdtram
	defw	wrtram
eatram::
 endif

 if opsdk
;
; e/a-tabelle 16k-OPS-Disk
;
	defb	0
	defw	rdops
	defw	wrops
eaops::
 endif
;
	page	
ixtab::	defs	32
;
ixtab1::defw	eataba		; tabelle der ix-adresse

	defw	eatab1,eatab2

 if anzakb gt 1
	defw	eatab3,eatab4
 else
	defw	0,0
 endif

 if anzakb gt 2
	defw	eatab5,eatab6
 else
	defw	0,0
 endif

 if mindk
	defw	eamd1,eamd2,eamd3,eamd4
 else
	defw	0,0,0,0
 endif

 if stadk
	defw	easd1,easd2
 else
	defw	0,0
 endif

 if zst
	defw	eazst
 else
	defw	0
 endif

 if tramdk
	defw	eatram
 else
	defw	0
 endif

 if opsdk
	defw	eaops
 else
	defw	0
 endif
;
