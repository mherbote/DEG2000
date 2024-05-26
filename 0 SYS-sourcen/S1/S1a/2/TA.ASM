	TITLE 'Tastaturmodul'
	PAGE
;	PN	TA01
;****************************************************************
;*                  DEG2000 V. 1.2    Tastaturmodul             *
;*  Version         --------------------------------------------*
;*                  Programmierer: M. Herbote  K EAW  ZFT (WFT) *
;*  V 1 . 2         --------------------------------------------*
;*                  Stand        : 06.Februar 1985              *
;****************************************************************

	ORG	06C00H

TA.TAST:
	CALL	TA.ABFR		;Abfragen der Tastatur
	JR	Z,TA.TAST	;Warten auf gueltiges Zeichen
	LD	(SM.TK),A
	LD	B,A
	LD	A,(SM.KGMER)	;(SM.KGMER)=1 : Schreibmasch.tastatur
	OR	A
	LD	A,B
	JR	Z,ABF14		;Codewandlung fuer Klein-/Gross-
	CP	7EH		;                  Schreibung
	JR	NC,ABF14
	CP	61H
	JR	NC,ABF15
	CP	5EH
	JR	NC,ABF14
	CP	41H
	JR	NC,ABF16
	JR	ABF14

ABF15:
	SUB	20H
	JR	ABF14

ABF16:
	ADD	A,20H

ABF14:
	CP	80H		;Test auf Funktionstasten
	JP	NC,ABF20
	CP	09H		;Tabulator
	JR	NZ,AB01
	LD	HL,(SM.TABU)
	JR	ABF3
AB01:
	CP	1EH		;ET1 / ENTER
	JR	NZ,ABF1
	LD	HL,(SM.NEWL)
	JR	ABF3

ABF1:
	LD	HL,SM.SPMER	;Merker fuer zugelassene Tastaturgruppen
	CP	3AH
	JR	NC,ABF10
	CP	20H
	JR	NC,ABF6
	BIT	0,M		;BIT 0 : Zeichencode < 20H
	JP	Z,TA.TFE

ABF2:
	LD	HL,(SM.EINA)	;Routine ASCII-Zeichen
ABF3:
	LD	C,A
	LD	A,H
	OR	L
	JR	Z,TA.TFE	;HL=0 : Taste nicht zugelassen
	CALL	SY.RESC		;Cursor loeschen
	LD	A,C
	LD	SP,SM.STACK	;STACK_POINTER ruecksetzen
	CALL	MM		;Sprung zur Tastenroutine
	CALL	SY.SETC		;Cursor setzen

WART:
	LD	B,130
WART1:
	PUSH	BC
	LD	A,(SM.ZSMER)
	OR	A
	JP	Z,TA.TFE
	LD	HL,(TR.TA1+1)
	CALL	TA.MM1
	JP	NZ,TA.TFE
	LD	HL,(TR.TA2+1)
	CALL	TA.MM1
	LD	HL,SM.TK
	CP	(HL)
	JP	NZ,TA.TFE
	POP	BC
	DJNZ	WART1
	LD	A,(SM.ZSTC)
	CP	SD.ZEIT2-SD.ZEIT1
	JR	C,WART3
	CP	SD.ZEIT2
	JR	Z,WART4
WART3:
	INC	A
	LD	(SM.ZSTC),A
	JR	WART
WART4:
	LD	A,SD.ZEIT2-SD.ZEIT1
	LD	(SM.ZSTC),A
	XOR	A
	LD	(SM.TK),A
	JP	TA.TAST

TA.MM1:
	DEC	HL
	DEC	HL
MM:
	JP	(HL)

ABF6:
	CP	30H
	JR	NC,ABF9
	CP	2BH
	JR	NC,ABF8
ABF7:
	BIT	1,M		;BIT 1 : SPACE!"#$%&'()*./
	JR	Z,TA.TFE
	JR	ABF2

ABF8:
	CP	2EH
	JR	NC,ABF7
	BIT	2,M		;BIT 2 : +,-
	JR	Z,TA.TFE
	JR	ABF2

ABF9:
	BIT	3,M		;BIT 3 : 1234567890
	JR	Z,TA.TFE
	JR	ABF2

ABF10:
	CP	40H
	JR	NC,ABF11
	BIT	4,M		;BIT 4 : :;<>=?
	JR	Z,TA.TFE
	JR	ABF2

TA.TFE:
	CALL	TFE2
	JP	TA.TAST

TFE2:
	XOR	A		;Einsprung Tastenende
	LD	(SM.ZSMER),A
	LD	(SM.ZSTC),A
	LD	HL,(TR.TFE+1)	;Warten auf Tastenende
	CALL	TA.MM1
	RET

ABF11:
	CP	61H
	JR	NC,ABF13
ABF12:
	BIT	5,M		;BIT 5 : 40H - 60H UND 7BH - 7EH
	JR	Z,TA.TFE
	JP	ABF2

