	PAGE
;	PN	KM01
;****************************************************************
;*                  DEG2000   V.1.2   ---   Programm:   K m b g *
;*  Version         --------------------------------------------*
;*                  Programmierer: R. Sieber   A d W            *
;*  V 1 . 2         --------------------------------------------*
;*                  Stand        : 25.Februar 1985              *
;****************************************************************

ANF:	DW	$
	DB	'Kmbg'
	LD	HL,DEL	;Taste:   D E L
	LD	(SM.FKTAB+58H),HL
	LD	HL,KM.ABS	;Taste:   A B S
	LD	(SM.FKTAB+24H),HL
	LD	HL,KM.HOME	;Taste:   H O M E
	LD	(SM.FKTAB+74H),HL
	LD	HL,SL	;Taste:   SCH_LINKS
	LD	(SM.FKTAB+26H),HL
	LD	HL,SR	;Taste:   SCH_RECHTS
	LD	(SM.FKTAB+36H),HL
	LD	HL,CO	;Taste:   C_HOCH
	LD	(SM.FKTAB+06H),HL
	LD	HL,KM.CR	;Taste:   C_RECHTS
	LD	(SM.FKTAB+16H),HL
	LD	HL,CU	;Taste:   C_RUNTER
	LD	(SM.FKTAB+18H),HL
	LD	HL,CL	;Taste:   C_LINKS
	LD	(SM.FKTAB+08H),HL
	LD	HL,CNZA	;Taste:   C N Z A
	LD	(SM.FKTAB+76H),HL
	LD	HL,NEWL	;Taste:   E T 1
	LD	(TNEWL),HL
	LD	HL,EINA	;alphanum. Tasten
	LD	(TEINA),HL

	LD	HL,UP13
	LD	DE,RAM
	LD	BC,UPEND-UP13
	LDIR

	LD	IX,KMTAB
	BIT	7,(IX)
	JP	NZ,UP4-UP13+RAM

CO:	CALL	KM.UP2	;KMBG Reservieren EIN
	DB	31H
	RET

	PAGE
;****************************************************************
;*                  Auswertung der Cursor-Tasten                *
;****************************************************************
KM.HOME:	CALL	KM.UP1	;KMBG Kassette zurueckspulen
	DB	21H
	RET

CU:	CALL	KM.UP2	;KMBG Reservieren AUS
	DB	41H
	RET

SL:	CALL	KM.UP2	;KMBG vorh.  Datensatz anzeigen
	DB	15H
	CALL	KM.UP1
	DB	2
CL:	CALL	KM.UP2	;KMBG einen  Datensatz zuruecksetzen
	DB	15H
	RET

SR:	CALL	KM.UP1	;KMBG nachf. Datensatz anzeigen
	DB	2
	RET

KM.CR:	CALL	KM.UP2	;KMBG einen  Datensatz vorsetzen
	DB	11H
	RET

CNZA:	BIT	7,(IX)
	RET	NZ
	LD	A,(TX2-UP13+RAM)
	CP	'l'
	JR	Z,CNZA1
	LD	(IX+9),0
	LD	(IX+10),1
CNZA1:	LD	A,60H
	OR	(IX+4)
	LD	(IX+4),A
	CALL	UP5
	LD	A,(IX+4)
	CALL	KM.UP1
	DB	2
	CALL	KM.UP2
	DB	15H
	LD	(IX+4),A
	JP	UP4-UP13+RAM
;****************************************************************
;*                  Routine fuer die Taste   E T 1              *
;****************************************************************
NEWL:	BIT	7,(IX)
	RET	NZ
	LD	HL,PUFF
	LD	(KMTAB+0DFH),HL	;2BE0
	LD	A,(IX+10)
	DEC	A
	AND	0F0H
	RLCA
	RLCA
	RLCA
	RLCA
	INC	A
	LD	(KMTAB+0EAH),A	;2BEB
	CALL	MHOME
	CALL	MINSL
	CALL	ATACO
	JP	UP4-UP13+RAM

	PAGE
;****************************************************************
;*                  Auswertung der alphanumerischen Tasten      *
;****************************************************************
EINA:	LD	A,C
	LD	HL,0
	CP	'r'
	JR	NZ,EINA1
	LD	HL,EINAB
