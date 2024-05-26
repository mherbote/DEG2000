	TITLE 'M E M O'
	PAGE
;	PN	ME02
	ORG	2000H
;**********************************************************
;        Darstellung (BZMAX) * 16 Byte Hexa und ASCII
;**********************************************************
;
AZBLD:
	PUSH	HL
	PUSH	DE
	PUSH	BC
	LD	HL,(AADR)	;HL:= Bereichsanfang
	LD	DE,SD.BWSA	;DE:= Bildwiederholsp.
	LD	A,(BZMAX)
	OR	A
	JR	Z,AZBL2	;0 Zeilen
	CP	23
	JR	NC,AZBL2	;mehr als 24 Zeilen
	LD	B,A	;B:=Zeilenzahl
AZBL1:
	CALL	ANZ1Z
	DJNZ	AZBL1
AZBL2:
	POP	BC
	POP	DE
	POP	HL
	RET
;
ANZ1Z:
	CALL	CVAX
	PUSH	BC
	INC	DE
	INC	DE
	PUSH	HL
	LD	B,4
ANZ11:
	CALL	AZ4BY	;Hexa-Darstellung
	DJNZ	ANZ11
	INC	DE
	POP	HL
	LD	B,16
ANZ12:
	LD	A,(HL)	;ASCII-Darstellung
	CALL	ANZ1B
	INC	HL
	INC	DE
	DJNZ	ANZ12
	LD	B,5
ANZ13:
	INC	DE
	DJNZ	ANZ13
	POP	BC
	RET
;
AZ4BY:
	PUSH	BC	;Anzeige Vierergruppe
	LD	B,4
AZ4B1:
	LD	A,(HL)
	CALL	CVBX
	INC	DE
	INC	HL
	DJNZ	AZ4B1
	INC	DE
	POP	BC
	RET
;
ANZ1B:
	CALL	TASCI	;Anzeige 1 Byte ASCII
	LD	(DE),A
	RET
;
TASCI:
	CP	' '
	JR	C,TASC1
	CP	80H
	RET	C
TASC1:
	LD	A,7FH
	RET
;
;********************************************************
;        Ausfuehrungsroutinen fuer die einzelnen
;        Tastencodes
;--------------------------------------------------------
; CDH    SYS-Taste  (Systemruecksprung)
;--------------------------------------------------------
;
SYS:
	LD	HL,SYSM
	EX	(SP),HL
	RET
;
;--------------------------------------------------------
; F8H   Home (Kursor nach oben links)
;--------------------------------------------------------
;
HOME:
	CALL	BSADL
	LD	HL,(AADR)
	LD	(AKTAD),HL	;aktuelle Adresse
	LD	A,(MOD)
	OR	A
	JR	NZ,AHOME	;---> ASCII-Mode
	LD	A,6
HOME1:
	LD	(BPZEI),A	;Position/Zeile
	XOR	A
	LD	(BZEIN),A
	CALL	BSADS
	RET
AHOME:
	LD	A,59
	JR	HOME1
;
;BWS-Adresse aus (BZEIN) und (BPZEI) berechnen
;OUT   HL=aktuelle BWS-Adresse
;
BSADR:
	PUSH	AF
	PUSH	BC
	PUSH	DE
	LD	A,(BZEIN)	;Zeilennummer
	LD	HL,SD.BWSA
	OR	A
	JR	Z,BSAD2
	LD	B,A
	LD	DE,80
BSAD1:
	ADD	HL,DE
	DJNZ	BSAD1
BSAD2:
	LD	A,(BPZEI)	;Position
	LD	E,A
	LD	D,0
	ADD	HL,DE
	POP	DE
	POP	BC
	POP	AF
	RET
;
BSADL:
	CALL	BSADR
	RES	7,(HL)
	RET
BSADS:
	CALL	BSADR
	SET	7,(HL)
	RET
;
;----------------------------------------------------------
; FAH    New Line (Anfang naechste Zeile)
;----------------------------------------------------------
;
ME.NEWL:
	LD	A,(BZEIN)
	INC	A
	CALL	TSZMX
	JR	NC,HOME	;---> Max. Zeilennummer
	CALL	BSADL
	LD	HL,BZEIN
	INC	(HL)
	LD	A,(MOD)
	OR	A
	JR	NZ,ANEWL
	LD	A,6
