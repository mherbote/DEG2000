	TITLE 'Betriebssystemkern DEG2000 Version 1.2'
	PAGE
;	PN	SY01.Betriebssystem___DEG20000__Version_1.2
;****************************************************************
;*                  Betriebssystemkern DEG2000 Version 1.2      *
;*  Version         --------------------------------------------*
;*                  Programmierer: M. Herbote  K EAW  ZFT (WFT) *
;*  V 1 . 2         --------------------------------------------*
;*                  Stand        : 28.Januar 1985               *
;****************************************************************
	ORG	SD.SYSTA
	DI
	JP	INRE1
	NOP
	NOP
	JR	$+5
RST8:
	JP	INRE
SY.SYSTB:
	JP	INSTB
	DEFS	2,0
RST10:
	JP	INRE
	DEFS	5,0
RST18:
	JP	INRE
	DEFS	5,0
RST20:
	JP	INRE
	DEFS	5,0
RST28:
	JP	INRE
	DEFS	5,0
RST30:
	JP	INRE
	DEFS	5,0
RST38:
	JP	SM.RST38
;****************************************************************
	ORG	00058H
				;Interrupt-Startadresse
ISRA0:
	DW	IO
;****************************************************************
	ORG	00066H
				;NMI - Routine
NMI:
	LD	HL,INNMI
	EX	(SP),HL
	EI
	RETN
;****************************************************************
	ORG	00070H
				;Programm KT01
ISRA3:	DW	IO		;Int. Beh. CTC- Kanal 0
ICTC1:	DW	0		;          CTC- Kanal 1
ICTC2:	DW	048B1H		;          CTC- Kanal 2
ICTC3:	DW	0		;          CTC- Kanal 3

IAUS:	DW	0446FH
IER:	DW	04513H
IEL:	DW	04562H
IST:	DW	04658H
IBE:	DW	04673H
IBE0:	DW	0468EH

	PAGE
;****************************************************************
	ORG	000A0H
				;Initialisierungen
INRE1:
	LD	SP,SM.STACK	;- Zeichen in die 25.Zeile schreiben
	LD	HL,SD.BWSA+24*80
	LD	DE,SD.BWSA+24*80+1
	LD	BC,79
	LD	(HL),'-'
	LDIR

	IF	SD.GENE AND 00010000B	;DEG2000 Emulator
	LD	BC,004C0H	;HS-Speicher auf Standard (1) umschalten
	LD	HL,OUTB1
	OTIR
	JR	INRE2
OUTB1:
	DB	0F0H	;Startbyte
	DB	003H	;wahl
	DB	004H	;SYS 1.2
	DB	0FFH	;Endbyte
	ENDIF

INRE2:
	LD	HL,SM.EADRU	;E-/A-Tabellen loeschen
	LD	DE,SM.EADRU+1
	LD	BC,8FH
	LD	(HL),0
	LDIR
	LD	A,0C3H		;Sprung zur RST38-Routine
	LD	(SM.RST38),A
	LD	HL,INSTC
	LD	(SM.RST38+1),HL
	LD	HL,SM.PTSC	;setzen der Variablen SM.PTS
	LD	(SM.PTS),HL
INRE:
	CALL	INI		;Initialisierung der Speicher
	LD	HL,(TR.TINIT+1)	;Initialisierung der Tastatur
	CALL	TA.MM1
	CALL	TA.E0IN
	CALL	INI1		;Initialisierung der Bildanzeige

	XOR	A
	LD	(SM.KGMER),A	;Grundstellung: Grossbuchstaben
	LD	(SM.IMERK),A


ZAN	MACRO	Z
	LD	C,Z		;Zeichenausgabe
	CALL	SY.AEIN
	ENDM

	ZAN	'D'
	ZAN	'A'
	ZAN	'T'
	ZAN	'E'
	ZAN	' '
	LD	A,11		;Systembildfenster setzen
	LD	(SM.ZMIN),A
	LD	(SM.ZMAX),A
	LD	A,8
	LD	(SM.SMIN),A
	LD	A,15
	LD	(SM.SMAX),A
	CALL	SY.SETC		;Cursor setzen
ININ1	EQU	$

	IF	SD.GENE AND 00000001B
	OUT	(0C3H),A	;RESET - Sperre ein
	ENDIF

ININ3:
	LD	HL,SM.DATUM
	CALL	S1.ANZG
	JP	TA.TFE

