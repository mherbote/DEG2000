	TITLE 'EDITOR --- Meldephase'
	PAGE
;	PN	ED01
;****************************************************************
;*                  DEG 2000   V. 1.2     EDITOR --- Meldephase *
;*  Version         --------------------------------------------*
;*                  Programmierer: M. Herbote  K EAW  ZFT (WFT) *
;*  V 1 . 2         --------------------------------------------*
;*                  Stand        : 30.Januar 1985               *
;****************************************************************

	ORG	SD.EDITA

	DW	$
	DB	'EDIT'
ED.MELAN:
	DI
	CALL	QTABL
	LD	(SM.PTSA),HL
	LD	B,SD.PSANZ
ED.MEL5:
	LD	M,0
	INC	HL
	DJNZ	MEL5
	LD	(SM.PTSE),HL
	JR	ED.MEL1
ED.MEL2:
	CALL	UMLKP
ED.MEL1:
 CALL	SY.BILO		;Bild loeschen
ED.MEL11:
	CALL	RESET
	CALL	PUFLO		;TP loeschen
	CALL	MEMLA		;Fkt.Tast. u. RAM definieren
	LD	HL,MELNL
	LD	(SM.FKTAB+28H),HL
	LD	HL,0
	LD	(SM.NEWL),HL	;NL--Taste def.
	LD	A,(SM.ZANZ)
	DEC	A
	LD	(SM.ZMIN),A
	LD	(SM.ZMAX),A	;Format: vorletzte Zeile
	CALL	BWSAF
	EX	DE,HL
	LD	HL,ZED1
	CALL	SY.MELD		;Ausschrift
	EX	DE,HL
ED.MEL3:
	CALL	SY.LCPOS
	CALL	KOM		;Format ab CPOS
	CALL	DELZL
	RET

;NL-Funktion in Meldephase

ED.MELNL:
	XOR	A
	LD	(SM.FSTAT),A
	CALL	STANL	;Z=0 falls nur Space
	JR	Z,VOLLF
	CP	'F'
	JR	Z,FREI
	CP	'Q'
	JR	Z,QUELL
ED.ERRO1:
	LD	C,1	;falsche Formatanweisung
	JP	ERROR

ED.QUELL:
	LD	A,80H
	LD	(SM.FSTAT),A	;Quellcode Status
	LD	HL,SM.TABZ
	LD	M,SD.QTAB1
	INC	HL
	LD	M,SD.QTAB2
	INC	HL
	LD	M,SD.QTAB3
	INC	HL
	LD	M,SD.QTAB4
ED.VOLLF:
	LD	HL,(SM.ZANZ)	;volles Format laden
ED.FREI2:
	DEC	L
	DEC	L
	LD	(SM.ZMAX2),HL
ED.KOMA2:
	LD	HL,0
	LD	(SM.ZPOS2),HL
	INC	H
	INC	L
	LD	(SM.ZMIN2),HL	;SPOS2,ZPOS2=SMIN2-1,ZMIN2-1
	LD	HL,ED.MEL1
	JR	KOMA3

ED.FREI:
	EX	DE,HL
	LD	IX,SM.SPANZ
	XOR	A
	EX	AF,AF'
	CALL	LT1Z	;freies Format
	EX	DE,HL	;A<E=<(IX+0) BEI Z=CY=0
	JR	Z,VOLLF
	JR	C,ERRO1
	LD	HL,(SM.ZANZ)
	LD	H,E
	JR	FREI2

;Kommandophase

ED.KOMA1:
	CALL	FOEX	;CPOS + Arb.Form. --> Zweitmerker
	CALL	FKTLA	;RAM neu laden
	LD	HL,MEL2	;Syst.Taste neu
ED.KOMA3:
	LD	(SM.FKTAB+68H),HL
	LD	HL,KONEV
	LD	(SM.FKTAB+28H),HL
	LD	HL,KONER
	LD	(SM.FKTAB+38H),HL
	LD	HL,SM.UMERK
	LD	M,0
	LD	DE,SM.UMERK+1
	LD	BC,SM.LOE1-1
	CALL	RALO1	;volles Format
	LD	A,L
	LD	(SM.ZMIN),A	;Format letzte Zeile
	LD	HL,SY.AEIN
	CALL	MEML1	;NEWL,DELZ,EINA laden
	LD	HL,UMS
	LD	(SM.USCH),HL
	CALL	BWSAF
	JP	MEL3

;Start--Funktion in Kommandophase

ED.KONEV:
	CALL	KOEIN
	LD	HL,SM.STAT
	SET	7,M
	JP	TEX

ED.KONER:
	CALL	KOEIN
	LD	HL,SM.STAT
	RES	7,M
	JP	TEX

ED.KOEIN:
	CALL	UMLKP
	CALL	STANL
	CALL	NZ,KOMAN
ED.ARBPH:
	CALL	FOEX
ED.ARBFK:
	LD	HL,FALFT	;Fkt. fuer Arb.Phase init.
	LD	DE,SM.FKTAB
	LD	BC,80H
	LDIR
	LD	HL,FALAT
	LD	DE,SM.USCH
	LD	BC,12
	LDIR
	RET

ED.UMLKP:
	CALL	FOEX
	CALL	UML
	CALL	LOEBP
	CALL	FOEX
	RET

ED.FALAT:
	DW	UMS	;Fkt.Adressliste Alphatastatur
	DW	E1.TAB
	DW	DELZ
	DW	LEERZ
	DW	CNEW
	DW	ZSCHS

;Funktionsadressliste Funktionstastatur

ED.FALFT:
	DW	PTS1	;S1,Z1
	DW	PTS15
	DW	TABS
	DW	TCNOS
	DW	TCNLS
	DW	PTS9
	DW	PTS23
	DW	0

	DW	PTS2	;S2,Z1
	DW	PTS16
	DW	TABL
	DW	TCNRS
	DW	TCNUS
	DW	PTS10
	DW	PTS24
	DW	0

	DW	PTS3	;S3,Z1
	DW	PTS17
	DW	ABS
	DW	ATTR
	DW	TEXV
	DW	PTS11
	DW	PTS25
	DW	0

	DW	PTS4	;S4,Z1
	DW	PTS18
	DW	PS
	DW	REPEL
	DW	TEXR
	DW	PTS12
	DW	PTS26
	DW	0

	DW	PTS5	;S5,Z1
	DW	PTS19
	DW	GS
	DW	UND
	DW	IFKT3
	DW	PTS13
	DW	IFKT4
	DW	0

	DW	PTS6	;S6,Z1
	DW	PTS20
	DW	HT
	DW	DOL
	DW	0
	DW	PTS14
	DW	0
	DW	0

	DW	PTS7	;S7,Z1
	DW	PTS21
	DW	CA
	DW	SCHW
	DW	KOMA1
	DW	PTS27
	DW	0
	DW	0

	DW	PTS8	;S8,Z1
	DW	PTS22
	DW	THOME
	DW	TCNZA
	DW	PFO1
	DW	PTS28
	DW	0
	DW	0