NEWL1:
	LD	(BPZEI),A
	CALL	BSADS
	CALL	CAKAL	;Korrektur akt. Adresse
	RET
ANEWL:
	LD	A,59
	JR	NEWL1
;
TSZMX:
	PUSH	HL	;Test auf max. Zeilennummer
	LD	HL,BZMAX
	CP	(HL)
	POP	HL
	RET
;
CAKAL:
	LD	HL,(AADR)
	PUSH	BC
	LD	A,(BZEIN)
	OR	A
	JR	Z,CAKA1
	LD	B,A
CAKA2:
	LD	DE,10H
	ADD	HL,DE
	DJNZ	CAKA2
	LD	(AKTAD),HL
CAKA1:
	POP	BC
	RET
;
;---------------------------------------------------------------
; FBH    Kursor nach unten
;---------------------------------------------------------------
;
CRUNT:
	LD	A,(BZEIN)
	INC	A
	CALL	TSZMX
	JR	NC,CRBLD	;max. Zeilenanzahl
	CALL	BSADL
	LD	HL,BZEIN
	INC	(HL)
CRUN1:
	CALL	BSADS
	LD	HL,(AKTAD)
	LD	DE,10H
	ADD	HL,DE
	LD	(AKTAD),HL
	RET
CRBLD:
	LD	HL,(AADR)
	LD	DE,10H
	ADD	HL,DE
	LD	(AADR),HL
	CALL	AZBLD
	JR	CRUN1
;
;----------------------------------------------------------
; F5H    Kursor nach oben
;----------------------------------------------------------
;
CHOCH:
	LD	A,(BZEIN)
	OR	A
	JR	Z,CHBLD	;1. Zeile
	CALL	BSADL
	LD	HL,BZEIN
	DEC	(HL)
CHOC1:
	CALL	BSADS
	LD	HL,(AKTAD)
	LD	DE,10H
	OR	A
	SBC	HL,DE
	LD	(AKTAD),HL
	RET
CHBLD:
	LD	HL,(AADR)
	LD	DE,10H
	OR	A
	SBC	HL,DE
	LD	(AADR),HL
	CALL	AZBLD
	JR	CHOC1
;
;-----------------------------------------------------------
; F0H    INS MODE (Umschaltung ASCII <---> HEXA)
;-----------------------------------------------------------
;
UMOD:
	CALL	BSADL
	LD	A,(MOD)
	OR	A
	JR	Z,ASCMD
	CALL	REFAH
	CALL	BSADS
	XOR	A
	LD	(MOD),A
	RET
;
REFAH:
	LD	A,(BPZEI)
	LD	HL,REFTB+10H
HEMD2:
	CP	(HL)
	JR	Z,HEMD1
	INC	HL
	JR	HEMD2
HEMD1:
	LD	DE,10H
	OR	A
	SBC	HL,DE
	LD	A,(HL)
	LD	(BPZEI),A
	RET
;
ASCMD:
	CALL	CBPZ
	CALL	REFHA
	CALL	BSADS
	LD	A,1
	LD	(MOD),A
	RET
;
CBPZ:
	INC	HL
	LD	A,(HL)
	CP	' '
	RET	NZ
	LD	HL,BPZEI
	DEC	(HL)
	RET
;
REFHA:
	LD	A,(BPZEI)
	LD	HL,REFTB
ASMD2:
	CP	(HL)
	JR	Z,ASMD1
	INC	HL
	JR	ASMD2
ASMD1:
	LD	DE,10H
	ADD	HL,DE
	LD	A,(HL)
	LD	(BPZEI),A
	RET
;
;------------------------------------------------------------
; B0H    POS. QUIT.  (Blaettern vorwaerts)
;------------------------------------------------------------
;
BLVOR:
	LD	HL,(AADR)
	LD	A,(BZMAX)
	LD	B,A
	LD	DE,10H
BLVO3:
	ADD	HL,DE
	DJNZ	BLVO3
BLVO2:
	LD	(AADR),HL
	LD	(AKTAD),HL
	CALL	AZBLD
	XOR	A
	LD	(BZEIN),A
	LD	A,(MOD)
	OR	A
	JR	NZ,ABLVO
	LD	A,6
