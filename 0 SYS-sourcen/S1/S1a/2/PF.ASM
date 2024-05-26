	TITLE	'DEG2000 V. 1.2    PF - Belegungen'
	PAGE
;	PN	PF01
;****************************************************************
;*                  DEG2000 V. 1.2    PF - ROM 2 - Belegung     *
;*  Version         --------------------------------------------*
;*                  Programmierer: M. Herbote  K EAW  ZFT (WFT) *
;*  V 1 . 2         --------------------------------------------*
;*                  Stand        : 06.Februar 1985              *
;****************************************************************

CR	EQU	01EH
PF.SPST EQU	028H

	DW	$
	DB	'PFTA'
	LD	A,(SD.BWSA+327H)
	CP	'1'
	JR	Z,PF.O1
	CP	'2'
	JR	Z,PF.O2
	CP	'3'
	JR	Z,PF.O3
	CP	'4'
	JR	Z,PF.O4
	JR	PF.OXEND

PF.O1:
	LD	HL,PFT1
	LD	DE,PFT1E
	JR	PF.OB
PF.O2:
	LD	HL,PF.O2ANF
	LD	DE,PF.O2END
	JR	PF.OB
PF.O3:
	LD	HL,PF.O3ANF
	LD	DE,PF.O3END
	JR	PF.OB
PF.O4:
	LD	HL,PF.O4ANF
	LD	DE,PF.O4END
	JR	PF.OB
	
PF.OB:
  	LD	(SM.PTSE),DE
	LD	(SM.PTSA),HL
PF.OXEND:
	JP	SY.SYSTB

PFT1:	DB	'----+----1----+----2----+----3----+----4'
	DB	'----+----5----+----6----+----7----+----'
	DB	01EH
	DW	0		; 2
	DW	0		; 4
	DW	0		; 6
	DW	0		; 8
	DW	0		;10
	DW	0		;12
	DW	0		;14
	DW	0		;16
	DW	0		;18
	DW	0		;20
	DW	0		;22
	DW	0		;24
	DW	0		;26
	DW	0		;28
PFT1E	EQU	$
	PAGE
;****************************************************************
PF.O2ANF EQU	$
	DB	';****************************************************************'    ;PF01-0
	DW	CR
	DB	';*                                                              *'    ;PF02-0
	DW	CR
	DB	';*                  '                                                 ;PF03-0
	DB	0
; ----
	DB	';*                  Programmierer:'                                   ;PF04-0
	DB	' M. Herbote  K EAW  ZFT (WFV) *'
	DW	CR
	DB	';*                  --------------------------------------------*'    ;PF05-0
	DW	CR
	DB	';*                  Stand        : '                                  ;PF06-0
	DB	0
; ----
	DB	'         CALL  '                                                      ;PF07-0
	DB	0
	DB	'         DA    '                                                      ;PF08-0
	DB	0
	DB	'         DB    '                                                      ;PF09-0
	DB	0
; ----
	DB	'         XOR   A'                                                     ;PF10-0
	DW	CR
	DB	'         LD    A,'                                                    ;PF11-0
	DB	0
	DB	'         LD    HL,'                                                   ;PF12-0
	DB	0
; ====	
	DB	'         PUSH  HL'                                                    ;PF01-1 PF13
	DW	CR
	DB	'         PUSH  IX'                                                    ;PF02-1 PF14
	DW	CR
	DB	'         PUSH  IY'                                                    ;PF03-1 PF15
; ----
	DW	CR
	DB	'         POP   HL'                                                    ;PF04-1 PF16
	DW	CR
	DB	'         POP   IX'                                                    ;PF05-1 PF17
	DW	CR
	DB	'         POP   IY'                                                    ;PF06-1 PF18
	DW	CR
; ----
	DB	'         PUSH  AF'                                                    ;PF07-1 PF19
	DW	CR
	DB	'         PUSH  BC'                                                    ;PF08-1 PF20
	DW	CR
	DB	'         PUSH  DE'                                                    ;PF09-1 PF21
	DW	CR
; ----
	DB	'         POP   AF'                                                    ;PF10-1 PF22
	DW	CR
	DB	'         POP   BC'                                                    ;PF11-1 PF23
	DW	CR
	DB	'         POP   DE'                                                    ;PF12-1 PF24
	DW	CR
