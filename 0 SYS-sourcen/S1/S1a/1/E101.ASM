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
	CALL	SY.ICPOS
	JR	E1.CNEW2

;NL-Funktion

E1.CNEW:
	CALL	SY.CPOS
	LD	M,C
	LD	BC,(SM.SPOS)
	LD	B,0
	INC	C
	DEC	C
	JR	Z,E1.CNEW3
	LD	A,M
	DEC	HL
	CPDR
	JR	NZ,E1.CNEW3
	INC	HL
	LD	M,SD.SPACE
E1.CNEW3:
	CALL	SY.ISPOS
	JR	C,E1.CNEW1
	CALL	S1.SPOSN
	CALL	SY.DEL2
	LD	A,(SM.SMIN)
	DEC	A
	LD	(SM.SPOS),A
E1.CNEW1:
	CALL	SY.IZPOS
E1.CNEW2:
	CALL	C,SY.DZPOS
	CALL	C,E1.LIFT
	CALL	E1.ZNUM
	RET

;1.Bildzeile umladen

E1.UMLZ1:
	LD	BC,(SM.SPANZ)
	LD	B,0
	CALL	E2.UMLT
	LD	(SM.WINA),HL
E1.ZEINR:
	LD	BC,SD.TPA
	CALL	E2.LANG
	CALL	E2.ZNX2
	LD	(SM.ZEIZ),DE
	RET

E1.LIFT:
	CALL	E1.UMLZ1
	LD	A,(SM.ZMAX)
E1.LIFT1:
	DEC	A
	CALL	E1.BIL1
	PUSH	HL
	POP	BC
	CALL	SY.DESZ
	PUSH	DE
	EX	DE,HL
	LD	DE,SD.BWSA
	ADD	HL,DE	;HL=BWSA+(SPANZ)
	LDIR
	POP	BC
	LD	B,C
	EX	DE,HL
	CALL	SY.DEL1
	RET

;Bildpuffer loeschen

E1.LOEBP:
	CALL	E1.BIL
E1.LOBP1:
	LD	BC,SD.BWSA-SD.BPA-1
	ADD	HL,BC
	PUSH	HL
	POP	BC
	JR	E1.PULO
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
	CALL	E1.UMLZ1
	POP	AF
	JR	NZ,E1.LIFT1
	LD	A,(SM.SPANZ)
	LD	HL,SD.BWSA
	JP	SY.DEL2

;Tabulator Aufruf

E1.TAB:
	CALL	E1.TAUP
	JR	NC,E1.TAB1
	LD	A,M
	LD	HL,(SM.SMAX)
	CP	L
	JR	NC,E1.TAB1
E1.TAB2:
	LD	(SM.SPOS),A
	RET	Z
	CALL	E2.RUFTF
	RET	NZ
	LD	A,SD.TAB
	JP	E1.ZSCH1

E1.TAB1:
	LD	A,(SM.SMIN)
	DEC	A
	JR	E1.TAB2

E1.TAUP:
	LD	A,(SM.SPOS)
E1.TAUP2:
	LD	HL,SM.TABZ
	LD	B,SD.TABZA
E1.TAUP1:
	CP	M
	RET	C,	;CY=1: gefunden
	INC	HL
	DJNZ	E1.TAUP1
	RET

;Tabulator setzen

E1.TABS:
	CALL	E1.TAUP
	JR	C,E1.TABS1
	DEC	HL
	INC	B
E1.TABS1:
	DJNZ	E1.TABS3
	LD	M,A
	RET
E1.TABS3:
	LD	C,A
	LD	A,SD.TABZA
	CP	B
	LD	A,C
	JR	Z,E1.TABS4
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
	CALL	E1.TAUP
	JR	C,E1.TABL1
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
	CALL	SY.CNRS
	JR	E1.TCUR
E1.TCNLS:
	CALL	SY.CNLS
	JR	E1.TCUR
E1.TCNOS:
	CALL	SY.CNOS
	JR	E1.TCUR
E1.TCNUS:
	CALL	SY.CNUS
	JR	E1.TCUR