BLVO1:
	LD	(BPZEI),A
	CALL	BSADS
	RET
ABLVO:
	LD	A,59
	JR	BLVO1
;
;----------------------------------------------------------
; CCH    NEG. QUIT.  (Blaettern rueckwaerts)
;----------------------------------------------------------
;
BLRUC:
	LD	HL,(AADR)
	LD	A,(BZMAX)
	LD	B,A
	LD	DE,10H
BLRU1:
	OR	A
	SBC	HL,DE
	DJNZ	BLRU1
	JR	BLVO2
;
;----------------------------------------------------------
; F9H    Kursor nach rechts
;----------------------------------------------------------
;
CRECH:
	LD	A,(MOD)
	OR	A
	JP	NZ,ACREC	;---> ASCII-Mode
	LD	A,(BPZEI)
	CP	55
	JR	Z,CRNZ	;---> naechste Zeile
	CALL	BSADL
	INC	HL
	LD	A,(HL)
	CP	' '
	JR	Z,CRAIC	;---> Adresse erhoehen
	LD	HL,BPZEI
	INC	(HL)
	CALL	BSADS
	RET
;
CRAIC:
	INC	HL
	LD	A,(HL)
	CP	' '
	JR	Z,CREC2	;---> naechste Vierergruppe
	SET	7,(HL)
	LD	HL,BPZEI
CREC4:
	INC	(HL)
	INC	(HL)
	JR	CREC3
CREC2:
	INC	HL
	SET	7,(HL)
	LD	HL,BPZEI
	INC	(HL)
	JR	CREC4
CREC3:
	LD	HL,(AKTAD)	;aktuelle Adr. erhoehen
	INC	HL
	LD	(AKTAD),HL
	RET
;
CRNZ:
	CALL	BSADL
	LD	A,6
CRNZ2:
	LD	(BPZEI),A
	LD	A,(BZEIN)
	INC	A
	CALL	TSZMX
	JR	NC,CRCBD	;---> letzte Zeile
	LD	HL,BZEIN
	INC	(HL)
CRNZ1:
	CALL	BSADS
	JP	CREC3
;
CRCBD:
	LD	HL,(AADR)
	LD	DE,10H
	ADD	HL,DE
	LD	(AADR),HL
	CALL	AZBLD
	JR	CRNZ1
;
;-------------------------------------------------------
;
ACREC:
	CALL	BSADL
	LD	A,(BPZEI)
	CP	74
	JR	Z,ACRNZ	;---> naechste Zeile
	INC	A
	LD	(BPZEI),A
	CALL	BSADS
	JP	CREC3
;
ACRNZ:
	LD	A,59
	JR	CRNZ2
;
;-------------------------------------------------------
; F7H    Kursor nach links
;-------------------------------------------------------
;
CLINK:
	LD	A,(MOD)
	OR	A
	JP	NZ,ACLNK	;---> ASCII-Mode
	LD	A,(BPZEI)
	CP	6
	JR	Z,CLNZ	;---> 1 Zeile zurueck
	CALL	BSADL
	DEC	HL
	LD	A,(HL)
	CP	' '
	JR	Z,CLDEC	;Adresse decrementieren
	LD	HL,BPZEI
	DEC	(HL)
	CALL	BSADS
	RET
;
CLDEC:
	DEC	HL
	LD	A,(HL)
	CP	' '
	JR	Z,CLDE2	;---> 1 Vierergruppe zurueck
	SET	7,(HL)
	LD	HL,BPZEI
CLDE4:
	DEC	(HL)
	DEC	(HL)
	JR	CLDE3
CLDE2:
	DEC	HL
	SET	7,(HL)
	LD	HL,BPZEI
	DEC	(HL)
	JR	CLDE4
CLDE3:
	LD	HL,(AKTAD)
	DEC	HL
	LD	(AKTAD),HL
	RET
;
CLNZ:
	CALL	BSADL
	LD	A,55
CLNZ2:
	LD	(BPZEI),A
	LD	A,(BZEIN)
	OR	A
	JR	Z,CLCBD	;1.Zeile
	LD	HL,BZEIN
	DEC	(HL)