ED.ZED1:
	DB	LOW(LZED1)
	DB	'EDITOR   FORMAT'
ED.LZED1 EQU    $-ZED1-1

			;Stand: 30.Januar 85 - K EAW/wfvm..MSH


;	END
	TITLE 'EDITOR --- Arbeitsphase'
	PAGE
;	PN	E101
;****************************************************************
;*                  DEG2000 V. 1.2    EDITOR --- Arbeitsphase   *
;*  Version         --------------------------------------------*
;*                  Programmierer: M. Herbote  K EAW  ZFT (WFT) *
;*  V 1 . 2         --------------------------------------------*
;*                  Stand        : 30.Januar 1985               *
;****************************************************************

;Alphazeichen schreiben

E1.ZSCHS:
	LD	A,1
	LD	(SM.ZSMER),A
E1.ZSCHR:
	LD	A,C
E1.ZSCH1:
	CALL	SY.CPOS
	LD	M,A
	CALL	ICPOS
	JR	CNEW2

;NL-Funktion

E1.CNEW:
	CALL	SY.CPOS
	LD	M,C
	LD	BC,(SM.SPOS)
	LD	B,0
	INC	C
	DEC	C
	JR	Z,CNEW3
	LD	A,M
	DEC	HL
	CPDR
	JR	NZ,CNEW3
	INC	HL
	LD	M,SD.SPACE
E1.CNEW3:
	CALL	ISPOS
	JR	C,CNEW1
	CALL	SPOSN
	CALL	SY.DEL2
	LD	A,(SM.SMIN)
	DEC	A
	LD	(SM.SPOS),A
E1.CNEW1:
	CALL	IZPOS
E1.CNEW2:
	CALL	C,DZPOS
	CALL	C,LIFT
	CALL	ZNUM
	RET

;1.Bildzeile umladen

E1.UMLZ1:
	LD	BC,(SM.SPANZ)
	LD	B,0
	CALL	UMLT
	LD	(SM.WINA),HL
E1.ZEINR:
	LD	BC,SD.TPA
	CALL	LANG
	CALL	ZNX2
	LD	(SM.ZEIZ),DE
	RET

E1.LIFT:
	CALL	UMLZ1
	LD	A,(SM.ZMAX)
E1.LIFT1:
	DEC	A
	CALL	BIL1
	PUSH	HL
	POP	BC
	CALL	DESZ
	PUSH	DE
	EX	DE,HL
	LD	DE,SD.BWSA
	ADD	HL,DE	;HL=BWSA+(SPANZ)
	LDIR
	POP	BC
	LD	B,C
	EX	DE,HL
	CALL	DEL1
	RET

;Bildpuffer loeschen

E1.LOEBP:
	CALL	BIL
E1.LOBP1:
	LD	BC,SD.BWSA-SD.BPA-1
	ADD	HL,BC
	PUSH	HL
	POP	BC
	JR	PULO
E1.PUFLO:
	LD	BC,SD.BWSA-SD.BPA-1
E1.PULO:
	LD	HL,SD.BPA
	LD	M,SD.SPACE
	LD	DE,SD.BPA+1
	LDIR
	RET

;BWS Laenge

E1.BIL:
	LD	A,(SM.ZMAX)
E1.BIL1:
	LD	HL,0
	CALL	SY.AMSZ
	RET		;HL=Laenge   BC,DE unveraendert

;Leerzeile einfuegen

E1.LEERZ:
	LD	HL,SM.ZPOS
	XOR	A
	OR	M
	RET	Z
	DEC	M
	PUSH	AF
	CALL	UMLZ1
	POP	AF
	JR	NZ,LIFT1
	LD	A,(SM.SPANZ)
	LD	HL,SD.BWSA
	JP	SY.DEL2

;Tabulator Aufruf

E1.TAB:
	CALL	TAUP
	JR	NC,TAB1
	LD	A,M
	LD	HL,(SM.SMAX)
	CP	L
	JR	NC,TAB1
E1.TAB2:
	LD	(SM.SPOS),A
	RET	Z
	CALL	RUFTF
	RET	NZ
	LD	A,SD.TAB
	JP	ZSCH1

E1.TAB1:
	LD	A,(SM.SMIN)
	DEC	A
	JR	TAB2

E1.TAUP:
	LD	A,(SM.SPOS)
E1.TAUP2:
	LD	HL,SM.TABZ
	LD	B,SD.TABZA
E1.TAUP1:
	CP	M
	RET	C	;CY=1: gefunden
	INC	HL
	DJNZ	TAUP1
	RET

;Tabulator setzen

E1.TABS:
	CALL	TAUP
	JR	C,TABS1
	DEC	HL
	INC	B
E1.TABS1:
	DJNZ	TABS3
	LD	M,A
	RET
E1.TABS3:
	LD	C,A
	LD	A,SD.TABZA
	CP	B
	LD	A,C
	JR	Z,TABS4
	DEC	HL
	CP	M
	RET	Z
E1.TABS4:
	LD	C,B
	LD	B,0
	ADD	HL,BC
	PUSH	HL
	POP	DE
	INC	DE
	LDDR
	LD	(DE),A
	RET

;Tabulator loeschen

E1.TABL:
	CALL	TAUP
	JR	C,TABL1
	DEC	HL
	CP	M
	RET	NZ
	LD	M,-1
	RET
E1.TABL1:
	LD	C,A
	LD	A,SD.TABZA
	CP	B
	RET	Z
	LD	A,C
	DEC	HL
	CP	M
	RET	NZ
	LD	C,B
	LD	B,0
	PUSH	HL
	POP	DE
	INC	HL
	LDIR
	LD	A,-1
	LD	(DE),A
	RET

;Cursor Funktionen

E1.TCNRS:
	CALL	CNRS
	JR	TCUR
E1.TCNLS:
	CALL	CNLS
	JR	TCUR
E1.TCNOS:
	CALL	CNOS
	JR	TCUR
E1.TCNUS:
	CALL	CNUS
	JR	TCUR
E1.TCNZA:
	CALL	IFKT2
	JR	TCUR
E1.THOME:
	CALL	IFKT1
E1.TCUR:
	CALL	ZNUM
	RET

;Anzahl der NL zwischen BWSA und ZLPOS

E1.BIZA:
	CALL	SY.ZLPOS
	INC	HL
	LD	BC,SD.BWSA
	CALL	LANG
	CALL	ZNX2
	DEC	DE	;DE=NL Anzahl
	RET

;Zeilennummer ausschreiben

E1.ZNUM:
	CALL	BIZA
	LD	HL,(SM.ZEIZ)
	ADD	HL,DE
	JR	NUM1
E1.NUM:
	LD	HL,(SM.ZEIZ)
E1.NUM1:
	LD	BC,-13
	LD	A,(SM.ZANZ)
	LD	DE,ZS12
	JP	MELDN

;Absatz einfuegen

E1.ABS:
	CALL	REPEL
	CALL	SY.CPOS
	LD	M,SD.NL
	LD	A,0
	LD	(SM.ZSMER),A
	LD	HL,SM.STAT
	SET	4,M
	JP	TEXL