ABF13:
	CP	7BH
	JR	NC,ABF12
	BIT	6,M		;BIT 6 : kleine Buchstaben
	JR	Z,TA.TFE
	JP	ABF2

ABF20:
	LD	HL,SM.SPMER	;Unterteilung der Funktionstasten
	CP	0FCH
	JR	NC,EW1
	CP	0F0H
	JR	NC,STEUT
	CP	0D0H
	JR	NC,STZ
	CP	0CAH
	JR	NC,FKT2
	CP	0C0H
	JR	NC,HZE
	BIT	7,M		;BIT 7 : Funktionstasten
	JR	Z,TA.TFE
	CP	0B0H
	JR	NC,FKT1

	LD	HL,SM.FKT	;PF1 - PF12 in 4 Ebenen
	LD	B,(HL)
	INC	B
	SUB	08CH
EAW2:
	ADD	A,0CH
	DJNZ	EAW2
EAW3:
	LD	HL,TA.TAB1
EAW5:
	ADD	A,A
	LD	C,A
	LD	B,0
	ADD	HL,BC

ABFR9:
	LD	A,M
	INC	HL
	LD	H,M
	LD	L,A
	LD	E,M
	INC	HL
	LD	D,M
	EX	DE,HL
	JP	ABF3

EW1:
	BIT	7,M		;Ebenenumschalttasten
	JR	Z,TA.TFE
	CPL
	LD	(SM.FKT),A	;0,...,3 steht in (SM.FKT)
	CALL	BBB
	LD	HL,(TR.TEM+1)	;Ansteuerung der Ebenen-Dioden
	CALL	TA.MM1
	JR	TA.TFE

STEUT:
	BIT	7,M		;INS_MODE ; DEL ; INS_LINE ; DEL_LINE
	JR	Z,TA.TFE
	CP	0F0H
	JR	Z,INSMD
	SUB	0F0H
STEU1:
	LD	HL,TA.TAB2
	JR	EAW5

INSMD:
	LD	A,(SM.IMERK)
	OR	A
	JR	Z,INSME
	DEC	A		;Diode INS_MODE ausschalten
	JR	INSML
INSME:
	INC	A		;Diode INS_MODE einschalten
INSML:
	LD	(SM.IMERK),A
	CALL	BBB
	LD	HL,(TR.TIM+1)	;Diode INS_MODE ansteuern
	CALL	TA.MM1
	XOR	A
	JR	STEU1

BBB:
	LD	A,(SM.FKT)	;( B )   laden fuer  TR.TIM
	INC	A
	LD	B,A
	LD	A,080H
	RLCA			;<--!
	DJNZ	$-1		;---!
	LD	B,A
	LD	A,(SM.IMERK)
	OR	A
	RET	Z
	SET	7,B
	RET

STZ:
	SUB	040H		;Codes 00H - 1FH (Hexatasten)
HZE:
	SUB	090H		;Codes 30H - 39H (Hexatasten)
	JP	ABF1

FKT2:
	BIT	7,M		;Tasten : - , NQ SYS END ABS
	JP	Z,TA.TFE
	SUB	0CAH
	LD	HL,TA.TAB3
	JR	EAW5

FKT1:
	SUB	0B0H		;Tasten : PQ TABS TABL CI M
	LD	HL,TA.TAB4
	JR	EAW5

TA.E0IN:
	XOR	A
	LD	(SM.FKT),A
	LD	(SM.IMERK),A
	CALL	BBB
	LD	HL,(TR.TEM+1)
	CALL	TA.MM1
	CALL	BBB
	LD	HL,(TR.TIM+1)
	CALL	TA.MM1
	RET


	DW	$		;Schreibmaschinentastatur
	DB	'STAS'
	LD	A,1
STAS1:
	LD	(SM.KGMER),A
	JP	SY.SYSTB

	DW	$		;Programmiertastatur
	DB	'PTAS'
	XOR	A
	JR	STAS1

	PAGE