INI:
	XOR	A
	LD	I,A		;I - Register laden

	IF	SD.GENE AND 00000001B
	OUT	(0C4H),A	;RESET - Sperre aus ---   S B S T
	OUT	(0C2H),A	;SYS 1 aktivieren
	OUT	(0C1H),A
	OUT	(0C0H),A
	ENDIF

	IM	2		;Interrupt - Mode 2
	EI
	LD	A,-1
	LD	(SM.SPMER),A
	RET

INI1:
	CALL	PRUEF
	CALL	MEMLA
INI2:
	CALL	SY.BILO
INI3:
	LD	HL,10
	LD	(SM.ZPOS),HL
	CALL	BILAD
	CALL	SY.SETC
	RET

INNMI:
	CALL	INI2
	JR	ININ3

INSTB:
	LD	SP,SM.STACK
	CALL	INI
	CALL	INI1
	JR	ININ1

INSTC:
	LD	SP,SM.STACK
	CALL	INI3
	JR	ININ3



INFKT
:	LD	(00D68H),HL
	LD	HL,IFKT1	;Taste: HOME
	LD	(00D74H),HL
	LD	HL,IFKT2	;Taste: CNZA
	LD	(00D76H),HL
	LD	HL,IFKT3	;Taste: 000 
	LD	(00D48H),HL
	LD	HL,IFKT4	;Taste: 00  
	LD	(00D4CH),HL
	LD	HL,07A90H	;Taste: DEL 
	LD	(00D58H),HL

	IF	SD.GENE AND 00000001B
	LD	HL,S3M	;PF1
	LD	(00D00H),HL
	LD	HL,S4	;PF2
	LD	(00D10H),HL
	LD	HL,S1.DEG2+6	;Taste: ABS 
	LD	(00D24H),HL
	ENDIF

	RET

IFKT1:
	LD	HL,(SM.ZMIN)
	LD	(SM.ZPOS),HL
	CALL	DZPOS
	CALL	DSPOS
	RET

IFKT2:
	LD	A,(SM.SMIN)
	DEC	A
	LD	(SM.SPOS),A
	CALL	IZPOS
	RET

IFKT3:
	CALL	SY.CPOS
	LD	(HL),'0'
	CALL	ICPOS
	JR	$+5
IFKT4:
	CALL	SY.CPOS
	LD	(HL),'0'
	CALL	ICPOS
	LD	(HL),'0'
	CALL	ICPOS
	RET


	DW	$
	DB	'DPTS'
	CALL	S1.INPTR
	INC	HL
	CALL	S1.HBKON
	LD	E,A
	LD	(SM.PTS),DE
	JP	SY.SYSTB

	PAGE
;****************************************************************
	IF	SD.GENE AND 00000001B
				;Aufruf des Systems   S Y S 3
	DW	$
	DB	'S3M '		;       mit  Rahmen
S3M:
	CALL	BSLOE
	CALL	BSRAH
	JR	SYS31

	DW	$
	DB	'S3O '		;       ohne Rahmen
	CALL	BSLOE
SYS31:
	OUT	(0C4H),A	;RESET - Sperre aus
	LD	A,00101110B
	OUT	(0C0H),A
	LD	A,00000010B
	OUT	(0C1H),A
	LD	A,00010000B
	OUT	(0C2H),A
	JP	0B40DH

BSRAH:
	LD	HL,SD.BWSA+0F7H	;Bildrahmen erzeugen
	LD	DE,SD.BWSA+0F9H
	LD	BC,64
	LD	(HL),2
	INC	HL
	LD	(HL),1
	LDIR
	LD	(HL),3
	LD	HL,SD.BWSA+647H
	LD	DE,SD.BWSA+649H
	LD	BC,64
	LD	(HL),10
	INC	HL
	LD	(HL),1
	LDIR
	LD	(HL),11
	LD	HL,SD.BWSA+147H
	LD	B,16
SYS30:
	LD	(HL),0
	LD	DE,65
	ADD	HL,DE
	LD	(HL),0
	LD	DE,15
	ADD	HL,DE
	DJNZ	SYS30
	RET

BSLOE:
	LD	HL,SD.BWSA
	LD	DE,SD.BWSA+1
	LD	BC,007FFH
	LD	(HL),' '
	LDIR
	RET
	ENDIF

	PAGE
;****************************************************************
	IF	SD.GENE AND 00000001B
			;Aufruf des Systems   S Y S 4
	DW	$
	DB	'S4L '
	CALL	SYS4L
	JP	SY.SYSTB

	DW	$
	DB	'S4  '