;Zeichen rechts von Cursor heranziehen

E1.ATTR:
	CALL	SY.CPOS
	LD	IX,RNL
	LD	M,SD.SPACE
E1.ATTR1:
	CALL	SPOSN
	DEC	A
	RET	Z
	LD	C,A
	LD	B,0
	CALL	MX
	LD	HL,SM.ZSMER
	LD	M,1
	RET

;Zeichen rechts von Cursor wegschieben

E1.REPEL:
	CALL	ZENDF
	LD	A,M
	CP	SD.SPACE
	RET	NZ
	LD	IX,RNR
	JR	ATTR1

;Zeile loeschen

E1.DELZ:
	CALL	DELZL
	CALL	IZPOS
	CALL	C,DZPOS
	CALL	ZNUM
	RET

;Aufruf programmierter Textelemente

E1.PTS1:	NOP
E1.PTS2:	NOP
E1.PTS3:	NOP
E1.PTS4:	NOP
E1.PTS5:	NOP
E1.PTS6:	NOP
E1.PTS7:	NOP
E1.PTS8:	NOP
E1.PTS9:	NOP
E1.PTS10:	NOP
E1.PTS11:	NOP
E1.PTS12:	NOP
E1.PTS13:	NOP
E1.PTS14:	NOP
E1.PTS15:	NOP
E1.PTS16:	NOP
E1.PTS17:	NOP
E1.PTS18:	NOP
E1.PTS19:	NOP
E1.PTS20:	NOP
E1.PTS21:	NOP
E1.PTS22:	NOP
E1.PTS23:	NOP
E1.PTS24:	NOP
E1.PTS25:	NOP
E1.PTS26:	NOP
E1.PTS27:	NOP
E1.PTS28:
	LD	DE,PTS1-1
	OR	A
	SBC	HL,DE
	CALL	PTSNR
	RET	C
	RET	PO
E1.PTS92:
	XOR	A
	OR	M
	RET	Z
	PUSH	HL
	CP	SD.NL
	JR	Z,PTS91
	CALL	ZSCH1
	JR	PTS93
E1.PTS91:
	LD	C,A
	CALL	CNEW
E1.PTS93:
	POP	HL
	INC	HL
	JR	PTS92

E1.PTSNR:
	EX	DE,HL
	LD	BC,(SM.PTSA)
	LD	HL,(SM.PTSE)
	CALL	LANG
	RET	C
	XOR	A
E1.PTSN1:
	DEC	E
	JR	Z,PTSN2
	CPIR
	RET	PO
	JR	PTSN1
E1.PTSN2:
	XOR	A
	RET		;P/V=1

E1.PTEST:
	LD	BC,(SM.PTS)
	LD	HL,(SM.PTSA)
	XOR	A
	SBC	HL,BC
	RET
E1.PS:
	CALL	PTEST
	JR	Z,PS1
	LD	(SM.PTSA),BC
	LD	HL,SD.RAM+3FFH
	XOR	A
	SBC	HL,BC
	PUSH	BC
	EX	(SP),HL
	POP	BC
E1.PS2:
	LD	E,SD.PSANZ+1
	CALL	PTSN1
	LD	(SM.PTSE),HL
	RET
E1.PS1:
	LD	HL,PFT1
	LD	(SM.PTSA),HL
	LD	BC,3FFH
	JR	PS2

E1.GS:
	LD	A,1DH
E1.GS1:
	JP	ZSCH1
E1.HT:
	LD	A,9
	JR	GS1
E1.CA:
	LD	A,18H
	JR	GS1
E1.UND:
	LD	A,26H
	JR	GS1
E1.DOL:
	LD	A,24H
	JR	GS1
E1.SCHW:
	LD	A,40H
	JR	GS1

			;Stand: 30.Januar 85 - K EAW/wfvm..MSH

;	END
	TITLE 'EDITOR --- Textaufruf'
	PAGE
;	PN	E201
;****************************************************************
;*                  DEG2000  V. 1.2   EDITOR --- Textaufruf     *
;*  Version         --------------------------------------------*
;*                  Programmierer: M. Herbote  K EAW  ZFT (WFT) *
;*  V 1 . 2         --------------------------------------------*
;*                  Stand        : 30.Januar 1985               *
;****************************************************************
E2.TEXV:
	LD	HL,SM.STAT
	SET	7,M
	JR	TEXS
E2.TEXR:
	LD	HL,SM.STAT
	RES	7,M
E2.TEXS:
	LD	A,1
	LD	(SM.ZSMER),A
E2.TEXL:
	CALL	UML
	CALL	LOEBP
	LD	DE,(SM.END)
	LD	HL,(SM.PTS)
	OR	A
	SBC	HL,DE
	JR	C,ERR99
	LD	DE,5000
	SBC	HL,DE
	CALL	C,TEXW
E2.TEX:
	CALL	QLANG
	RET	C
	CALL	TEXV1
	PUSH	HL
	POP	BC	;BC=WINE
	CALL	LANG1
	CALL	NC,SET
	CALL	C,RESET
	CALL	SY.CPOS
	PUSH	HL
	XOR	A
	LD	(SM.ZPOS),A
E2.TEXV3:
	LD	BC,(SM.WINE)
	CALL	LANG1
	JR	C,TEXV2
	CALL	RUFT	;Zeilenaufruf
	LD	HL,SM.ZPOS
	INC	M
	LD	A,(SM.ZMAX)
	DEC	A
	CP	M
	JR	NC,TEXV3
E2.TEXV2:
	POP	HL
	CALL	SY.LCPOS	;Cursor einsetzen
	CALL	ZNUM
	RET

E2.TEXW:
	ADD	HL,DE	;Warnung Speicher voll
	LD	DE,ZS13
	LD	A,(SM.ZANZ)
	LD	BC,-22
	JP	MELDE

E2.RESET:
	LD	HL,1
	LD	(SM.ZEIZ),HL
	LD	HL,SD.TPA
E2.SET:
	LD	(SM.WINA),HL
	LD	(SM.WINE),HL
	RET

E2.ERR99:
	LD	C,99	;Speicherueberlauf
	JR	ERR5A
E2.ERR7A:
	LD	C,7	;Zeichenkette nicht vorhanden
	JR	ERR5A
E2.ERRO5:
	LD	C,5	;Zeilennummer zu gross
E2.ERR5A:
	JP	ERRR

E2.TEX0:
	PUSH	HL
	LD	HL,SM.STAT
	RES	4,M
	LD	HL,(SM.ZEIZ)
	LD	DE,(SM.BZA)
	LD	D,0
	ADD	HL,DE
	JR	ZNR2

