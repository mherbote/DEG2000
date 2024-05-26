	TITLE 'physische Tastatur-Routine'
	PAGE
;	PN	TR01
;****************************************************************
;*                  TAP / DEG2000 -- physische Tastatur-Routine *
;*  T A P           --------------------------------------------*
;*                  Programmierer: M. Herbote  K EAW  ZFT (WFT) *
;*  D E G 2 0 0 0   --------------------------------------------*
;*                  Stand        : 06.Februar 1985              *
;****************************************************************
TR.ATAST EQU	0A0H		;Grundadresse der Tastaturansteuerung

TR.ANST EQU	2		;8 --- PIO- Ansteuerung
				;4 --- ATD- Ansteuerung
				;2 --- ATS- Ansteuerung

TR.TAST EQU	2		;1 --- Tastatur K 760x
				;2 --- Tastatur K 763x

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

	IF	TR.ANST AND 8
PPTAB:	DB	0CFH
	DB	0FFH
	DB	003H

PTAB1:	DB	0CFH
	DB	001H
	DB	003H

PTAB2:	DB	0CFH
	DB	0F0H
	DB	003H
	ENDIF

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

;	IF	(TR.ANST AND 2) AND (TR.TAST AND 2)
;	PUSH	AF
;	ENDIF

	INC	C
	INC	C

;	IF	TR.ANST AND 8	;PIO
;	LD	HL,PTAB1
;	CALL	TR.PIOU3
;	INC	C
;	LD	HL,PPTAB
;	CALL	TR.PIOU3
;	RET
;TR.PIOUM: LD	A,TR.ATAST
;TR.PIOU2: LD	C,A
;	LD	A,0FEH		;DB tristate
;	OUT	(C),A
;	INC	C
;	INC	C
;	INC	C
;TR.PIOU3: LD	B,3
;	OTIR
;	ENDIF

	IF	TR.ANST AND 4 OR TR.ANST AND 2
	XOR	A
	OUT	(C),A
	DEC	C
	DEC	C
	IN	A,(C)
	LD	BC,8000H
	DEC	BC
	LD	A,B
	OR	C
	JR	NZ,$-3

;	IF	(TR.ANST AND 2) AND (TR.TAST AND 2)
;	POP	AF
;	CALL	TR.TA32
;	ENDIF

TR.PIOUM EQU	$
TR.PIOU2 EQU	$
	ENDIF

	RET

TR.TA31: LD	A,TR.ATAST	;Warten auf gedrueckte Taste
TR.TA32	EQU	$ 
;;	PUSH	AF
;;	CALL	TR.TA1
;;	POP	BC
;;	LD	A,B
;;	JR	NZ,TR.TA32
	CALL	TR.TA2
	RET

TR.TFE1: LD	A,TR.ATAST	;Warten auf Tastenende
TR.TFE2: RET
	PUSH	AF
	CALL	TR.TA1
	POP	BC
	LD	A,B
	PUSH	AF
	CALL	TR.TA2
	POP	AF
	JR	Z,TR.TFE2
	RET

	PAGE
;****************************************************************
;*                  UP zum Abfragen nach gedrueckter Taste      *
;****************************************************************
TR.TTA11: LD	A,TR.ATAST

TR.TTA12 EQU	$
	IF	TR.TAST AND 1
	PUSH	AF
	ENDIF

;	IF	TR.ANST AND 8	;PIO
;	LD	C,A
;	LD	A,0FEH		;DB tristate
;	OUT	(C),A
;	LD	A,0FAH		;/UCS2
;	OUT	(C),A
;	IN	A,(C)
;	BIT	0,A
;	ENDIF

;	IF	TR.ANST AND 4	;ATD
;	ADD	4		;/UCS2
;	ENDIF

	IF	TR.ANST AND 2	;ATS
	INC	A		;/UCS2    ;A1h
	ENDIF

	IF	TR.ANST AND 4 OR TR.ANST AND 2
	LD	C,A
	IN	A,(C)
	BIT	3,A
	ENDIF

	IF	TR.TAST AND 1	;alte Tastatur  ( K 760x )
	SET	2,A		;CTRL ausschalten
	POP	BC
	RET	Z		;RET wenn /UInt aktiv
	PUSH	AF
	LD	A,B		;liegt gueltige Taste an ?
	CALL	TR.TTA22
	OR	A		;Z=1 wenn keine gueltige Taste
	JR	NZ,$+4		;---!
	POP	AF		;   !
	RET			;   !
	POP	AF		;<--!
	RES	3,A		;/UINT akivieren
	BIT	3,A
	ENDIF

	RET
;****************************************************************
;*                  UP zum Einlesen des Tastaturcodes           *
;****************************************************************
TR.TTA21: LD	A,TR.ATAST
TR.TTA22: LD	C,A

;	IF	TR.ANST AND 8	;PIO
;	LD	A,0FCH		;/UCS1
;	OUT	(C),A
;	INC	C
;	IN	A,(C)
;	ENDIF

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
TR.TTIM1: LD	A,TR.ATAST
TR.TTIM2: LD	C,A		;( B )___bit 7       INS_MOD
	PUSH	AF		;        bit 3,2,1,0 aktuelle Ebene

;	IF	TR.ANST AND 8	; P I O
;	LD	HL,PTAB2
;	CALL	TR.PIOU2
;	ENDIF

	POP	AF
	PUSH	AF

	IF	TR.TAST AND 1	;alte Tastatur  ( K 760x )
	BIT	7,B
	JR	NZ,$+6		;---!
	LD	B,0F7H		;   !     /UCS4: UB3
	JR	$+4		;------!
	LD	B,0FDH		;<--!  !  /UCS4: UB1
	ENDIF			;<-----!

