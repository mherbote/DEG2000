'Drucker-Verbindungsmodul fuer Version 1.1'	MACRO-80 3.44	09-Dec-81	PAGE	1


                                	TITLE 'Drucker-Verbindungsmodul fuer Version 1.1'
                                	PAGE	86
'Drucker-Verbindungsmodul fuer Version 1.1'	MACRO-80 3.44	09-Dec-81	PAGE	1-1


                                
                                ;	PN	PR07
                                ;****************************************************************
                                ;*               Drucker-Verbindungsmodul fuer Version 1.1      *
                                ;*  Version      -----------------------------------------------*
                                ;*               Programmierer: M. Herbote --- K EAW  ZFT (WFT) *
                                ;*  V 1 . 1      -----------------------------------------------*
                                ;*               Stand        : 21.August 1984                  *
                                ;****************************************************************
                                	ORG	7C00H
  7C00'   C3 7C0C'              PRINT:	JP	PRINA
  7C03'   C9                    DINIT:	RET
  7C04'   0000                  	DW	0
                                
  7C06'   C3 7CF3'              	JP	P1.MRES
  7C09'   C3 7D61'              	JP	P1.PRIO
                                
  7C0C'   C5                    PRINA:	PUSH	BC
  7C0D'   4F                    	LD	C,A
  7C0E'   DD 21 0F73            	LD	IX,PR.DRU+3
  7C12'   CD 7D61'              	CALL	P1.PRIO
  7C15'   C1                    	POP	BC
  7C16'   C9                    	RET
                                
                                
  7C17'   7C17'                 	DW	$
  7C19'   44 49 4E 49           	DB	'DINI'
  7C1D'   DD 21 0F73            	LD	IX,PR.DRU+3
  7C21'   3E 58                 	LD	A,LOW(ISR)
  7C23'   DD 77 03              	LD	(IX+3),A
  7C26'   AF                    	XOR	A
  7C27'   DD 77 0B              	LD	(IX+11),A
  7C2A'   3A 3327               	LD	A,(PAR)	;char per inch
  7C2D'   FE 30                 	CP	'0'
  7C2F'   28 0A                 	JR	Z,PR.CPI10
  7C31'   FE 32                 	CP	'2'
  7C33'   20 0A                 	JR	NZ,PR.CPI
  7C35'   DD CB 04 C6           	SET	0,(IX+4)
  7C39'   18 04                 	JR	PR.CPI
  7C3B'   DD CB 04 86           PR.CPI10:	RES	0,(IX+4)
  7C3F'   3A 3328               PR.CPI:	LD	A,(PAR+1)	;line per inch
  7C42'   FE 36                 	CP	'6'
  7C44'   28 0A                 	JR	Z,PR.LPI6
  7C46'   FE 38                 	CP	'8'
  7C48'   20 0A                 	JR	NZ,LPI
  7C4A'   DD CB 04 CE           	SET	1,(IX+4)
  7C4E'   18 04                 	JR	LPI
  7C50'   DD CB 04 8E           PR.LPI6:	RES	1,(IX+4)
  7C54'   3A 3329               LPI:	LD	A,(PAR+2)	;ohne/mit Nulldurchstreichung
  7C57'   FE 4F                 	CP	'O'
  7C59'   28 08                 	JR	Z,ONULL
  7C5B'   FE 4D                 	CP	'M'
  7C5D'   20 04                 	JR	NZ,ONULL
  7C5F'   3E FF                 	LD	A,-1
  7C61'   18 01                 	JR	NULL
  7C63'   AF                    ONULL:	XOR	A
  7C64'   DD 77 0C              NULL:	LD	(IX+12),A
  7C67'   CD 7CF3'              	CALL	P1.MRES
  7C6A'   C3 000B               SYS:	JP	SYSTB
                                
                                	TITLE 'EDITOR-Raum der Version 1 alles drucken'
                                	PAGE
'EDITOR-Raum der Version 1 alles drucken'	MACRO-80 3.44	09-Dec-81	PAGE	1-2


                                
                                ;****************************************************************
                                ;*               EDITOR-Raum der Version 1 alles drucken        *
                                ;****************************************************************
  7C6D'   7C6D'                 	DW	$
  7C6F'   50 52 45 54           	DB	'PRET'
  7C73'   DD 21 0F73            	LD	IX,PR.DRU+3
  7C77'   21 8831               	LD	HL,ANFED+1
  7C7A'   CD 7CE6'              	CALL	PR.END
  7C7D'   DA 000B               	JP	C,SYSTB
  7C80'   2B                    	DEC	HL
  7C81'   CD 7CE6'              PR.M2:	CALL	PR.END
  7C84'   CA 000B               	JP	Z,SYSTB
  7C87'   4E                    	LD	C,(HL)
  7C88'   CD 7D61'              	CALL	P1.PRIO
  7C8B'   23                    	INC	HL
  7C8C'   18 F3                 	JR	PR.M2
                                ;****************************************************************
                                ;*               Seitenvorschub bei  1 1 5 2 / 1 1 5 7          *
                                ;****************************************************************
  7C8E'   7C8E'                 	DW	$
  7C90'   50 41 47 45           	DB	'PAGE'
  7C94'   DD 21 0F73            	LD	IX,PR.DRU+3
  7C98'   0E 0C                 	LD	C,00CH
  7C9A'   CD 7D61'              	CALL	P1.PRIO
  7C9D'   18 CB                 	JR	SYS
                                
                                	TITLE 'EDITOR-Raum der Version 1 von anz  drucken'
                                	PAGE