E2.TEXV1
:	LD	A,(SM.STAT)	;pruefen Statusbits
	BIT	4,A
	JR	NZ,TEX0
	BIT	3,A
	JR	NZ,NZEI
	BIT	2,A
	JP	NZ,MRK
	BIT	1,A
	JR	NZ,ZNR
	BIT	7,A
	JR	Z,SPR
	LD	HL,(SM.WINE)
	PUSH	HL
	LD	BC,(SM.WINA)
	CALL	LANG
	CALL	ZNX2
	LD	HL,(SM.ZEIZ)
	ADD	HL,DE
	LD	(SM.ZEIZ),HL
	POP	HL
	RET

E2.SPR:
	LD	DE,(SM.ZMAX)
	LD	D,0
	JR	NZEI8

E2.ZNR:
	LD	A,1
	LD	(SM.STAT),A
	PUSH	HL
	LD	HL,(SM.ZEIZ)
E2.ZNR2:
	CALL	NKORR
	EX	DE,HL
	POP	HL
	CALL	ZNR1
	JP	PO,ERRO5
	RET

E2.ZNR1:
	DEC	DE	;BC=Textlaenge
E2.ZNR0:
	LD	A,D	;HL=Textanfang
	OR	E
	RET	Z
	LD	A,1EH
	CPIR
	RET	PO
	JR	ZNR1	;HL=WINE neu

E2.NZEI:
	LD	DE,(SM.WEITE)	;+/- n Zeilen
E2.NZEI8:
	LD	BC,(SM.ZEIZ)
	LD	HL,(SM.BZA)
	LD	H,0
	ADD	HL,BC
	BIT	7,A
	JR	NZ,NZEIV
	SCF
	SBC	HL,DE
	INC	HL
	JR	NC,NZEIR
	EX	DE,HL
E2.NZEI7:
	PUSH	DE
	CALL	ZNUMX
	POP	HL
	ADD	HL,DE	;HL<=0!
	LD	(SM.ZEIZ),HL
	EX	DE,HL
E2.NZEI6:
	CALL	QLANG
	CALL	ZNR1
	RET

E2.NZEIV:
	ADD	HL,DE
	PUSH	HL
	PUSH	BC
	CALL	ZNUMX
	POP	BC
	POP	HL
	OR	A
	SBC	HL,DE
	JP	NC,RESET
	ADD	HL,DE
E2.NZEIR:
	CALL	NKORR
	OR	A
	SBC	HL,BC
	EX	DE,HL	;DE=Weite
	LD	HL,(SM.WINA)
	RET	Z
	JR	C,NZEI4
	PUSH	HL
	POP	BC
	CALL	LANG1
	RET	C
	CALL	ZNR0
	RET

E2.NZEI4:
	LD	BC,SD.TPA
	CALL	LANG
	JR	C,NZEI7
	ADD	HL,BC
	DEC	HL
	INC	BC
E2.NZEI1:
	LD	A,1EH
	CPDR
	JR	NZ,NZEI3
	LD	A,D
	OR	E
	INC	DE
	JR	NZ,NZEI1
E2.NZEI3:
	INC	HL
	INC	HL
	RET

E2.NKORR:
	LD	DE,(SM.ZPOS)
	LD	D,0
	SCF
	SBC	HL,DE
	INC	HL
	JR	NC,NKOR1
	ADD	HL,DE
	LD	A,L
	DEC	A
	LD	(SM.ZPOS),A
	LD	HL,1
E2.NKOR1:
	LD	(SM.ZEIZ),HL
	RET

E2.QLANG:
	LD	BC,SD.TPA
E2.LANG1:
	LD	HL,(SM.END)
E2.LANG:
	SCF		;HL=Q.Ende  BC=Q.Anfang
	SBC	HL,BC
	INC	HL
	PUSH	BC
	EX	(SP),HL
	POP	BC	;BC=Q.Laenge   HL=Q.Anfang
	RET		;CY=1 falls BC<=0

E2.SUCH:
	LD	DE,SM.ZKA
	LD	A,(DE)
	CPIR
	SCF
	RET	PO
	PUSH	HL
	DEC	HL
E2.SC1:
	PUSH	BC
	LD	A,(SM.LZA)
	LD	B,A
	CALL	VERGL
	SCF
	CCF
	POP	BC
	POP	HL	;CY=1 Fehler
	RET		;CY=0 Z=1 falls Zeichenkette gefunden

E2.SUCHR:
	LD	DE,SM.ZKA
	LD	A,(DE)
	CPDR
	SCF
	RET	PO
	PUSH	HL
	INC	HL
	JR	E2.SC1

E2.MARKR:
	CALL	LANG1
	JR	C,MRKR1
	LD	DE,(SM.BZA)
	LD	D,0
	CALL	ZNR0
E2.MRKR1:
	LD	BC,SD.TPA
	CALL	LANG
	JR	C,MRKR4
	ADD	HL,BC
	DEC	HL
	INC	BC
E2.MRKR3:
	CALL	SUCHR
	JR	C,MRKR4
	JR	NZ,MRKR3
	INC	HL
	JR	MRK2
E2.MRKR4:
	CALL	QLANG
	ADD	HL,BC
	DEC	HL
	INC	BC
E2.MRKR2:
	CALL	SUCHR
	JP	C,ERR7A
	JR	NZ,MRKR2
	INC	HL
	JR	MRK2

E2.MRK:
	LD	BC,(SM.WINA)
	BIT	7,A
	JR	Z,MARKR
	CALL	LANG1
	JR	C,MRK4
	LD	DE,(SM.BZA)
	LD	D,0
	INC	E
	CALL	ZNR0
	JP	PO,MRK4
E2.MRK3:
	CALL	SUCH
	JR	C,MRK4
	JR	NZ,MRK3
	DEC	HL
	JR	MRK2
E2.MRK4:
	CALL	QLANG
E2.MRK1:
	CALL	SUCH
	JP	C,ERR7A
	JR	NZ,MRK1
	DEC	HL
E2.MRK2:
	LD	BC,SD.TPA
	INC	HL
	CALL	LANG
	PUSH	HL
	PUSH	BC
	CALL	ZNX2
	EX	DE,HL
	CALL	NKORR
	EX	DE,HL
	POP	BC
	POP	HL
	CALL	ZNR1
	RET

E2.ZNUMX:
	CALL	QLANG
E2.ZNX2:
	LD	A,1EH
	LD	DE,0
	RET	C
E2.ZNX1:
	INC	DE
	CPIR
	RET	PO	;DE=Zeilenanzahl, HL=(END)
	JR	ZNX1

;TEXTAUFRUF AUS TEXTPUFFER

E2.RUFTF:
	LD	A,(SM.FSTAT)
	CP	80H
	RET

E2.RUFT:
	LD	A,(SM.SMIN)	;HL=WINE  BC=Laenge
	DEC	A
	LD	(SM.SPOS),A
	CALL	SPOSN
	INC	B
	DEC	B
	JR	NZ,RUF5
	CP	C
	JR	C,RUF5
	LD	A,C
E2.RUF5:
	LD	C,A
	LD	B,0
	PUSH	HL
	LD	A,SD.NL
	LD	E,C
	CPIR
	JR	Z,RUF3
	DEC	HL
	LD	C,E
	CALL	RUFTF
	JR	Z,RUFQ2
	LD	A,SD.SPACE
	CPDR
	JR	Z,RUF2
	LD	C,E
	DEC	C
	JR	NZ,$+3
	INC	C
	POP	HL
	CALL	RUF1
	LD	A,SD.NL
	LD	(DE),A
	RET
