	TITLE	'Systemroutinen  DEG 2000    Version 1.2'
	PAGE
;	PN	S101
;****************************************************************
;*                  Systemroutinen  DEG2000    Version 1.2      *
;*  Version         --------------------------------------------*
;*                  Programmierer: M. Herbote  K EAW  ZFT (WFT) *
;*  V 1 . 2         --------------------------------------------*
;*                  Stand        : 30.Januar 1985               *
;****************************************************************
	DW	$
	DB	'BILD'

	LD	DE,SD.BWSA+327H
	CALL	UC.CVDB
	RET	C
	XOR	A
	CP	H
	RET	NZ
	LD	A,16
	CP	L
	RET	C
	LD	B,L
	PUSH	BC
	LD	HL,SD.TPA
	PUSH	HL
	LD	DE,SD.TPA+1
	LD	(HL),20H
	LD	BC,SD.TPE-SD.TPA-1
	LDIR
	POP	HL
	POP	BC
BI1:
	PUSH	BC
	CALL	STR
	LD	B,20
	LD	DE,78
BI2:
	LD	(HL),7CH
	ADD	HL,DE
	LD	(HL),7CH
	INC	HL
	LD	(HL),1EH
	INC	HL
	DJNZ	BI2
	CALL	STR
	POP	BC
	DJNZ	BI1
	LD	(SM.END),HL
	JP	SY.SYSTB

STR:
	PUSH	HL
	POP	DE
	INC	DE
	LD	BC,79
	LD	(HL),2DH
	LDIR
	LD	(HL),1EH
	INC	HL
	RET

	PAGE
;****************************************************************
;*                  Hardcopy-Tastenfunktion Version 1.1         *
;****************************************************************
S1.COPG:
	PUSH	AF
	PUSH	BC
	PUSH	HL
	LD	B,22		;Anzahl der Zeilen
	LD	C,80		;Anzahl der Spalten
	LD	HL,SD.BWSA	;Bildschirmanfang
	CALL	HCP
	LD	A,1EH
	CALL	PRINT
	CALL	PRINT
	POP	HL
	POP	BC
	POP	AF
	RET

HCP:
	PUSH	AF
	PUSH	BC
	PUSH	DE
	PUSH	HL
	LD	DE,80
M1:
	PUSH	BC
	PUSH	HL
	LD	B,C		;Spaltenanzahl

M2:
	LD	A,(HL)
	CALL	KODE
	CALL	PRINT
	INC	HL
	DJNZ	M2

	LD	A,1EH
	CALL	PRINT
	POP	HL
	ADD	HL,DE
	POP	BC
	DJNZ	M1

	POP	HL
	POP	DE
	POP	BC
	POP	AF
	RET

KODE:
	RES	7,A
	CP	7FH
	JR	NZ,KODE1
	LD	A,2EH
KODE1:
	CP	20H
	RET	NC
	LD	A,20H
	RET

	DEFS	8,0

	PAGE
;****************************************************************
;*                  PF-Tastendefinition 2.ROM-Ber. fuer  EDIT   *
;****************************************************************
PFO1:
	LD	HL,PF.O2END	;6FD5H
	LD	(SM.PTSE),HL
	LD	HL,PF.O2ANF	;6D20H
	LD	(SM.PTSA),HL
	RET

	DEFS	3,0

;****************************************************************
	ORG	00800H
				;
STANL:
	CALL	SPOSN
	CALL	SY.CPOS
	CALL	SY.DEL2		;RESTZEILE LOESCHEN
	CALL	SY.ZLPOF
	CALL	SY.SZAHL
	LD	B,A
	CALL	SY.SZEI4	;ZEICHEN SUCHEN
	RET			;A=ZEICH. SONST Z=0

;ZEILENLAENGE HINTER EINSCHLIESSLICH CPOS

SPOSN:
	PUSH	BC
	LD	BC,(SM.SPOS)
	LD	A,(SM.SMAX)
	SUB	C
	POP	BC
	RET			;A=SPALTENZAHL DER RESTZEILE

;FORMATZEILENENDE

ZENDF:
	CALL	SY.ZLPOS
ENDF2:
	LD	DE,(SM.SMAX)
ENDF1:
	LD	D,0
	DEC	E
	ADD	HL,DE		;HL=ADR.ZEILENENDE
	RET

;AUSTAUSCH FORMATMERKER <--> ZWEITMERKER

FOEX:
	LD	HL,SM.ZPOS
	LD	DE,SM.ZPOS2
	LD	B,6