EINA1:	CP	'z'
	JR	NZ,EINA2
	LD	HL,EINAC
EINA2:	CP	'p'
	JR	NZ,EINA3
	LD	HL,0
EINA3:	CP	'c'
	JR	NZ,EINA4
	LD	HL,0
EINA4:	LD	(TTABU),HL
	CP	'0'
	JR	C,EINA5
	CP	'G'
	JR	C,EINA7
EINA5:	LD	(TX2-UP13+RAM),A
EINA6:	JP	UP4-UP13+RAM

EINA7:	LD	A,(TX2-UP13+RAM)
	CP	'g'
	JR	NZ,EINA8
	LD	A,C
	SUB	30H
	RET	C
	RET	Z
	CP	3
	RET	NC
	LD	(IX+3),A
	CALL	UP20
	JR	EINA6

EINA8:	CP	'l'
	JR	NZ,EINAA
	LD	A,C
	SUB	30H
	CP	00AH
	JR	C,EINA9
	SUB	7
EINA9:	LD	E,A
	LD	D,0
	LD	H,D
	LD	L,(IX+10)
	ADD	HL,HL
	ADD	HL,HL
	ADD	HL,HL
	ADD	HL,HL
	ADD	HL,DE
	LD	(IX+9),H
	LD	(IX+10),L
	JR	EINA6

EINAA:	RET

EINAB:	CALL	KM.UP2
	DB	8
	RET

EINAC:	LD	(IX+13),0
EINAD:	CALL	KM.UP1
	DB	2
	LD	A,(IX+9)
	OR	(IX+10)
	JR	Z,EINAE
	INC	(IX+13)
	CALL	EINAE
	JR	EINAD

EINAE:	CALL	UP4-UP13+RAM
	LD	DE,SD.BWSA+5E0H
	CALL	UP10
	DB	'bz:'
	DB	00DH
	DB	20H+80H
	RET

UP20:	LD	C,(IX+2)
	INC	C
	INC	C
	INC	C
	INC	C
	IN	B,(C)
	CP	1
	JR	NZ,UP21
	BIT	1,B
	JR	NZ,UP25
UP21:	SET	3,B
	JR	UP22
	BIT	0,B
	JR	NZ,UP25
	SET	2,B
UP22:	OUT	(C),B
	INC	C
	IN	D,(C)
	DEC	C
	RES	2,B
	RES	3,B
	OUT	(C),B
	CP	1
	JR	NZ,UP23
	BIT	4,D
	JR	UP24

UP23:	BIT	3,D
UP24:	JR	Z,UP25
	LD	(IX+0),0
	JP	CO

UP25:	SET	7,(IX+0)
	RET

	PAGE
KM.ABS:	LD	HL,SD.BWSA
	LD	B,17
ABS1:	PUSH	BC
	CALL	UP30
	POP	BC
	DJNZ	ABS1
	JP	UP36

UP30:	CALL	UP34
	DB	0A0H
	JR	Z,UP33
	CALL	UP34
	DB	050H
	JR	Z,UP32
UP31:	LD	A,(HL)
	INC	HL
	CALL	DRUZ
	DJNZ	UP31
UP36:	LD	A,1EH
	JP	DRUZ

UP32:	CALL	UP36
UP33:	INC	HL
	DJNZ	UP33
	RET

UP34:	EX	(SP),HL
	LD	B,(HL)
	INC	HL
	EX	(SP),HL
	PUSH	HL
	CALL	UP35
	POP	HL
	LD	B,80
	RET

UP35:	LD	A,' '
	CP	(HL)
	INC	HL
	RET	NZ
	DJNZ	UP35
	RET



DEL:	RES	7,(IX+0)
	LD	(IX+1),0
	JP	UP4-UP13+RAM

	PAGE
;****************************************************************
;*                  Unterprogramme                              *
;****************************************************************
KM.UP1:	CALL	LOE1
KM.UP2:	BIT	7,(IX)
	JR	Z,UP3
	POP	HL
	RET	NZ
UP3:	EX	(SP),HL
	PUSH	AF
	LD	A,(HL)
	INC	HL
	LD	(IX+4),A
	POP	AF
	EX	(SP),HL
