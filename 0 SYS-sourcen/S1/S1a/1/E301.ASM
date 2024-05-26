	TITLE	'EDITOR --- Kommandointerpr.'
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
	JP	Z,E3.ZET	;B=Zaehler
	CP	'T'
	JP	Z,E3.TAUS
	CP	'Y'
	JP	Z,E3.STAN
	CP	'X'
	JP	Z,E3.LESE
	CP	'M'
	JP	Z,E3.MOVE
	CP	'N'
	JP	Z,E3.NEUST
	CP	'P'
	JP	Z,E3.PTSL
	CP	'E'
	JR	NZ,E3.ERRO2
	CALL	E2.RESET
	JP	SY.SYSTB
E3.ERRO2:
	LD	C,2	;KOMMANDO FALSCH
E3.FEHL:
	CALL	SY.LCPOS
E3.FEHL1:
	JP	E3.ERRR

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
	CALL	S1.SUZEI
	RET	Z
	CP	'*'
	JR	NZ,E3.Z1
	CALL	E2.RESET
	XOR	A
	LD	(SM.BZA),A
	CALL	S1.SUZEI
	RET	Z		;Blaettern ab #
E3.Z1:
	CALL	S1.IDH
	JR	C,E3.Z4
	JR	Z,E3.ERRO3
E3.ZET1:
	LD	A,2
	LD	(SM.STAT),A
E3.Z3:
	LD	(SM.ZEIZ),HL
	RET
E3.Z4:
	CP	'+'
	JR	NZ,E3.ZEIK
	LD	A,8
	LD	(SM.STAT),A
	LD	HL,1
E3.PL3:
	CALL	S1.SUZA
	JR	C,E3.ERRO3
	LD	(SM.WEITE),HL
	RET

E3.ERR3A:
	POP	AF
E3.ERRO3:
	LD	C,3	;falsche Zahleneingabe
	EX	DE,HL
	JP	E3.FEHL

E3.ZEIK:
	LD	HL,SM.STAT
	LD	M,4
	PUSH	DE
	POP	HL
E3.ZEIKA:
	CALL	S1.KETTE
	JR	C,E3.ERRO4
	JR	Z,E3.ERRO4
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
	JP	E3.FEHL1

E3.TAUS:
	CALL	SY.SZEI2
	RET	Z
	PUSH	HL
	POP	DE
	CALL	S1.KETTE
	JR	C,E3.ERRO4
	JR	Z,E3.ERRO4
	PUSH	BC
	CALL	E3.ZEIKC
	POP	BC
	CALL	SY.SZEI2
	JR	Z,E3.TAU3
	PUSH	HL
	POP	DE
	CALL	S1.KETTE
	JR	C,E3.ERRO4
E3.TAU3:
	LD	HL,SM.LZN
	LD	M,0
	JR	Z,E3.TAU6
	LD	M,A
	INC	DE
	LD	(SM.ZKN),DE
E3.TAU6:
	CALL	E2.QLANG
E3.TAU4:
	CALL	NC,E2.SUCH
	JR	C,E3.ERRO7
	JR	NZ,E3.TAU4
E3.TAU1:
	CALL	Z,E3.EXCH
	CALL	NC,E2.SUCH
	JR	NC,E3.TAU1
E3.TAU2:
	LD	HL,SM.STAT
	BIT	2,M
	JR	Z,E3.TAU5
	LD	M,1
E3.TAU5:
	SET	4,M
	RET

E3.ERRO7:
	LD	C,7	;Zeichenkette nicht vorhanden
	JP	E3.FEHL

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
	CALL	E2.UMLAD
	POP	BC
	LD	HL,(SM.ZKN)
	CALL	E2.UMLA
	PUSH	HL
	POP	BC
	JP	E2.LANG1

E3.NEUST:
	CALL	E2.RESET
	LD	(SM.END),HL
E3.NEU1:
	CALL	E1.NUM
	LD	A,1
	LD	(SM.STAT),A
	LD	HL,(SM.ZMIN2)
	DEC	H
	DEC	L
	LD	(SM.ZPOS2),HL
	RET

E3.LESE:
	CALL	SY.SZEI2
	JR	Z,E3.LESE1
	CP	'*'
	JP	NZ,E3.ERRO2
	CALL	E3.NEUST
E3.LESE1:
	CALL	E2.ZNUMX	;HL=(END)
	PUSH	DE
	CALL	E4.LESER
	POP	HL
	INC	HL
	JP	E3.ZET1

E3.STAN:
	EX	DE,HL
E3.STAN2:
	CALL	S1.SUZA
	JR	NZ,E3.STAN1
	LD	DE,SD.TPA	;DE=Anfang
E3.STAN3:
	LD	HL,(SM.END)	;HL=Ende
E3.STAN6:
	DEC	HL
	CALL	E4.STANZ
	JR	E3.TAU2
E3.STAN1:
	JP	C,E3.ERRO3
	PUSH	BC
	PUSH	DE
	EX	DE,HL
	CALL	E2.QLANG
	JR	C,E3.ERR5C
	CALL	E2.ZNR1	;HL=Startadresse
	POP	DE	;DE=KOZEIposition
	POP	BC
	JP	PO,E3.ERR5B
E3.STAN5:
	PUSH	HL
	CALL	S1.SUZA
	JR	C,E3.STAN1
	POP	DE	;DE=Startadresse
	JR	Z,E3.STAN3
	PUSH	DE
	INC	HL
	EX	DE,HL
	CALL	E2.QLANG
	CALL	E2.ZNR1
	POP	DE
	JP	PO,E3.STAN3
	JR	E3.STAN6