CLNZ1:
	CALL	BSADS
	JP	CLDE3
;
CLCBD:
	LD	HL,(AADR)
	LD	DE,10H
	OR	A
	SBC	HL,DE
	LD	(AADR),HL
	CALL	AZBLD
	JR	CLNZ1
;
;---------------------------------------------------------
;
ACLNK:
	CALL	BSADL
	LD	A,(BPZEI)
	CP	59
	JR	Z,ACLNZ
	DEC	A
	LD	(BPZEI),A
	CALL	BSADS
	JP	CLDE3
ACLNZ:
	LD	A,74
	JR	CLNZ2
;
;-------------------------------------------------------------
; F6H   Schieben rechts  (Ablegen im Puffer)
;-------------------------------------------------------------
;
INPUF:
	LD	DE,(PUZEI)
	LD	HL,400H
	OR	A
	SBC	HL,DE
	RET	Z		;Puffer voll
	CALL	CCPO	;Korrektur Kursorpos.
	LD	HL,(AKTAD)
	LD	A,(HL)
	LD	HL,PUFAN
	ADD	HL,DE
	LD	(HL),A
	INC	DE
	LD	(PUZEI),DE
	CALL	CRECH
	LD	A,(MOD)
	OR	A
	RET	NZ
	CALL	CRECH
	RET
;
CCPO:
	LD	A,(MOD)
	OR	A
	RET	NZ
	CALL	BSADR
	INC	HL
	LD	A,(HL)
	CP	' '
	RET	NZ
	DEC	HL
	RES	7,(HL)
	LD	HL,BPZEI
	DEC	(HL)
	RET
;
;--------------------------------------------------------------
; F4H   Schieben links (Auslagern Pufferinhalt)
;--------------------------------------------------------------
;
AUPUF:
	LD	DE,(PUZEI)
	LD	A,D
	OR	E
	RET	Z
	CALL	CCPO
	LD	DE,PUFAN
	LD	A,(DE)
	LD	HL,(AKTAD)
	LD	(HL),A
	CP	(HL)
	RET	NZ
	PUSH	DE
	POP	HL
	INC	HL
	LD	BC,(PUZEI)
	PUSH	BC
	LDIR
	POP	BC
	DEC	BC
	LD	(PUZEI),BC
	LD	C,A
	LD	A,(MOD)
	OR	A
	JR	NZ,AUPU1
	LD	HL,BPZEI
	LD	B,(HL)
	CALL	DSBAH
	CALL	CRECH
	CALL	CRECH
	RET
AUPU1:
	CALL	BSADR
	LD	A,C
	CALL	TASCI
	LD	(HL),A
	LD	B,C
	CALL	DSBH
	CALL	CRECH
	RET
;
;--------------------------------------------------------------
; F3H    DEL LINE (Zeile mit 00H fuellen)
;--------------------------------------------------------------
;
DELL:
	LD	A,(MOD)
	OR	A
	RET	NZ
	CALL	BSADL
	LD	A,6
	LD	(BPZEI),A
	CALL	BSADS
	CALL	CAKAL
	LD	(AKTAD),HL
	LD	B,32
DELL1:
	LD	A,'0'
	PUSH	BC
	CALL	HEXMO
	POP	BC
	DJNZ	DELL1
	RET
;
;--------------------------------------------------------------
; F0H    DEL  (Bildneuaufbau) 
;--------------------------------------------------------------
;
TDEL:
	LD	HL,(AADR)
	LD	(AKTAD),HL
	LD	(AADR1),HL
	LD	(AKTA1),HL
	LD	A,6
	LD	(BPZEI),A
	LD	(BPZE1),A
	XOR	A
	LD	(MOD),A
	LD	(BZEIN),A
	LD	(MOD1),A
	LD	(BZEI1),A
	LD	A,16
	LD	(BZMAX),A
	LD	HL,550H
	LD	(VTAS),HL
	LD	HL,0
	LD	(PUZEI),HL
INSLN:
	CALL	ME.BILO
	CALL	AZBLD
	CALL	BSADS
	CALL	DSPAD
	CALL	DSPOI
	RET
