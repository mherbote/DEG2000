	TITLE	'EDITOR --- Peripherieger.'
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
	CALL	E4.LBL
	BIT	0,(IX+3)
	JR	NZ,E4.FERTL
	CP	00AH
	JR	Z,E4.LLQ2
	CP	00DH
	JR	Z,E4.LLQ2
	CP	SD.TAB	;Tabulator
	JR	NZ,E4.LLQ6
	LD	M,SD.SPACE
	CALL	E2.RUFTF
	LD	A,SD.TAB
	JR	NZ,E4.LLQ6
	INC	HL
E4.LLQ6:
	LD	M,A
	CP	M
	JR	NZ,E4.ERR13	;Schreibfehler
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
	JR	Z,E4.FERTL	;(SM.PTS)-2500 = akt. Zeiger
	JR	C,E4.FERTL	;(SM.PTS)-2500 < akt. Zeiger
	JR	E4.LLQ0

E4.LLQ2:
	LD	A,1EH
	DEC	HL
	CP	M
	INC	HL
	JR	Z,E4.LLQ0
	JR	E4.LLQ6

E4.ERR13:
	LD	C,13	;Schreibfehler
E4.ERR0:
	PUSH	HL
	CALL	S1.ERRO
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
	CALL	E4.LBS
	OR	A
	SBC	HL,DE
	ADD	HL,DE
	INC	DE
	JR	NZ,E4.LSQ1
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
	CALL	E4.LBS
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
	CALL	E4.LBS
	JR	E4.LEER1

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
	LD	HL,E4.KONV
	EXX
	LD	B,10101110B	;Kommando
	LD	C,0EFH	;Parity
	LD	DE,0801EH	;EOR - Zeichen
	LD	A,081H	;EOF - Zeichen
	LD	HL,E4.SKTBI
	CALL	E4.TAB
	EXX
	LD	IY,SM.EALBS	;E/A-Tabelle   L B S
	LD	B,10101100B	;Kommando
	LD	C,010H	;Parity
	LD	HL,E4.SKTBO
	JR	E4.ISO

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
	CALL	E4.LEER
	JP	SY.SYSTB


	DW	$
	DB	'EOF '
	CALL	E4.STEND
	CALL	E4.LEER
	JP	SY.SYSTB


	DW	$
	DB	'MB  '
E4.MBIF:
	PUSH	BC
	PUSH	IX
	OUT	(C),SD.AMB	;Aktivierung der  A M B
	LD	BC,255
E4.MBIF1:
	DEC	BC	;Warteschleife ca. 1.27 ms
	LD	A,B
	OR	C
	JR	NZ,E4.MBIF1
	LD	IX,SM.EAAMB
E4.MBIF2:
	BIT	0,(IX+0)	;MB-Geraet 1 bzw. 2 ?
	JR	NZ,E4.MBIF3
	BIT	1,(IX+7)	;MB-Geraet 1  besetzt ?
	JR	E4.MBIF4
E4.MBIF3:
	BIT	1,(IX+8)	;MB-Geraet 2  besetzt ?
E4.MBIF4:
	JR	NZ,E4.MBIF2
	POP	IX
	POP	BC
	RET

			;Stand: 04.Februar 85 - K EAW/wfvm..MSH

;	END
