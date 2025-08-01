	PN	RD31
;****************************************************************
;*               REcord Display and Change                      *
;*  Version      -----------------------------------------------*
;*               Programmierer: M. Herbote --- K EAW  ZFT (WFT) *
;*  V 2 . 1      -----------------------------------------------*
;*               Stand        : 14.Maerz 1985                   *
;****************************************************************
	TITL	'REcord Display and Change'
	DB	'V2.1/140385'

	DA	#
	DB	'REDC'
REDD:	LD	HL,REDD
	LD	(K2.FRADR),HL
	LD	A,5	;Bildschirm loeschen
	LD	(MS.CMD),A
	CALL	MO.MONI
	CALL	S1.ANZEI	;Programmname anzeigen
	DA	00012H	;ZPOS=19 , SPOS= 1
	DB	40
	DB	'Record Display and Change    Version 2.1'
	DB	0
	CALL	S1.ANZEI
	DA	00013H	;ZPOS=20 , SPOS= 1
	DB	TXT11-TXT10+80H
	DA	TXT10
	DB	0

	CALL	PANZ
	LD	HL,00101H	;ZMIN= 1 , SMIN= 1
	LD	(MS.ZMIN),HL
	DEC	H	;ZPOS= 1 , SMIN= 1
	DEC	L
	LD	(MS.ZPOS),HL
	LD	HL,05011H	;ZMAX=17 , SMAX=80
	LD	(MS.ZMAX),HL
	CALL	TARE
	RET

	EJEC
TXT1:	DB	'1=RE 2=RW 3=RA   4=L- 5=PT 6=L+  '
	DB	'7=R- 8=CW 9=R+  10=BM 11=W 12=SL'

TXT2:	DB	'1=copy Satz_1 2=copy BM__1 3=copy SL_1  '
	DB	' 4=copy Satz_2  5=copy BM__2 6=copy SL_2'
	DB	'7=printSatz_1 8=printASC_1 9=R+_1       '
	DB	'10=printSatz_2 11=printASC_2 12=R+_2 '

TXT14:	DB	'1=Pos1_auf 2=Pos1_+ 3=Pos1_-  '
	DB	'4=Pos2_auf 5=Pos2_+ 6=Pos2_-'


TXT3:	DB	'copieren '
TXT4:	DB	'Satz  '
TXT5:	DB	'bis BM  '
TXT6:	DB	'bis SL  '
TXT7:	DB	'von Ger. 2 => 1'
TXT8:	DB	'von Ger. 1 => 2'
TXT9:	DB	'Geraet: '
TXT10:	DB	'Satzlaenge: ....H   CRC-Summe: ....H'
TXT11:	DB	'* * *   B A N D M A R K E   * * *'
TXT12:	DA	1E1EH
TXT13:	DB	'Geraet . auf Datei: 003 Satz: 001 positionieren'
TXT15:	DB	'Geraet . um 000 Dateien und 000 Saetze '
TXT16:	DB	'vorsetzen'
TXT17:	DB	'zuruecksetzen'
TXT18:	EQU	#

	EJEC
RE2:	DA	RERE1	;PF 1/0
	DA	RERW1	;PF 2/0
	DA	RERA1	;PF 3/0
	DA	RELM1	;PF 4/0
	DA	REPT1	;PF 5/0
	DA	RELP1	;PF 6/0
	DA	RERM1	;PF 7/0
	DA	RECW1	;PF 8/0
	DA	RERP1	;PF 9/0
	DA	REBM1	;PF10/0
	DA	REW1	;PF11/0
	DA	RESL1	;PF12/0

	DA	RERE2	;PF 1/1
	DA	RERW2	;PF 2/1
	DA	RERA2	;PF 3/1
	DA	RELM2	;PF 4/1
	DA	REPT2	;PF 5/1
	DA	RELP2	;PF 6/1
	DA	RERM2	;PF 7/1
	DA	RECW2	;PF 8/1
	DA	RERP2	;PF 9/1
	DA	REBM2	;PF10/1
	DA	REW2	;PF11/1
	DA	RESL2	;PF12/1

	DA	RECS1	;PF 1/2
	DA	RECB1	;PF 2/2
	DA	RECE1	;PF 3/2
	DA	RECS2	;PF 4/2
	DA	RECB2	;PF 5/2
	DA	RECE2	;PF 6/2
	DA	REHC1	;PF 7/2
	DA	REHC3	;PF 8/2
	DA	RERP1	;PF 9/2
	DA	REHC2	;PF10/2
	DA	REHC4	;PF11/2
	DA	RERP2	;PF12/2

	DA	P1A	;PF 1/3
	DA	P1P	;PF 2/3
	DA	P1M	;PF 3/3
	DA	P2A	;PF 4/3
	DA	P2P	;PF 5/3
	DA	P2M	;PF 6/3
	DA	0	;PF 7/3
	DA	0	;PF 8/3
	DA	0	;PF 9/3
	DA	0	;PF10/3
	DA	0	;PF11/3
	DA	0	;PF12/3

	EJEC