;
;--------------------------------------------------------------
; B1H    TABS  (aktuellen Zustand retten)
;--------------------------------------------------------------
;
SAVE:
	LD	HL,AADR
	LD	DE,AADR1
SAVE1:
	LD	BC,7
	LDIR
	RET
;
;-------------------------------------------------------------
; B2H    TABL  (geretteten Zustand herstellen)
;-------------------------------------------------------------
;
GET:
	LD	HL,AADR1
	LD	DE,AADR
	CALL	SAVE1
	LD	A,(BZMAX)
	LD	B,A
	LD	A,(BZEIN)
GET2:
	CP	B
	JR	C,GET1
	LD	HL,(AADR)
	LD	DE,10H
	ADD	HL,DE
	LD	(AADR),HL
	DEC	A
	LD	(BZEIN),A
	JR	GET2
GET1:
	CALL	INSLN
	RET
;
;-------------------------------------------------------------
; 09H    ET2   (Start eines Programms ab Kursorposition)
;-------------------------------------------------------------
;
ME.START:
	LD	HL,(AKTAD)
	LD	BC,STAR1
	PUSH	BC
	JP	(HL)
STAR1:
	CALL	INSLN
	RET
;
;--------------------------------------------------------------
; B3H    (Zeilenanzahl erhoehen)
;--------------------------------------------------------------
;
INCBZ:
	LD	A,(BZMAX)
	CP	22
	RET	NC
	INC	A
	LD	(BZMAX),A
	CALL	INSLN
	RET
;
;-------------------------------------------------------------
; B4H    (Zeilenanzahl verringern)
;-------------------------------------------------------------
;
DECBZ:
	LD	A,(BZMAX)
	CP	1
	RET	Z
	DEC	A
	LD	(BZMAX),A
	LD	B,A
	LD	A,(BZEIN)
	LD	C,A
	LD	A,B
	DEC	A
	CP	C
	JR	NC,DECB1
	OR	A
	LD	DE,10H
	LD	HL,(AKTAD)
	SBC	HL,DE
	LD	(AKTAD),HL
	LD	A,C
	DEC	A
	LD	(BZEIN),A
DECB1:
	CALL	INSLN
	RET
;
;-------------------------------------------------------------
;        Positionstabelle   HEXA ---- ASCII fuer Byte 00...0FH
;-------------------------------------------------------------
;
REFTB:
	DB	6	;00H   HEXA-Mode
	DB	9	;01H
	DB	12
	DB	15
	DB	19
	DB	22
	DB	25
	DB	28
	DB	32
	DB	35
	DB	38
	DB	41
	DB	45
	DB	48
	DB	51
	DB	54	;0FH
	DB	59	;00H  ASCII-Mode
	DB	60
	DB	61
	DB	62
	DB	63
	DB	64
	DB	65
	DB	66
	DB	67
	DB	68
	DB	69
	DB	70
	DB	71
	DB	72
	DB	73
	DB	74	;0FH
;
;-------------------------------------------------------------
;        Auswertung alphanumerischer Tasten im ASCII-Mode
;-------------------------------------------------------------
;
ASCMO:
	LD	B,A	;Code retten
	CALL	BSADR
	LD	(HL),A	;Code anzeigen
	LD	HL,(AKTAD)
	LD	(HL),A	;Code abspeichern
	LD	A,(HL)	;ruecklesen
	CP	B
	JR	Z,ASCM1	;---> RAM-Bereich
	CALL	BSADR
	CALL	TASCI
	LD	(HL),A	;Speicherinhalt anzeigen
	SET	7,(HL)	;Kursor setzen
	RET
ASCM1:
	CALL	DSBH
	CALL	CRECH
	RET
;
DSBH:
	LD	A,(BPZEI)
	PUSH	AF	;Position retten
	CALL	REFAH	;Position HEXA
	CALL	BSADR	;BWS-Adresse HEXA
	POP	AF
	LD	(BPZEI),A	;Position ASCII
	EX	DE,HL
	LD	A,B
	CALL	CVBX	;Anzeige HEXA
	RET
;
;-------------------------------------------------------------
;        Auswertung Tasten 0...9,A...F im HEXA-Mode
;-------------------------------------------------------------
;
HEXMO:
	LD	B,A	;Code retten
	CALL	CVAXB	;ASCII-Hexa ---> Binaer < 16
	LD	C,A
	CALL	BSADR
	INC	HL
	LD	A,(HL)
	CP	' '
	JR	Z,RHB	;---> rechtes Halbbyte