FOEX1:
	LD	C,M
	LD	A,(DE)
	LD	M,A
	LD	A,C
	LD	(DE),A
	INC	HL
	INC	DE
	DJNZ	FOEX1
	RET

;KONVERTIERUNG HEXA.WERT IN HL --> ISO.-DEZ.ZAHL AB (DE)

HDI:
	LD	BC,10000
	CALL	HDI1
	LD	BC,1000
	CALL	HDI1
	LD	BC,100
	CALL	HDI1
	LD	BC,10
	CALL	HDI1
	LD	A,L
	OR	30H
	INC	DE
	LD	(DE),A
	RET
HDI1:
	CALL	DIV
	OR	30H
	CP	30H
	JR	NZ,HDI3
	LD	B,A
	LD	A,(DE)
	CP	SD.SPACE
	JR	Z,HDI3
	LD	A,B
HDI3:
	INC	DE
	LD	(DE),A
	RET

;DIVISION HL/BC

DIV:
	XOR	A
DIV1:
	SBC	HL,BC
	INC	A
	JR	NC,DIV1
	ADD	HL,BC
	DEC	A		;A:=HL/BC  HL:=REST
	RET

;KONVERTIERUNG ISO.-DEZ.-ZAHL AB (DE) --> HEXA.-WERT IN HL
;ZAHL <10000H

IDH:
	LD	C,6
	CALL	IDH1
	RET	C		;CY=1 FEHLER: KEINE ZAHL AB (DE)
	LD	H,0
IDH2:
	LD	L,A
	INC	DE
	DEC	C
	RET	Z		;Z=1 FEHLER: STELLENZAHL >5
IDH3:
	CALL	IDH1
	JR	C,IDHE		;CY=1 WENN ZAHL ZUENDE
	CALL	MUL10
	JR	C,IDHF		;CY=1 WENN ZAHL >FFFFH
	JP	IDH41
IDHF:
	XOR	A
	RET			;Z=1 FEHLER: ZAHL >FFFFH
IDHE:
	LD	A,1
	OR	A
	RET			;Z=CY=0 KEIN FEHLER

IDH1:
	LD	A,(DE)
	CALL	SIEBD
	RET	C
	AND	0FH
	RET

;TEST: ISOZEICHEN = ZIFFER ?

SIEBD:
	CP	'0'
	RET	C
	CP	3AH
	CCF
	RET			;CY=1 WENN A KEINE DEZ. ZIFFER

;MULTIPLIKATION HL*10

MUL10:
	PUSH	DE
	PUSH	HL
	POP	DE
	ADD	HL,HL
	ADD	HL,HL
	ADD	HL,DE
	ADD	HL,HL
	POP	DE
	RET			;HL:=HL*10

