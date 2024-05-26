	TITLE 'Lochband-Geraeter-Treiber'
	PAGE
;	PN	LR01
;****************************************************************
;*                  Lochband-Geraete-Treiber  fuer              *
;*                  S I F 1000  ( ADA )  und  I F S P  ( ALB )  *
;*  T A P           --------------------------------------------*
;*                  Programmierer: M. Herbote  K EAW  ZFT (WFT) *
;*  D E G 2 0 0 0   --------------------------------------------*
;*                  Stand        : 10.Januar 1985               *
;****************************************************************

;****************************************************************
;*                  Aufbau der  E-/A-Tabelle                    *
;*                  --------------------------------------------*
;*       +  0       EOR - Zeichen  extern                       *
;*       +  1       EOR - Zeichen  intern                       *
;*       +  2       Basisadresse der Ansteuerkarte fuer Lochb.  *
;*       +  3       Status                                      *
;*                  bit 0 = 1  ...  EOF gelesen                 *
;*                      1 = 1  ...  EOR gelesen                 *
;*       +  4       Kommando                                    *
;*                  bit 0      ...  nicht benutzt               *
;*                                                              *
;*                      1 = 0  ...  Transport rueckwaerts Lesen *
;*                        = 1  ...  Transport vorwaerts   Lesen *
;*                      2 = 0  ...  keine EOR-Umwandlung        *
;*                        = 1  ...  EOR extern <===> EOR intern *
;*                      3 = 0  ...  keine Code-Konvertierung    *
;*                        = 1  ...        Code-Konvertierung    *
;*                      4      ...  nicht benutzt               *
;*                                                              *
;*                      5 = 0  ...  NUL und DEL      lesen      *
;*                          1  ...  NUL und DEL ueberlesen      *
;*                      6 = 0  ...  ungerade Paritaet (7=1)     *
;*                          1  ...    gerade Paritaet (7=1)     *
;*                      7 = 0  ...  ohne Paritaet               *
;*                          1  ...  mit  Paritaet               *
;*       + 5, + 6   Anfangsadresse der Konvertierungstabelle(n) *
;*       + 7, + 8   Blockadresse                                *
;*       + 9, +10   Blocklaenge                                 *
;*       +11        Paritaetsverknuepfungszeichen               *
;*       +12        EOF - Zeichen                               *
;*       +13, +14   Adresse der  OPEN       - Routine           *
;*       +15, +16   Adresse der  CLOSE      - Routine           *
;*       +17, +18   Adresse der  READ/WRITE - Routine           *
;*       +19, +20   Adresse der  KONV       - Routine           *
;****************************************************************

	ORG	07000H
LRLBL:	JP	LBL
LRLBS:	JP	LBS

	ORG	07010H
IRLB:	DW	IRLBS
	DW	IRLBL

	PAGE
;****************************************************************
;*                  Standard-Konvertierungsroutine              *
;*                  fuer Einfach-Kodetabelle                    *
;****************************************************************
KONV:	PUSH	HL
	PUSH	BC
	LD	H,(IX+6)	;Adresse der Konvertierungstabelle
	LD	L,(IX+5)
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD	A,(HL)
	POP	BC
	POP	HL
	RET

KONV1:	BIT	3,B		;Konvertierung ?
	RET	Z		;NEIN
	PUSH	AF		;Zeichen retten
	LD	A,(IX+19)	;Adresse der Konvertierungsroutine
	LD	L,A		;laden
	OR	(IX+20)
	JR	Z,KONV2
	LD	H,(IX+20)
	JR	KONV3
KONV2:	LD	HL,KONV
KONV3:	POP	AF		;Zeichen laden
	JP	(HL)		;Konvertierungsroutine aufrufen



LBGEN	EQU	00000001B	;Generierungskonstante
				;Bit 0 = 1  ...  ALB / K6200
				;    1 = 1  ...  ADA / DARO

	TITLE	'Lochband Ausgabe Routine'
	PAGE
;****************************************************************
;*                  Ausgabe eines Zeichens zum Lochbandstanzer  *
;****************************************************************
LBS:	PUSH	HL		;Register retten
	PUSH	BC
	PUSH	AF
	LD	A,I		;I-Register retten
	PUSH	AF
	LD	A,HIGH(IRLB)	;I-Register fuer LB laden
	LD	I,A
	LD	B,C		;auszugebendes Zeichen retten
	PUSH	BC

	IF	LBGEN AND 1
	LD	A,0E8H		;Basisadresse ALB
	ENDIF
	IF	LBGEN AND 2
	LD	A,0		;Basisadresse ADA
	ENDIF