;****************************************************************
;*                  Verzweigungstabelle der Tastenroutinen      *
;****************************************************************
TA.TAB1:
	DW	00D00H	;P01
	DW	00D10H	;P02
	DW	00D20H	;P03
	DW	00D30H	;P04
	DW	00D40H	;P05
	DW	00D50H	;P06
	DW	00D60H	;P07
	DW	00D70H	;P08
	DW	00D0AH	;P09

	DW	00D1AH	;P10
	DW	00D2AH	;P11
	DW	00D3AH	;P12
	DW	00D4AH	;P13
	DW	00D5AH	;P14
	DW	00D02H	;P15
	DW	00D12H	;P16
	DW	00D22H	;P17
	DW	00D32H	;P18
	DW	00D42H	;P19

	DW	00D52H	;P20
	DW	00D62H	;P21
	DW	00D72H	;P22
	DW	00D0CH	;P23
	DW	00D1CH	;P24
	DW	00D2CH	;P25
	DW	00D3CH	;P26
	DW	00D6AH	;P27
	DW	00D7AH	;P28
	DW	00D0EH	;P29

	DW	00D5EH	;P30
	DW	00D7CH	;P31
	DW	00D7EH	;P32
	DW	00D2EH	;P33
	DW	00D4EH	;P34
	DW	00D1EH	;P35
	DW	00D3EH	;P36
	DW	00D5EH	;P37
	DW	00D5EH	;P38
	DW	00D5EH	;P39

	DW	00D5EH	;P40
	DW	00D5EH	;P41
	DW	00D5EH	;P42
	DW	00D5EH	;P43
	DW	00D5EH	;P44
	DW	00D5EH	;P45
	DW	00D5EH	;P46
	DW	00D5EH	;P47
	DW	00D5EH	;P48

TA.TAB2:
	DW	00D5EH	;INS_MOD
	DW	00D58H	;DEL
	DW	00DACH	;INS_LINE
	DW	00DAAH	;DEL_LINE

	DW	00D26H	;SCH_LINKS
	DW	00D06H	;C_HOCH
	DW	00D36H	;SCH_RECHTS
	DW	00D08H	;C_LINKS
	DW	00D74H	;HOME
	DW	00D16H	;C_RECHTS
	DW	00D76H	;CNZA
	DW	00D18H	;C_RUNTER

TA.TAB3:
	DW	00D4CH	;00
	DW	00D48H	;000
	DW	00D38H	;NEG_QUIT
	DW	00D68H	;SYS
	DW	00D68H	;END
	DW	00D24H	;ABS

TA.TAB4:
	DW	00D28H	;POS_QUIT
	DW	00D04H	;TABS
	DW	00D14H	;TABL
	DW	00D34H	;CI
	DW	00D78H	;M

	PAGE
;****************************************************************
;*                  Eingabe des Tastencode                      *
;****************************************************************
TA.ABFR:
	PUSH	BC		;retten der Register
	PUSH	HL
	PUSH	AF
	POP	BC		;BC=AF
	SET	6,C		;Z=1, wenn keine Taste betaetigt
	PUSH	BC
	LD	HL,(TR.TA1+1)	;/UInt einlesen
	CALL	TA.MM1
	LD	(SM.CTRL),A
	POP	BC
	JR	NZ,AB1		;keine Taste : Rueckladen der Register

	PUSH	BC
	LD	HL,(TR.TA2+1)	;Tastencode lesen
	CALL	TA.MM1
	POP	BC

	OR	A		;Zeichen  NULL
	JR	Z,AB1
	RES	6,C		;Taste betaetigt ----- Z=0
	LD	H,B		;Inhalt von A retten fuer CTRL
	LD	B,A		;B : Tastencode

	LD	A,(SM.CTRL)	;Abfrage CTRL - Taste
	BIT	2,A
	CALL	Z,TA.CTRL	;Auswertung CTRL - Taste

AB1:
	PUSH	BC
	POP	AF		;Rueckladen der Register
	POP	HL
	POP	BC
	RET

TA.ABFR2:
	CALL	ABFR
	PUSH	AF
	PUSH	BC
	LD	BC,03000H
	DEC	BC		;<--!
	LD	A,B		;   !
	OR	C		;   !
	JR	NZ,$-3		;---!
	POP	BC
	POP	AF
	RET


TA.CTRL:
	LD	A,B		;Auswertung der CTRL-Taste
	CP	0CEH		;Taste Hardcopy
	JR	NZ,CT1
	CALL	S1.COPG
	LD	B,H		;nach Ausfuehrung Hardcopy wird die
	SET	6,C		;Taste als nicht betaetigt betrachtet
	RET
CT1:
	CP	85H		;nur fuer Tastencode kleiner 85H
	RET	NC
	CP	84H
	JR	NZ,CTRL0
	LD	B,0F4H		;84H wird SCH_LINKS
	RET
CTRL0:
	CP	80H
	JR	C,CTRL1
	ADD	A,31H		;TABS , TABL , CI , M
	LD	B,A
CTRL1:
	CP	70H
	RET	NC
	CP	60H
	JR	C,CTRL2
	ADD	A,80H		;`.....o wird zu 10H - 1FH
	LD	B,A
CTRL2:
	CP	50H
	RET	NC
	CP	40H
	RET	C
	ADD	A,90H		;@.....O wird zu 00H - 0FH
	LD	B,A
	RET

	ORG	06EE0H
TA.TAST1:
	JP	TA.TAST
TA.TFE1:
	JP	TA.TFE
TA.ABFR1:
	JP	TA.ABFR2

	ORG	06EF0H

				;Stand: 06.Februar 85 - K EAW/wfvm..MSH

;	END