E2.RUF2:
	JP	PO,RUF6
	CPD
	JR	Z,RUF2
	INC	HL
	INC	BC
E2.RUF6:
	INC	HL
	LD	M,SD.NL
	INC	BC
	POP	HL
	JR	RUF1

E2.RUF3:
	LD	A,E
	SUB	C
	LD	C,A
	POP	HL
	CALL	RUFTF
	JR	Z,RUFQ
E2.RUF1:
	EX	DE,HL
	CALL	SY.CPOS
	EX	DE,HL
E2.RUF4:
	LDIR
	LD	(SM.WINE),HL
	RET

E2.RUFQ4:
	INC	DE
E2.RUFQ3:
	CALL	SY.CPOS
	LD	B,3
E2.RUFQ5:
	LD	M,'$'
	INC	HL
	DJNZ	RUFQ5
	INC	HL
	CALL	SPOSN
	SUB	5
	CP	C
	JR	NC,$+3
	LD	C,A
	EX	DE,HL
	CALL	KOMZ3
	LD	M,'$'
	JP	KOMZ4

E2.RUFQ1:
	CALL	SY.CPOS
	EX	DE,HL
	INC	C
	JP	KOMTR

E2.RUFQ2:
	POP	DE
	LD	A,(DE)
	CP	3BH
	JR	Z,RUFQ1
	CP	'$'
	JR	Z,RUFQ4
	LD	A,3BH
	PUSH	BC
	CPDR
	POP	BC
	JR	NZ,RUFQ3
	EX	DE,HL

E2.RUFQ:
	LD	B,C	;Quellkodeaufruf und Sortieren
	CALL	SY.SZEI4
	JR	Z,OP1
	LD	C,B
	LD	B,0
	CP	'$'
	JP	Z,RUF1
	CP	3BH
	JP	Z,RUF1
	PUSH	HL
	LD	A,3BH
	LD	E,C
	CPIR		;allgemeiner Kommentar ?
	CALL	Z,E2.KOM
	POP	HL	;Marke ?
	PUSH	HL
	LD	C,E
	LD	A,':'	;Doppelpunkt-Suche
	CPIR
	POP	HL
	JR	NZ,OPCO	;Sprung, falls keine Marke
E2.MARK:
	LD	A,E
	SUB	C	;Markenlaenge einstellen
	LD	C,A
	PUSH	HL
	PUSH	BC
	LD	A,27H	;Literalsuche
	CPIR
	POP	BC
	POP	HL
	JR	Z,OPCO	;keine Marke falls Literal
	CALL	POSI0
	LDIR
	CALL	SY.SZEI4
E2.OPCO:
	LD	A,(SM.TABZ+1)
	CALL	POSIT
E2.OP2:
	LD	A,M
	CP	SD.SPACE
	JR	Z,OPRD
	LDI
	CP	SD.NL
	JR	NZ,OP2
E2.OP1:
	LD	(SM.WINE),HL
	RET

E2.OPRD:
	LD	A,(SM.TABZ+2)
	CALL	POSIT
	CALL	SY.SZEI2
E2.OP3:
	CP	3BH	;Semikolon
	RET	Z
	LDI
	CP	SD.NL
	JR	Z,OP1
	CP	27H
	LD	A,M
	JR	NZ,OP3
E2.OP4:
	LDI
	CP	27H
	LD	A,M
	JR	Z,OP3
	JR	OP4

E2.KOM:
	PUSH	HL
	PUSH	BC
	LD	A,E
	SUB	C
	LD	C,A
	LD	A,27H
	DEC	HL
	CPDR
	JR	NZ,KOM3
	CPDR
	JR	Z,KOM3
	POP	BC
	POP	HL
	LD	A,3BH
	CPIR
	RET	NZ
E2.KOM3:
	POP	BC
	POP	HL
	LD	A,E
	SUB	C
	LD	E,A
	PUSH	DE
	INC	BC
	DEC	HL
	LD	A,(SM.TABZ+3)
	CALL	POSIT
	CALL	KOMTR
	POP	DE
	RET

E2.KOMTR:
	CALL	SPOSN
	SUB	C
	JP	NC,RUF4
	ADD	A,C
	DEC	A
	LD	C,A
	PUSH	BC
	PUSH	HL
	ADD	HL,BC
	LD	A,SD.SPACE
	CPDR
	POP	HL
	CALL	Z,KOMZ2
	POP	BC
	CALL	NZ,KOMZ3
	LD	M,3BH
E2.KOMZ4:
	LD	A,SD.NL
	LD	(DE),A
	LD	(SM.WINE),HL
	RET

E2.KOMZ2:
	INC	BC
	LDIR
	RET

E2.KOMZ3:
	LDIR
	DEC	HL
	RET

E2.POSI0:
	LD	A,(SM.TABZ)
E2.POSIT:
	LD	(SM.SPOS),A
	EX	DE,HL
	CALL	SY.CPOS
	EX	DE,HL
	RET

E2.UML:
	CALL	BIZA
	LD	A,E
	LD	(SM.BZA),A
	CALL	BIL
E2.UMLT1:
	PUSH	HL
	POP	BC
E2.UMLT:
	LD	HL,SD.BWSA
	LD	DE,SD.BPA
	PUSH	DE
	CALL	UMLBT	;Komprimieren
	POP	HL
	EX	DE,HL
	OR	A
	SBC	HL,DE
	PUSH	HL	;HL=Laenge
	CALL	UMLAD
	POP	BC
	LD	HL,SD.BPA
E2.UMLA:
	LD	DE,(SM.WINA)
	LD	A,B
	OR	C
	JR	Z,UMLE
	LDIR
E2.UMLE:
	EX	DE,HL
	LD	(SM.WINE),HL
	RET

E2.UMLAD:
	LD	BC,(SM.WINA)	;HL=Laenge Text im BPUF
	ADD	HL,BC	;HL=WINE neu
	PUSH	HL
	LD	DE,(SM.WINE)
	OR	A
	SBC	HL,DE	;CY=1 falls WINE neu < alt
	POP	HL
	RET	Z
	PUSH	HL
	PUSH	AF
	LD	HL,(SM.END)
	SCF
	SBC	HL,DE
	INC	HL
	JR	NC,UMLC	;HL=Laenge Q.Rest
	POP	AF
	POP	HL
	LD	(SM.END),HL
	RET
E2.UMLC:
	POP	AF
	PUSH	HL
	POP	BC	;BC=Laenge Q.Rest
	POP	HL	;HL=WINE neu
	JR	C,UMLR
	ADD	HL,BC	;Luecke vergroessern
	EX	DE,HL	;DE=END neu
	LD	HL,(SM.END)
	LD	(SM.END),DE
	INC	BC
	LDDR
	RET