;****************************************************************
;*               Kassettengeraet reservieren ein                *
;****************************************************************
RERE1:	CALL	K1.RGL1
	JR	RERE3-#
RERE2:	CALL	K1.RGL2
RERE3:	CALL	K1.GNRE
	CALL	TADEF
	JR	RELM5-#
;****************************************************************
;*               Kassettengeraet rewind                         *
;****************************************************************
RERW1:	CALL	K1.RGL1
	JR	RERW3-#
RERW2:	CALL	K1.RGL2
RERW3:	CALL	K1.GNRW
	JR	RELM5-#
;****************************************************************
;*               Kassettengeraet reservieren aus                *
;****************************************************************
RERA1:	CALL	K1.RGL1
	JR	RERA3-#
RERA2:	CALL	K1.RGL2
RERA3:	CALL	K1.GNRE
	CALL	K1.GNRA
	CALL	TARE
	JR	RELM6-#
;****************************************************************
;*               Kassettengeraet eine Datei zurueck             *
;****************************************************************
RELM1:	CALL	K1.RGL1
	JR	RELM3-#
RELM2:	CALL	K1.RGL2
RELM3:	LD	D,0
	LD	A,(IY-3)	;RCZx = 0 ?
	OR	(IY-4)
	JRNZ	+3
	INC	D
	CALL	K1.GNLMN
RELM4:	LD	A,1	;Schnellschreiben erlaubt
	LD	(TS.ZSMER),A
RELM5:	CALL	TADEF
RELM6:	CALL	K1.GNSTS
	CALL	ANZLO
	CALL	PANZ
	LD	HL,0
	LD	(MS.ZPOS),HL
	RET
;****************************************************************
;*               Kassettengeraet eine Datei vor                 *
;****************************************************************
RELP1:	CALL	K1.RGL1
	JR	RELP3-#
RELP2:	CALL	K1.RGL2
RELP3:	CALL	K1.GNLP
	JR	RELM4-#

	EJEC
;****************************************************************
;*               Schreiben einer Bandmarke                      *
;****************************************************************
REBM1:	CALL	K1.RGL1
	JR	REBM3-#
REBM2:	CALL	K1.RGL2
REBM3:	CALL	S1.ANZEI
	DA	00010H
	DB	21
	DB	'Bandmarke schreiben ?'
	DB	1
	DB	10000000B
	DA	BMNQ
	DA	BMPQ
	DA	0
BMPQ:	CALL	WR3
BMNQ:	JR	RELM5-#
;****************************************************************
;*               Schreiben einer Schlussluecke                  *
;****************************************************************
RESL1:	CALL	K1.RGL1
	JR	RESL3-#
RESL2:	CALL	K1.RGL2
RESL3:	CALL	S1.ANZEI
	DA	00010H
	DB	25
	DB	'Schlussluecke schreiben ?'
	DB	1
	DB	10000000B
	DA	BMNQ
	DA	SLPQ
	DA	0
SLPQ:	LD	(IX+4),61H
	CALL	K1.ARMB
	CALL	K1.ARBT
	JR	BMNQ-#
;****************************************************************
;*               Eingabe- <==> Ausgabe-Puffer  Tausch           *
;****************************************************************
REPT1:	LD	HL,S0.PFFI
	LD	DE,S0.PFFA
	JR	REPT3-#
REPT2:	LD	HL,S0.PFFA
	LD	DE,S0.PFFI
REPT3:	LD	(S2.DMANF),HL
	LD	B,0
REPT4:	LD	A,(HL)
	EXAF
	LD	A,(DE)
	LD	(HL),A
	EXAF
	LD	(DE),A
	INC	HL
	INC	DE
	DJNZ	REPT4-#
	CALL	SAN1
	RET

	EJEC