E3.ERR5C:
	POP	DE
E3.ERR5B:
	EX	DE,HL
	LD	C,5	;Zeilennummer zu gross
	JP	E3.FEHL

E3.ERRO8:
	EX	DE,HL
	LD	C,8	;Zeilennummer zu klein
	JP	E3.FEHL

E3.MOVE2:
	CALL	S1.SUZA
	JP	C,E3.ERR3A
	RET	NZ
	LD	A,(SM.SMIN)
	DEC	A
	LD	(SM.SPOS),A
	POP	AF	;SP korrigieren
E3.ERR2A:
	EX	DE,HL
	JP	E3.ERRO2

E3.MOVE:
	EX	DE,HL
	CALL	E3.MOVE2
	LD	(SM.LZN-2),HL
	INC	HL
	LD	(SM.LZN-4),HL
	CALL	E3.MOVE4
	JR	Z,E3.ERR2A
	CP	'>'
	JR	Z,E3.MOVE1
	CALL	S1.SUZA1
	JP	C,E3.ERRO3
	INC	HL
	LD	(SM.LZN-4),HL
	PUSH	BC
	LD	BC,(SM.LZN-2)
	SBC	HL,BC
	POP	BC
	JR	C,E3.ERRO8
	CALL	E3.MOVE4
	JR	Z,E3.ERR2A
	CP	'>'
	JR	NZ,E3.ERR2A
E3.MOVE1:
	CALL	E3.MOVE2
	LD	(SM.LZN-6),HL
	LD	BC,(SM.LZN-4)
	LD	A,1
	LD	(SM.LZN-7),A
	SBC	HL,BC
	ADD	HL,BC
	JR	NC,E3.MOVE3
	LD	BC,(SM.LZN-2)
	XOR	A
	SBC	HL,BC
	JR	NC,E3.ERRO8
	LD	(SM.LZN-7),A
E3.MOVE3:
	PUSH	DE
	CALL	E2.QLANG
	JR	C,E3.ERR5C
	LD	DE,(SM.LZN-6)
	CALL	E2.ZNR1
	JP	PO,ERR5C
	CALL	E2.SET	;WINA=WINE=Zielzeile
	CALL	E2.QLANG
	LD	DE,(SM.LZN-2)
	CALL	E2.ZNR1	;HL=Quellanfang
	JP	PO,E3.ERR5C
	EX	(SP),HL
	PUSH	HL
	CALL	E2.QLANG
	LD	DE,(SM.LZN-4)
	CALL	E2.ZNR1	;HL=Quellende
	POP	DE
	JP	PO,E3.ERR5B
	POP	BC
	PUSH	BC
	OR	A
	SBC	HL,BC	;HL=QE-QA
	PUSH	HL
	CALL	E2.UMLAD
	POP	BC
	POP	HL	;HL=QA
	LD	A,(SM.LZN-7)
	OR	A	;Z=1 fuer rueckwaerts
	JR	NZ,E3.MOVEV
	ADD	HL,BC
E3.MOVEV:
	PUSH	HL
	CALL	E2.UMLA
	POP	HL
	LD	(SM.WINA),HL
	LD	(SM.WINE),DE
	LD	HL,0
	CALL	E2.UMLAD
	JP	E3.TAU2
E3.MOVE4:
	CALL	S1.SUZEI
	RET	Z		;Z=1: Fehler
	CP	'-'
	JR	Z,E3.MOVE4
	RET
E3.PTSL:
	XOR	A
	EX	AF,AF'
	LD	IX,SD.RAM
	LD	(IX+0),SD.PSANZ
	EX	DE,HL
	CALL	S1.LT1Z
	JP	Z,E3.ERR2A
	JP	C,E3.ERRO3
	PUSH	BC
	PUSH	DE
	CALL	E1.PTSNR
	POP	DE
	JP	C,E3.ERR5B
	EXX
	LD	HL,(SM.END)
	LD	DE,(SM.WINA)
	LD	BC,(SM.WINE)
	EXX
	LD	(SM.WINA),HL
	JP	PO,E3.PTSL1
	CPIR
E3.PTSL1:
	DEC	HL
	LD	(SM.WINE),HL
	LD	HL,(SM.PTSE)
	LD	(SM.END),HL
	POP	BC
	CALL	S1.SUZEI
	JR	Z,E3.PTER4
	PUSH	DE
	POP	HL
	CALL	S1.KETTE
	JR	Z,E3.PTER4
	JR	C,E3.PTER4
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
	JR	NC,E3.PTER9	;END+WINA-WINE+L < 0FFFFH   ?
	LD	H,0	;                  RAM+400H ?
	LD	L,A
	INC	DE
	PUSH	HL
	PUSH	DE
	CALL	E2.UMLAD
	POP	HL
	POP	BC
	CALL	E2.UMLA
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
	CALL	E3.PTEX
	JP	E3.ERRO4
E3.PTER9:
	CALL	E3.PTEX
	LD	C,9	;Speicherueberlauf
	JP	E3.FEHL1

E3.ERRR:
	LD	SP,SM.STACK-2
	LD	A,23
	LD	(SM.ZPOS),A
	CALL	S1.ERRO
	JP	ED.MEL11

			;Stand: 30.Januar 85 - K EAW/wfvm..MSH

;	END