'EDITOR-Raum der Version 1 von anz  drucken'	MACRO-80 3.44	09-Dec-81	PAGE	1-3


                                
                                ;****************************************************************
                                ;*               EDITOR-Raum der Version 1  von anz  drucken    *
                                ;****************************************************************
  7C9F'   7C9F'                 	DW	$
  7CA1'   50 52 49 4E           	DB	'PRIN'
  7CA5'   DD 21 0F73            	LD	IX,PR.DRU+3
  7CA9'   11 3327               	LD	DE,PAR
  7CAC'   CD 0877               	CALL	IDH
  7CAF'   E5                    	PUSH	HL
  7CB0'   13                    	INC	DE
  7CB1'   CD 0877               	CALL	IDH
  7CB4'   E3                    	EX	(SP),HL
  7CB5'   EB                    	EX	DE,HL
  7CB6'   21 882F               	LD	HL,ANFED-1
  7CB9'   1B                    PR1:	DEC	DE
  7CBA'   7A                    	LD	A,D
  7CBB'   B3                    	OR	E
  7CBC'   28 0E                 	JR	Z,PR3
  7CBE'   3E 1E                 	LD	A,01EH
  7CC0'   23                    PR2:	INC	HL
  7CC1'   CD 7CE6'              	CALL	PR.END
  7CC4'   CA 000B               	JP	Z,SYSTB
  7CC7'   BE                    	CP	(HL)
  7CC8'   20 F6                 	JR	NZ,PR2
  7CCA'   18 ED                 	JR	PR1
  7CCC'   D1                    PR3:	POP	DE
  7CCD'   23                    	INC	HL
  7CCE'   CD 7CE6'              PR4:	CALL	PR.END
  7CD1'   CA 000B               	JP	Z,SYSTB
  7CD4'   4E                    	LD	C,(HL)
  7CD5'   CD 7D61'              	CALL	P1.PRIO
  7CD8'   23                    	INC	HL
  7CD9'   3E 1E                 	LD	A,01EH
  7CDB'   B9                    	CP	C
  7CDC'   20 F0                 	JR	NZ,PR4
  7CDE'   1B                    	DEC	DE
  7CDF'   7A                    	LD	A,D
  7CE0'   B3                    	OR	E
  7CE1'   20 EB                 	JR	NZ,PR4
  7CE3'   C3 000B               	JP	SYSTB
                                
  7CE6'   E5                    PR.END:	PUSH	HL
  7CE7'   D5                    	PUSH	DE
  7CE8'   ED 5B 0DC4            	LD	DE,(ENDED)
  7CEC'   EB                    	EX	DE,HL
  7CED'   B7                    	OR	A
  7CEE'   ED 52                 	SBC	HL,DE
  7CF0'   D1                    	POP	DE
  7CF1'   E1                    	POP	HL
  7CF2'   C9                    	RET
                                
                                
  000B                          SYSTB	EQU	0000BH
  0058                          ISR	EQU	00058H
  0DC4                          ENDED	EQU	00DC4H
  0877                          IDH	EQU	00877H
  8830                          ANFED	EQU	08830H
  3327                          PAR	EQU	03327H
  0F70                          PR.DRU	EQU	00F70H
                                
                                
                                ;	END
                                	TITLE 'Drucker-Routine'
                                	PAGE
'Drucker-Routine'	MACRO-80 3.44	09-Dec-81	PAGE	1-4


                                
                                ;	PN	P108
                                ;****************************************************************
                                ;*               Drucker-Routine  1152 , 1154 , 1156 , 1157     *
                                ;*                                BD 4000 , S 6001              *
                                ;*               -----------------------------------------------*
                                ;*               Programmierer: M. Herbote --- K EAW  ZFT (WFT) *
                                ;*               -----------------------------------------------*
                                ;*               Stand        : 17.August 1984                  *
                                ;****************************************************************
                                
                                ;****************************************************************
                                ;*               Aufbau der E/A-Tabelle  (Adresse ueber  IX)    *
                                ;*               ===============================================*
                                ;*                                                              *
                                ;*               Byte  ! Bedeutung                              *
                                ;*               ------!----------------------------------------*
                                ;*               -  3  ! Laengenbyte                            *
                                ;*               -  2  ! Praefixbyte 1                          *
                                ;*               -  1  ! Praefixbyte 2                          *
                                ;*                  0  ! Status - "1BH"-Merker                  *
                                ;*                  1  ! Fehlerschluessel      (z.Z. unbenutzt) *
                                ;*                  2  ! Basisadresse (wird bei DINIT gesetzt)  *
                                ;*                  3  ! L-Teil Interruptvektor, bei INT-Betrieb*
                                ;*                  4  ! Kommando bei DINIT                     *
                                ;*                     ! bit 0 = 0 ...   CPI = 10 Zoll          *
                                ;*                     !       = 1 ...   CPI = 12 Zoll          *
                                ;*                     !     1 = 0 ...   LPI =  6 Zoll          *
                                ;*                     !       = 1 ...   LPI =  8 Zoll          *
                                ;*                  5  ! Adresse Eintrittspunkt (z.Z.unbenutzt) *
                                ;*                  7  ! Blockadresse          (z.Z. unbenutzt) *
                                ;*                  9  ! Blocklaenge           (z.Z. unbenutzt) *
                                ;*                 11  ! Wert fuer Farbbandstellung             *
                                ;*                 12  ! ungleich Null ...  Nulldurchstreichung *
                                ;****************************************************************
                                
                                	PAGE
'Drucker-Routine'	MACRO-80 3.44	09-Dec-81	PAGE	1-5


                                
  0000                          ES2	EQU	00H	;00H ... Generierung   D E G 2 0 0 0
                                			;4xH ... Generierung   E S   2 0 0 0
                                
  0002                          DRU	EQU	00000010B	;Drucker Typ
                                			;Bit 0  ...   1152/1157  PIO
                                			;    1  ...   1152/1157  SIO
                                			;    2  ...   1154       GNI
                                			;    3  ...   1154       ASCII
                                			;    4  ...
                                			;    5  ...
                                			;    6  ...   BD 4000
                                			;    7  ...   S 6001
                                
  0008                          ANST	EQU	00001000B	;Ansteuerung
                                			;Bit 0  ...   A D A
                                			;    1  ...   A T D 1
                                			;    2  ...   A T D 2
                                			;    3  ...   A T S
                                			;    4  ...
                                			;    5  ...   S-A1
                                			;    6  ...   S-A2
                                			;    7  ...   S-A3
                                
                                	IF	DRU AND 00000011B
  0001                          PIO	EQU	1	;1 ... PIO-Schnittstelle 1
                                			;2 ... PIO-Schnittstelle 2
                                	ENDIF
                                
                                
                                	IF	ES2 AND 40H
                                DINIT:	JP	MRES
                                PRINT:	JP	PRI
                                	DB	'...'
                                	DB	ES2
                                	DW	0
                                	DW	0
                                	DB	0
                                
                                PRI:	PUSH	AF
                                	LD	A,C
                                	CP	20H
                                	JR	NC,PRI1
                                	CP	1EH
                                	JR	Z,PRI1
                                	POP	AF
                                	RET
                                PRI1:	POP	AF
                                	JP	PRIO
                                	ENDIF
                                
                                	TITLE	'Drucker-Initialisierung'
                                	PAGE