;****************************************************************
;*               einen Datenblock einlesen und anzeigen         *
;****************************************************************
RERM1:	CALL	K1.RGL1	;rueckwaerts
	LD	HL,S0.PFFI
	JR	RERM3-#
RERM2:	CALL	K1.RGL2
	LD	HL,S0.PFFA
RERM3:	LD	(S2.DMANF),HL
	CALL	K1.GNRM
	CALL	K1.GNRM
RERM4:	CALL	RD3
	CALL	K1.ARBT
	CALL	SAN1
	CALL	K1.BM
	JRZ	RERM5-#	;Datenblock = Bandmarke ?
	CALL	K1.RCZP
	JMP	RELM4

RERM5:	CALL	K1.BLKP
	CALL	K1.RCZN
	JMP	RELM4

RERP1:	CALL	K1.RGL1	;vorwaerts
	LD	HL,S0.PFFI
	JR	RERP3-#
RERP2:	CALL	K1.RGL2
	LD	HL,S0.PFFA
RERP3:	LD	(S2.DMANF),HL
	JMP	RERM4

	EJEC
;****************************************************************
;*               Satz korrigieren und zurueckschreiben          *
;****************************************************************
RECW1:	CALL	K1.RGL1
	LD	HL,S0.PFFI
	JR	RECW3-#
RECW2:	CALL	K1.RGL2
	LD	HL,S0.PFFA
RECW3:	LD	(S2.DMANF),HL
	CALL	ANZLO
	CALL	PAN
	CALL	TA.LOES
	LD	HL,RECW4	;POS QUIT
	LD	(TS.TAB4),HL
RECW9:	LD	HL,ANZUM	;INS MOD
	LD	(TS.TAB2),HL
	LD	HL,RELM5	;NEQ QUIT
	LD	(TS.TAB3+4),HL
	LD	HL,S1.EINDB	;alphanum. Tasten
	LD	(TS.EINA),HL
	CALL	S1.ANZU1
	JMP	S1.DB111+3

RECW4:	CALL	K1.LHLBC
	CALL	S1.SYDB2
	CALL	SAN1
	CALL	S1.ANZEI
	DA	00010H
	DB	23
	DB	'Satz zurueckschreiben ?'
	DB	1
	DB	10000000B
	DA	RECW3+3
	DA	RECW5
	DA	0

RECW5:	LD	B,(IX+9)
	LD	C,(IX+10)
	PUSH	BC
	CALL	K1.GNRM
	LD	HL,(S2.DMANF)
	POP	BC
	CALL	K1.GNRWR
	JMP	RELM5


ANZUM:	CALL	K1.LHLBC
	JMP	S1.ANZU2

	EJEC
;****************************************************************
;*               satzweises Copieren                            *
;****************************************************************
RECS:	LD	(S2.DMANF),HL
	CALL	S1.ANZEI
	DA	00010H
	DB	15+80H
	DA	TXT3
	DB	0
	RET

RECS1:	LD	HL,S0.PFFI
	CALL	RECS
	CALL	S1.ANZEI
	DA	00F10H
	DB	15+80H
	DA	TXT7
	DB	1
	DB	10000000B
	DA	RELM5
	DA	RECS3
	DA	0

RECS3:	CALL	K1.RGL2
	CALL	K1.GNRD
	CALL	SAN1
	CALL	K1.LHLBC
	CALL	K1.RGL1
RECS5:	LD	A,B
	OR	C
	JPZ	BMPQ
	CALL	WR1
	CALL	K1.GNWR
	JMP	RELM5


RECS2:	LD	HL,S0.PFFA
	CALL	RECS
	CALL	S1.ANZEI
	DA	00F10H
	DB	15+80H
	DA	TXT8
	DB	1
	DB	10000000B
	DA	RELM5
	DA	RECS4
	DA	0

RECS4:	CALL	K1.RGL1
	CALL	K1.GNRD
	CALL	SAN1
	CALL	K1.LHLBC
	CALL	K1.RGL2
	JR	RECS5-#

	EJEC
;****************************************************************
;*               Copieren bis Bandmarke                         *
;****************************************************************
RECB:	LD	(S2.DMANF),HL
	CALL	S1.ANZEI
	DA	00010H
	DB	9+80H
	DA	TXT3
	DB	0

	CALL	S1.ANZEI
	DA	00910H
	DB	8+80H
	DA	TXT5
	DB	0
	RET

