	TITLE	'Fehleranzeige  UND  BEHANDLUNG'
	PAGE
;	PN	UF
;***************************************************************
;
;      Fehleranzeige  UND  BEHANDLUNG
;
;***************************************************************
UF.RET:
	POP	AF
	POP	BC
	POP	DE
	POP	HL
	RET
;---------------------Ausfhr. Kass.kommando lt.Steuerblock-------------
UF.EXEC:
	PUSH	HL
	PUSH	DE
	PUSH	BC
	PUSH	AF
	RES	7,(IX)
	LD	(IX+1),0
	CALL	KR.KARO
UF.EXEC1:
	LD	A,41H
	CP	(IX+5)
;	JR	Z,UF.EXEC2
;	BIT	4,(IX)
;	JR	NZ,UF.ERA1
;UF.EXEC2:
	BIT	7,(IX)
	JR	Z,UF.RET
;-------------------------Fehlerbehandlung---------------
;UF.ERA1:
; 	RES	7,(IX)
; 	LD	C,(IX+4)
; 	LD	A,(IX+1)
; 	JR	$+6
UF.ERANZ:
	PUSH	HL
	PUSH	DE
	PUSH	BC
	PUSH	AF
	PUSH	AF
	LD	A,19
	LD	(UB.ZN),A
	LD	HL,UA.ZKF	;IN: <A> Fehlerschluessel
	CALL	UR.MIMO
	POP	AF
	PUSH	AF
	EX	DE,HL
	CALL	UC.CVBX+2
	POP	AF
	CP	17H
	JP	Z,UF.FL17
	CP	18H
	JP	Z,UF.FL18
	CP	00H
	JP	Z,UF.BEHB
	CP	11H
	JP	Z,UF.BEHB
	CP	19H
	JR	Z,UF.AZVB
	CP	14H
	JP	Z,UF.FL14
	CP	16H
	JP	Z,UF.FL16
	JP	UF.RET
;----------------------------------------------------------------------
UF.SYS:
	LD	A,(IX+1)
	LD	DE,UE.BWSA+5A8H
	CALL	UC.CVBX+2
	NOP
	NOP
	NOP
UF.SYS1:
	LD	SP,UE.STANF
	RET
;----------------------------------------------------------
UF.AZVB:
	RES	2,(IX)	;Aufzeichnen verboten
	LD	(IX+5),41H
	CALL	KR.KARO
	BIT	7,(IX)
	JR	NZ,UF.SYS
	LD	HL,UA.FRZ
	CALL	UR.MIMO
	JR	C,UF.SYS1
	LD	(IX+5),31H
	CALL	KR.KARO
	BIT	4,(IX)
	JR	NZ,UF.SYS
	BIT	7,(IX)
	JR	NZ,UF.SYS
	BIT	2,(IX)
	JR	NZ,UF.SYS
	JP	UF.BEHB1
;----------------------------------------------------------
UF.BEHB:
	LD	HL,UA.FRZ
	CALL	UR.MIMO
	JR	C,UF.SYS1
UF.BEHB1:
	LD	(IX+5),C	;??? Inhalt von C
	JP	UF.EXEC+4
;---------------------------------------
UF.FL18:
	; LD	B,3
	; LD	(IX+5),15H
	; CALL	KR.KARO
	; BIT	7,(IX)
	; JP	NZ,UF.SYS
	; DJNZ	$-14
	; LD	B,8
	; LD	(IX+5),02H
	; CALL	KR.KARO
	; BIT	7,(IX)
	; JP	NZ,UF.SYS
	; LD	A,(IX+9)	;8 BLOECKE LESEN        ;###
	; OR	(IX+10)                             ;###
	; JR	Z,$+7
	; DJNZ	$-22
	; JP	UF.SYS
	LD	HL,UA.BMGF
	CALL	UR.MIMO
	JP	C,UF.SYS1
	JP	UF.RET