ILBS:	DI

	IF	LBGEN AND 1
	ADD	A,6
	ENDIF
	IF	LBGEN AND 2
	ADD	A,2
	ENDIF

	LD	C,A
	LD	HL,SWLBS
	LD	B,3
	OTIR			;Adresse + 6 : PIO 2, Port A, Steuer
				;Adresse + 2 : PIO 1, Port A, Steuer

	INC	C
	LD	B,3
	OTIR			;Adresse + 7 : PIO 2, Port B, Steuer
				;Adresse + 3 : PIO 1, Port B, Steuer

	DEC	C
	DEC	C

	POP	AF		;Ausgabe des Datenbyte ====>
	PUSH	BC
	LD	B,(IX+4)	;Kommandobyte
	BIT	2,B		;EOR-Umwandlung ?
	JR	Z,LBS2		;NEIN
	CP	(IX+1)		;EOR intern ?
	JR	NZ,LBS2		;NEIN
	LD	A,(IX+0)	;EOR extern
LBS2:	CALL	KONV1
	BIT	7,B		;mit Paritaet ?
	JR	Z,LBSE		;NEIN
	BIT	6,B		;welche Paritaet ?
	JR	NZ,LBS1

	OR	A		;ungerade Paritaet ?
	JP	PO,LBSE		;JA
	OR	(IX+11)		;Paritybit setzen
	JR	LBSE

LBS1:	OR	A		;  gerade Paritaet ?
	JP	PE,LBSE		;JA
	OR	(IX+11)		;Paritybit seten

LBSE:	POP	BC
	PUSH	AF

	IF	LBGEN AND 1
	DEC	C
	XOR	A		;ALB aktivieren
	OUT	(C),A		;Adresse + 4 : PIO 2, Port A, Daten
	INC	C
	ENDIF
	IF	LBGEN AND 2
	LD	A,7		;SIF1000 - Kommando ausgeben
	OUT	(C),A		;Adresse + 1 : PIO 1, Port B, Daten
	IN	A,(C)
	DEC	C
	ENDIF

	POP	AF
	OUT	(C),A		;Adresse + 5 : PIO 2, Port B, Daten
				;Adresse + 0 : PIO 1, Port A, Daten

	IF	LBGEN AND 1
	DEC	C
	ENDIF
	IF	LBGEN AND 2
	INC	C
	ENDIF

	EI
	HALT

	IF	LBGEN AND 1
	LD	A,10H		;ALB sperren
	OUT	(C),A		;Adresse + 4
	ENDIF

	POP	AF		;I-Register alten Zustand laden
	LD	I,A
	POP	AF		;Register laden
	POP	BC
	POP	HL
	RET
;****************************************************************
;*                  Interruptroutine Lochbandstanzer            *
;****************************************************************
IRLBS	EQU	$

	IF	LBGEN AND 1
	IN	A,(C)		;Adresse + 4
	BIT	3,A
	JR	NZ,IRLBS
	BIT	0,A
	JR	NZ,IRLBS
	ENDIF

	EI
	RETI

	TITLE	'Lochband Eingabe Routine'
	PAGE
;****************************************************************
;*                  Eingabe eines Zeichens vom Lochbandleser    *
;****************************************************************
LBL:	PUSH	HL		;Register retten
	PUSH	BC
	LD	A,I		;I-Register retten
	PUSH	AF
	LD	A,HIGH(IRLB)	;I-Register fuer LB laden
	LD	I,A

	IF	LBGEN AND 1
	LD	A,0E8H		;Basisadresse ALB
	ENDIF
	IF	LBGEN AND 2
	LD	A,0		;Basisadresse ADA
	ENDIF

ILBL:	DI

	IF	LBGEN AND 1
	ADD	A,2
	ENDIF
	IF	LBGEN AND 2
	ADD	A,6
	ENDIF

	LD	C,A

	LD	B,3
	LD	HL,SWLBL
	OTIR			;Adresse + 2 : PIO 1, Port A, Steuer
				;Adresse + 6 : PIO 2, Port A, Steuer

	INC	C
	LD	B,3
	OTIR			;Adresse + 3 : PIO 1, Port B, Steuer
				;Adresse + 7 : PIO 2, Port B, Steuer

	DEC	C
	DEC	C

	IF	LBGEN AND 1
	DEC	C
	LD	A,(IX+4)	;Kommando: 0 ... Lesen rueckwaerts
	AND	002H		;          2 ... Lesen vorwaerts
	OUT	(C),A		;Adresse + 0 : PIO 1, Port A, Daten
	INC	C
	ENDIF
	IF	LBGEN AND 2
	LD	A,(IX+4)	;Kommando: 0 ... Lesen rueckwaerts
	AND	002H		;          2 ... Lesen vorwaerts
	CP	2		;rueckwaerts ?
	JR	NZ,$+6		;NEIN
	LD	A,3
	JR	+4
	LD	A,7
	OUT	(C),A		;Adresse + 5 : PIO 2, Port B, Daten
	DEC	C
	ENDIF

				;Eingabe des Datenbyte <====
	IN	A,(C)		;Adresse + 1 : PIO 1, Port B, Daten
	LD	(IX+3),0
	CP	(IX+12)		;Zeichen = EOF ?
	JR	NZ,LBL2		;NEIN
	SET	0,(IX+3)