S4:
	CALL	SYS4L
	JP	0D200H		;Sprung zum BIOS-Anfang

	DEFS	16,0

SYS4L:
	OUT	(0C4H),A	;RESET - Sperre aus
	LD	A,00000100B	;4000H V1.2 wegschalten
	OUT	(0C0H),A
	LD	A,10000000B	;4000H V4.1 zuschalten
	OUT	(0C2H),A
	LD	HL,04000H	;Umladen
	LD	DE,0B800H
	LD	BC,03800H
	LDIR
	XOR	A		;SYS 1 aktivieren
	OUT	(0C2H),A
	OUT	(0C0H),A
	OUT	(0C3H),A	;RESET - Sperre ein
	RET
	ENDIF

	PAGE
;****************************************************************
	ORG	00280H

	IF	SD.GENE AND 00001110B
	LD	HL,00000H	;ZRE umladen
	LD	DE,08000H
	LD	BC,00C00H
	LDIR
	LD	HL,01000H	;OFS umladen
	LD	BC,01800H
	LDIR
	JP	0C267H
	ENDIF

	PAGE
;****************************************************************
	ORG	00400H
				;Sprung zur Tastaturroutine
ABFR:
	JP	TA.TAST
;
;
;
IO:
	EI
	RETI
;****************************************************************
	ORG	0048DH
				;Bildausschrift Systemgrundzustand
BILAD:
	LD	HL,ZSY2
BILA1:
	PUSH	HL
	CALL	MELDE
	LD	DE,SD.BWSA+20H
	POP	HL
	CALL	SY.MELD
	JR	KOM2
	DEFS	3,0
KOM:
	LD	C,':'
	CALL	SY.AEIN
	CALL	ISPOS
	LD	A,(SM.SPOS)
	INC	A
	JR	KOM1
	DEFS	2,0

SY.SETC:
	CALL	SY.CPOS
	SET	7,M
	RET
	DEFS	16,0

SY.RESC:
	PUSH	HL
	CALL	SY.CPOS
	RES	7,M
	POP	HL
	RET

KOM1:
	LD	(SM.SMIN),A
	LD	A,11		;Begrenzung Bildbereich Kommandozeile
	LD	(SM.ZMIN),A
	LD	(SM.ZMAX),A
	RET

KOM2:
	LD	HL,ZSY3
	LD	DE,SD.BWSA+060H
	CALL	SY.MELD
	LD	HL,ZSY4
	LD	DE,SD.BWSA+0B0H
	CALL	SY.MELD
	LD	A,10
	LD	(SM.ZPOS),A
	JR	KOM
;****************************************************************
;*                  Zeichenketten                               *
;****************************************************************
ZSY1:
	DB	LOW (LZSY1)
	DB	'DEG 2000'
LZSY1	EQU	$-ZSY1-1
ZSY2:
	DB	LOW (LZSY2)
	DB	'Betriebssystem'
LZSY2	EQU	$-ZSY2-1
ZSY3:
	DB	LOW (LZSY3)
	DB	'Version 1.2'
LZSY3	EQU	$-ZSY3-1
ZSY4:
	DB	LOW (LZSY4)
	DB	'Datum:  '
LZSY4	EQU	$-ZSY4-1
;****************************************************************
QTABL:
	LD	HL,SM.TABZ
	LD	(HL),SD.QTAB1
	INC	HL
	LD	(HL),SD.QTAB2
	INC	HL
	LD	(HL),SD.QTAB3
	INC	HL
	LD	(HL),SD.QTAB4
	INC	HL
	LD	(HL),-1
	PUSH	HL
	POP	DE
	INC	DE
	LD	BC,5
	LDIR
	LD	HL,(SM.PTS)
	RET
;****************************************************************
	ORG	00548H
BWSAF:
	CALL	POSA		;Format--BWS--Anfang
	JR	POS5
SPPOF:
	CALL	SPPOS		;Formatspaltenanfang
POS5:
	PUSH	AF
	LD	A,(SM.ZMIN)
	DEC	A
	JR	POS4
SY.ZLPOF:
	CALL	POSA
	JR	POS3
SY.ZLPOS:
	LD	HL,SD.BWSA	;Zeilenanfang
	JR	POS3
SY.CPOS:
	CALL	SPPOS		;Cursorposition
POS3:
	PUSH	AF
	LD	A,(SM.ZPOS)
POS4:
	CALL	SY.AMSZ
POS1:
	POP	AF
	RET
POSA:
	LD	HL,(SM.SMIN)
	DEC	L
	JR	POS7