; ====
	DB	'(C) Marcus Herbote    K EAW / wfvm'                                   ;PF01-2 PF25
	DW	CR
	DB	0                                                                      ;PF02-2 PF26
	DB	0                                                                      ;PF03-2 PF27
	DB	0                                                                      ;PF04-2 PF28
PF.O2END EQU	$
	PAGE
;****************************************************************
PF.O3ANF EQU	$
	DB	'!//FRJOB01  JOB (FR690030,01),FRpgrmr1,MSGLEVEL=(1,1),'               ;PF01-0
	DW	CR
	DB	'!//             REGION=090K,TYPRUN=HOLD,CLASS=E'                      ;PF02-0
	DW	CR
	DB	'!//STEP01  EXEC PGM=name...,PARM=''    '''                            ;PF03-0
	DW	CR
; ----
	DB	'!//STEPLIB  DD  DSN=FR1.LADT.T1,DISP=SHR'                             ;PF04-0
	DW	CR
	DB	'!//SYSPRINT DD  SYSOUT=A'                                             ;PF05-0
	DW	CR
	DB	'!//SYSUT1   DD  DSN=FRx.QUET.T1,DISP=SHR'                             ;PF06-0
	DW	CR
; ----
	DB	'!//SYSUT2   DD  DSN=FRx.QUET.T1,DISP=SHR'                             ;PF07-0
	DW	CR
	DB	'!//SYSIN    DD  *'                                                    ;PF08-0
	DW	CR
	DB	'!//             UNIT=5010,VOL=SER=TBoooo,LABEL=(o,SL),'               ;PF09-0
	DW	CR
; ----
	DB	'!//             DCB=(RECFM=FBA,LRECL=121,BLKSIZE=0121),'              ;PF10-0
	DW	CR
	DB	'!//             SPACE=(TRK,(100,50),RLSE),'                           ;PF11-0
	DW	CR
	DB	'!//             DISP=(,PASS),'                                        ;PF12-0
	DW	CR
; ====
	DB	'!//             HIS0=FR1,HIS1=FR1,NCAL=,MODUL=name'                   ;PF00-1 PF13
	DW	CR
	DB	'!//             UNIT=5050,VOL=SER=BBoooo,DISP=(,PASS),'               ;PF02-1 PF14
	DW	CR
	DB	'!NEWMEMBER      name,R01'                                             ;PF03-1 PF15
	DW	CR
; ----
	DB	'!START    AUTOINCL'                                                   ;PF04-1 PF16
	DW	CR
	DB	'!PARM.PRINT'                                                          ;PF05-1 PF17
	DW	CR
	DB	'!INCLUDE        name'                                                 ;PF06-1 PF18
	DW	CR
; ----
	DB	'!         INCL  (ooooo}'
	DB	9EH
	DB	0BAH
	DB	'ooo,oooooooo)'                                                        ;PF07-1 PF19
	DW	CR
	DB	'! oooooooo'                                                           ;PF08-1 PF20
	DW	CR
	DB	'!#ENDE#'                                                              ;PF09-1 PF21
	DW	CR
; ----
	DB	'!A,EXTRN        KOM'                                                  ;PF10-1 PF22
	DW	CR
	DB	'!CONTROL  ALL   FILPRINT,FIL#M01'                                     ;PF11-1 PF23
	DW	CR
	DB	'!./       CHANGE NAME=name,newname,R02'                               ;PF12-1 PF24
	DW	CR
; ----
	DB	7DH
	DB	9FH
	DB	'7!         TEXT  titelzeile'                                          ;PF01-2 PF25
	DW	CR
	DB	'!         PRINT name'                                                 ;PF02-2 PF26
	DW	CR
	DB	'!EX,FILPRINT    INHALT*'                                              ;PF03-2 PF27
	DW	CR
; ----
	DB	'umschlagtitel '                                                       ;PF04-2 PF28
	DW	CR
	DB	'VVVVVVttmmjjDRnnMCR1FRbbbbb0001KOI7ECLK'                              ;PF05-2 PF29
	DW	CR
	DB	'!//'                                                                  ;PF06-2 PF30
	DW	CR