LBL2:	LD	B,(IX+4)	;Kommandobyte
	BIT	7,B		;mit Paritaet ?
	JR	Z,LBL3		;NEIN
	AND	(IX+11)		;Paritybyte
LBL3:	CP	(IX+0)		;EOR extern ?
	JR	NZ,LBL4		;NEIN
	SET	1,(IX+3)
LBL4:	CALL	KONV1
	BIT	2,B		;EOR-Umwandlung ?
	JR	Z,LBLE		;NEIN
	BIT	1,(IX+3)	;war EOR-Zeichen ?
	JR	Z,LBLE		;NEIN
	LD	A,(IX+1)	;EOR intern

LBLE:	PUSH	AF
	DEC	C
	EI
	HALT

	POP	AF
	POP	BC		;I-Register laden
	PUSH	AF
	LD	A,B
	LD	I,A
	POP	AF
	POP	BC
	POP	HL
	BIT	5,(IX+4)	;mit NUL und DEL ?
	RET	Z		;NEIN
	CP	0		;Zeichen = NUL ?
	JR	Z,LBL		;JA
	CP	7FH		;Zeichen = DEL ?
	JR	Z,LBL		;JA
	RET
;****************************************************************
;*                  Interruptroutine Lochbandleser              *
;****************************************************************
IRLBL	EQU	$

	IF	LBGEN AND 1
	IN	A,(C)		;Adresse + 0
	BIT	4,A
	JR	NZ,IRLBL
	ENDIF

	EI
	RETI

	PAGE
;****************************************************************
;*                  PIO - Steuerworte fuer Stanzen              *
;****************************************************************
SWLBS	EQU	$

	IF	LBGEN AND 1	;fuer   +++   ALB   +++
	DB	0CFH		;MODE 3 : BIT Ein-/Ausgabe
	DB	00FH		;             Ein-/Ausgabe - Maske
	DB	003H		;Interrupt AUS

	DB	00FH		;MODE 0 : BYTE Ausgabe
	DB	LOW(IRLB)
	DB	083H		;Interrupt EIN
	ENDIF


	IF	LBGEN AND 2	;fuer   +++   ADA   +++
	DB	00FH		;MODE 0 : BYTE Ausgabe
	DB	LOW(IRLB)
	DB	083H		;Interrupt EIN

	DB	0CFH		;MODE 3 : BIT Ein-/Ausgabe
	DB	0F0H		;             Ein-/Ausgabe - Maske
	DB	003H		;Interrupt AUS
	ENDIF
;****************************************************************
;*                  PIO - Steuerworte fuer Lesen                *
;****************************************************************
SWLBL	EQU	$

	IF	LBGEN AND 1	;fuer   +++   ALB   +++
	DB	0CFH		;MODE 3 : BIT Ein-/Ausgabe
	DB	0F0H		;             Ein-/Ausgabe - Maske
	DB	003H		;Interrupt AUS

	DB	04FH		;MODE 1 : BYTE Eingabe
	DB	LOW(IRLB+2)
	DB	083H		;Interrupt EIN
	ENDIF


	IF	LBGEN AND 2	;fuer   +++   ADA   +++
	DB	04FH		;MODE 1 : BYTE Eingabe
	DB	LOW(IRLB+2)
	DB	083H		;Interrupt EIN

	DB	0CFH		;MODE 3 : BIT Ein-/Ausgabe
	DB	0F0H		;             Ein-/Ausgabe - Maske
	DB	003H		;Interrupt AUS
	ENDIF

	PAGE
;****************************************************************
;*                  Standard-Anwendercode-Tabelle               *
;****************************************************************
	ORG	07200H
SKTBI:	DEFS	00100H,0

SKTBO:	DEFS	00100H,0


				;(C) Marcus Herbote    K EAW / wfvm
;	END