'Drucker-Initialisierung'	MACRO-80 3.44	09-Dec-81	PAGE	1-6


                                
                                ;****************************************************************
                                ;*               Drucker - Initialisierung                      *
                                ;****************************************************************
  7CF3'   F5                    P1.MRES:	PUSH	AF	;Register retten
  7CF4'   C5                    	PUSH	BC
  7CF5'   D5                    	PUSH	DE
  7CF6'   E5                    	PUSH	HL
  7CF7'   DD E5                 	PUSH	IX
  7CF9'   FD E5                 	PUSH	IY
                                
                                
                                ;                B a s i s a d r e s s e   bereitstellen
                                
                                	IF	ANST AND 10000000B
                                	LD	C,088H	;Koppelinterface
                                	ENDIF
                                
                                	IF	ANST AND 00001000B
  7CFB'   0E B0                 	LD	C,0B0H	;A T S
                                	ENDIF
                                
                                	IF	ANST AND 00000110B
                                	LD	C,0B8H	;A T D
                                	ENDIF
                                
                                	IF	ANST AND 00000001B
                                	LD	C,040H	;A D A
                                	ENDIF
                                
                                
                                	IF	ANST AND 10001111B
  7CFD'   DD 71 02              	LD	(IX+2),C	;Basisadresse in E/A-Tabelle setzen
                                	ENDIF
                                
                                	PAGE
'Drucker-Initialisierung'	MACRO-80 3.44	09-Dec-81	PAGE	1-7


                                
                                	IF	DRU AND 1
                                	IF	ANST AND 6
                                ;****************************************************************
                                ;*               Drucker  1 1 5 2 / 1 1 5 7  ueber  A T D       *
                                ;****************************************************************
                                	LD	A,08FH
                                	INC	C
                                	IF	ANST AND 2
                                	INC	C
                                	ENDIF
                                	OUT	(C),A	;Adresse ( + 2 / + 1 )
                                	LD	A,0CFH
                                	INC	C
                                	IF	ANST AND 4
                                	INC	C
                                	ENDIF
                                	OUT	(C),A	;Adresse + 3
                                	LD	A,0FEH
                                	OUT	(C),A	;Adresse + 3
                                	LD	A,3
                                	OUT	(C),A	;Adresse + 3
                                	DEC	C
                                	IF	ANST AND 4
                                	DEC	C
                                	ENDIF
                                	OUT	(C),A	;Adresse ( + 2 / + 1 )
                                	LD	A,1
                                	IF	ANST AND 2
                                	DEC	C
                                	ENDIF
                                	IF	ANST AND 4
                                	INC	C
                                	ENDIF
                                	OUT	(C),A	;Adresse ( + 1 / + 2 )
                                	XOR	A
                                	OUT	(C),A	;Adresse ( + 1 / + 2 )
                                	DEC	C
                                	IF	ANST AND 4
                                	DEC	C
                                	ENDIF
                                	IN	A	;Adresse + 0,(C)
                                
                                	BIT	0,(IX+4)	;char per inch
                                	JR	Z,+7
                                	LD	HL,CPI12	;=1 ... 12 CPI
                                	JR	+5
                                	LD	HL,CPI10	;=0 ... 10 CPI
                                	CALL	CPI
                                
                                	BIT	1,(IX+4)	;char per line
                                	JR	Z,+7
                                	LD	HL,LPI8	;=1 ...  8 LPI
                                	JR	+5
                                	LD	HL,LPI6	;=0 ...  6 LPI
                                	CALL	CPI
                                	ENDIF
                                	ENDIF
                                
                                	PAGE
'Drucker-Initialisierung'	MACRO-80 3.44	09-Dec-81	PAGE	1-8


                                
                                	IF	DRU AND 4
                                	IF	ANST AND 1
                                ;****************************************************************
                                ;*               Drucker  1 1 5 4 / GNI ueber  A D A            *
                                ;****************************************************************
                                	LD	A,00FH
                                	INC	C
                                	INC	C
                                	OUT	(C),A	;Adresse + 2
                                	LD	A,(IX+3)	;L-Teil Interruptvektor
                                	OUT	(C),A	;Adresse + 2
                                	LD	A,083H
                                	OUT	(C),A	;Adresse + 2
                                	LD	A,0CFH
                                	INC	C
                                	OUT	(C),A	;Adresse + 3
                                	LD	A,0F0H
                                	OUT	(C),A	;Adresse + 3
                                	LD	A,(IX+11)	;00H bzw. 04H Farbbandstellung
                                	AND	4
                                	DEC	C
                                	DEC	C
                                	OUT	(C),A	;Adresse + 1
                                	ENDIF
                                	ENDIF
                                
                                	IF	DRU AND 80H
                                	IF	ANST AND 80H
                                ;****************************************************************
                                ;*               Schreibmaschine S 6 0 0 1  ueber Koppelinterf. *
                                ;****************************************************************
                                	PUSH	BC
                                	INC	C
                                	INC	C
                                	LD	HL,STW
                                	LD	B,2
                                	OTIR		;Adresse + 2   Kanal A
                                	INC	C
                                	LD	B,3
                                	OTIR		;Adresse + 3   Kanal B
                                	POP	BC
                                
                                	BIT	0,(IX+4)	;char per inch
                                	JR	Z,+6
                                	LD	A,6	;=1 ... 12 CPI
                                	JR	+4
                                	LD	A,5	;=0 ... 10 CPI
                                	CALL	ZEI
                                	BIT	1,(IX+4)	;line per inch
                                	JR	Z,+6
                                	LD	A,3	;=1 ... 1 1/2 zeilig
                                	JR	+4
                                	LD	A,2	;=0 ... 1     zeilig
                                	CALL	ZEI
                                	ENDIF
                                	ENDIF
                                
                                	PAGE
'Drucker-Initialisierung'	MACRO-80 3.44	09-Dec-81	PAGE	1-9


                                
                                	IF	DRU AND 40H
                                	IF	ANST AND 1
                                ;****************************************************************
                                ;*               Bediendrucker  4 0 0 0   ueber  A D A          *
                                ;****************************************************************
                                	INC	C	;Control Kanal A
                                	INC	C
                                	LD	A,(IX+3)	;L(Adr. Interruptadress-Tabelle)
                                	OUT	(C),A	;Adresse + 2
                                	LD	A,00FH	;Modus 0 = Byte-Ausgabe
                                	OUT	(C),A
                                	LD	A,083H	;Interrupt-Freigabe
                                	OUT	(C),A
                                	INC	C	;Control Kanal B
                                	LD	A,0CFH	;Modus 3 = Bit-E/A
                                	OUT	(C),A	;Adresse + 3
                                	LD	A,060H	;E: Bit 6,5 (Status)
                                	OUT	(C),A	;   (wird nicht ausgewertet)
                                	LD	A,007H	;keine Interruptfreigabe
                                	DEC	C
                                	DEC	C	;Daten Kanal B (Kommandos)
                                	XOR	A	;0: FBU
                                	OUT	(C),A
                                	DEC	C	;Daten Kanal A
                                	LD	A,022H	; schwarz (Grundstellung)
                                	BIT	2,(IX+11)
                                	JR	Z,+3
                                	DEC	A	;21H rot
                                	OUT	(C),A
                                	INC	C	;Daten Kanal B
                                	LD	A,001H	;Kommando 01H: Druck lt. Code-Tabelle
                                	OUT	(C),A
                                	DEC	C	;bereit fuer Druck Daten auf Kanal A
                                	ENDIF
                                	ENDIF
                                
                                	PAGE