LHB:
	LD	HL,(AKTAD)	;linkes Halbbyte
	LD	A,C
	ADD	A,A	;*16
	ADD	A,A
	ADD	A,A
	ADD	A,A
	LD	C,A
	LD	A,(HL)	;A:= Speicherinhalt
	AND	0FH	;linkes Halbbyte ausblenden
	OR	C	;neuer Wert
LHB1:
	LD	D,A	;Wert retten
	LD	(HL),A	;abspeichern
	LD	C,A
	LD	A,(HL)	;ruecklesen
	CP	D
	JR	Z,HEXM0	;---> RAM
	EX	DE,HL
	LD	A,C
	CALL	CVBX	;alten Wert anzeigen
	CALL	BSADS
	RET
;
RHB:
	LD	HL,(AKTAD)	;rechtes Halbbyte
	LD	A,(HL)
	AND	0F0H	;rechtes Halbbyte ausblenden
	OR	C
	JR	LHB1
;
HEXM0:
	LD	A,(BPZEI)
	LD	B,A
	CALL	BSADR
	INC	HL
	LD	A,(HL)
	CP	' '
	CALL	Z,RHB1
	CALL	DSBAH
	CALL	CRECH
	RET
;
DSBAH:
	CALL	BSADR
	LD	A,C
	EX	DE,HL
	CALL	CVBX
HEXM1:
	CALL	REFHA
	CALL	BSADR
	LD	A,C
	CALL	TASCI
	LD	(HL),A	;Anzeige ASCII
	LD	HL,BPZEI
	LD	(HL),B
	RET
;
RHB1:
	LD	HL,BPZEI
	DEC	(HL)
	RET
;
;***************************************************************
;        Tastencodeauswertung
;***************************************************************
;
ATACO:
	CALL	TAREP
	PUSH	AF
	CALL	TAUSF
	CALL	DSPAD
	CALL	DSPOI
	POP	AF
	JR	ATACO
SYSM:
	POP	AF
	RET
;
TAUSF:
	CP	0CDH
	JP	Z,SYS
	CP	0CEH
	JP	Z,HDCOP
	CP	0B0H
	JP	Z,BLVOR
	CP	0B1H
	JP	Z,SAVE
	CP	0B2H
	JP	Z,GET
	CP	0B3H
	JP	Z,INCBZ
	CP	0B4H
	JP	Z,DECBZ
	CP	09H
	JP	Z,ME.START
	CP	0CCH
	JP	Z,BLRUC
	CP	0F0H
	JP	Z,UMOD
	CP	0F8H
	JP	Z,HOME
	CP	0FAH
	JP	Z,ME.NEWL
	CP	0F7H
	JP	Z,CLINK
	CP	0F9H
	JP	Z,CRECH
	CP	0F2H
	JP	Z,INSLN
	CP	0F3H
	JP	Z,DELL
	CP	0F5H
	JP	Z,CHOCH
	CP	0FBH
	JP	Z,CRUNT
	CP	0F6H
	JP	Z,INPUF
	CP	0F4H
	JP	Z,AUPUF
	CP	0F1H
	JP	Z,TDEL
	PUSH	AF
	LD	A,(MOD)
	OR	A
	JR	Z,NHEXA
	POP	AF
	CP	20H
	RET	C
	CP	80H
	RET	NC
	JP	ASCMO
NHEXA:
	POP	AF
	CP	'0'
	RET	C
	CP	3AH
	JP	C,HEXMO
	CP	'G'
	RET	NC
	CP	'A'
	RET	C
	JP	HEXMO

;      INITIALISIERUNG

	DW	$
	DB	'M   '
	CALL	INSLN
	CALL	ATACO
	JP	SY.SYSTB

	DW	$
	DB	'MEMO'
	LD	DE,SD.BWSA+327H
	CALL	CVXA
	JR	C,AAALT
	LD	(AADR),HL
AAALT:
	CALL	TDEL
	CALL	ATACO
	JP	SY.SYSTB

;---------------------------