; ----
	DB	0                                                                      ;PF07-2 PF31
	DB	0                                                                      ;PF08-2 PF32
	DB	0                                                                      ;PF09-2 PF33
; ----
	DB	0                                                                      ;PF10-2 PF34
	DB	0                                                                      ;PF11-2 PF35
	DB	0                                                                      ;PF12-2 PF36
PF.O3END EQU	$
	PAGE
;****************************************************************
PF.O4ANF EQU	$
	DB	'AIF   ('                                                              ;PF01-0
	DW	CR
	DB	'AGO   .'                                                              ;PF02-0
	DW	CR
	DB	'ANOP'                                                                 ;PF03-0
	DB	1EH
	DW	CR
; ----
	DB	'SETa  '                                                               ;PF04-0
	DW	CR
	DB	'MNOTE *,'                                                             ;PF05-0
	DW	CR
	DB	'&SYSLIST('                                                            ;PF06-0
	DW	CR
; ----
	DB	'DC    CL'                                                             ;PF07-0
	DW	CR
	DB	'&A+'                                                                  ;PF08-0
	DW	CR
	DB	'&PRMCa('                                                              ;PF09-0
	DW	CR
; ----
	DB	' EQ '                                                                 ;PF10-0
	DW	CR
	DB	' NE '                                                                 ;PF11-0
	DW	CR
	DB	' OR '                                                                 ;PF12-0
	DW	CR
; ====
	DB	' AND '                                                                ;PF01-1 PF13
	DW	CR
	DB	';****************************************************************'    ;PF02-1 PF14
	DB	1EH
	DW	CR
	DB	';*                                                              *'    ;PF03-1 PF15
	DB	1EH
	DW	CR
; ----
	DB	'1---5----10---5----20---5----30---5----40---5----50---5----60---5----70*--5----'
	DB	1EH                                                                    ;PF04-1 PF16
	DW	CR
	DB	'|------------------------------------------------------------------------------|'
	DB	CR                                                                     ;PF05-1 PF17
	DB	'|                                                                              |'
	DB	CR                                                                     ;PF06-1 PF18
; ----
	DW	CR
	DB	'Programmierer: Marcus Herbote   --- IfR - OE-S'                       ;PF07-1 PF19
	DW	CR
	DB	'-----------------------------------------------'                      ;PF08-1 PF20
	DW	CR
	DB	';*               '                                                    ;PF09-1 PF21
	DW	CR
; ----
	DB	'Stand        :'                                                       ;PF10-1 PF22
	DW	CR
	DB	0                                                                      ;PF11-1 PF23
	DB	0                                                                      ;PF12-1 PF24
PF.O4END EQU	$
	PAGE
	IF	SD.GENE AND 00010000B	;DEG2000 Emulator
	DW	$
	DB	'S4  '

	LD	BC,004C0H
	LD	HL,OUTB2
	OTIR
	JP	00000H	;!!!!	;Sprung zum BIOS-Anfang
OUTB2:
	DB	0F0H	;Startbyte
	DB	003H	;wahl
	DB	005H	;Sys_43
	DB	0FFH	;Endbyte
	ENDIF


	PAGE