'Drucker-Initialisierung'	MACRO-80 3.44	09-Dec-81	PAGE	1-10


                                
                                	IF	DRU AND 00001000B
                                	IF	ANST AND 1
                                ;****************************************************************
                                ;*               Drucker  1 1 5 4 / ASCII  ueber  A D A         *
                                ;****************************************************************
                                	INC	C
                                	INC	C
                                	LD	A,00FH	;Byte - Ausgabe
                                	OUT	(C),A	;Adresse + 2
                                	INC	C
                                	LD	A,0CFH	;Bit  - Ein-/Ausgabe
                                	OUT	(C),A	;Adresse + 3
                                	LD	A,0F0H
                                	OUT	(C),A
                                	DEC	C	;Ausgabe der Synchronisation
                                	DEC	C
                                	DEC	C
                                	XOR	A
                                	OUT	(C),A	;Adresse + 0
                                	INC	C
                                	LD	A,3	;PRIME und STROBE
                                	OUT	(C),A	;Adresse + 1
                                	LD	A,0
                                	OUT	(C),A
                                	LD	A,2	;STROBE
                                	OUT	(C),A
                                	XOR	A
                                	OUT	(C),A
                                ASC1:	IN	A,(C)
                                	BIT	7,0
                                	JR	Z,ASC2
                                	LD	A,1
                                	OUT	(C),A
                                	XOR	A
                                	OUT	(C),A
                                	DEC	C
                                	CALL	ZEIZ
                                	INC	C
                                	JR	ASC1
                                ASC2:	DEC	C
                                	ENDIF
                                	ENDIF
                                
                                	PAGE
'Drucker-Initialisierung'	MACRO-80 3.44	09-Dec-81	PAGE	1-11


                                
                                	IF	DRU AND 2
                                	IF	ANST AND 8
                                ;****************************************************************
                                ;*               Drucker  1 1 5 2 / 1 1 5 7  ueber  A T S       *
                                ;****************************************************************
  7D00'   0C                    	INC	C
  7D01'   0C                    	INC	C
  7D02'   0C                    	INC	C
  7D03'   21 7DEB'              	LD	HL,SIOTB	;Initialisierung SIO  Kanal B
  7D06'   06 0A                 	LD	B,10
  7D08'   ED B3                 	OTIR		;Adresse + 3
                                
  7D0A'   3E 07                 	LD	A,7	;Initialisierung CTC
  7D0C'   81                    	ADD	A,C
  7D0D'   4F                    	LD	C,A
  7D0E'   3E 07                 	LD	A,7
  7D10'   ED 79                 	OUT	(C),A	;Adresse + 10
  7D12'   3E 01                 	LD	A,1
  7D14'   ED 79                 	OUT	(C),A
                                
  7D16'   79                    	LD	A,C
  7D17'   D6 07                 	SUB	7
  7D19'   4F                    	LD	C,A
  7D1A'   0D                    IN1:	DEC	C
  7D1B'   ED 78                 	IN	A,(C)		;Adresse + 2
  7D1D'   0C                    	INC	C
  7D1E'   CD 7DF5'              	CALL	STAT
  7D21'   20 F7                 	JR	NZ,IN1
  7D23'   0D                    	DEC	C
  7D24'   0D                    	DEC	C
  7D25'   0D                    	DEC	C
                                
  7D26'   3E 7F                 	LD	A,7FH
  7D28'   CD 7DC2'              	CALL	ZEI
  7D2B'   3E 00                 	LD	A,0
  7D2D'   CD 7DC2'              	CALL	ZEI
                                
  7D30'   DD CB 04 46           	BIT	0,(IX+4)	;char per inch
  7D34'   28 05                 	JR	Z,$+7
  7D36'   21 7E0D'              	LD	HL,CPI12	;=1 ... 12 CPI
  7D39'   18 03                 	JR	$+5
  7D3B'   21 7E08'              	LD	HL,CPI10	;=0 ... 10 CPI
  7D3E'   CD 7E1C'              	CALL	CPI
                                
  7D41'   DD CB 04 4E           	BIT	1,(IX+4)	;line per inch
  7D45'   28 05                 	JR	Z,$+7
  7D47'   21 7E17'              	LD	HL,LPI8		;=1 ...  8 LPI
  7D4A'   18 03                 	JR	$+5
  7D4C'   21 7E12'              	LD	HL,LPI6		;=0 ...  6 LPI
  7D4F'   CD 7E1C'              	CALL	CPI
                                	ENDIF
                                	ENDIF
                                
                                	PAGE
'Drucker-Initialisierung'	MACRO-80 3.44	09-Dec-81	PAGE	1-12


                                
                                	IF	DRU AND 10000000B
                                	IF	ANST AND 01100000B
                                ;****************************************************************
                                ;*               Schreibmaschine S 6 0 0 1 ueber Spezialinterf. *
                                ;****************************************************************
                                	OUT	(C),8FH	;RESET Memory on SL6001
                                	XOR	A	;A=0
                                
                                	IF	ANST AND 00100000B
                                	LD	C,8CH	;Adress
                                	OUT	(C),A	;Latching on Printboard
                                	OUT	(C),8AH	;Latching on SL6001
                                	OUT	(C),88H	;Sign on SL6001-Keyboard
                                	OUT	(C),8DH	;Delete Latch on Printboard
                                	LD	HL,400H
                                	CALL	TIM
                                	INC	A
                                	CALL	MR1
                                	XOR	A	;A=0
                                	CALL	MR1
                                	OUT	(C),8FH	;RESET all
                                	LD	HL,4000H
                                	ENDIF
                                
                                	IF	ANST AND 01000000B
                                	CALL	MR1
                                	LD	A,1
                                	CALL	MR1
                                	OUT	(C),8FH
                                	LD	HL,2000H
                                	ENDIF
                                
                                	CALL	TIM
                                	ENDIF
                                	ENDIF
                                
  7D52'   DD 36 00 01           	LD	(IX+0),1	;Merker CPI/LPI-Steuerzeichenfolgen
  7D56'   DD CB FF CE           	SET	1,(IX-1)	;OPEN - Bit setzen
  7D5A'   DD CB FF D6           	SET	2,(IX-1)	;Richtungsbit: Ausgabe
  7D5E'   C3 7DB9'              	JP	M2
                                
                                	PAGE