RECB1:	LD	HL,S0.PFFI
	CALL	RECB
	CALL	S1.ANZEI
	DA	01110H
	DB	15+80H
	DA	TXT7
	DB	1
	DB	10000000B
	DA	RELM5
	DA	RECB3
	DA	0

RECB3:	CALL	K1.RGL2
	CALL	RD
	JPZ	RELM5
	CALL	K1.LHLBC
	CALL	K1.RGL1
	LD	A,B
	OR	C
	JPZ	BMPQ
	CALL	WR
	JR	RECB3-#


RECB2:	LD	HL,S0.PFFA
	CALL	RECB
	CALL	S1.ANZEI
	DA	01110H
	DB	15+80H
	DA	TXT8
	DB	1
	DB	10000000B
	DA	RELM5
	DA	RECB4
	DA	0

RECB4:	CALL	K1.RGL1
	CALL	RD
	JPZ	RELM5
	CALL	K1.LHLBC
	CALL	K1.RGL2
	LD	A,B
	OR	C
	JPZ	BMPQ
	CALL	WR
	JR	RECB4-#

;****************************************************************
;*               Copieren bis Schlussluecke                     *
;****************************************************************
RECE:	LD	(S2.DMANF),HL
	CALL	S1.ANZEI
	DA	00010H
	DB	9+80H
	DA	TXT3
	DB	0

	CALL	S1.ANZEI
	DA	00910H
	DB	8+80H
	DA	TXT6
	DB	0
	RET

RECE1:	LD	HL,S0.PFFI
	CALL	RECE
	CALL	S1.ANZEI
	DA	01110H
	DB	15+80H
	DA	TXT7
	DB	1
	DB	10000000B
	DA	RELM5
	DA	RECE3
	DA	0

RECE3:	CALL	K1.RGL2
	CALL	RD
	JRZ	RECE6-#
	CALL	K1.LHLBC
	CALL	K1.RGL1
	CALL	WR2
	JR	RECE3-#
RECE6:	CALL	K1.RGL1
	JMP	SLPQ


RECE2:	LD	HL,S0.PFFA
	CALL	RECE
	CALL	S1.ANZEI
	DA	01110H
	DB	15+80H
	DA	TXT8
	DB	1
	DB	10000000B
	DA	RELM5
	DA	RECE4
	DA	0

RECE4:	CALL	K1.RGL1
	CALL	RD
	JRZ	RECE8-#
	CALL	K1.LHLBC
	CALL	K1.RGL2
	CALL	WR2
	JR	RECE4-#
RECE8:	CALL	K1.RGL2
	JMP	SLPQ

	EJEC
;****************************************************************
;*               Erzeugen eines neuen Satzes                    *
;****************************************************************
REW1:	CALL	K1.RGL1
	LD	HL,S0.PFFI
	JR	REW3-#

REW2:	CALL	K1.RGL2
	LD	HL,S0.PFFA

REW3:	LD	(S2.DMANF),HL
	LD	(IX+8),H
	LD	(IX+7),L
	CALL	ANZLO
	CALL	PAN
REW4:	CALL	SAN1
	CALL	S1.ANZEI
	DA	00C13H	;ZPOS=20 , SPOS=13
	DB	0
	DB	4
	DB	10101000B
	DA	BMNQ
	DA	REW5
	DA	LO.EIN1

REW5:	LD	HL,00C13H
	LD	(MS.ZPOS),HL
	LD	A,11
	LD	(MS.CMD),A
	CALL	MO.MONI
	CALL	S1.HBKON
	LD	D,A
	CALL	S1.HBKON
	LD	E,A
	OR	D
	JRZ	REW4-#
	LD	(IX+9),D
	LD	(IX+10),E
	CALL	SAN1
REW6:	CALL	TA.LOES
	LD	HL,REW7	;POS QUIT
	LD	(TS.TAB4),HL
	JMP	RECW9

REW7:	CALL	K1.LHLBC
	CALL	S1.SYDB2
	CALL	SAN1
	CALL	S1.ANZEI
	DA	00010H
	DB	16
	DB	'Satz schreiben ?'
	DB	1
	DB	10001000B
	DA	REW6
	DA	REW8
	DA	REW9

REW8:	LD	HL,(S2.DMANF)
	LD	(IX+8),H
	LD	(IX+7),L
	CALL	K1.GNWR
	JMP	RELM5

REW9:	LD	A,(TS.TK)
	CMP	'8'
	RNZ
	LD	HL,(S2.DMANF)
	LD	(IX+8),H
	LD	(IX+7),L
	LD	(IX+4),8
	CALL	K1.GNWR+4
	JMP	RELM5

	EJEC