SPPOS:
	LD	HL,(SM.SPOS)	;Spaltenanfang
POS7:
	LD	H,HIGH(SD.BWSA)
	RET
BWSL:
	PUSH	HL
	LD	HL,0
	CALL	ADDBL
	EX	(SP),HL
	POP	BC		;BC=BWSL  A=0
	RET			;HL,DE unveraendert
BWSE:
	LD	HL,SD.BWSA-1	;HL:=BWSE
ADDBL:
	LD	A,(SM.ZANZ)	;HL=HL+BWSL
SY.AMSZ:
	OR	A		;HL:=HL+A*(SPANZ)
	RET	Z
	PUSH	DE
	CALL	DESZ
AMSZ1:
	ADD	HL,DE
	DEC	A
	JR	NZ,AMSZ1
	POP	DE
	RET
DZPOS:
	PUSH	BC		;Zeilennr. decrementieren
	LD	HL,SM.ZPOS
	LD	A,(SM.ZMAX)
	LD	B,A
	LD	A,(SM.ZMIN)
	JR	DEC2
DSPOS:
	PUSH	BC		;Spaltennr. decrementieren
	LD	HL,SM.SPOS
	LD	A,(SM.SMAX)
	LD	B,A
	LD	A,(SM.SMIN)
DEC2:
	DEC	A
	CP	M
	JR	Z,INC3		;Z=1,CY=0 falls Uebertrag
	DEC	M
	JR	INC4
IZPOS:
	PUSH	BC		;Zeilennr. incrementieren
	LD	HL,SM.ZPOS
	LD	A,(SM.ZMIN)
	LD	B,A
	LD	A,(SM.ZMAX)
	JR	INC2
ISPOS:
	PUSH	BC		;Spaltennr. incrementieren
	LD	A,(SM.SMIN)
	LD	B,A
	LD	A,(SM.SMAX)
	LD	HL,SM.SPOS
INC2:
	LD	C,A
	LD	A,M
	INC	A
	CP	C
	JR	C,INC1
INC3:
	DEC	B
	LD	A,B
INC1:
	LD	M,A
INC4:
	CALL	SY.CPOS
	POP	BC
	CCF
	RET			;Z=CY=1 falls Uebertrag
ICPOS:
	CALL	ISPOS		;Schreibcursorpos. increment.
	CALL	C,IZPOS
	RET			;Z=CY=1 falls CPOS=SD.BWSA
DCPOS:
	CALL	DSPOS		;Schreibcursorpos. decrement.
	CALL	C,DZPOS
	RET			;Z=CY=1 falls CPOS=BWSEnde
SY.LCPOS:
	PUSH	HL		;HL-->ZPOS/SPOS
	PUSH	DE
	LD	DE,SD.BWSA
	OR	A
	SBC	HL,DE
	CALL	DESZ
	XOR	A
LCP1:
	SBC	HL,DE
	INC	A
	JR	NC,LCP1
	ADD	HL,DE
	DEC	A
	LD	(SM.ZPOS),A
	LD	A,L
	LD	(SM.SPOS),A
	POP	DE
	POP	HL
	RET
DESZ:
	LD	DE,(SM.SPANZ)
	LD	D,0
	RET
				;Schreibcursor Operationen
CNRS:
	CALL	ICPOS		;-->
	JR	CURS
CNLS:
	CALL	DCPOS		;<--
	JR	CURS
CNUS:
	CALL	IZPOS		;Runter
	JR	CURS
CNOS:
	CALL	DZPOS		;Hoch
CURS:
	LD	A,1
	LD	(SM.ZSMER),A
	RET
				;Bild loeschen
SY.BILO:
	LD	HL,SD.BWSA
	LD	DE,SD.BWSA+1
	CALL	BWSL
	DEC	BC
	PUSH	BC
	LD	M,SD.SPACE
	LDIR
	POP	BC
	LD	A,(SM.ZANZ)
	CP	32
	RET	NZ
	INC	HL
	INC	DE
	LD	M,0		;SD.SW
	LDIR
	RET
				;Funktionsadressen laden
FKTLA:
	LD	HL,SM.FKTAB
	LD	M,0
	LD	DE,SM.FKTAB+1
	LD	BC,SM.TK-SM.FKTAB-1
	LDIR
	LD	HL,CNOS
	LD	(SM.FKTAB+6),HL
	LD	HL,CNLS
	LD	(SM.FKTAB+8),HL
	LD	HL,CNRS
	LD	(SM.FKTAB+16H),HL
	LD	HL,CNUS
	LD	(SM.FKTAB+18H),HL
	LD	HL,INSTB
	JP	INFKT
	RET
				;ArbeitsRAM und Tabellen laden
