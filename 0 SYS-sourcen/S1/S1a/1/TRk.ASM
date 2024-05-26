	TITLE 'physische Tastatur-Routine'
	PAGE
;	PN	TR01
;****************************************************************
;*                  TAP / DEG2000 -- physische Tastatur-Routine *
;*  T A P           --------------------------------------------*
;*                  Programmierer: M. Herbote                   *
;*  D E G 2 0 0 0   --------------------------------------------*
;*                  Stand        : 24.August 2022               *
;****************************************************************
TR.ATAST EQU	0A0H		;Grundadresse der Tastaturansteuerung

TR.ANST EQU	2		;2 --- ATS- Ansteuerung

TR.TAST EQU	1		;2 --- Tastatur K 763x

TR.CTR EQU	1		;1 --- ohne Code-Transformation
          	 		;2 --- mit  Code-Transformation

;****************************************************************
;*                  physische Ansteuerung der Tastatur          *
;****************************************************************
TR.TINIT: JP	TR.PIOP2	;Initialisierung der Tastatur
TR.TA1:	JP	TR.TTA12	;U_Int - Abfrage
TR.TA2:	JP	TR.TTA22	;Tastencode-Eingabe
TR.TA3:	JP	TR.TA32		;Warten auf Tasten
TR.TFE:	JP	TR.TFE2		;Warten auf Tastenende
TR.TIM:	JP	TR.TTIM2	;Ansteuerung der INS_MOD - Diode
TR.TEM:	JP	TR.TTEM2	;Ansteuerung der Ebenen  - Dioden
TR.TBEL: JP	TR.TTBL2	;Ansteuerung der Fehleranzeigen

	PAGE
	IF	TR.CTR AND 2
;****************************************************************
;*                  Codewandeltabelle  neue ==> alte Tastatur   *
;****************************************************************
TR.TABB1: DB	36
	DW	08D09H
	DW	0118FH
	DW	09291H
	DW	09493H
	DW	09695H
	DW	09897H
	DW	09A99H
	DW	09C9BH
	DW	09D1FH
	DB	002H
	DW	08B1BH
	DB	01CH
	DW	08E1EH
	DW	01303H
	DW	0050BH
	DW	00A04H
	DW	00607H
	DW	00F01H
	DW	00810H

	DW	0FEFFH
	DW	0FCFDH
	DW	08180H
	DW	08382H
	DW	08584H
	DW	08786H
	DW	08988H
	DW	08B8AH
	DW	01E09H
	DB	0F0H
	DW	0F1F1H
	DB	0F2H
	DW	0F3F3H
	DW	0F6F5H
	DW	0F8F7H
	DW	0FAF9H
	DW	0B0FBH
	DW	0CDCCH
	DW	0CFCEH
TR.TABB2 EQU	$-1
	ENDIF

	PAGE
;****************************************************************
;*                  Initialisierung der Tastatur                *
;****************************************************************
TR.PIOPR: LD	A,TR.ATAST
TR.PIOP2: LD	C,A
	RET

TR.TA31: LD	A,TR.ATAST	;Warten auf gedrueckte Taste
TR.TA32	EQU	$ 
	RET

TR.TFE2:
	RET
	
;****************************************************************
;*                  UP zum Abfragen nach gedrueckter Taste      *
;****************************************************************
TR.TTA11: LD	A,TR.ATAST
TR.TTA12 EQU	$

	IF	TR.ANST AND 2	;ATS
	INC	A		;/UCS2
	ENDIF

	IF	TR.ANST AND 4 OR TR.ANST AND 2
	LD	C,A
	IN	A,(C)
	BIT	3,A
	ENDIF

	RET

;****************************************************************
;*                  UP zum Einlesen des Tastaturcodes           *
;****************************************************************
TR.TTA21: LD	A,TR.ATAST
TR.TTA22: LD	C,A

	IF	TR.ANST AND 4 OR TR.ANST AND 2
	IN	A,(C)		;/UCS1
	ENDIF

	IF	TR.CTR AND 2
	PUSH	HL		;Codewandlung neue ==> alte Tast.
	PUSH	BC
	LD	HL,TR.TABB1
	LD	B,0
	LD	C,(HL)
	INC	HL
	CPIR
	JR	NZ,TR.KODE
	OR	A
	LD	HL,TR.TABB2
	SBC	HL,BC
	LD	A,(HL)
TR.KODE: POP	BC
	POP	HL
	ENDIF

	RET

	PAGE
;****************************************************************
;*                  Ansteuerung der INS_MOD - Diode             *
;****************************************************************
TR.TTIM1:
TR.TTIM2:
	RET

	PAGE
;****************************************************************
;*                  Ansteuerung der Ebenen  - Dioden            *
;****************************************************************
TR.TTEM1: LD	A,TR.ATAST
TR.TTEM2: LD	C,A
	RET

	PAGE
;****************************************************************
;*                  Ansteuerung der Fehleranzeigen              *
;****************************************************************
TR.TTBL1:
TR.TTBL2:
	RET

			;Stand: 24.August 22 - MSH

;	END