;****************************************************************
;*               Druckausgabe des Kassetteninhaltes             *
;****************************************************************
REHC1:	CALL	K1.RGL1
	LD	HL,S0.PFFI
	JR	REHC5-#

REHC2:	CALL	K1.RGL2
	LD	HL,S0.PFFA

REHC5:	LD	(S2.DMANF),HL
	CALL	K1.BM
	JRNZ	REHC7-#

	LD	HL,TXT11	;Bandmarke
	LD	BC,TXT13-TXT11
	CALL	PRINT
REHC6:	JMP	RERM4

REHC7:	LD	HL,(MS.BWSA)	;Datei- und Satzzaehler ausdrucken
	LD	B,0
	LD	A,(K2.SKADR+1)
	ADD	9
	LD	C,A
	ADD	HL,BC
	LD	A,(K2.SKADR)
	DEC	A
	CALL	MO.PNSP
	LD	BC,26
	CALL	PRINT
	LD	HL,(MS.BWSA)	;CRC-Summe ausdrucken
	LD	A,19
	CALL	MO.PNSP
	LD	DE,17
	ADD	HL,DE
	LD	BC,19
	CALL	PRINT
	LD	C,1EH
	CALL	S1.SM+3

	CALL	K1.LHLBC
	PUSH	BC
	POP	DE
	EXX
	LD	DE,(S2.DMANF)
HC1:	CALL	S1.HXN1
	LD	B,16
	CALL	S1.MEAU2
	PUSH	DE
	CALL	MO.BWSE
	LD	BC,7
	ADD	HL,BC
	LD	BC,69
	CALL	PRINT
	LD	C,1EH
	CALL	S1.SM+3
	POP	DE
	EXX
	PUSH	BC
	POP	DE
	LD	A,B
	OR	C
	JRZ	HC9-#
	EXX
	JR	HC1-#

HC9:	LD	C,1EH
	CALL	S1.SM+3
	JMP	REHC6



REHC3:	CALL	K1.RGL1
	LD	DE,S0.PFFI
	JR	RHC5-#

REHC4:	CALL	K1.RGL2
	LD	DE,S0.PFFA

RHC5:	LD	(S2.DMANF),DE
	CALL	K1.LHLBC
RHC6:	LD	A,(DE)
	INC	DE
	PUSH	BC
	LD	C,A
	CALL	S1.SM+3
	POP	BC
	DEC	BC
	LD	A,B
	OR	C
	JRNZ	RHC6-#
	JMP	RERM4

	EJEC
;****************************************************************
;*               Kassette auf "Datei" , "Satz" positionieren    *
;****************************************************************
P1A:	CALL	K1.RGL1
	LD	HL,S0.PFFI
	LD	A,'1'
	JR	PA1-#

P2A:	CALL	K1.RGL2
	LD	HL,S0.PFFA
	LD	A,'2'

PA1:	PUSH	AF
	LD	(S2.DMANF),HL
	CALL	S1.ANZEI
	DA	00010H	;ZPOS=17 , SPOS= 1
	DB	TXT15-TXT13+80H
	DA	TXT13
	DB	0

	LD	HL,00710H	;ZPOS=17 , SPOS= 8
	LD	(MS.ZPOS),HL
	LD	A,11	;HL:=ZPOS,SPOS
	LD	(MS.CMD),A
	CALL	MO.MONI
	POP	AF
	LD	(HL),A
	CALL	S0.BWSUS
PAA1:	CALL	S1.ANZEI	;Eingabe Dateinummer
	DA	01410H	;ZPOS=17 , SPOS=21
	DB	0
	DB	3
	DB	10001000B
	DA	BMNQ
	DA	PAA2
	DA	S1.AEIN

PAA2:	LD	HL,01410H	;ZPOS=17 , SPOS=21
	LD	(MS.ZPOS),HL
	LD	A,11
	LD	(MS.CMD),A
	CALL	MO.MONI
	EX	DE,HL
	CALL	S1.IDH
	LD	A,L
	LD	(S2.PRGN),A
	CALL	S1.ANZEI	;Eingabe Satznummer
	DA	01E10H	;ZPOS=17 , SPOS=31
	DB	0
	DB	3
	DB	10001000B
	DA	PAA1
	DA	PAA3
	DA	S1.AEIN