E1.TCNZA:
	CALL	SY.IFKT2
	JR	E1.TCUR
E1.THOME:
	CALL	SY.IFKT1
E1.TCUR:
	CALL	E1.ZNUM
	RET

;Anzahl der NL zwischen BWSA und ZLPOS

E1.BIZA:
	CALL	SY.ZLPOS
	INC	HL
	LD	BC,SD.BWSA
	CALL	E2.LANG
	CALL	E2.ZNX2
	DEC	DE	;DE=NL Anzahl
	RET

;Zeilennummer ausschreiben

E1.ZNUM:
	CALL	E1.BIZA
	LD	HL,(SM.ZEIZ)
	ADD	HL,DE
	JR	E1.NUM1
E1.NUM:
	LD	HL,(SM.ZEIZ)
E1.NUM1:
	LD	BC,-13
	LD	A,(SM.ZANZ)
	LD	DE,S1.ZS12
	JP	S1.MELDN

;Absatz einfuegen

E1.ABS:
	CALL	E1.REPEL
	CALL	SY.CPOS
	LD	M,SD.NL
	LD	A,0
	LD	(SM.ZSMER),A
	LD	HL,SM.STAT
	SET	4,M
	JP	E2.TEXL

;Zeichen rechts von Cursor heranziehen

E1.ATTR:
	CALL	SY.CPOS
	LD	IX,S1.RNL
	LD	M,SD.SPACE
E1.ATTR1:
	CALL	S1.SPOSN
	DEC	A
	RET	Z
	LD	C,A
	LD	B,0
	CALL	S1.MX
	LD	HL,SM.ZSMER
	LD	M,1
	RET

;Zeichen rechts von Cursor wegschieben

E1.REPEL:
	CALL	S1.ZENDF
	LD	A,M
	CP	SD.SPACE
	RET	NZ
	LD	IX,S1.RNR
	JR	E1.ATTR1

;Zeile loeschen

E1.DELZ:
	CALL	SY.DELZL
	CALL	SY.IZPOS
	CALL	C,SY.DZPOS
	CALL	E1.ZNUM
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
	LD	DE,E1.PTS1-1
	OR	A
	SBC	HL,DE
	CALL	E1.PTSNR
	RET	C
	RET	PO
E1.PTS92:
	XOR	A
	OR	M
	RET	Z
	PUSH	HL
	CP	SD.NL
	JR	Z,E1.PTS91
	CALL	E1.ZSCH1
	JR	E1.PTS93
E1.PTS91:
	LD	C,A
	CALL	E1.CNEW
E1.PTS93:
	POP	HL
	INC	HL
	JR	E1.PTS92

E1.PTSNR:
	EX	DE,HL
	LD	BC,(SM.PTSA)
	LD	HL,(SM.PTSE)
	CALL	E2.LANG
	RET	C
	XOR	A
E1.PTSN1:
	DEC	E
	JR	Z,E1.PTSN2
	CPIR
	RPO
	JR	E1.PTSN1
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
	CALL	E1.PTEST
	JR	Z,E1.PS1
	LD	(SM.PTSA),BC
	LD	HL,SD.RAM+3FFH
	XOR	A
	SBC	HL,BC
	PUSH	BC
	EX	(SP),HL
	POP	BC
E1.PS2:
	LD	E,SD.PSANZ+1
	CALL	E1.PTSN1
	LD	(SM.PTSE),HL
	RET
E1.PS1:
	LD	HL,SY.PFT1
	LD	(SM.PTSA),HL
	LD	BC,3FFH
	JR	E1.PS2

E1.GS:
	LD	A,1DH
E1.GS1:
	JP	E1.ZSCH1
E1.HT:
	LD	A,9
	JR	E1.GS1
E1.CA:
	LD	A,18H
	JR	E1.GS1
E1.UND:
	LD	A,26H
	JR	E1.GS1
E1.DOL:
	LD	A,24H
	JR	E1.GS1
E1.SCHW:
	LD	A,40H
	JR	E1.GS1

			;Stand: 30.Januar 85 - K EAW/wfvm..MSH

;	END
