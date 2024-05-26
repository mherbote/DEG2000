	TITLE 'Routinen fuer Kassette,Monitor UND Tastatur'
	PAGE
;	PN	UR
;	ORG	49A0H
;----------------------------------------------------------------------
;
;   ROUTINEN FUER KASSETTE,MONITOR UND TASTATUR
;
;----------------------------------------------------------------------
;   1.     KASSETTE
;----------------------------------------------------------------------
UR.KRE:
	LD	(IX+4),31H
UR.KRE1:
	CALL	UF.EXEC
	RET
UR.KRW:
	LD	(IX+4),21H
	JR	UR.KRE1	;Umspulen
UR.KRWW:
	CALL	UR.KRW
	RET
UR.KRA:
	LD	(IX+4),41H
	JR	UR.KRE1	;Reservieren aus
UR.KLV:
	LD	(IX+4),71H
	JR	UR.KRE1	;Label vorsetzen
UR.KLR:
	LD	(IX+4),75H
	JR	UR.KRE1	;LABEL RUECKSETZEN
UR.KBM:
	LD	(IX+4),51H
	JR	UR.KRE1	;BANDMARKE SCHREIBEN
UR.KSL:
	LD	(IX+4),61H
	JR	UR.KRE1	;SCHLUSSLUECKE SCHREIBEN
UR.KBV:
	LD	(IX+4),11H
	JR	UR.KRE1	;Block vorsetzen
UR.KBR:
	LD	(IX+4),15H
	JR	UR.KRE1
UR.RPOS:
	PUSH	HL
	PUSH	DE
	PUSH	AF
	PUSH	BC
	XOR	A
	DEC	A
	LD	C,A
	JR	$+8
UR.POSIK:
	PUSH	HL
	PUSH	DE
	PUSH	AF
	PUSH	BC	;Positionieren
	XOR	A
	LD	C,A
	LD	B,0
	LD	DE,0
UR.LES:
	LD	(IX+4),02H
	CALL	UF.EXEC	;BLOCK LESEN
	LD	A,(IX+9)
	OR	(IX+10)	;BANDMARKE?
	JR	Z,UR.BM
	INC	B	;ANZAHL BLOECKE
	LD	A,B
	CP	4
	JR	Z,UR.OK
	LD	HL,0
	CALL	XY.LIDX
	DB	9	;HL<--BLOCKLAENGE
	ADD	HL,DE
	EX	DE,HL
	LD	HL,300
	OR	A
	SBC	HL,DE
	JR	C,UR.OK
	JR	UR.LES
UR.BM:
	XOR	A
	OR	C
	JR	Z,$+6
	POP	BC
	INC	B
	JR	UR.POSIK+3
	POP	BC
	DEC	B
	JR	Z,UR.RSP
	JR	UR.POSIK+3
UR.OK:
	XOR	A
	OR	C
	JR	Z,$+10
	LD	(IX+10),B
	CALL	UR.KLR
	JR	UR.RSP
	LD	(IX+4),15H
	CALL	UF.EXEC
	DJNZ	$-7
	POP	BC
	DEC	B
	JR	Z,UR.RSP
	LD	(IX+10),B
	CALL	UR.KLV
UR.RSP:
	POP	AF
	POP	DE
	POP	HL
	RET
;----------------------------------------------------------------------
;     2.     MONITOR
;----------------------------------------------------------------------
UR.MIMO:
	PUSH	DE	;Register DE, BC retten
	PUSH	BC
	LD	B,(HL)	;Anzahl einzugebender Zeichen
	INC	HL
	LD	C,(HL)	;Laenge der Zeichenkette
	INC	HL
	LD	E,(HL)	;Zeichenschluessel
	INC	HL
	LD	A,(UB.ZN)	;Zeilennummer
	LD	D,A	;D:= Zeilennummer
	XOR	A
	CP	C
	JR	Z,UR.MIMO1	;Anzeige entfaellt
	PUSH	DE
	CALL	UR.DSPZK	;Anzeige
UR.MIMO2:
	POP	DE
	CALL	UR.ZINP	;Zeicheneingabe ueber Tastatur
	POP	BC
	POP	DE
	JR	UR.MIMO3
UR.MIMO1:
	PUSH	DE
	CALL	UR.BBSAD	;BWS - Adresse berechnen
	EX	DE,HL	;HL:= akt. Bildschirmposition
	JR	UR.MIMO2
UR.MIMO3:
	PUSH	AF
	LD	A,(UB.ZN)
	INC	A
	CP	24
	CALL	Z,UR.BILRO	;Zeile 24 ---> Bild rollen
	LD	(UB.ZN),A
	POP	AF
	RET
UR.BBSAD:
	PUSH	HL	;Berechnung der BWS-Adresse
	PUSH	BC	;IN:    D...Zeilennummer
	LD	HL,UE.BWSA-80	;OUT:   DE..BWS-Adresse
	LD	BC,80	;BC:= Zeichen/Zeile
UR.BBSA1:
	ADD	HL,BC
	DEC	D
	JR	NZ,UR.BBSA1
	EX	DE,HL
	POP	BC
	POP	HL
	RET
UR.DSPZK:
	PUSH	DE	;Anzeige
	PUSH	BC	;IN   HL...Anfangsadresse ZK
	CALL	UR.BBSAD	;      D...Zeilennummer
	LD	B,0	;      C...Zeichenkettenlaenge
	LDIR		;OUT  HL...akt. BWS-Adresse
	EX	DE,HL
	POP	BC
	POP	DE
	RET