E2.UMLR:
	EX	DE,HL	;DE=WINE neu   HL= alt
	LDIR
	LD	(SM.END),DE
	RET

E2.UMLBT:
	LD	A,B
	OR	C
	RET	Z
	LD	A,(SM.FSTAT)
	CP	80H
	JR	Z,UML1
E2.UMLF:
	PUSH	BC
	EX	(SP),HL	;HL=Laenge (SP)=Quelle
	LD	BC,(SM.SPANZ)
	LD	B,0
	CALL	DIV	;A=Zeilenazahl  BC=Zeilenlaenge
	POP	HL	;HL=Quelle
E2.UMLF0:
	PUSH	AF
	PUSH	BC
	PUSH	HL
	LD	B,C
	CALL	SY.SZEI4	;Z=1 wenn nur space
	JR	Z,UMLF1
	LD	BC,(SM.SMIN)
	LD	B,0
	DEC	C
	POP	HL
	PUSH	HL
	ADD	HL,BC
	PUSH	AF
	LD	A,(SM.SMAX)
	SUB	C
	LD	C,A
	POP	AF
	CALL	UMLFR
E2.UMLF1:
	POP	HL
	POP	BC
	ADD	HL,BC
	POP	AF
	DEC	A
	JR	NZ,UMLF0
	RET

E2.UMLF2:
	LD	A,SD.SPACE
	CPI
	RET	PO
	JR	Z,UMLF2
	DEC	HL
	INC	BC
E2.UMLF3:
	LD	A,M
	LDI
	RET	PO
E2.UMLFR:
	CP	SD.NL
	JR	NZ,UMLF3
	JR	UMLF2

E2.UML1:
	LD	A,SD.SPACE	;Komprimieren
	CPI
	RET	PO
	JR	Z,UML1
	DEC	HL
	INC	BC
	LD	A,M	;kein space
	CP	SD.NL	;NL ?
	JR	Z,UML2
	CP	27H	;Literal ?
	JR	Z,UML4
	CP	3BH	;Semikolon ?
	JR	Z,UML5
E2.UML6:
	LDI		;Text uebertragen mit nachgestelltem SP
	RET	PO
	LD	A,SD.SPACE
	CP	M
	JR	NZ,UML1
E2.UML2:
	LDI		;Text uebertragen ohne nachgestelltes SP
	RET	PO
	JR	UML1
E2.UML4:
	LDI
	RET	PO
	LD	A,27H
	CP	M
	JR	NZ,UML4
	JR	UML6
E2.UML5:
	LDI
	RET	PO
	LD	A,1EH
	CP	M
	JR	NZ,UML5
	JR	UML2

			;Stand: 30.Januar 85 - K EAW/wfvm..MSH


;	END
	TITLE 'EDITOR --- Kommandointerpreter'
	PAGE
;	PN	E301
;****************************************************************
;*                  DEG2000 V.1.2   EDITOR --- Kommandointerpr. *
;*  Version         --------------------------------------------*
;*                  Programmierer: M. Herbote  K EAW  ZFT (WFT) *
;*  V 1 . 2         --------------------------------------------*
;*                  Stand        : 30.Januar 1985               *
;****************************************************************
E3.KOMAN:
	CP	'Z'	;(HL)=A=1.Kommandozeichen
	JP	Z,ZET	;B=Zaehler
	CP	'T'
	JP	Z,TAUS
	CP	'Y'
	JP	Z,STAN
	CP	'X'
	JP	Z,LESE
	CP	'M'
	JP	Z,MOVE
	CP	'N'
	JP	Z,NEUST
	CP	'P'
	JP	Z,PTSL
	CP	'E'
	JR	NZ,ERRO2
	CALL	RESET
	JP	SY.SYSTB
E3.ERRO2:
	LD	C,2	;KOMMANDO FALSCH
E3.FEHL:
	CALL	SY.LCPOS
E3.FEHL1:
	JP	ERRR

;Kommando       Statusbyte     Bedeutung
;  Z                1          fortlaufend  Blaettern
;  Z n              2          ab Zeile  n  Blaettern
;  Z '...'          4          ab naechster Zeichenkette
;  Z +n             8          ab Zeilenstand  +n
;  Z +              8          ''      ''      +1
;  Z*....       wie oben       wie oben ab Zeile 1 geginnend
;  T '..' '..'   ''  ''+10H    Tausch von Zeichenketten
;  Y ....        ''  ''  ''    Stanzen
;  M ....        ''  ''  ''    Verschieben


E3.ZET:
	EX	DE,HL
	LD	HL,SM.STAT	;DE=Anfang Rest Kommando
	LD	M,1
	CALL	SUZEI
	RET	Z
	CP	'*'
	JR	NZ,E3.Z1
	CALL	RESET
	XOR	A
	LD	(SM.BZA),A
	CALL	SUZEI
	RET	Z	;Blaettern ab #
E3.Z1:
	CALL	IDH
	JR	C,Z4
	JR	Z,ERRO3
E3.ZET1:
	LD	A,2
	LD	(SM.STAT),A
E3.Z3:
	LD	(SM.ZEIZ),HL
	RET
E3.Z4:
	CP	'+'
	JR	NZ,ZEIK
	LD	A,8
	LD	(SM.STAT),A
	LD	HL,1
E3.PL3:
	CALL	SUZA
	JR	C,ERRO3
	LD	(SM.WEITE),HL
	RET

E3.ERR3A:
	POP	AF
E3.ERRO3:
	LD	C,3	;falsche Zahleneingabe
	EX	DE,HL
	JP	FEHL

E3.ZEIK:
	LD	HL,SM.STAT
	LD	M,4
	PUSH	DE
	POP	HL
E3.ZEIKA:
	CALL	KETTE
	JR	C,ERRO4
	JR	Z,ERRO4
E3.ZEIKC:
	LD	HL,SM.LZA
E3.ZEIKB:
	EX	DE,HL
	LD	(DE),A
	INC	DE
	INC	HL
	LD	B,0
	LD	C,A
	LDIR
	RET

E3.ERRO4:
	LD	C,4	;falsch eingegebene Zeichenkette
	JP	FEHL1

E3.TAUS:
	CALL	SY.SZEI2
	RET	Z
	PUSH	HL
	POP	DE
	CALL	KETTE
	JR	C,ERRO4
	JR	Z,ERRO4
	PUSH	BC
	CALL	ZEIKC
	POP	BC
	CALL	SY.SZEI2
	JR	Z,TAU3
	PUSH	HL
	POP	DE
	CALL	KETTE
	JR	C,ERRO4
E3.TAU3:
	LD	HL,SM.LZN
	LD	M,0
	JR	Z,TAU6
	LD	M,A
	INC	DE
	LD	(SM.ZKN),DE
E3.TAU6:
	CALL	QLANG
E3.TAU4:
	CALL	NC,SUCH
	JR	C,ERRO7
	JR	NZ,TAU4
E3.TAU1:
	CALL	Z,EXCH
	CALL	NC,SUCH
	JR	NC,TAU1