;	IF	TR.TAST AND 2	;neue Tastatur  ( K 763x )
;	LD	A,B
;	AND	00FH
;	CPL
;	BIT	7,B
;	JR	Z,$+4		;---!
;	RES	4,A		;   !     /UCS4: UB4
;	LD	B,A		;<--!
;	ENDIF

TR.TTIM4 EQU	$

;	IF	TR.ANST AND 8	; P I O
;	LD	A,0EEH		; /UCS4
;TR.TTIM3: OUT	(C),A
;	INC	C
;	OUT	(C),B
;	POP	AF
;	LD	HL,PPTAB
;	CALL	TR.PIOU2
;	ENDIF

;	IF	TR.ANST AND 4	; A T D
;	PUSH	BC
;	LD	B,12		; /UCS4
;	ENDIF

	IF	TR.ANST AND 2	; A T S
	PUSH	BC
	LD	B,2		; /UCS4
	ENDIF

	IF	TR.ANST AND 2 OR TR.ANST AND 4
TR.TTIM3: INC	C
	DJNZ	$-1
	POP	AF
	OUT	(C),A
	POP	AF
;	IF	(TR.ANST AND 2) AND (TR.TAST AND 2)
;	CALL	TR.TA32
;	ENDIF

	ENDIF

	RET

	PAGE
;****************************************************************
;*                  Ansteuerung der Ebenen  - Dioden            *
;****************************************************************
TR.TTEM1: LD	A,TR.ATAST
TR.TTEM2: LD	C,A

;	IF	TR.TAST AND 2	;neue Tastatur  ( K 763x )
;TR.TTEM3: JR	TR.TTIM2
;	ENDIF

	IF	TR.TAST AND 1	;alte Tastatur  ( K 760x )
	PUSH	AF

;	IF	TR.ANST AND 8	; P I O
;	LD	HL,PTAB2
;	CALL	TR.PIOU2
;	ENDIF

	POP	AF
	PUSH	AF

	LD	A,B
	AND	00FH
	CPL
	LD	B,A

;	IF	TR.ANST AND 8	; P I O
;	LD	A,0F6H		; /UCS3
;	JR	TR.TTIM3
;	ENDIF

;	IF	TR.ANST AND 4	; A T D
;	PUSH	BC
;	LD	B,8		; /UCS3
;	ENDIF

	IF	TR.ANST AND 2	; A T S
	PUSH	BC
	LD	B,7		; /UCS3
	ENDIF

	IF	TR.ANST AND 2 OR TR.ANST AND 4
	JR	TR.TTIM3
	ENDIF

	ENDIF


	PAGE
;****************************************************************
;*                  Ansteuerung der Fehleranzeigen              *
;****************************************************************
TR.TTBL1: LD	A,TR.ATAST
TR.TTBL2: LD	C,A		;( B )___bit 3,2,1,0 aktuelle Ebene
				;        bit 4       Fehlerlampe
				;        bit 5       Hupe lang
				;        bit 6       Hupe kurz
				;        bit 7       INS_MOD

;	IF	TR.ANST AND 8	; P I O
;	PUSH	AF
;	LD	HL,PTAB2
;	CALL	TR.PIOU2
;	POP	AF
;	ENDIF

	PUSH	AF

;	IF	TR.TAST AND 2	;neue Tastatur  ( K 763x )
;	LD	A,B
;	AND	00FH
;	CPL
;	BIT	7,B
;	JR	Z,$+4		;---!
;	RES	4,A		;   !     /UCS4: UB4
;	BIT	4,B		;<--!
;	JR	Z,$+4		;------!
;	RES	5,A		;      !  /UCS4: UB5
;	BIT	5,B		;<-----!
;	JR	Z,$+4		;---!
;	RES	6,A		;   !     /UCS4: UB6
;	BIT	6,B		;<--!
;	JR	Z,$+4		;------!
;	LD	A,020H		;      !  /UCS4: UB0,1,2,3,4,6,7
;	LD	B,A		;<-----!
;	JP	TR.TTIM4
;	ENDIF

	IF	TR.TAST AND 1	;alte Tastatur  ( K 760x )
	BIT	4,B
	JR	NZ,TR.BL3
	BIT	5,B
	JR	NZ,TR.BL3
	BIT	6,B
	JR	NZ,TR.BL3

	LD	A,0F7H		;         /UCS4: UB3
	JR	TR.BL4

TR.BL3:	LD	A,0FEH		;         /UCS4: UB0
	BIT	7,B
	JR	Z,TR.BL4
	RES	1,A		;         /UCS4: UB1

TR.BL4:	LD	B,A

;	IF	TR.ANST AND 8	; P I O
;	LD	A,0EEH		; /UCS4
;	OUT	(C),A
;	INC	C
;	OUT	(C),B
;	POP	AF
;	LD	HL,PPTAB
;	CALL	TR.PIOU2
;	ENDIF

;	IF	TR.ANST AND 4	; A T D
;	PUSH	BC
;	LD	B,12		; /UCS4
;	ENDIF

	IF	TR.ANST AND 2	; A T S
	PUSH	BC
	LD	B,2		; /UCS4
	ENDIF

	IF	TR.ANST AND 2 OR TR.ANST AND 4
	INC	C
	DJNZ	$-1
	POP	AF
	OUT	(C),A
	POP	AF
;	IF	TR.ANST AND 2
;	IF	TR.TAST AND 2
;	CALL	TR.TA32
;	ENDIF
;	ENDIF
	ENDIF

	RET

	ENDIF

			;Stand: 07.Februar 85 - K EAW/wfvm..MSH


;	END