UP5:	CALL	KARO
	LD	HL,05C01H	;? ? ?
	LD	(SM.FKTAB+8EH),HL	;? ? ?
	JP	UP4-UP13+RAM

LOE1:	LD	HL,PUFF-1
	LD	(HL),0
	LD	BC,103H
	JR	LOE3
LOE2:	LD	HL,SD.BWSA
	LD	BC,007FFH
	LD	(HL),' '
LOE3:	PUSH	HL
	POP	DE
	INC	DE
	LDIR
	RET

UP10:	EX	(SP),HL
UP11:	LD	A,(HL)
	AND	07FH
	CP	' '
	JR	C,UP12
	LD	(DE),A
	INC	DE
UP12:	CALL	C,UP13-UP13+RAM
	BIT	7,(HL)
	INC	HL
	JR	Z,UP11
	EX	(SP),HL
	RET

UP41:	LD	DE,SD.BWSA
	LD	A,(IX+10)
	OR	A
	JR	NZ,UP42
	BIT	0,(IX+9)
	RET	Z
	PUSH	AF
	CALL	MANZ
	POP	AF
	SUB	10H
UP42:	PUSH	AF
	CALL	MANZ
	POP	AF
	SUB	10H
	RET	Z
	RET	C
	JR	UP42

UP43:	CP	01EH
	RET	Z
	CP	00AH
	RET	Z
	CP	00DH
	RET	Z
	OR	A
	RET	Z
	CP	' '
	JR	C,UP44
	CP	080H
	RET	C
UP44:	LD	A,07FH
	RET

	PAGE
	ORG	00300H

UP13:	LD	(UP15-UP13+RAM-1),A
	LD	A,(IX+1)	;<<<
UP15:	EX	DE,HL
	LD	(HL),A
	LD	A,33H
	RRD
	EX	DE,HL
	PUSH	AF
	LD	A,(DE)
	CALL	UP14-UP13+RAM
	POP	AF
UP14:	CP	03AH
	JR	C,$+4	;---!
	ADD	A,7	;   !
	LD	(DE),A	;<--!
	INC	DE
	RET

UP4:	PUSH	AF
	CALL	LOE2
	LD	A,(IX+3)
	ADD	A,30H
	LD	(TX1-UP13+RAM),A
	LD	DE,SD.BWSA+5A0H
	CALL	UP10
TX2:	DB	's  ('	;<<<
TX1:	DB	'2)'	;<<<
	DB	3AH+80H	;":"
	LD	DE,SD.BWSA+5B4H
	CALL	UP10
	DB	'l:'
	DB	9
	DB	10
	DB	' s:'
	DB	0
	DB	'/'
	DB	1
	DB	'      '
	DB	2DH+80H	;"-"
	DEC	DE
	DEC	DE
	DEC	DE
	LD	HL,PUFF-1
	LD	A,(HL)
	INC	HL
	CALL	UP15-UP13+RAM
	INC	DE
	LD	B,(IX+10)
	PUSH	HL
	INC	HL
	DJNZ	$-1
	LD	A,(HL)
	CALL	UP15-UP13+RAM
	INC	HL
	LD	A,(HL)
	CALL	UP15-UP13+RAM
	POP	HL
	PUSH	HL
	LD	DE,SD.BWSA+640H
	LD	B,0
	LD	A,(HL)
	CALL	UP43
	LD	(DE),A
	INC	HL
	INC	DE
	DJNZ	$-7
	POP	HL
UP40:	CALL	UP41
	POP	AF
	RET

UPEND	EQU	$

;FKTAB	EQU	00D00H
TTABU	EQU	00DA8H
TNEWL	EQU	00DAEH
TEINA	EQU	00DB0H
PUFF	EQU	00E66H

MANZ	EQU	0201DH
MHOME	EQU	02060H
MINSL	EQU	023BAH
;ATACO	EQU	024F8H

KMTAB	EQU	02B01H
;BWSA	EQU	03000H

KARO	EQU	05A93H

;DRUZ	EQU	07C00H

RAM	EQU	0FF80H

			;(C) Rainer Sieber     A d W


;	END