PAA3:	LD	HL,01E10H	;ZPOS=17 , SPOS=31
	LD	(MS.ZPOS),HL
	LD	A,11
	LD	(MS.CMD),A
	CALL	MO.MONI
	EX	DE,HL
	CALL	S1.IDH
	LD	A,L
	LD	(S2.PRGN+1),A
	CALL	K1.GNRW

	LD	A,(S2.PRGN)	;auf entspr. Datei setzen
	OR	A
	JRZ	PAA4-#
	DEC	A
	JRZ	PAA4-#
	LD	D,A
	CALL	K1.GNLPN

PAA4:	LD	A,(S2.PRGN+1)	;auf entspr. Satz positionieren
	OR	A
	JRZ	PAA5-#
	DEC	A
	JRZ	PAA5-#
	LD	B,A
	PUSH	BC
	CALL	K1.GNRP
	POP	BC
	DJNZ	-5

PAA5:	JMP	RERM4

	EJEC
;****************************************************************
;*               Positionieren um "Dateien","Saetze" vor        *
;****************************************************************
P1P:	CALL	K1.RGL1
	LD	HL,S0.PFFI
	LD	A,'1'
	JR	PP1-#

P2P:	CALL	K1.RGL2
	LD	HL,S0.PFFA
	LD	A,'2'

PP1:	PUSH	AF
	LD	(S2.DMANF),HL
	CALL	S1.ANZEI
	DA	00010H	;ZPOS=17 , SPOS= 1
	DB	TXT17-TXT15+80H
	DA	TXT15
	DB	0

	LD	HL,00710H	;ZPOS=17 , SPOS= 8
	LD	(MS.ZPOS),HL
	LD	A,11	;HL:=ZPOS,SPOS
	LD	(MS.CMD),A
	CALL	MO.MONI
	POP	AF
	LD	(HL),A
	CALL	S0.BWSUS
PPA1:	CALL	S1.ANZEI	;Eingabe Dateinummer
	DA	00C10H	;ZPOS=17 , SPOS=13
	DB	0
	DB	3
	DB	10001000B
	DA	BMNQ
	DA	PPA2
	DA	S1.AEIN

PPA2:	LD	HL,00C10H	;ZPOS=17 , SPOS=13
	LD	(MS.ZPOS),HL
	LD	A,11
	LD	(MS.CMD),A
	CALL	MO.MONI
	EX	DE,HL
	CALL	S1.IDH
	LD	A,L
	LD	(S2.PRGN),A
	CALL	S1.ANZEI	;Eingabe Satznummer
	DA	01C10H	;ZPOS=17 , SPOS=29
	DB	0
	DB	3
	DB	10001000B
	DA	PPA1
	DA	PPA3
	DA	S1.AEIN

PPA3:	LD	HL,01C10H	;ZPOS=17 , SPOS=29
	LD	(MS.ZPOS),HL
	LD	A,11
	LD	(MS.CMD),A
	CALL	MO.MONI
	EX	DE,HL
	CALL	S1.IDH
	LD	A,L
	LD	(S2.PRGN+1),A

	LD	A,(S2.PRGN)	;auf entspr. Datei setzen
	OR	A
	JRZ	PPA4-#
	LD	D,A
	CALL	K1.GNLPN

PPA4:	LD	A,(S2.PRGN+1)	;auf entspr. Satz positionieren
	OR	A
	JRZ	PPA5-#
	LD	B,A
	PUSH	BC
	CALL	K1.GNRP
	POP	BC
	DJNZ	-5


PPA5:	JMP	PAA5

	EJEC
;****************************************************************
;*               Positionieren um "Dateien","Saetze" zurueck    *
;****************************************************************
P1M:	CALL	K1.RGL1
	LD	HL,S0.PFFI
	LD	A,'1'
	JR	PQ1-#

P2M:	CALL	K1.RGL2
	LD	HL,S0.PFFA
	LD	A,'2'

PQ1:	PUSH	AF
	LD	(S2.DMANF),HL
	CALL	S1.ANZEI
	DA	00010H	;ZPOS=17 , SPOS= 1
	DB	TXT16-TXT15+80H
	DA	TXT15
	DB	0

	CALL	S1.ANZEI
	DA	02710H	;ZPOS=17 , SPOS=40
	DB	TXT18-TXT17+80H
	DA	TXT17
	DB	0

	LD	HL,00710H	;ZPOS=17 , SPOS= 8
	LD	(MS.ZPOS),HL
	LD	A,11	;HL:=ZPOS,SPOS
	LD	(MS.CMD),A
	CALL	MO.MONI
	POP	AF
	LD	(HL),A
	CALL	S0.BWSUS