E3.TAU2:
	LD	HL,SM.STAT
	BIT	2,M
	JR	Z,TAU5
	LD	M,1
E3.TAU5:
	SET	4,M
	RET

E3.ERRO7:
	LD	C,7	;Zeichenkette nicht vorhanden
	JP	FEHL

E3.EXCH:
	DEC	HL
	LD	(SM.WINA),HL
	LD	BC,(SM.LZA)
	LD	B,0
	ADD	HL,BC
	LD	(SM.WINE),HL
	LD	HL,(SM.LZN)
	LD	H,B
	PUSH	HL
	CALL	UMLAD
	POP	BC
	LD	HL,(SM.ZKN)
	CALL	UMLA
	PUSH	HL
	POP	BC
	JP	LANG1

E3.NEUST:
	CALL	RESET
	LD	(SM.END),HL
E3.NEU1:
	CALL	NUM
	LD	A,1
	LD	(SM.STAT),A
	LD	HL,(SM.ZMIN2)
	DEC	H
	DEC	L
	LD	(SM.ZPOS2),HL
	RET

E3.LESE:
	CALL	SY.SZEI2
	JR	Z,LESE1
	CP	'*'
	JP	NZ,ERRO2
	CALL	NEUST
E3.LESE1:
	CALL	ZNUMX	;HL=(END)
	PUSH	DE
	CALL	LESER
	POP	HL
	INC	HL
	JP	ZET1

E3.STAN:
	EX	DE,HL
E3.STAN2:
	CALL	SUZA
	JR	NZ,STAN1
	LD	DE,SD.TPA	;DE=Anfang
E3.STAN3:
	LD	HL,(SM.END)	;HL=Ende
E3.STAN6:
	DEC	HL
	CALL	STANZ
	JR	TAU2
E3.STAN1:
	JP	C,ERRO3
	PUSH	BC
	PUSH	DE
	EX	DE,HL
	CALL	QLANG
	JR	C,ERR5C
	CALL	ZNR1	;HL=Startadresse
	POP	DE	;DE=KOZEIposition
	POP	BC
	JP	PO,ERR5B
E3.STAN5:
	PUSH	HL
	CALL	SUZA
	JR	C,STAN1
	POP	DE	;DE=Startadresse
	JR	Z,STAN3
	PUSH	DE
	INC	HL
	EX	DE,HL
	CALL	QLANG
	CALL	ZNR1
	POP	DE
	JP	PO,STAN3
	JR	STAN6

E3.ERR5C:
	POP	DE
E3.ERR5B:
	EX	DE,HL
	LD	C,5	;Zeilennummer zu gross
	JP	FEHL

E3.ERRO8:
	EX	DE,HL
	LD	C,8	;Zeilennummer zu klein
	JP	FEHL

E3.MOVE2:
	CALL	SUZA
	JP	C,ERR3A
	RET	NZ
	LD	A,(SM.SMIN)
	DEC	A
	LD	(SM.SPOS),A
	POP	AF	;SP korrigieren
E3.ERR2A:
	EX	DE,HL
	JP	ERRO2

E3.MOVE:
	EX	DE,HL
	CALL	MOVE2
	LD	(SM.LZN-2),HL
	INC	HL
	LD	(SM.LZN-4),HL
	CALL	MOVE4
	JR	Z,ERR2A
	CP	'>'
	JR	Z,MOVE1
	CALL	SUZA1
	JP	C,ERRO3
	INC	HL
	LD	(SM.LZN-4),HL
	PUSH	BC
	LD	BC,(SM.LZN-2)
	SBC	HL,BC
	POP	BC
	JR	C,ERRO8
	CALL	MOVE4
	JR	Z,ERR2A
	CP	'>'
	JR	NZ,ERR2A
E3.MOVE1:
	CALL	MOVE2
	LD	(SM.LZN-6),HL
	LD	BC,(SM.LZN-4)
	LD	A,1
	LD	(SM.LZN-7),A
	SBC	HL,BC
	ADD	HL,BC
	JR	NC,MOVE3
	LD	BC,(SM.LZN-2)
	XOR	A
	SBC	HL,BC
	JR	NC,ERRO8
	LD	(SM.LZN-7),A
E3.MOVE3:
	PUSH	DE
	CALL	QLANG
	JR	C,ERR5C
	LD	DE,(SM.LZN-6)
	CALL	ZNR1
	JP	PO,ERR5C
	CALL	SET	;WINA=WINE=Zielzeile
	CALL	QLANG
	LD	DE,(SM.LZN-2)
	CALL	ZNR1	;HL=Quellanfang
	JP	PO,ERR5C
	EX	(SP),HL
	PUSH	HL
	CALL	QLANG
	LD	DE,(SM.LZN-4)
	CALL	ZNR1	;HL=Quellende
	POP	DE
	JP	PO,ERR5B
	POP	BC
	PUSH	BC
	OR	A
	SBC	HL,BC	;HL=QE-QA
	PUSH	HL
	CALL	UMLAD
	POP	BC
	POP	HL	;HL=QA
	LD	A,(SM.LZN-7)
	OR	A	;Z=1 fuer rueckwaerts
	JR	NZ,MOVEV
	ADD	HL,BC
E3.MOVEV:
	PUSH	HL
	CALL	UMLA
	POP	HL
	LD	(SM.WINA),HL
	LD	(SM.WINE),DE
	LD	HL,0
	CALL	UMLAD
	JP	TAU2
E3.MOVE4:
	CALL	SUZEI
	RET	Z	;Z=1: Fehler
	CP	'-'
	JR	Z,MOVE4
	RET
E3.PTSL:
	XOR	A
	EX	AF,AF'
	LD	IX,SD.RAM
	LD	(IX+0),SD.PSANZ
	EX	DE,HL
	CALL	LT1Z
	JP	Z,ERR2A
	JP	C,ERRO3
	PUSH	BC
	PUSH	DE
	CALL	PTSNR
	POP	DE
	JP	C,ERR5B
	EXX
	LD	HL,(SM.END)
	LD	DE,(SM.WINA)
	LD	BC,(SM.WINE)
	EXX
	LD	(SM.WINA),HL
	JP	PO,PTSL1
	CPIR
E3.PTSL1:
	DEC	HL
	LD	(SM.WINE),HL
	LD	HL,(SM.PTSE)
	LD	(SM.END),HL
	POP	BC
	CALL	SUZEI
	JR	Z,PTER4
	PUSH	DE
	POP	HL
	CALL	KETTE
	JR	Z,PTER4
	JR	C,PTER4
	LD	HL,(SM.END)
	LD	BC,(SM.WINA)
	ADD	HL,BC
	LD	BC,(SM.WINE)
	OR	A
	SBC	HL,BC
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD	BC,0FFFFH
	OR	A
	SBC	HL,BC
	JR	NC,PTER9	;END+WINA-WINE+L < 0FFFFH   ?
	LD	H,0	;                  RAM+400H ?
	LD	L,A
	INC	DE
	PUSH	HL
	PUSH	DE
	CALL	UMLAD
	POP	HL
	POP	BC
	CALL	UMLA
	LD	HL,(SM.END)
	LD	(SM.PTSE),HL