PF.MINTP EQU	$
	IF	SD.GENE AND 00000010B
	LD	BC,PF.SPST	;Sektoren 0, 1, 2, 3 wegschalten
	LD	E,4
	LD	A,8		;<--|
	OUT	(C),A		;   |
	LD	A,B		;   |
	ADD	A,10H		;   |
	LD	B,A		;   |
	DEC	E		;   |
	JR	NZ,$-9		;---|
	ENDIF

	IF	SD.GENE AND 00000100B
	XOR	A		;Sektoren 0, 1, 2, 3 wegschalten
	LD	B,4
	EXX			;<--|
	LD	B,A		;   |
	LD	C,PF.SPST+5	;   |
	OUT	(C),A		;   |
	LD	C,PF.SPST+7	;   |
	OUT	(C),A		;   |
	ADD	A,10H		;   |
	EXX			;   |
	DJNZ	$-13		;---|
	ENDIF

	IF	SD.GENE AND 00001110B
	LD	HL,PF.UP1	;RESET - Eintrittsadresse setzen
	LD	(00C02H),HL
	ENDIF

	IF	SD.GENE AND 00000010B
	LD	BC,PF.SPST	;Sektoren 0, 1, 2    zuschalten
	LD	E,3
	XOR	A		;<--|
	OUT	(C),A		;   |
	LD	A,B		;   |
	ADD	A,10H		;   |
	LD	B,A		;   |
	DEC	E		;   |
	JR	NZ,$-8		;---|
	ENDIF

	IF	SD.GENE AND 00000100B
	XOR	A		;Sektoren 0, 1, 2    zuschalten
	LD	B,3
	EXX			;<--|
	LD	B,A		;   |
	LD	C,PF.SPST+4	;   |
	OUT	(C),A		;   |
	LD	C,PF.SPST+6	;   |
	OUT	(C),A		;   |
	ADD	A,10H		;   |
	EXX			;   |
	DJNZ	$-13		;---|
	ENDIF

	IF	SD.GENE AND 00001110B
	LD	HL,08000H	;"ZRE-PROM" - Bereich umladen
	LD	DE,00000H
	LD	BC,00C00H
	LDIR
	LD	DE,01000H	;"OFS-PROM" - Bereich umladen
	LD	BC,01800H
	LDIR
	JP	00000H	;Aufruf  DEG2000  Version 1.2

PF.UP1	EQU	$	;Eintrittsroutine fuer  R E S E T
	ENDIF

	IF	SD.GENE AND 00000010B
	LD	BC,PF.SPST	;Sektoren 0, 1, 2, 3 wegschalten
	LD	E,4
	LD	A,8		;<--|
	OUT	(C),A		;   |
	LD	A,B		;   |
	ADD	A,10H		;   |
	LD	B,A		;   |
	DEC	E		;   |
	JR	NZ,$-9		;---|

	LD	BC,PF.SPST	;Sektoren 0, 1, 2    zuschalten
	LD	E,3
	XOR	A		;<--|
	OUT	(C),A		;   |
	LD	A,B		;   |
	ADD	A,10H		;   |
	LD	B,A		;   |
	DEC	E		;   |
	JR	NZ,$-8		;---|
	ENDIF

	IF	SD.GENE AND 00000100B
	XOR	A		;Sektoren 0, 1, 2, 3 wegschalten
	LD	B,4
	EXX			;<--|
	LD	B,A		;   |
	LD	C,PF.SPST+5	;   |
	OUT	(C),A		;   |
	LD	C,PF.SPST+7	;   |
	OUT	(C),A		;   |
	ADD	A,10H		;   |
	EXX			;   |
	DJNZ	$-13		;---|

	XOR	A		;Sektoren 0, 1, 2    zuschalten
	LD	B,3
	EXX			;<--|
	LD	B,A		;   |
	LD	C,PF.SPST+4	;   |
	OUT	(C),A		;   |
	LD	C,PF.SPST+6	;   |
	OUT	(C),A		;   |
	ADD	A,10H		;   |
	EXX			;   |
	DJNZ	$-13		;---|
	ENDIF

	IF	SD.GENE AND 00001110B
	JP	00000H

	DW	$
	DB	'URL '
	ENDIF

	IF	SD.GENE AND 00000010B
	LD	BC,PF.SPST	;Sektoren 0, 1, 2    wegschalten
	LD	E,3
	LD	A,8		;<--|
	OUT	(C),A		;   |
	LD	A,B		;   |
	ADD	A,10H		;   |
	LD	B,A		;   |
	DEC	E		;   |
	JR	NZ,$-9		;---|
	ENDIF

	IF	SD.GENE AND 00000100B
	XOR	A		;Sektoren 0, 1, 2    wegschalten
	LD	B,3
	EXX			;<--|
	LD	B,A		;   |
	LD	C,PF.SPST+5	;   |
	OUT	(C),A		;   |
	LD	C,PF.SPST+7	;   |
	OUT	(C),A		;   |
	ADD	A,10H		;   |
	EXX			;   |
	DJNZ	$-13		;---|
	ENDIF

	IF	SD.GENE AND 00001110B
	JP	00000H		;Aufruf des  U r l a d e r s
	ENDIF

			;Stand: 21.Februar 85 - K EAW/wfvm..MSH

;	END
