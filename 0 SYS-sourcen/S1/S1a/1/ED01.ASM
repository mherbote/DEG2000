	TITLE	'EDITOR --- Meldephase'
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
	CALL	SY.QTABL
	LD	(SM.PTSA),HL
	LD	B,SD.PSANZ
ED.MEL5:
	LD	M,0
	INC	HL
	DJNZ	ED.MEL5
	LD	(SM.PTSE),HL
	JR	MEL1
ED.MEL2:
	CALL	ED.UMLKP
ED.MEL1:
	CALL	SY.BILO	;Bild loeschen
ED.MEL11:
	CALL	E2.RESET
	CALL	E1.PUFLO	;TP loeschen
	CALL	SY.MEMLA	;Fkt.Tast. u. RAM definieren
	LD	HL,ED.MELNL
	LD	(SM.FKTAB+28H),HL
	LD	HL,0
	LD	(SM.NEWL),HL	;NL--Taste def.
	LD	A,(SM.ZANZ)
	DEC	A
	LD	(SM.ZMIN),A
	LD	(SM.ZMAX),A	;Format: vorletzte Zeile
	CALL	SY.BWSAF
	EX	DE,HL
	LD	HL,ED.ZED1
	CALL	SY.MELD	;Ausschrift
	EX	DE,HL
ED.MEL3:
	CALL	SY.LCPOS
	CALL	SY.KOM	;Format ab CPOS
	CALL	SY.DELZL
	RET

;NL-Funktion in Meldephase

ED.MELNL:
	XOR	A
	LD	(SM.FSTAT),A
	CALL	S1.STANL	;Z=0 falls nur Space
	JR	Z,ED.VOLLF
	CP	'F'
	JR	Z,ED.FREI
	CP	'Q'
	JR	Z,ED.QUELL
ED.ERRO1:
	LD	C,1	;falsche Formatanweisung
	JP	S1.ERROR

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
	JR	ED.KOMA3

ED.FREI:
	EX	DE,HL
	LD	IX,SM.SPANZ
	XOR	A
	EX	AF,AF'
	CALL	S1.LT1Z	;freies Format
	EX	DE,HL	;A<E=<(IX+0) BEI Z=CY=0
	JR	Z,ED.VOLLF
	JR	C,ED.ERRO1
	LD	HL,(SM.ZANZ)
	LD	H,E
	JR	ED.FREI2

;Kommandophase

ED.KOMA1:
	CALL	S1.FOEX	;CPOS + Arb.Form. --> Zweitmerker
	CALL	SY.FKTLA	;RAM neu laden
	LD	HL,ED.MEL2	;Syst.Taste neu
ED.KOMA3:
	LD	(SM.FKTAB+68H),HL
	LD	HL,ED.KONEV
	LD	(SM.FKTAB+28H),HL
	LD	HL,ED.KONER
	LD	(SM.FKTAB+38H),HL
	LD	HL,SM.UMERK
	LD	M,0
	LD	DE,SM.UMERK+1
	LD	BC,SM.LOE1-1
	CALL	SY.RALO1	;volles Format
	LD	A,L
	LD	(SM.ZMIN),A	;Format letzte Zeile
	LD	HL,SY.AEIN
	CALL	SY.MEML1	;NEWL,DELZ,EINA laden
	LD	HL,S1.UMS
	LD	(SM.USCH),HL
	CALL	SY.BWSAF
	JP	ED.MEL3

;Start--Funktion in Kommandophase

ED.KONEV:
	CALL	ED.KOEIN
	LD	HL,SM.STAT
	SET	7,M
	JP	E2.TEX

ED.KONER:
	CALL	ED.KOEIN
	LD	HL,SM.STAT
	RES	7,M
	JP	E2.TEX

ED.KOEIN:
	CALL	ED.UMLKP
	CALL	S1.STANL
	CALL	NZ,E3.KOMAN
ED.ARBPH:
	CALL	S1.FOEX
ED.ARBFK:
	LD	HL,ED.FALFT	;Fkt. fuer Arb.Phase init.
	LD	DE,SM.FKTAB
	LD	BC,80H
	LDIR
	LD	HL,ED.FALAT
	LD	DE,SM.USCH
	LD	BC,12
	LDIR
	RET

ED.UMLKP:
	CALL	S1.FOEX
	CALL	E2.UML
	CALL	E1.LOEBP
	CALL	S1.FOEX
	RET

ED.FALAT:
	DW	S1.UMS	;Fkt.Adressliste Alphatastatur
	DW	E1.TAB
	DW	E1.DELZ
	DW	E1.LEERZ
	DW	E1.CNEW
	DW	E1.ZSCHS

;Funktionsadressliste Funktionstastatur

ED.FALFT:
	DW	E1.PTS1	;S1,Z1
	DW	E1.PTS15
	DW	E1.TABS
	DW	E1.TCNOS
	DW	E1.TCNLS
	DW	E1.PTS9
	DW	E1.PTS23
	DW	0

	DW	E1.PTS2	;S2,Z1
	DW	E1.PTS16
	DW	E1.TABL
	DW	E1.TCNRS
	DW	E1.TCNUS
	DW	E1.PTS10
	DW	E1.PTS24
	DW	0

	DW	E1.PTS3	;S3,Z1
	DW	E1.PTS17
	DW	E1.ABS
	DW	E1.ATTR
	DW	E2.TEXV
	DW	E1.PTS11
	DW	E1.PTS25
	DW	0

	DW	E1.PTS4	;S4,Z1
	DW	E1.PTS18
	DW	E1.PS
	DW	E1.REPEL
	DW	E2.TEXR
	DW	E1.PTS12
	DW	E1.PTS26
	DW	0

	DW	E1.PTS5	;S5,Z1
	DW	E1.PTS19
	DW	E1.GS
	DW	E1.UND
	DW	SY.IFKT3
	DW	E1.PTS13
	DW	SY.IFKT4
	DW	0

	DW	E1.PTS6	;S6,Z1
	DW	E1.PTS20
	DW	E1.HT
	DW	E1.DOL
	DW	0
	DW	E1.PTS14
	DW	0
	DW	0

	DW	E1.PTS7	;S7,Z1
	DW	E1.PTS21
	DW	E1.CA
	DW	E1.SCHW
	DW	ED.KOMA1
	DW	E1.PTS27
	DW	0
	DW	0

	DW	E1.PTS8	;S8,Z1
	DW	E1.PTS22
	DW	E1.THOME
	DW	E1.TCNZA
	DW	S1.PFO1
	DW	E1.PTS28
	DW	0
	DW	0

ED.ZED1:
	DB	LOW(ED.LZED1)
	DB	'EDITOR   FORMAT'
ED.LZED1
	EQU	$-ED.ZED1-1

			;Stand: 30.Januar 85 - K EAW/wfvm..MSH

;	END