E3.PTEX:
	EXX
	LD	(SM.END),HL
	LD	(SM.WINA),DE
	LD	(SM.WINE),BC
	EXX
	RET
E3.PTER4:
	CALL	PTEX
	JP	ERRO4
E3.PTER9:
	CALL	PTEX
	LD	C,9	;Speicherueberlauf
	JP	FEHL1

E3.ERRR:
	LD	SP,SM.STACK-2
	LD	A,23
	LD	(SM.ZPOS),A
	CALL	ERRO
	JP	MEL11

			;Stand: 30.Januar 85 - K EAW/wfvm..MSH

;	END
	TITLE 'EDITOR --- Peripheriegeraete'
	PAGE
;	PN	E403
;****************************************************************
;*                  DEG2000  V. 1.2   EDITOR --- Peripherieger. *
;*  Version         --------------------------------------------*
;*                  Programmierer: M. Herbote  K EAW  ZFT (WFT) *
;*  V 1 . 2         --------------------------------------------*
;*                  Stand        : 04.Februar 1985              *
;****************************************************************
E4.LESER:
	PUSH	IX
	LD	IX,SM.EALBL
E4.LLQ0:
	CALL	LRLBL
	BIT	0,(IX+3)
	JR	NZ,FERTL
	CP	00AH
	JR	Z,LLQ2
	CP	00DH
	JR	Z,LLQ2
	CP	SD.TAB	;Tabulator
	JR	NZ,LLQ6
	LD	M,SD.SPACE
	CALL	RUFTF
	LD	A,SD.TAB
	JR	NZ,LLQ6
	INC	HL
E4.LLQ6:
	LD	M,A
	CP	M
	JR	NZ,ERR13	;Schreibfehler
	INC	HL
	PUSH	HL
	PUSH	DE
	EX	DE,HL
	LD	HL,(SM.PTS)
	OR	A
	SBC	HL,DE
	LD	DE,2500
	OR	A
	SBC	HL,DE
	POP	DE
	POP	HL
	JR	Z,FERTL	;(PTS)-2500 = akt. Zeiger
	JR	C,FERTL	;(PTS)-2500 < akt. Zeiger
	JR	LLQ0

E4.LLQ2:
	LD	A,1EH
	DEC	HL
	CP	M
	INC	HL
	JR	Z,LLQ0
	JR	LLQ6

E4.ERR13:
	LD	C,13	;Schreibfehler
E4.ERR0:
	PUSH	HL
	CALL	ERRO
	POP	HL
E4.FERTL:
	LD	(SM.END),HL
	POP	IX
	RET


E4.STANZ:
	PUSH	IX	;(DE)=1.-, (HL)=letztes Zeichen
	LD	IX,SM.EALBS
E4.LSQ1:
	LD	A,(DE)
	LD	C,A
	CALL	LRLBS
	OR	A
	SBC	HL,DE
	ADD	HL,DE
	INC	DE
	JR	NZ,LSQ1
	POP	IX
	RET


E4.LEER:
	PUSH	IX
	LD	IX,SM.EALBS
	LD	A,(IX+4)
	PUSH	AF
	LD	(IX+4),00000010B
	PUSH	BC
	LD	BC,08000H	;Ausgabe von 80H mal Zeichen "00H"
	CALL	LRLBS
	DJNZ	$-3
E4.LEER1:
	POP	BC
	POP	AF
	LD	(IX+4),A
	POP	IX
	RET

E4.STEND:
	PUSH	IX	;Ausgabe des LB-Endezeichens  EOF
	LD	IX,SM.EALBS
	LD	A,(IX+4)
	PUSH	AF
	LD	(IX+4),00000010B
	PUSH	BC
	LD	C,(IX+12)
	CALL	LRLBS
	JR	LEER1

	PAGE
;****************************************************************
;*                  Eintragungen in die E/A-Tabellen            *
;****************************************************************
	DW	$
	DB	'ISO '
	LD	IY,SM.EALBL	;E/A-Tabelle   L B L
	LD	HL,0
	EXX
	LD	B,11100110B	;Kommando
	LD	C,07FH	;Parity
	LD	DE,01E1EH	;EOR - Zeichen
	LD	A,019H	;EOF - Zeichen
	LD	HL,0
	CALL	E4.TAB
	EXX
	LD	IY,SM.EALBS	;E/A-Tabelle   L B S
	LD	B,11000100B	;Kommando
	LD	C,080H	;Parity
E4.ISO:
	CALL	E4.TAB
	JP	SY.SYSTB


	DW	$
	DB	'ANW '
	LD	IY,SM.EALBL	;E/A-Tabelle   L B L
	LD	HL,KONV
	EXX
	LD	B,10101110B	;Kommando
	LD	C,0EFH		;Parity
	LD	DE,0801EH	;EOR - Zeichen
	LD	A,081H		;EOF - Zeichen
	LD	HL,SKTBI
	CALL	E4.TAB
	EXX
	LD	IY,SM.EALBS	;E/A-Tabelle   L B S
	LD	B,10101100B	;Kommando
	LD	C,010H	;Parity
	LD	HL,SKTBO
	JR	ISO

E4.TAB:
	LD	(IY+0),D
	LD	(IY+1),E
	LD	(IY+4),B
	LD	(IY+11),C
	LD	(IY+12),A
	LD	(IY+5),L
	LD	(IY+6),H
	EXX
	LD	(IY+19),L
	LD	(IY+20),H
	RET

	PAGE
;****************************************************************
;*                  Kommandos:  V O R _ , E O F _ , M B _ _     *
;****************************************************************
	DW	$
	DB	'VOR '
	CALL	LEER
	JP	SY.SYSTB


	DW	$
	DB	'EOF '
	CALL	STEND
	CALL	LEER
	JP	SY.SYSTB


	DW	$
	DB	'MB  '
E4.MBIF:
	PUSH	BC
	PUSH	IX
	OUT	(SD.AMB),A	;Aktivierung der  A M B
	LD	BC,255
E4.MBIF1:
	DEC	BC		;Warteschleife ca. 1.27 ms
	LD	A,B
	OR	C
	JR	NZ,MBIF1
	LD	IX,SM.EAAMB
E4.MBIF2:
	BIT	0,(IX+0)	;MB-Geraet 1 bzw. 2 ?
	JR	NZ,MBIF3
	BIT	1,(IX+7)	;MB-Geraet 1  besetzt ?
	JR	MBIF4
E4.MBIF3:
	BIT	1,(IX+8)	;MB-Geraet 2  besetzt ?
E4.MBIF4:
	JR	NZ,MBIF2
	POP	IX
	POP	BC
	RET


;LBL	EQU	07000H
;LBS	EQU	07003H
;KONV	EQU	07014H
;SKTBI	EQU	07200H
;SKTBO	EQU	07300H

			;Stand: 04.Februar 85 - K EAW/wfvm..MSH


;	END