PQA1:	CALL	S1.ANZEI	;Eingabe Dateinummer
	DA	00C10H	;ZPOS=17 , SPOS=13
	DB	0
	DB	3
	DB	10001000B
	DA	BMNQ
	DA	PQA2
	DA	S1.AEIN

PQA2:	LD	HL,00C10H	;ZPOS=17 , SPOS=13
	LD	(MS.ZPOS),HL
	LD	A,11
	LD	(MS.CMD),A
	CALL	MO.MONI
	EX	DE,HL
	CALL	S1.IDH
	LD	A,L
	LD	(S2.PRGN),A
	CALL	S1.ANZEI	;Eingabe Satznummer
	DA	01C10H	;ZPOS=17 , SPOS=29
	DB	0
	DB	3
	DB	10001000B
	DA	PQA1
	DA	PQA3
	DA	S1.AEIN

PQA3:	LD	HL,01C10H	;ZPOS=17 , SPOS=29
	LD	(MS.ZPOS),HL
	LD	A,11
	LD	(MS.CMD),A
	CALL	MO.MONI
	EX	DE,HL
	CALL	S1.IDH
	LD	A,L
	LD	(S2.PRGN+1),A

	LD	A,(S2.PRGN)	;auf entspr. Datei setzen
	OR	A
	JRZ	PQA4-#
	LD	D,A
	CALL	K1.GNLMN

PQA4:	LD	A,(S2.PRGN+1)	;auf entspr. Satz positionieren
	OR	A
	JRZ	PQA5-#
	LD	B,A
	PUSH	BC
	CALL	K1.GNRM
	POP	BC
	DJNZ	-5

PQA5:	JMP	PPA5

	EJEC
;****************************************************************
;*               Zeile 17 loeschen                              *
;****************************************************************
ANZLO:	LD	HL,(MS.ZMIN)
	PUSH	HL
	LD	HL,(MS.ZMAX)
	PUSH	HL
	LD	HL,00111H
	LD	(MS.ZMIN),HL
	LD	HL,05011H
	LD	(MS.ZMAX),HL
	LD	A,5
	LD	(MS.CMD),A
	CALL	MO.MONI
	POP	HL
	LD	(MS.ZMAX),HL
	POP	HL
	LD	(MS.ZMIN),HL
	RET
;****************************************************************
;*               Satzlaenge und Satzinhalt anzeigen             *
;****************************************************************
SAN1:	LD	A,(MS.SPANZ)	;ersten 16 BWSA-Zeilen loeschen
	LD	HL,S0.BWSA
SAN3:	PUSH	AF
	LD	B,16
SAN4:	LD	(HL),' '
	INC	HL
	DJNZ	SAN4-#
	POP	AF
	DEC	A
	JRNZ	SAN3-#
	LD	HL,(MS.BWSA)	;BWS-Pos. "Satzlaenge"
	LD	A,19
	CALL	MO.PNSP
	LD	DE,12
	ADD	HL,DE
	LD	A,(IX+9)	;Satzlaenge anzeigen
	CALL	S1.BHKON
	LD	A,(IX+10)
	CALL	S1.BHKON
	CALL	K1.BM
	JRZ	SAN2-#
	LD	DE,15	;CRC-Summe  anzeigen
	ADD	HL,DE
	PUSH	HL
	CALL	K1.LHLBC
	CALL	S1.CHK
	POP	HL
	LD	A,D
	CALL	S1.BHKON
	LD	A,E
	CALL	S1.BHKON
	LD	DE,(S2.DMANF)	;Satzinhalt anzeigen
	CALL	K1.LHLBC
	LD	(IX+8),D
	LD	(IX+7),E
	LDIR
	CALL	K1.LHLBC
	PUSH	BC
	POP	DE
	CALL	S1.MEAA
	RET
SAN2:	LD	HL,00101H	;Bandmarke anzeigen
	LD	(MS.ZMIN),HL
	LD	HL,05011H	;ZMAX=17 , SMAX=80
	LD	(MS.ZMAX),HL
	LD	A,5	;Bildfenster loeschen
	LD	(MS.CMD),A
	CALL	MO.MONI
	CALL	S1.ANZEI
	DA	0
	DB	39
	DB	'gelesener Datenblock ist eine Bandmarke'
	DB	0
	RET

	EJEC