'Drucker-Initialisierung'	MACRO-80 3.44	09-Dec-81	PAGE	1-13


                                
                                	IF	DRU AND 10000000B
                                
                                	IF	ANST AND 01000000B
                                MR1:	OUT	(C),8CH
                                	OUT	(C),8DH
                                	LD	HL,16
                                	CALL	TIM
                                	OUT	(C),8AH
                                	OUT	(C),8BH
                                	OUT	(C),88H
                                	LD	HL,300H
                                	CALL	TIM
                                	RET
                                	ENDIF
                                
                                	IF	ANST AND 00100000B
                                MR1:	OUT	(C),A	;latching on Printboard
                                	OUT	(C),8BH	;follow   on S 6001
                                	OUT	(C),8AH	;latching on S 6001
                                	LD	HL,400H
                                	CALL	TIM
                                	RET
                                	ENDIF
                                
                                	IF	ANST AND 01100000B
                                PZKB	EQU	48	;number of lower-case signs at table
                                PZGB	EQU	56	;number of upper-case signs at table
                                	ENDIF
                                
                                	IF	ANST AND 10000000B
                                STW:	DB	00001111B	;Byteausgabe   Kanal A
                                	DB	00000011B	;INT-Sperre
                                	DB	11001111B	;Bit-Mode      Kanal B
                                	DB	11110000B	;I/O-Maske
                                	DB	00000011B	;INT-Sperre
                                	ENDIF
                                
                                	ENDIF
                                
                                	TITLE	'Zeichenausgabe an den Drucker'
                                	PAGE
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-14


                                
                                ;****************************************************************
                                ;*               Ausgabe eines Zeichens an den Drucker          *
                                ;****************************************************************
  7D61'   F5                    P1.PRIO:	PUSH	AF	;Register retten
  7D62'   C5                    	PUSH	BC
  7D63'   D5                    	PUSH	DE
  7D64'   E5                    	PUSH	HL
  7D65'   DD E5                 	PUSH	IX
  7D67'   FD E5                 	PUSH	IY
  7D69'   79                    	LD	A,C	;auszugebendes Zeichen
                                	IF	ANST AND 10001111B
  7D6A'   DD 4E 02              	LD	C,(IX+2)	;C  laden mit Basisadresse
                                	ENDIF
  7D6D'   DD CB FF 4E           	BIT	1,(IX-1)	;OPEN - Bit gesetzt ?
  7D71'   28 46                 	JR	Z,M2	;nein
                                	IF	DRU AND 11111100B
                                	CP	0CH
                                	JR	Z,M2
                                	ENDIF
  7D73'   FE 80                 	CP	80H
  7D75'   30 02                 	JR	NC,$+4
  7D77'   18 04                 	JR	$+6
  7D79'   3E 2E                 	LD	A,'.'
  7D7B'   18 34                 	JR	M3
  7D7D'   FE 1B                 	CP	1BH
  7D7F'   20 04                 	JR	NZ,CL1
  7D81'   DD 36 00 05           	LD	(IX+0),5
  7D85'   FE 1E                 CL1:	CP	1EH	;Zeilenendezeichen
  7D87'   28 2D                 	JR	Z,M1
                                
                                	IF	DRU AND 10000011B
  7D89'   47                    	LD	B,A
  7D8A'   DD 35 00              	DEC	(IX+0)
  7D8D'   DD 7E 00              	LD	A,(IX+0)
  7D90'   FE 00                 	CP	0
  7D92'   78                    	LD	A,B
  7D93'   28 02                 	JR	Z,$+4			;-----+
  7D95'   30 1A                 	JR	NC,M3			;     !
  7D97'   DD 36 00 01           	LD	(IX+0),1	;<----+
  7D9B'   47                    	LD	B,A	;Zeichen retten
  7D9C'   DD 7E 0C              	LD	A,(IX+12)	;Nullen durchstreichen ?
  7D9F'   B7                    	OR	A
  7DA0'   78                    	LD	A,B	;Zeichen zurueckladen
  7DA1'   28 0E                 	JR	Z,M3	;=0 ... nicht durchstreichen
  7DA3'   FE 30                 	CP	'0'
  7DA5'   20 0A                 	JR	NZ,M3
  7DA7'   CD 7DC2'              	CALL	ZEI
  7DAA'   3E 08                 	LD	A,8
  7DAC'   CD 7DC2'              	CALL	ZEI
  7DAF'   3E 2F                 	LD	A,'/'
                                	ENDIF
                                
  7DB1'   CD 7DC2'              M3:	CALL	ZEI
  7DB4'   18 03                 	JR	M2
  7DB6'   CD 7DFD'              M1:	CALL	ZEIZ
  7DB9'   FD E1                 M2:	POP	IY
  7DBB'   DD E1                 	POP	IX
  7DBD'   E1                    	POP	HL
  7DBE'   D1                    	POP	DE
  7DBF'   C1                    	POP	BC
  7DC0'   F1                    	POP	AF
  7DC1'   C9                    	RET
                                	PAGE
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-15


                                
  7DC2'                         ZEI	EQU	$
                                
                                	IF	DRU AND 4
                                	IF	ANST AND 1
                                ;****************************************************************
                                ;*               1154/GNI  mit  A D A                           *
                                ;****************************************************************
                                	OUT	(C),A	;Adresse + 0
                                	EI
                                	HALT
                                	ENDIF
                                	ENDIF
                                
                                	IF	DRU AND 00001000B
                                	IF	ANST AND 1
                                ;****************************************************************
                                ;*               1154/ASCII mit  A D A                          *
                                ;****************************************************************
                                	CPL
                                	OUT	(C),A	;Adresse + 0
                                	INC	C
                                	LD	A,2	;STROBE
                                	OUT	(C),A	;Adresse + 1
                                	XOR	A
                                	OUT	(C),A
                                	DEC	C
                                	PUSH	DE
                                	LD	DE,0D00H
                                	DEC	DE
                                	LD	A,D
                                	OR	E
                                	JR	NZ,$-3
                                	POP	DE
                                	ENDIF
                                	ENDIF
                                
                                	IF	DRU AND 40H
                                	IF	ANST AND 1
                                ;****************************************************************
                                ;*               BD 4000 mit  A D A                             *
                                ;****************************************************************
                                	PUSH	AF
                                	AND	07FH	;herstellen gerade Paritaet
                                	JPPE	#+5
                                	OR	080H
                                	OUT	(C),A	;Adresse + 0
                                	POP	AF
                                	EI
                                	HALT
                                	ENDIF
                                	ENDIF
                                
                                	PAGE
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-16


                                
                                	IF	DRU AND 1
                                	IF	ANST AND 6
                                ;****************************************************************
                                ;*               1152/1157  mit  A T D                          *
                                ;****************************************************************
                                	OUT	(C),A	;Adresse + 0
                                	INC	C
                                	IF	ANST AND 4
                                	INC	C
                                	ENDIF
                                M4:	IN	A	;Adresse ( + 1 / + 2 ),(C)
                                	IF	ANST AND 2
                                	BIT	3,A
                                	ENDIF
                                	IF	ANST AND 4
                                	BIT	4,A
                                	ENDIF
                                	JR	NZ,M4
                                	DEC	C
                                	IF	ANST AND 4
                                	DEC	C
                                	ENDIF
                                	IN	A	;Adresse + 0,(C)
                                	PUSH	BC
                                	LD	B,0
                                	DJNZ	0
                                	POP	BC
                                	ENDIF
                                	ENDIF
                                
                                	PAGE
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-17


                                
                                	IF	DRU AND 2
                                	IF	ANST AND 8
                                ;****************************************************************
                                ;*               1152/1157  mit  A T S                          *
                                ;****************************************************************
  7DC2'   F5                    	PUSH	AF
  7DC3'   0C                    	INC	C
  7DC4'   0C                    	INC	C
  7DC5'   0C                    	INC	C
  7DC6'   CD 7DF5'              B1:	CALL	STAT
  7DC9'   CB 57                 	BIT	2,A
  7DCB'   28 F9                 	JR	Z,B1
  7DCD'   F1                    	POP	AF
  7DCE'   0D                    	DEC	C
  7DCF'   ED 79                 	OUT	(C),A		;Adresse + 2
  7DD1'   ED 78                 B3:	IN	A,(C)
  7DD3'   E6 7F                 	AND	7FH
  7DD5'   FE 11                 	CP	11H
  7DD7'   28 04                 	JR	Z,B4
  7DD9'   FE 13                 	CP	13H
  7DDB'   28 F4                 	JR	Z,B3
  7DDD'   0C                    B4:	INC	C
  7DDE'   0D                    B6:	DEC	C
  7DDF'   ED 78                 	IN	A,(C)		;Adresse + 2
  7DE1'   0C                    	INC	C
  7DE2'   CD 7DF5'              	CALL	STAT
  7DE5'   20 F7                 	JR	NZ,B6
  7DE7'   0D                    	DEC	C
  7DE8'   0D                    	DEC	C
  7DE9'   0D                    	DEC	C
  7DEA'   C9                    	RET
                                
  7DEB'   04                    SIOTB:	DB	4	;Steuerworte  S I O
  7DEC'   45                    	DB	45H	;WR4
  7DED'   01                    	DB	1
  7DEE'   00                    	DB	00H	;WR1
  7DEF'   03                    	DB	3
  7DF0'   41                    	DB	41H	;WR3
  7DF1'   05                    	DB	5
  7DF2'   28                    	DB	28H	;WR5
  7DF3'   00                    	DB	0
  7DF4'   30                    	DB	30H	;WR0
                                
  7DF5'   AF                    STAT:	XOR	A
  7DF6'   ED 79                 	OUT	(C),A
  7DF8'   ED 78                 	IN	A,(C)
  7DFA'   CB 47                 	BIT	0,A
                                	ENDIF
                                	ENDIF
                                
                                	PAGE
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-18


                                
                                	IF	DRU AND 80H
                                	IF	ANST AND 01100000B
                                ;****************************************************************
                                ;*               S 6 0 0 1  mit  Spezialinteface                *
                                ;****************************************************************
                                	LD	A,C	;device-control for a single sign
                                	LD	HL,PTAKB	;table of lower-case signs
                                	LD	BC,PZKB	;number   lower-case signs
                                	CPIR		;compare
                                	JR	Z,PRIZK
                                	LD	HL,PTAGB	;table of upper-case signs
                                	LD	BC,PZGB	;number   upper-case signs
                                	CPIR
                                	JR	Z,PRIZG
                                	LD	A,' '	;space if no sign is matched
                                PRIZK:	OUT	(C),8FH	;Reset all
                                	PUSH	AF	;save sign
                                	LD	A,0EH	;shift sign
                                	JR	PRIZ2
                                PRIZG:	OUT	(C),8FH	;Reset all
                                	PUSH	AF	;save sign
                                	LD	A,0FH	;lock sign
                                PRIZ2	EQU	$
                                
                                	IF	ANST AND 00100000B
                                	LD	C,8CH	;Address
                                	ENDIF
                                
                                	CALL	MR2
                                	LD	HL,200H
                                	CALL	TIM	;time-loop
                                	OUT	(C),8FH	;Reset all
                                	LD	HL,200H
                                	CALL	TIM
                                	POP	AF	;real sign now
                                	CALL	MR2
                                	LD	HL,200H
                                	CALL	TIM
                                	OUT	(C),8FH	;Reset all
                                
                                	IF	ANST AND 00100000B
                                	LD	HL,300H
                                	ENDIF
                                
                                	IF	ANST AND 01000000B
                                	LD	HL,2E0H
                                	ENDIF
                                
                                	CALL	TIM
                                	LD	HL,200H
                                	CALL	TIM
                                	RET
                                	ENDIF
                                	ENDIF
                                
                                	PAGE
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-19


                                
                                	IF	DRU AND 80H
                                	IF	ANST AND 01100000B
                                
                                	IF	ANST AND 01000000B
                                MR2:	OUT	(C),8CH
                                	OUT	(C),8DH
                                	CALL	PRIZU
                                	ENDIF
                                
                                	IF	ANST AND 00100000B
                                MR2:	OUT	(C),A	;latching on Printboard
                                	OUT	(C),8AH	;latching on S6001
                                	OUT	(C),88H	;sign on S6001-Keyboard
                                	ENDIF
                                
                                	RET
                                
                                
                                TIM:	PUSH	HL	;time-loop here , Input:<HL>
                                	CALL	TIM1
                                	POP	HL
                                TIM1:	LD	A,L
                                	OR	H
                                	RZ
                                	DEC	HL
                                	JR	TIM1
                                
                                	IF	ANST AND 01000000B
                                PRIZU:	LD	HL,16
                                	CALL	TIM
                                	OUT	(C),8AH
                                	OUT	(C),8BH
                                	OUT	(C),88H
                                	ENDIF
                                
                                	ENDIF
                                	ENDIF
                                
                                	PAGE
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-20


                                
                                	IF	DRU AND 80H
                                	IF	ANST AND 80H
                                ;****************************************************************
                                ;*               S 6 0 0 1  mit  Koppelinterface                *
                                ;****************************************************************
                                	PUSH	BC
                                	PUSH	AF
                                	LD	HL,CTBS6	;Codeumwandlung ASCII ===> S6001
                                	LD	D,0
                                	LD	E,A
                                	ADD	A,HL,DE
                                	LD	A,(HL)
                                	CPL
                                	PUSH	AF
                                	INC	C
                                TOUT:	IN	A	;Adresse + 1,(C)
                                	BIT	5,A
                                	JR	NZ,TOUT	;kein bereit
                                	POP	AF
                                	DEC	C
                                	OUT	(C),A	;Ausgabe Zeichen
                                	LD	A,0FDH
                                	INC	C
                                	OUT	(C),A	;STB High
                                	LD	A,0FFH
                                	OUT	(C),A	;STB Low
                                	LD	A,0FDH
                                	OUT	(C),A	;STB High
                                	OR	A
                                	POP	AF
                                	POP	BC
                                	ENDIF
                                	ENDIF
                                
  7DFC'   C9                    	RET		;return vom UP "ZEI"
                                
                                	PAGE
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-21


                                
  7DFD'                         ZEIZ	EQU	$
                                
                                	IF	DRU AND 3	;1152/1157
                                	IF	ANST AND 00001110B	;A T D / A T S
  7DFD'   3E 0D                 	LD	A,00DH
  7DFF'   CD 7DC2'              	CALL	ZEI
  7E02'   3E 0A                 	LD	A,00AH
  7E04'   CD 7DC2'              	CALL	ZEI
                                	ENDIF
                                	ENDIF
                                
                                	IF	DRU AND 4	;1154/GNI
                                	IF	ANST AND 1	;A D A
                                	INC	C
                                	LD	A,1
                                	CALL	KOUT
                                	LD	A,2
                                	CALL	KOUT
                                	CALL	WAIT
                                	CALL	WAIT
                                	DEC	C
                                	RET
                                KOUT:	OUT	(C),A	;Adresse + 1
                                	IN	A	;Adresse + 1,(C)
                                	BIT	5,A
                                	JR	NZ,KOUT+2
                                	RET
                                WAIT:	LD	B,20H
                                	PUSH	BC
                                	LD	B,0FFH
                                	DJNZ	0
                                	POP	BC
                                	DJNZ	WAIT+2
                                	ENDIF
                                	ENDIF
                                
                                	IF	DRU AND 8	;1154/ASCII
                                	IF	ANST AND 1	;A D A
                                	LD	A,00DH
                                	CALL	ZEI
                                	PUSH	DE
                                	LD	DE,00C00H
                                	DEC	DE
                                	LD	A,D
                                	OR	E
                                	JR	NZ,$-3
                                	POP	DE
                                	LD	A,00AH
                                	CALL	ZEI
                                	ENDIF
                                	ENDIF
                                
                                	IF	DRU AND 40H	;BD 4000
                                	IF	ANST AND 1
                                	CALL	ZEI
                                	ENDIF
                                	ENDIF
                                
                                	IF	DRU AND 80H	;S 6001
                                	IF	ANST AND 11100000B
                                	CALL	ZEI
                                	ENDIF
                                	ENDIF
                                
  7E07'   C9                    	RET		;return vom UP "ZEIZ"
                                
                                	PAGE
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-22


                                
                                	IF	DRU AND 00000011B	;1152/1157 PIO
                                
                                	IF	PIO AND 1	;P I O 1
  7E08'   1B                    CPI10:	DB	01BH
  7E09'   5B 30 20 4B           	DB	'[0 K'
  7E0D'   1B                    CPI12:	DB	01BH
  7E0E'   5B 31 20 4B           	DB	'[1 K'
  7E12'   1B                    LPI6:	DB	01BH
  7E13'   5B 30 20 4C           	DB	'[0 L'
  7E17'   1B                    LPI8:	DB	01BH
  7E18'   5B 35 20 4C           	DB	'[5 L'
                                
  7E1C'   06 05                 CPI:	LD	B,5
                                	ENDIF
                                
                                	IF	PIO AND 2	;P I O 2
                                CPI10:	DB	1
                                CPI12:	DB	2
                                LPI6:	DB	5
                                LPI8:	DB	6
                                
                                CPI:	LD	B,1
                                	ENDIF
                                
                                
  7E1E'   7E                    CPI1:	LD	A,(HL)
  7E1F'   23                    	INC	HL
  7E20'   CD 7DC2'              	CALL	ZEI
  7E23'   10 F9                 	DJNZ	CPI1
  7E25'   C9                    	RET
                                	ENDIF
                                
                                	PAGE
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-23


                                
                                	IF	DRU AND 80H
                                	IF	ANST AND 01100000B
                                PTAGB:	DB	26H	; &     table of upper-case signs
                                	DB	3BH	; ;
                                	DB	5FH	; _
                                	DB	3DH	; =
                                	DB	25H	; %
                                	DB	2BH	; +
                                	DB	28H	; (
                                	DB	29H	; )
                                	DB	3CH	; <
                                	DB	3EH	; >
                                	DB	2FH	; /
                                	DB	3AH	; :
                                	DB	40H	; $
                                	DB	08H	; BS
                                	DB	09H	; TAB
                                	DB	24H	; DOLLAR
                                	DB	7FH	; RUBOUT
                                	DB	22H	; "
                                	DB	3FH	; ?
                                	DB	21H	; !
                                	DB	27H	; '
                                	DB	41H	; A
                                	DB	42H	; B
                                	DB	43H	; C
                                	DB	44H	; D
                                	DB	45H	; E
                                	DB	46H	; F
                                	DB	47H	; G
                                	DB	48H	; H
                                	DB	49H	; I
                                	DB	4AH	; J
                                	DB	4BH	; K
                                	DB	4CH	; L
                                	DB	4DH	; M
                                	DB	4EH	; N
                                	DB	4FH	; O
                                	DB	50H	; P
                                	DB	51H	; Q
                                	DB	52H	; R
                                	DB	53H	; S
                                	DB	54H	; T
                                	DB	55H	; U
                                	DB	56H	; V
                                	DB	57H	; W
                                	DB	58H	; X
                                	DB	59H	; Y
                                	DB	5AH	; Z
                                	DB	5BH
                                	DB	5CH
                                	DB	5DH
                                	DB	5EH
                                	DB	03H	;Sperrschrift
                                	DB	04H	;Sparschrift
                                	DB	05H	;Schattenschrift
                                	DB	06H	;Unterstreichen
                                	DB	07H	;Fettschrift
                                
                                	ENDIF
                                	ENDIF
                                
                                	PAGE
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-24


                                
                                	IF	DRU AND 80H
                                	IF	ANST AND 01100000B
                                PTAKB:	DB	40H	; @     table of lower-case signs
                                	DB	23H	; #
                                	DB	2AH	; *
                                	DB	2CH	; ,
                                	DB	2EH	; .
                                	DB	2DH	; -
                                	DB	1EH	; newline
                                	DB	20H	; space
                                	DB	30H	; 0
                                	DB	31H	; 1
                                	DB	32H	; 2
                                	DB	33H	; 3
                                	DB	34H	; 4
                                	DB	35H	; 5
                                	DB	36H	; 6
                                	DB	37H	; 7
                                	DB	38H	; 8
                                	DB	39H	; 9
                                	DB	61H	; a
                                	DB	62H	; b
                                	DB	63H	; c
                                	DB	64H	; d
                                	DB	65H	; e
                                	DB	66H	; f
                                	DB	67H	; g
                                	DB	68H	; h
                                	DB	69H	; i
                                	DB	6AH	; j
                                	DB	6BH	; k
                                	DB	6CH	; l
                                	DB	6DH	; m
                                	DB	6EH	; n
                                	DB	6FH	; o
                                	DB	70H	; p
                                	DB	71H	; q
                                	DB	72H	; r
                                	DB	73H	; s
                                	DB	74H	; t
                                	DB	75H	; u
                                	DB	76H	; v
                                	DB	77H	; w
                                	DB	78H	; x
                                	DB	79H	; y
                                	DB	7AH	; z
                                	DB	7BH
                                	DB	7CH
                                	DB	7DH
                                	DB	7EH
                                
                                	ENDIF
                                	ENDIF
                                
                                	PAGE
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-25


                                
                                	IF	DRU AND 80H
                                	IF	ANST AND 80H
                                CTBS6:	DW	1D1DH
                                	DB	0A5H
                                	DB	0A6H
                                	DB	0A7H
                                	DB	0A8H
                                	DB	0A9H
                                	DB	0AAH
                                	DB	1CH
                                	DB	19H
                                	DB	0AH
                                	DB	08H
                                	DB	0CH
                                	DB	1EH
                                	DB	0BH
                                	DB	1DH
                                	DB	80H
                                	DB	81H
                                	DB	82H
                                	DB	83H
                                	DB	84H
                                	DB	90H
                                	DB	91H
                                	DB	92H
                                	DB	93H
                                	DB	94H
                                	DW	1D1DH
                                	DW	1D1DH
                                	DB	1EH
                                	DB	1FH
                                	DB	1DH	;20
                                	DB	21H
                                	DB	22H
                                	DB	23H
                                	DB	5EH
                                	DB	25H
                                	DB	26H
                                	DB	27H
                                	DB	'()*+,-./'
                                	DB	'0123456789'
                                	DB	':;'
                                	DB	24H
                                	DB	3DH
                                	DB	20H
                                	DB	3FH
                                	DB	3CH
                                	DB	'ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]'
                                	DB	40H
                                	DB	5FH
                                	DB	3EH
                                	DB	'abcdefghijklmnopqrstuvwxyz{|}'
                                	DB	7EH
                                	DB	1DH
                                	DB	80H
                                	DB	81H
                                	DB	82H
                                	DB	83H
                                	DB	84H
                                	DB	1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DB	90H
                                	DB	91H
                                	DB	92H
                                	DB	93H
                                	DB	94H
                                	DB	1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DB	0A0H
                                	DB	0A1H
                                	DB	0A2H
                                	DB	0A3H
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	1-26


                                	DB	0A4H
                                	DB	0A5H
                                	DB	0A6H
                                	DB	0A7H
                                	DB	0A8H
                                	DB	0A9H
                                	DB	0AAH
                                	DW	1D1DH
                                	DB	0ADH
                                	DB	0AEH
                                	DB	0AFH
                                	DB	0B0H
                                	DB	0B1H
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DB	0C0H
                                	DB	0C1H
                                	DB	0C2H
                                	DW	1D1DH
                                	DB	1DH
                                	DB	0C6H
                                	DB	0C7H
                                	DB	0C8H
                                	DB	0C9H
                                	DB	0CAH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DB	0CFH
                                	DB	0D0H
                                	DB	0D1H
                                	DB	0D2H
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DW	1D1DH
                                	DB	0FFH
                                	ENDIF
                                	ENDIF
                                
                                	END
'Zeichenausgabe an den Drucker'	MACRO-80 3.44	09-Dec-81	PAGE	S


Macros:

Symbols:
8830 	ANFED           0008 	ANST            7DC6'	B1              
7DD1'	B3              7DDD'	B4              7DDE'	B6              
7D85'	CL1             7E1C'	CPI             7E1E'	CPI1            
7E08'	CPI10           7E0D'	CPI12           7C03'	DINIT           
0002 	DRU             0DC4 	ENDED           0000 	ES2             
0877 	IDH             7D1A'	IN1             0058 	ISR             
7C54'	LPI             7E12'	LPI6            7E17'	LPI8            
7DB6'	M1              7DB9'	M2              7DB1'	M3              
7C64'	NULL            7C63'	ONULL           7CF3'	P1.MRES         
7D61'	P1.PRIO         3327 	PAR             0001 	PIO             
7C3F'	PR.CPI          7C3B'	PR.CPI10        0F70 	PR.DRU          
7CE6'	PR.END          7C50'	PR.LPI6         7C81'	PR.M2           
7CB9'	PR1             7CC0'	PR2             7CCC'	PR3             
7CCE'	PR4             7C0C'	PRINA           7C00'	PRINT           
7DEB'	SIOTB           7DF5'	STAT            7C6A'	SYS             
000B 	SYSTB           7DC2'	ZEI             7DFD'	ZEIZ            



No Fatal error(s)


    
7D61'	P1.PRIO         3327 	PAR             0001 	PIO             
7C3F'	PR.CPI          7C3B'	PR.CPI10    