MEMLA:
	CALL	FKTLA
	CALL	RALO
	LD	HL,NL
MEML1:
	LD	(SM.NEWL),HL
	LD	HL,SY.AEIN
	LD	(SM.EINA),HL
	LD	HL,DELZL
	LD	(SM.DELZ),HL
	RET
				;ArbeitsRAM loeschen
RALO:
	LD	HL,SM.ZSMER
	LD	M,0
	LD	DE,SM.ZSMER+1
	JP	RALO2		;LD    BC,SM.LOE-1
RALO1:
	LDIR
	INC	HL		;Format = volles Bild
	LD	M,1
	INC	HL
	LD	M,1
	LD	HL,(SM.ZANZ)	;H=(SPANZ) L=(ZANZ)
	LD	(SM.ZMAX),HL	;(SMAX)=L  (ZMAX)=H
	RET
				;ABS K7024
PRUEF:
	LD	HL,5018H	;H=80 L=24
	LD	(SM.ZANZ),HL	;(SPANZ):=H (ZANZ):=L
	RET

RALO2:
	LD	BC,12
	LDIR
	LD	HL,SM.UMERK
	LD	DE,SM.USCH
	LD	BC,14
	LD	(HL),0
	JP	RALO1

	DEFS	3,0		;Adresskorrektur
				;pruefen RAM-Bereich
RAMPR:
	INC	HL
	LD	A,M
	INC	M
	CP	M
	LD	M,A
	JR	NZ,RAMPR
	RET			;HL=RAMEnde+1
MELDE:
	LD	DE,SD.BWSA+10H
	LD	HL,ZSY1
SY.MELD:
	LD	B,0		;Zeichenkette uebertragen
	LD	C,M
	INC	HL
	LDIR
	RET
DELZL:
	CALL	SY.ZLPOF
	CALL	SY.LCPOS
	CALL	SY.SZAHL
SY.DEL2:
	LD	B,A
DEL1:
	LD	M,SD.SPACE
	INC	HL
	DJNZ	DEL1
	RET
SY.AEIN:
	CALL	SY.CPOS		;<A> --> Cursorposition
	LD	M,C
	CALL	ISPOS
	CALL	C,DSPOS
	RET
NL:
	CALL	SY.ZLPOS	;Startroutine (NEWLINE Taste)
	LD	A,M
	CP	':'
	RET	NZ
	CALL	SZEI
	RET	Z
	EX	DE,HL
SUCHE:
	LD	HL,0
	PUSH	HL
	PUSH	HL
SUCH2:
	POP	BC
	POP	HL
SUCH1:
	LD	A,L
	CPI
	JP	PO,SD.SYSTA+6
	JR	NZ,SUCH1
	LD	A,H
	CP	M
	JR	NZ,SUCH1
	PUSH	HL
	PUSH	BC
	LD	B,4		;Programmanfang suchen
	INC	HL
	CALL	VERGL
	JR	NZ,SUCH2
	POP	BC
	POP	DE
	EI
	JP	(HL)
VERGL:
	PUSH	DE		;DE = gegebene  ZK
VERG1:
	LD	A,(DE)		;B  = Laenge
	CP	M		;HL = vermutete ZK
	JR	NZ,VERG2
	INC	DE
	INC	HL
	DJNZ	VERG1
VERG2:
	POP	DE		;Z=1: Kette gefunden B=0
	RET			;HL=Kette+1  DE:=DE
SZEI:
	LD	A,(SM.SPANZ)	;Zeichen suchen
SZEI1:
	LD	B,A
	DEC	B
SZEI3:
	INC	HL
SY.SZEI4:
	LD	A,M
	CP	SD.SPACE
	RET	NZ
SY.SZEI2:DJNZ	SZEI3
	RET			;Z=0 falls kein Zeichen
SY.SZAHL:
	PUSH	HL
	LD	HL,(SM.SMIN)
SZA1:
	LD	A,(SM.SMAX)
	JR	ZAHL
ZZAHL:
	PUSH	HL
	LD	HL,(SM.ZMIN)
ZZA1:
	LD	A,(SM.ZMAX)
ZAHL:
	SUB	L
	INC	A
	POP	HL
	RET			;A=Zeilen- bzw. Spaltenanzahl
				;Stand: 28.Januar 85 - K EAW/wfvm..MSH

;	END