UR.ZINP:
	PUSH	HL	;Zeicheneingabe ueber Tastatur
	XOR	A	;IN    B...Zeichenanzahl (max.)
	LD	D,B	;     HL...akt. Adresse
	CP	B	;      E...Zeichenschluessel
	JR	Z,UR.RET0	;keine Zeicheneingabe
UR.ZINP1:
	SET	7,(HL)	;Kursor setzen
UR.ZINP2:
	CALL	UR.TAREP	;Tastaturabfrage
	CALL	UR.TCL	; <---
	CALL	UR.TCR	; --->
	CALL	UR.TSYS	; SYS
	CALL	UR.TQUIT	; POS.QUIT
	CALL	UR.ZKONT	;Zeichenkontrolle
	RES	7,(HL)	;Kursor loeschen
	LD	(HL),A	;Zeichen anzeigen
	INC	HL	;akt. Adresse erhoehen
	DJNZ	UR.ZINP1	;B > 0, naechstes Zeichen
	SET	7,(HL)	;Kursor setzen
UR.ZINP5:
	CALL	UR.TAREP
	CP	UE.TACL
	CALL	Z,UR.ZINP7
	CP	UE.TAQUI
	JR	Z,UR.ZINP3	;---> POS.QUIT
	CP	UE.TASYS
	JR	Z,UR.ZINP4	;---> SYS
	JR	UR.ZINP5
UR.ZINP3:
	RES	7,(HL)	;Kursor loeschen
	POP	HL	;BWS - Adresse auskellern
	XOR	A	;CY:= 0
	RET
UR.ZINP4:
	RES	7,(HL)	;Kursor loeschen
	POP	HL
	SCF		;CY:= 1
	RET
UR.RET0:
	POP	HL	;keine Zeicheneingabe
	XOR	A
	RET
UR.ZINP7:
	CALL	UR.TCL
	INC	SP
	INC	SP
	JR	UR.ZINP2
UR.TCL:
	CP	UE.TACL	;   <---
	RET	NZ		;Taste nicht gedrueckt
	PUSH	AF	;Tastencode retten
	INC	B
	LD	A,D
	CP	B
	JR	C,UR.TCLN	;Linksbewegung nicht zulaessig
	RES	7,(HL)	;Kursor loeschen
	DEC	HL	;BWS - Adresse decrementieren
	SET	7,(HL)	;Kursor setzen
	POP	AF	;Code auskellern
	RET
UR.TCLN:
	DEC	B
	POP	AF
	RET
UR.TCR:
	CP	UE.TACR	;   --->
	RET	NZ
	PUSH	AF
	LD	A,B
	CP	2
	JR	C,UR.TCRN
	DEC	B
	RES	7,(HL)
	INC	HL
	SET	7,(HL)
UR.TCRN:
	POP	AF
	RET
UR.TSYS:
	CP	UE.TASYS	; SYS-Taste
	RET	NZ
	INC	SP
	INC	SP	;Returnadresse uebergehen
	JP	UR.ZINP4
UR.TQUIT:
	CP	UE.TAQUI	; POS.QUIT
	RET	NZ
	INC	SP
	INC	SP
	JP	UR.ZINP3
UR.ZKONT:
	CP	7FH
	JR	NC,UR.ZKON1
	BIT	7,E	;Zeichenschluesselauswertung
	RET	NZ		;Bit 7 = L, alle Tasten erlaubt
	CP	20H
	RET	Z		;Leertaste
	BIT	5,E
	SCF
	CALL	NZ,UR.ALPHA
	RET	NC		;Bit 5 = L, nur Buchstaben
	BIT	4,E
	SCF
	CALL	NZ,UR.NUM
	RET	NC		;Bit 4 = L, nur Ziffern
	BIT	6,E
	SCF
	CALL	NZ,UR.ALPNU
	RET	NC		;Bit 6 = L, Buchstaben und
			;            Ziffern
	BIT	3,E
	SCF
	CALL	NZ,UR.HEXAZ
	RET	NC		;BIT 3 = L ,HEXAZEICHEN
UR.ZKON1:
	INC	SP
	INC	SP
	JP	UR.ZINP2	;unerlaubter Tastencode
UR.ALPHA:
	CP	41H
	RET	C
	CP	5BH
	JR	C,UR.ALPH1
	SCF
	RET
UR.ALPH1:
	CCF
	RET
UR.NUM:
	CP	30H
	RET	C
	CP	3AH
	JR	C,UR.ALPH1
	SCF
	RET
UR.ALPNU:
	CALL	UR.ALPHA
	RET	NC
	CALL	UR.NUM
	RET	NC
	SCF
	RET
UR.HEXAZ:
	CALL	UR.NUM
	RET	NC
	CP	'A'
	RET	C
	CP	'G'
	JR	C,UR.HEXZ1
	SCF
	RET
UR.HEXZ1:
	CCF
	RET

UR.TAREP:
	CALL	UE.TARO	;TASTATURROUTINE FUER ATS
	JR	Z,$-3	;ES LIEGT KEIN ZEICHEN AN
	RET

UR.BILRO:
	PUSH	BC
	PUSH	DE
	PUSH	HL
	LD	BC,960
	LD	DE,UE.BWSA+880
	LD	HL,UE.BWSA+960
	LDIR
	LD	A,20H	;letzte Zeile loeschen
	LD	B,80
UR.BILR1:
	LD	(DE),A
	DJNZ	UR.BILR1
	POP	HL
	XOR	A
	LD	BC,80
	SBC	HL,BC	;aktuelle BWS-Adresse nach  ROLL
	LD	A,(UB.ZN)
	POP	DE
	POP	BC
	RET
;----------------------------------------------------------------------
;	END