;------------------------------------------
UF.FL17:
; 	LD	B,5
; 	RES	7,(IX)
; 	LD	(IX+4),15H
; 	LD	H,2
; 	CALL	KR.KARO
; 	BIT	7,(IX)
; 	JP	NZ,UF.SYS	;2 BLOECKE ZURUECK
; 	DEC	H
; 	JR	NZ,$-11
; 	LD	(IX+4),C	;WDHLG
; 	CALL	KR.KARO
; 	BIT	7,(IX)
; 	JR	NZ,$+5
; 	JP	UF.RET
; 	DJNZ	$-38
;----------------------------------------------------------------------
; 	RES	7,(IX)	;ERMITTELN DER BLOCKLAENGE
; 	LD	(IX+5),15H
; 	CALL	KR.KARO
; 	BIT	7,(IX)
; 	JP	NZ,UF.SYS
; 	LD	(IX+5),02H
; 	CALL	KR.KARO	;NAECHSTEN BLOCK LESEN
; 	BIT	7,(IX)
; 	JP	NZ,UF.SYS
; 	LD	A,(IX+9)                            ;###
; 	OR	(IX+10)	;BM ?                       ;###
; 	PUSH	AF
; 	LD	B,2
; 	LD	(IX+5),15H
; 	CALL	KR.KARO	;POS.VOR FEHLERHAFTEN BLOCK
; 	BIT	7,(IX)
; 	JP	NZ,UF.SYS
; 	DJNZ	$-10
; 	POP	AF
; 	JR	NZ,$+35
; 	CALL	KR.KARO
; 	BIT	7,(IX)
; 	JP	NZ,UF.SYS
; 	LD	(IX+5),02H
; 	CALL	KR.KARO	;BLOCK VOR FEHLERHAFTEN B.LESEN
; 	BIT	7,(IX)
; 	JP	NZ,UF.SYS
; 	LD	A,(IX+9)                            ;###
; 	OR	(IX+10)                             ;###
; 	JP	Z,UF.SYS	;WENN AUCH BM -->SYS
; 	CALL	XY.LIDX	;BLOCKLAENGE -->HL
; 	DB	9
; 	LD	(IX+5),02H
; 	CALL	KR.KARO	;FEHLERHAFTEN BLOCK LESEN
; 	LD	B,L
; 	LD	HL,UE.PUF
; 	CALL	UE.CRC
; 	INC	HL
; 	LD	B,(HL)
; 	INC	HL
; 	LD	C,(HL)	;BC=CRC VON KASSETTE
; 	EX	DE,HL
; 	OR	A
; 	SBC	HL,BC
; 	JR	Z,$+7
; 	LD	HL,UA.DF
; 	JR	$+5
	; LD	HL,UA.DOK
	; CALL	UR.MIMO
	; LD	HL,UA.FRZ
	; CALL	UR.MIMO
	; JP	C,UF.SYS1
	; LD	A,(HL)
	; CP	'I'
	; JR	Z,$+41
	; CP	'U'
	; JR	NZ,$-16
	; RES	7,(IX)
	; LD	(IX+5),15H
	; CALL	KR.KARO
	; BIT	7,(IX)
	; JP	NZ,UF.SYS
	; LD	(IX+5),02H
	; CALL	KR.KARO	;NAECHSTEN BLOCK EINLESEN
	; BIT	7,(IX)
	; JP	NZ,UF.SYS
	; JP	UF.RET
	; RES	7,(IX)
	; LD	(IX+5),15H
	; CALL	KR.KARO
	; BIT	7,(IX)
	; JP	NZ,UF.SYS
	; LD	(IX+5),02H
	JP	UF.RET
;-------------------------------------
UF.FL14:
	JP	UF.RET
	; LD	HL,UA.FRZ
	; CALL	UR.MIMO
	; JP	C,UF.SYS1
	; LD	A,(HL)
	; CP	'B'
	; JR	Z,$+12
	; CP	'S'
	; JR	NZ,$-16
	; LD	(IX+5),61H	;SL SCHREIBEN
	; JR	$+20
	; LD	(IX+5),15H
	; CALL	KR.KARO
	; BIT	7,(IX)
	; JP	NZ,UF.SYS
	; LD	(IX+5),51H	;BM HINTER LETZTEN BLOCK
	; INC	HL
	; LD	A,(HL)
	; CALL	U1.TST
	; JR	C,UF.FL14
	; LD	(IX+4),A
	; CALL	KR.KARO
	; BIT	7,(IX)
	; JP	Z,UF.SYS1
	; JP	UF.SYS
	; NOP
	; NOP
	; NOP
	; NOP
	; NOP
	; NOP
	; NOP
UF.FL16:
	LD	HL,UA.FRZ
	CALL	UR.MIMO
	JP	UF.RET
	; JP	C,UF.SYS1
	; LD	A,(IX+5)
	; XOR	04H	;71 <-----> 75
	; LD	(IX+5),A
	; CALL	KR.KARO
	; BIT	7,(IX)
	; JP	Z,UF.SYS1
	; JP	UF.SYS
	; NOP
	; NOP
	; NOP
	; NOP
	; NOP
	; NOP
	; NOP
;----------------------------------------------------------------------
;	END