;****************************************************************
;*               einen Satz einlesen und anzeigen               *
;****************************************************************
RD:	CALL	RD3
	LD	A,(IX+1)	;Schlussluecke erreicht ?
	CMP	14H
	RZ		;ja
	CALL	K1.ARBT	;nein
	CALL	K1.BM
	JRZ	RD1-#
	CALL	K1.RCZP
	JR	RD2-#
RD1:	CALL	K1.BLKP
	CALL	K1.RCZN
RD2:	CALL	SAN1	;Satzlaenge und Satzinhalt anzeigen
	LD	A,1
	OR	A
	RET

RD3:	LD	(IX+4),2
	CALL	K1.ARMB
	CALL	K1.F17
	CALL	K1.BM
	RZ
	JMP	K1.PUFT
;****************************************************************
;*               Pufferlaenge und -adresse ==> E/A-Tabelle      *
;****************************************************************
WR1:	LD	(IX+8),H
	LD	(IX+7),L
	LD	(IX+9),B
	LD	(IX+10),C
	RET
;****************************************************************
;*               Datenblock bzw. Bandmarke schreiben            *
;****************************************************************
WR2:	LD	A,B
	OR	C
	JRZ	WR3-#
WR:	CALL	WR1
	CALL	K1.GNWR
	CALL	K1.GNSTS
	RET
WR3:	LD	(IX+4),51H
	CALL	K1.ARMB
	CALL	K1.ARBT
	CALL	K1.BLKP
	CALL	K1.RCZN
	RET

	EJEC
;****************************************************************
;*               Tastendefinitionen                             *
;****************************************************************
TADEF:	CALL	TA.LOE
	LD	HL,RE2
	LD	DE,TS.TAB1
	LD	BC,RERE1-RE2
	LDIR

TAD1:	LD	HL,S1.SYSTB
	LD	(TS.TAB3+6),HL
	LD	HL,PANZ
	LD	(TS.TAB5),HL
	LD	(TS.TAB5+2),HL
	LD	(TS.TAB5+4),HL
	LD	(TS.TAB5+6),HL
	LD	A,10000000B
	LD	(TS.SPMER),A
	RET


TARE:	CALL	TA.LOE
	LD	HL,RERE1
	LD	(TS.TAB1),HL
	LD	HL,RERE2
	LD	(TS.TAB1+24),HL
	JR	TAD1-#

;****************************************************************
;*               Druckeranschlussroutine                        *
;****************************************************************
PRINT:	PUSH	HL
	PUSH	BC
	LD	A,(HL)
	LD	C,A
	CALL	S1.SM+3
	POP	BC
	POP	HL
	INC	HL
	DEC	BC
	LD	A,B
	OR	C
	JRNZ	PRINT-#
	RET

	EJEC
;****************************************************************
;*               aktive P-Tasten anzeigen                       *
;****************************************************************
PAN:	LD	HL,(MS.BWSA)
	LD	A,20	;Zeile 21 und 22 loeschen
	CALL	MO.PNSP
	PUSH	HL
	PUSH	HL
	POP	DE
	INC	DE
	LD	B,0
	LD	A,(MS.SPANZ)
	ADD	A
	DEC	A
	LD	C,A
	LD	(HL),' '
	LDIR
	CALL	S0.BWSUS
	POP	HL
	RET

PANZ:	CALL	PAN
	PUSH	HL
	LD	A,(TS.EMERK)
	CMP	2
	JRC	PANZ1-#
	JRZ	PANZ2-#
	LD	HL,TXT14	;Ebene 3
	LD	BC,TXT3-TXT14
	JR	PANZ4-#

PANZ1:	LD	B,0	;Ebene 0 und 1
	EXAF
	LD	A,(MS.SPANZ)
	LD	C,A
	POP	HL	;Anzeige in Zeile 22:  Geraet: i
	PUSH	HL
	ADD	HL,BC
	EX	DE,HL
	LD	HL,TXT9
	LD	BC,TXT10-TXT9
	LDIR
	EXAF
	ADD	31H
	LD	(DE),A
	LD	HL,TXT1
	LD	BC,TXT2-TXT1
	JR	PANZ4-#

PANZ2:	LD	HL,TXT2	;Ebene 2
	LD	BC,TXT14-TXT2
PANZ4:	POP	DE	;Anzeige in Zeile 21
	LDIR
	CALL	S0.BWSUS
	RET


	END
еееееееееееееееееееееееееее