;MELDUNGEN
;DE=AUSZUGEBENDE ZEICHENKETTE, HL=DEZIMAL AUSZUGEBENDE HEXA-
;ZAHL, A=ZEILENNUMMER, BC=DISTANZ VON ZEILENANFANG (AUCH
;NEGATIV ZUGELASSEN

MELDN:
	DEC	A		;A=ZEILENNUMMER
S1.MELDE:
PUSH	HL		;A=ZEILENNUMMER-1
	LD	HL,SD.BWSA
	ADD	HL,BC
	CALL	SY.AMSZ
	EX	DE,HL		;DE=BWSA+BC+ A*(SPANZ)
	CALL	SY.MELD		;HL=ZEICHENKETTE
	POP	HL		;HL=ZAHL
	JP	HDI

;FEHLERMELDUNGEN

ERROR:
	CALL	SY.LCPOS
ERRO:
	LD	H,0
	LD	L,C
	LD	A,(SM.ZPOS)
	INC	A
	LD	BC,-11
	LD	DE,ZS11
	JR	S1.MELDE

;ZEICHENKETTEN FUER MELDUNGEN

ZS11:
	DB	LOW(LZS11)
	DB	'ERROR'
LZS11	EQU	$-ZS11-1
ZS12:
	DB	LOW(LZS12)
	DB	'ZEILE'
LZS12	EQU	$-ZS12-1
ZS13:
	DB	LOW(LZS13)
	DB	'MEMORY RESERVE'
LZS13	EQU	$-ZS13-1

;ZEICHENKETTE LAENGE ERMITTELN

KETTE:
	LD	C,B		;B=LAENGE SUCHBEREICH
	JR	KET3
KET1:
	INC	HL
	CP	M
	JR	Z,KET2
KET3:
	DJNZ	KET1
	SCF
	RET			;CY=1=FEHLER
KET2:
	LD	A,C
	DEC	A
	SUB	B		;A=LAENGE ZEICHENKETTE
	RET

;ZEICHEN SUCHEN  (DE),(DE+1),...=SUCHBEREICH, B=LAENGE

SUZEI:
	EX	DE,HL
	CALL	SY.SZEI2
	EX	DE,HL		;A=ZEICHEN,DE=ADR.
	RET			;Z=1 WENN KEIN ZEICHEN

;ZAHL SUCHEN (DE),(DE+1),...=SUCHBEREICH, B=LAENGE

SUZA:
	CALL	SUZEI
	RET	Z		;Z=1: KEIN ZEICHEN
SUZA1:
	CALL	IDH
	RET	C		;Z=0 CY=1: FALSCHE ZAHL
	RET	NZ		;CY=Z=0: HL=ZAHL
SUZA3:
	LD	A,1
	OR	A
	SCF
	RET			;Z=0 CY=1: FALSCHE ZAHL

;ZAHL LESEN U. PRUEFEN: A'< ZAHL =< (IX+0)
;FALLS BEDINGUNG ERFUELLT: L=ZAHL Z=CY=0
;FALLS KEINE ZEICHEN: Z=1
;FALLS FALSCHE ZAHL: CY=1

LT1Z:
	CALL	SUZA
	RET	C
	RET	Z
	LD	A,H
	OR	A
	JR	NZ,SUZA3
	LD	A,(IX+0)
	CP	L
	RET	C
	EX	AF,AF'
	CP	L
	CCF
	RET

MX:
	JP	(IX)

RNR:
	PUSH	HL		;RECHTSROTIEREN VOR (HL)
	POP	DE		;BC=ANZAHL
	LD	A,(DE)
	DEC	HL
	LDDR
	LD	(DE),A
	RET

RNL:
	PUSH	HL		;LINKSROTIEREN HINTER (HL)
	POP	DE		;BC=ANZAHL
	LD	A,(DE)
	INC	HL
	LDIR
	LD	(DE),A
	RET

;UMSCHALTEN AUF KLEINBUCHSTABEN

UMS:
	LD	HL,SM.UMERK
	LD	A,M
	XOR	20H
	LD	M,A
	RET

;INPTR --UNTERPROGRAMM BESTIMMT PARAMETER NACH BEFEHLSNAME
;D=PARAMETER BINAER
;SM.PARAM -- SM.PARAM + 3 = PARAMETER HEXA
;
S1.INPTR:
	LD	HL,SD.BWSA+327H
	LD	BC,4
	LD	DE,SM.PARAM
	LDIR
	CALL	SY.BILO
	LD	HL,SM.PARAM
	CALL	S1.HBKON
	LD	D,A
	RET
;
;HBKON -- HEXADEZIMAL BINAER KONVERTIERUNG
;         HL = ANFANGSADRESSE DES HEXAZEICHEN
;         A = BINAERZEICHEN
;
S1.HBKON:
	PUSH	BC
	LD	A,(HL)		;1.ZEICHEN
	LD	B,0
	CALL	KON1
	RL	B
	RL	B
	RL	B
	RL	B
	INC	HL
	LD	A,(HL)
	CALL	KON1
	LD	A,B
	POP	BC
	RET
;
KON1:
	SUB	30H
	CP	10		;CHARACTER?
	JR	C,S1.ZAHL
	AND	0FH		;NO
	ADD	A,9
S1.ZAHL:
	OR	B
	LD	B,A
	RET
;
;BHKON -- KONVERTIERE 8 BIT VON REG. A IN ASCII HEXA AUF (HL)
;
BHKON:
	PUSH	AF		;RETTE A
	RRA
	RRA
	RRA
	RRA
	CALL	KON2		;KONVERTIERE HIGH ORDER 4 BITS
	POP	AF
	INC	HL
	CALL	KON2		;KONVERTIERE LOW ORDER 4 BITS
	RET
;
KON2:
	AND	0FH		;MASKE FUER LOW ORDER 4 BITS
	CP	10
	JR	C,HB10
	ADD	A,7
HB10:
	ADD	A,30H
	LD	(HL),A
	RET
;
IDH41:
	ADD	A,L
	JP	NC,IDH2
	INC	H
	JP	IDH2

	PAGE
;****************************************************************
;*                  E X E C --- Starten eines Programmes        *
;****************************************************************
	DW	$
	DB	'EXEC'
	CALL	S1.INPTR
	INC	HL
	CALL	S1.HBKON
	LD	E,A
	LD	SP,SM.STACK
	LD	BC,SY.SYSTB
	PUSH	BC
	PUSH	DE
	RET
;****************************************************************

	IF	SD.GENE AND 00000001B
S1.DEG2:
	DW	$
	DB	'DEG2'
	OUT	(0C4H),A	;RESET-Sperre aus
	LD	A,0FEH
	OUT	(0C0H),A	;SYS 1
	LD	A,01
	OUT	(0C1H),A	;SYS 2
	JP	0FF37H		;Sprung zur Version 2.1
				;           Version 2.0 : 0C093H
	ENDIF
;****************************************************************

	DW	$
	DB	'DATE'
	LD	HL,SM.DATUM
	PUSH	HL
	CALL	EING
	POP	HL
	RET	C
	CALL	S1.ANZG
	JP	SY.SYSTB

EING:
	LD	B,3
	LD	DE,SD.BWSA+327H
	LD	A,(DE)
	CP	20H
	RET	Z
EIN1:
	PUSH	HL
	CALL	UC.CVDB
	JR	C,RET
	XOR	A
	CP	H
	JR	NZ,RET
	LD	A,L
	CP	100
	JR	NC,RET
	POP	HL
	LD	(HL),A
	INC	HL
	INC	DE
	DJNZ	EIN1
	XOR	A
	RET
RET:
	POP	HL
	SCF
	RET

S1.ANZG:
	PUSH	HL
	CALL	TEST
	CALL	C,STAND
	POP	HL
	LD	DE,SD.BWSA+0B8H
	LD	B,3
ANZ1:
	PUSH	HL
	LD	L,(HL)
	LD	H,0
	CALL	UC.CVBD2
	LD	A,2EH
	LD	(DE),A
	INC	DE
	POP	HL
	INC	HL
	DJNZ	ANZ1
	DEC	DE
	LD	A,20H
	LD	(DE),A
	RET

TEST:
	XOR	A
	CP	(HL)
	JR	Z,TE1
	LD	A,31
	CP	(HL)
	JR	C,TE1
	INC	HL
	XOR	A
	CP	(HL)
	JR	Z,TE1
	LD	A,12
	CP	(HL)
	JR	C,TE1
	XOR	A
	RET
TE1:
	SCF
	RET

STAND:
	LD	HL,STAB
	LD	DE,SM.DATUM
	LD	BC,3
	LDIR
	RET

STAB:
	DB	15
	DB	2
	DB	85

;CVDB	EQU	052F4H
;CVBD2	EQU	052AFH

	PAGE
;****************************************************************
;*                  Editorkommandos  'EDN'  und  'ED'           *
;****************************************************************
EDN:
	DW	$
	DB	'EDN '
	DI
	XOR	A
	LD	HL,(SM.END)
	LD	DE,SD.TPA
	SBC	HL,DE
	JP	C,SY.SYSTB

	LD	A,01CH
	LD	(SM.NUTZK),A

	PUSH	DE
	LD	HL,(SM.PTS)
	LD	BC,03FFH	;0400H loescht sonst 0000H ein Byte
	PUSH	HL
	PUSH	BC
	LD	DE,(SM.PTS)
	INC	DE
	LD	(HL),0
	LDIR
	POP	BC
	POP	DE
	POP	HL

ED1:
	LD	A,03AH
	CP	(HL)
	INC	HL
	JR	Z,ED11
	CALL	ETEST
	JR	ED1

ED11:
	INC	HL
	CALL	ETEST
ED2:
	XOR	A
	CP	(HL)
	JR	Z,ED3
ED6:
	LDI
	JP	PO,ED4
	CALL	ETEST
	OR	A
	JR	NZ,ED1
	JR	ED2

ED3:
	LD	A,(SM.NUTZK)
	DEC	A
	LD	(SM.NUTZK),A
	JR	NZ,ED6
	JR	ED5
ED4:
	LD	A,(SM.NUTZK)
	LD	B,A
	XOR	A
ED7:
	DEC	DE
	LD	(DE),A
	DJNZ	ED7
ED5:
	LD	HL,(SM.PTS)
	LD	(SM.PTSA),HL
	LD	HL,0FFFFH
	LD	(SM.PTSE),HL
	JP	ED.MEL1

ED:
	DW	$
	DB	'ED  '
	DI
	JP	ED.MEL1

ETEST:
	PUSH	DE
	PUSH	HL
	OR	A
	LD	DE,(SM.END)
	SBC	HL,DE
	POP	HL
	POP	DE
	RET	C
	POP	HL
	JR	ED5

PRINT	EQU	07C00H

				;Stand: 30.Januar 85 - K EAW/wfvm..MSH


;	END