DSPAD:
	PUSH	HL
	PUSH	DE
	LD	DE,SD.BWSA+730H
	LD	HL,(AKTAD)
DSPA1:
	CALL	CVAX
	POP	DE
	POP	HL
	RET
DSPOI:
	PUSH	HL
	PUSH	DE
	LD	DE,SD.BWSA+73AH
	LD	HL,(PUZEI)
	JR	DSPA1

CVAX:
	LD	A,H
	CALL	CVBX
	LD	A,L
	CALL	CVBX
	RET

CVXB:
	PUSH	BC
	CALL	CVX1B
	JR	C,CVX11
	ADD	A,A
	ADD	A,A
	ADD	A,A
	ADD	A,A
	LD	C,A
	CALL	CVX1B
	JR	C,CVX11
	ADD	A,C
	OR	A
	POP	BC
	RET
CVX11:
	POP	BC
	SCF
	RET

CVXA:
	CALL	CVXB
	RET	C
	LD	H,A
	CALL	CVXB
	RET	C
	LD	L,A
	RET

CVX1B:
	LD	A,(DE)	; ASCII hexa (DE) --> A binaer,DE+1
	CALL	CVAXB
	INC	DE
	RET

TAREP:
	CALL	ME.ABFR
	JR	Z,TAREP
	RET

;***************  HARDCOPY  *******************

HDCOP:
	CALL	TDEL
	LD	A,20
	LD	(ZN),A
	LD	HL,ZKEIN
	CALL	MIMO
	RET	C

	EX	DE,HL
	CALL	CVXA
	RET	C

	LD	DE,(AADR)
	XOR	A
	SBC	HL,DE
	RET	C
	RET	Z

	LD	DE,100H
	XOR	A
	LD	B,A
	LD	C,A
	PUSH	HL

HC01:
	SBC	HL,DE
	JR	C,HC02
	INC	B
	JR	HC01

HC02:
	POP	HL
	NOP
	NOP
	NOP
	SRL	L
	SRL	L
	SRL	L
	SRL	L
	INC	L
	LD	C,L
HC021:
	CP	B
	JR	Z,HC04

HC03:
	PUSH	BC
	LD	B,16
	CALL	HC
	LD	DE,100H
	LD	HL,(AADR)
	ADD	HL,DE
	LD	(AADR),HL
	CALL	TDEL
	POP	BC
	DJNZ	HC03

	XOR	A
	CP	C
	JR	Z,ME.END
HC04:
	LD	B,C
	CALL	HC

ME.END:
	RET

HC:
	LD	HL,SD.BWSA
	LD	C,80
	CALL	HCP
	LD	A,1EH
	CALL	DRUZ
	CALL	DRUZ
	RET

ZKEIN:
	DB	4
	DB	22
	DB	8
	DB	'Drucken bis Adresse : '

;	END
	TITLE 'Arbeitszellen fuer MEMO'
	PAGE
;	PN	ME01
	ORG	2BE0H
;***********************************************************
;      Arbeitszellen fuer MEMO
;***********************************************************

AADR:	DEFS	2,0
AKTAD:	DEFS	2,0
MOD:	DEFS	1,0
BZEIN:	DEFS	1,0
BPZEI:	DEFS	1,0
PUZEI:	DEFS	2,0
VTAS:	DEFS	2,0
BZMAX:	DEFS	1,0

AADR1:	DEFS	2,0
AKTA1:	DEFS	2,0
MOD1:	DEFS	1,0
BZEI1:	DEFS	1,0
BPZE1:	DEFS	1,0

;SYSTB	EQU	SY.SYSTB
;HCP	EQU	S1.HCP
ZN	EQU	02B00H
PUFAN	EQU	02C00H
;BWSA	EQU	SD.BWSA
MIMO	EQU	04A4CH	;UR.MIMI
CVAXB	EQU	0525DH	;UC.CVAXB
CVBX	EQU	0523AH	;UC.CVBX +2
CVABX	EQU	0522EH	;UC.CVABX
ME.BILO	EQU	06478H	;KH.BILO
ME.ABFR	EQU	06EE6H	;TA.ABFR1
DRUZ	EQU	07C00H

	ORG	3000H
	DEFS	1000H,20H	
;	END
