	TITLE 'Handling f. IX/IY-adressierte Bereiche'
	PAGE
;	PN	XY ; Unterprogramme
;**********************************************************************
;*                                                                    *
;*       Handling f. IX/IY-adressierte Steuer-Bloecke bzw.            *
;*                                     Arbeits-Bereiche               *
;*                                                                    *
;*--------------------------------------------------------------------*
;*                                                                    *
;*       Ausser den angegebenen Registern bzw. Flags wird nur noch    *
;*       die angegebene Anzahl der ersten freien Stack-Plaetze (je    *
;*       Byte) veraendert. Weiterer RAM-Platz wird nicht benoetigt.   *
;*                                                                    *
;**********************************************************************
;*                                                                    *
;*       Technische (Hilfs-) Unter-Programme                          *
;*                                                                    *
;**********************************************************************
			;
;        Uebernahme von nach dem CALL stehenden Parameter
;        ++++++++++++++++++++++++++++++++++++++++++++++++
;        erwarten Stack:           Return-Adresse f.uebergeordnetes UP
;                       (SP) -->   Return-Adresse f.CALPn
;        geben Stack zurueck:      Return-Adresse f.uebergeordn.UP + n
;                                  (DE)
;                       (SP) -->   (HL)
;        geben in Reg.zurueck:     (DE):  Wert    1.Parameter-Byte
;                                  (HL):  Adresse 2.Parameter-Byte
;        --------------------------------------------------------------
			;
XY.CALP1	EQU	$	; 1 Byte-Parameter
			; ++++++++++++++++++++++++++++++
	PUSH	HL	; Retten HL
	POP	HL
			;
	EX	DE,HL	; DE <--> RET-Adr.f.CALPn
	EX	(SP),HL
	EX	DE,HL
			;
	POP	HL	; (SP) --> RET-Adr.f.ueberg.UP
			;
	POP	HL	; Laden u. korrig. ...
	INC	HL
	PUSH	HL
XY.CALPE:
	DEC	HL
			;
	DEC	SP	; (SP) --> (DE)
	DEC	SP
	DEC	SP	; (SP) --> (HL)
	DEC	SP
			;
	PUSH	DE	; RET-Adr.f.CALPn
			;
	LD	E,(HL)	; Laden DE, HL
	LD	D,0
	INC	HL
			;
	RET
			;
			;
;**********************************************************************
;*                                                                    *
;*       Lade-, Speicher- und Transport-Unterprogramme                *
;*                                                                    *
;**********************************************************************
;
;    CALL  LDDX    'Load':              HL := (IX+d)
;    DB    d                                              Stack: 4
;    -----------   ----------------------------------------------------
			;
XY.LDDX:
	CALL	XY.CALP1	; Uebernahme d
			;
	PUSH	IX	; HL := IX+d
	POP	HL	;               <--- LDDY
	PUSH	AF
	ADD	HL,DE
	POP	AF
			;
	LD	E,(HL)	; HL := (IX+d)
	INC	HL
	LD	D,(HL)
	EX	DE,HL
			;
	POP	DE	; Return
	POP	DE
	RET
			;
;**********************************************************************
;
;    CALL  LIDX    'Load inverse':      LH := (IX+d)
;    DB    d                                              Stack: 4
;    -----------   ----------------------------------------------------
			;
XY.LIDX:
	CALL	XY.CALP1	; Uebernahme d
			;
	PUSH	IX	; HL := IX+d
	POP	HL	;               <--- LIDY
	PUSH	AF
	ADD	HL,DE
	POP	AF
			;
	LD	D,(HL)	; LH := (IX+d)
	INC	HL
	LD	E,(HL)
	EX	DE,HL
			;
	POP	DE	; Return
	POP	DE
	RET
			;
;**********************************************************************
;
;    CALL  STDX    'Store':            (IX+d) := HL
;    DB    d                                                  Stack: 4
;    -----------   ----------------------------------------------------
			;
XY.STDX:
	CALL	XY.CALP1	; Uebernahme d
			;
	PUSH	IX	; HL := IX+d
	POP	HL	;               <--- STDY
	PUSH	AF
	ADD	HL,DE
	POP	AF
			;
	POP	DE
	LD	(HL),E	; (IX+d) := HL
	INC	HL
	LD	(HL),D
	EX	DE,HL
			;
	POP	DE	; Return
	RET
			;
;**********************************************************************
;
;    CALL  STIDX    'Store inverse':    (IX+d) := LH
;    DB    d                                                  Stack: 4
;    -----------   ----------------------------------------------------
			;
XY.STIDX:
	CALL	XY.CALP1	; Uebernahme d
			;
	PUSH	IX	; HL := IX+d
	POP	HL	;               <--- STIDY
	PUSH	AF
	ADD	HL,DE
	POP	AF
			;
	POP	DE
	LD	(HL),D	; (IX+d) := LH
	INC	HL
	LD	(HL),E
	EX	DE,HL
			;
	POP	DE	; Return
	RET
			;
;**********************************************************************
;
;    CALL  INCDX    'Increment':        (IX+d) := (IX+d) + 1
;    DB    d                                    Flags wie ADC HL,...
;                                                             Stack: 4
;    -----------   ----------------------------------------------------
			;
XY.INCDX:
	CALL	XY.CALP1	; Uebernahme d
			;
	PUSH	IX	; HL := IX+d
	POP	HL	;               <--- INCDY
	ADD	HL,DE
			;
	LD	E,(HL)	; DE := (IX+d)
	INC	HL
	LD	D,(HL)
			;
	PUSH	HL	; DE := (IX+d) + 1
	LD	HL,1
	OR	A
	ADC	HL,DE
	EX	DE,HL
	POP	HL
	LD	(HL),D
	DEC	HL
	LD	(HL),E
			;
	POP	HL	; Return
	POP	DE
	RET
			;
;**********************************************************************
;*                                                                    *
;*       Unterprogramm  'Unbedingter Sprung'                          *
;*                                                                    *
;**********************************************************************
;
;    CALL  JMPDX   'Jump':              JMP  (IX+d)
;    DB    d                                              Stack: 4
;                                       Achtung!
;                                           Veraendert freie Stack-Pl.
;    -----------   ----------------------------------------------------
			;
XY.JMPDX:
	CALL	XY.CALP1	; Uebernahme d
			;
	PUSH	IX	; HL := IX+d
	POP	HL	;               <--- JMPDY
	PUSH	AF
	ADD	HL,DE
	POP	AF
			;
	LD	E,(HL)	; HL := (IX+d)
	INC	HL
	LD	D,(HL)
	EX	DE,HL
			;
	POP	DE	; Return = Jump
	EX	(SP),HL
	EX	DE,HL
	RET
			;
;**********************************************************************
;	END
