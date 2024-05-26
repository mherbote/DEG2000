	TITLE 'Konvertierungen'
	PAGE
;	PN	UC
;----------------------------------------------------------------------
;
;       KONVERTIERUNGEN
;
;----------------------------------------------------------------------
;                            HL := HL * 10
;                                      (ohne Kontrolle auf Uebertrag)
UC.HL10N:
	PUSH	HL
	POP	DE	; alter Wert in DE
	ADD	HL,HL
	ADD	HL,HL
	ADD	HL,DE
	ADD	HL,HL
	RET
;                            HL := HL * 10
;                                            -->  C: Uebertrag in A
UC.HL10C:
	PUSH	HL
	POP	DE	; alter Wert in DE
	XOR	A
	ADD	HL,HL
	JR	NC,$+3
	INC	A
	ADD	A,A
	ADD	HL,HL
	JR	NC,$+3
	INC	A
	ADD	HL,DE
	JR	NC,$+3
	INC	A
	ADD	A,A
	ADD	HL,HL
	JR	NC,$+3
	INC	A
	OR	A
	RET	Z
	SCF
	RET
			;
;        --------------------------------------------------------------
;                            Division mit Rest:  A  := HL / DE
;                                                HL := Rest
			;      Cy(A) --->  A=255
			;-------------------------------
UC.DIVR:
	XOR	A
	SBC	HL,DE
	INC	A
	JR	NZ,$+5
	DEC	A
	JR	C,$+5
	JR	NC,$-8
	DEC	A
	ADD	HL,DE
	RET
			;
;**********************************************************************
;*                                                                    *
;*       CV...               Konvertierungen     (convert ...)        *
;*                                                                    *
;*--------------------------------------------------------------------*
;*       ..A..:              in A                                     *
;*       ..?*.:              von Typ *                                *
;*       ..?.*:              nach Typ *                               *
;*                                                                    *
;*       Typen:              B - binaer                               *
;*                           X - hexadezimal ASCII                    *
;*                           A - Adresse binaer (L,H)                 *
;*                           D - dezimal ASCII                        *
;*                                                                    *
;**********************************************************************
			;
;                            In A:      Binaer < 16 --> ASCII hexa
;                            ------------------------------------------
UC.CVABX:
	AND	0FH
	OR	30H
	CP	3AH
	RET	C
	ADD	A,7H
	RET
			;
;        --------------------------------------------------------------
;                            Byte binaer (HL) --> 2 ASCII hexa (DE)
;                                                            HL+1, DE+2
;                            ------------------------------------------
UC.CVBX:
	LD	A,(HL)
	INC	HL	; benutzt: A, 2 Stack-P.
			;
	PUSH	AF	;ENTRY,WENN ZEICHEN IN A
	RRCA
	RRCA
	RRCA
	RRCA
	CALL	$+4
	POP	AF
			;
	CALL	UC.CVABX
	LD	(DE),A
	INC	DE
	RET
			;
;        --------------------------------------------------------------
;                       Adresse (L,H) binaer (HL) --> 4 ASCII hexa (DE)
;                                                            HL+2, DE+4
;                       -----------------------------------------------
UC.CVAX:
	INC	HL
	CALL	UC.CVBX	; benutzt: A, 3 Stack-P.
	DEC	HL
	DEC	HL
	CALL	UC.CVBX
	INC	HL
	RET
			;
;        --------------------------------------------------------------
;                       Adresse aus HL, binaer    --> 4 ASCII hexa (DE)
;                                                                  DE+4
;                       -----------------------------------------------
UC.CVHLX:
	LD	A,H
	CALL	UC.CVBX+2	; benutzt: A, 3 Stack-P.
	LD	A,L
	CALL	UC.CVBX+2
	RET
			;
			;
;      ---------------------------------------------------------------
;                            In A:     ASCII hexa --> binaer < 16
;
;                                       Datenfehler: Cy, A undefiniert
;                            ------------------------------------------
UC.CVAXB:
	SUB	30H
	RET	C		;       (A) < '0'
	CP	10
	CCF
	RET	NC
	CP	11H
	RET	C		; '9' < (A) < 'A'
	CP	17H
	CCF
	RET	C		; 'F' < (A)
	SUB	7H
	RET
			;
;        --------------------------------------------------------------
;                            2 ASCII hexa (DE) --> Byte binaer (HL)
;                                                            DE+2, HL+1
;
;                                       mit Datenfehler-Behandlung
;                            ------------------------------------------
UC.CVXB:
	PUSH	BC
			; benutzt: A, 3 Stack-P.
	CALL	UC.CVX1B
	ADD	A,A
	ADD	A,A
	ADD	A,A
	ADD	A,A
	LD	C,A
			;
	CALL	UC.CVX1B
	ADD	A,C
			;
	LD	(HL),A
	INC	HL
	POP	BC
	RET
			;
UC.CVX1B:
	LD	A,(DE)	; ASCII hexa (DE) --> A binaer,
	CALL	UC.CVAXB	;                           DE+1
	CALL	C,UC.CVXER
	INC	DE
	RET
			;
UC.CVXER:
	EX	DE,HL       ; Datenfehler-Behandlung hexa
	SET	7,(HL)      ;         set cursor
    CALL  UR.TAREP  ; <-+     tast.request
    LD    (HL),A    ;   |     write in conv.-area
    CALL  UC.CVAXB  ;   |     conv.in A
    JR    C,$-7     ; --+     on error ...
    RES   7,(HL)
    EX    DE,HL
    RET
			;
;        --------------------------------------------------------------
;                       4 ASCII hexa (DE) --> Adresse (L,H) binaer (HL)
;                                                            DE+4, HL+2
;
;                                       mit Datenfehler-Behandlung
;                       -----------------------------------------------
UC.CVXA:
	INC	HL
	CALL	UC.CVXB	; benutzt: A, 4 Stack-P.
	DEC	HL
	DEC	HL
	CALL	UC.CVXB
	INC	HL
	RET
			;
;        --------------------------------------------------------------
;                     2 Byte binaer in HL ---> 1...5-stellig dezi (DE),
;                                                             DE+1...5
;                                  mit Vor-Null-Unterdrueckung
;                                                    (nach nicht-dezi),
;                                  zu wenig Stellen -->
;                                      '*' in der obersten angeg.Stelle
;                      ------------------------------------------------
UC.CVBD5:
	LD	A,5	; benutzt: A, 7 Stack-P.
	JR	$+16
UC.CVBD4:
	LD	A,4
	JR	$+12
UC.CVBD3:
	LD	A,3
	JR	$+8
UC.CVBD2:
	LD	A,2
	JR	$+4
UC.CVBD1:
	LD	A,1
			;
UC.CVBD:	PUSH	BC	; Zeichenzahl in A
	PUSH	HL
	LD	B,A
	CALL	UC.CVBD0
	DJNZ	$-3
	POP	HL
	POP	BC
	RET
			;
;                          Abspaltung B-te Stelle dezi von HL nach (DE)
;                                                                  DE+1
;                          B-te nicht fuehrende Stelle: '*' nach (DE)
;                          --------------------------------------------
UC.CVBD0:
	PUSH	BC	; benutzt: A, 5 Stack-P.
			; --------
	LD	A,L
	OR	'0'
	DEC	B
    JR   Z,$+43	  ; -------+
                  ;        |
    PUSH DE       ;        |
    PUSH HL       ; DE := (B-1)-te Zehner-Potenz
    LD   HL,1     ;        |
    CALL UC.HL10N ;        |
    DJNZ $-3      ;        |
    EX   DE,HL    ;        |
    POP  HL       ;        |
                  ;        |
    CALL UC.DIVR  ; A := HL / B-te Zehner-Potenz
    POP  DE       ;        |     HL := Rest
                  ;        |
    CP   10       ; test to decimal
    JR   C,$+6    ; ---+   |
    LD   A,'*'    ;    |   |
    JR   $+19     ; -------+
                  ; <--+   |
    OR   '0'      ; conv.to decimal
                  ;        |
    CP   '0'      ; Vor-Null ?
    JR   NZ,$+13  ; -------+
    DEC  DE       ;        |
    LD   C,A      ;        |
    CALL UC.CVD1B ;        |
    LD   A,C      ;        |
    INC  DE       ;        |
    JR   NC,$+4   ;        |
    LD   A,' '    ;        |
                  ; <------+
	LD	(DE),A
	INC	DE
	POP	BC
	RET
			;
;        --------------------------------------------------------------
;                      Dezi von (DE) bis (-->DE) nicht-dezi
;                                                --->      binaer in HL
;
;                         Fehler:
;                         -------
;                         Cy, NZ: Zahl zu gross, HL ohne letzte Ziffer
;                         Cy, Z:  Leere Zahl (1.Position keine Ziffer),
;                                        -->     HL = 0
;                      ------------------------------------------------
UC.CVDB:
	LD	H,0
	CALL	UC.CVD1B
	LD	L,A
	JR	NC,$+6
	XOR	A
	LD	L,A
	SCF
	RET		; ---> abend C, Z
			;
	INC	DE
	CALL	UC.CVD1B
	CCF
	RET	NC		; ---> normal end
    PUSH  DE
    PUSH  AF
    CALL  UC.HL10C
    JR    C,$+13    ; ----------+
    POP   AF        ;           |
    ADD   A,L       ;           |
    LD    L,A       ;           |
    JR    NC,$+5	; --+       |
    INC   H         ;   |       |
    JR    Z,$+6     ;   |    ---|--+
    POP   DE        ; <-+       |  |
    JR    $-22      ;           |  |
                    ;      <----+  !
    POP   HL        ; abend Cy, NZ !
    DEC   H         ;              |
    EX    DE,HL     ;        <-----+
    POP   DE
    RET
			;
;        --------------------------------------------------------------
;                            Ziffer dezi (DE) ---> binaer nach A, DE+1
;                                                  Cy: nicht-dezi
;                            ------------------------------------------
UC.CVD1B:
	LD	A,(DE)
	SUB	30H
	RET	C
	CP	10
	CCF
	RET
			;
;        --------------------------------------------------------------
;                    Byte binaer (HL) --> Byte ASCII-Symbol (DE)
;                                         (sonst: 7FH )
;                                                     HL+1, DE+1
;                    --------------------------------------------------
UC.CVBC:
	LD	A,(HL)	; benutzt: A, 0 Stack-P.
	INC	HL	; --------
	CP	20H
	JR	NC,$+4
	LD	A,7FH
	CP	7FH
	JR	C,$+4
	LD	A,7FH
	LD	(DE),A
	INC	DE
	RET
			;
;        --------------------------------------------------------------
;                       Byte ASCII-Symbol (DE)   -->   Byte binaer (HL)
;                                                      DE+1, HL+1
;                       -----------------------------------------------
UC.CVCB:
	LD	A,(DE)	; benutzt: A, 0 Stack-P.
	INC	DE
	CP	20H
	JR	C,$+7
	CP	7EH
	JR	NC,$+3
	LD	(HL),A
	INC	HL
	RET
			;

;**********************************************************************
;----------------------------------------------------------------------
;
;      KONVERTIERUNGEN
;
;----------------------------------------------------------------------
UC.DKONV:
	LD	A,(HL)	;DKOI--->ASCII
	CALL	UC.DK1	;(HL)--->(DE)
	LD	(DE),A
	INC	HL
	INC	DE
	DJNZ	UC.DKONV
	RET
;------------------------------------
UC.KONV:
	LD	A,(HL)	;ASCII--->DKOI
	CALL	UC.CKONV	;(HL) --->(DE)
	LD	(DE),A
	INC	HL
	INC	DE
	DJNZ	UC.KONV
	RET
;-----------------------------
UC.DK1:
	PUSH	HL	;DKOI--->ASCII
	PUSH	DE
	PUSH	BC
	LD	HL,UC.ASCCO
	LD	DE,UC.DKOI
	JR	UC.DK2
UC.CKONV:
	PUSH	HL	;ASCII ---> DKOI
	PUSH	DE
	PUSH	BC
	LD	HL,UC.DKOI	;HL:= Anfangsadresse
	LD	DE,UC.ASCCO	;DE:= Anfangsadresse
UC.DK2:
	PUSH	AF	;Quellcodebyte retten
	XOR	A	;CY = 0
	SBC	HL,DE	;Tabellendistanz berechnen
	DEC	HL
	PUSH	HL
	POP	BC	;BC:= Tabellendistanz - 1
	EX	DE,HL	;HL:= Anfangsadresse
	POP	AF	;Zeichen wieder herstellen
	PUSH	BC	;Tabellendistanz retten
	LD	BC,UE.COTAL	;BC:= Tabellenlaenge
	CPIR		;Quellcodebyte suchen
	SCF		;CY = 1
	POP	BC	;Tabellendistanz auskellern
	JR	NZ,UC.KONV2	;---> Quellcodebyte nicht
	ADD	HL,BC	;Zielcodeadresse berechnen
	XOR	A	;CY = 0
	LD	A,(HL)	;Zielcodebyte laden
UC.KONV2:
	POP	BC
	POP	DE
	POP	HL
	RET
;****************************************************************
;         ASCII - Codetabelle
;****************************************************************
UC.ASCCO:
	DB	' !"#$%&'
	DB	27H	;'
	DB	'()*+,-./'
	DB	'0123456789'
	DB	':;<=>?@'
	DB	'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	DB	'[\]^_`'
	DB	'abcdefghijklmnopqrstuvwxyz'
	DB	'{|}~'
	DB	7FH	;DEL
;***************************************************************
;         DKOI - Codetabelle
;***************************************************************
UC.DKOI:
	DB	40H	;blank
	DB	4FH	;!
	DB	7FH	;"
	DB	7BH	;#
	DB	5BH	;$
	DB	6CH	;%
	DB	50H	;&
	DB	7DH	;'
	DB	4DH	;(
	DB	5DH	;)
	DB	5CH	;*
	DB	4EH	;+
	DB	6BH	;,
	DB	60H	;-
	DB	4BH	;.
	DB	61H	;/
	DB	0F0H	;0
	DB	0F1H	;1
	DB	0F2H	;2
	DB	0F3H	;3
	DB	0F4H	;4
	DB	0F5H	;5
	DB	0F6H	;6
	DB	0F7H	;7
	DB	0F8H	;8
	DB	0F9H	;9
	DB	7AH	;:
	DB	5EH	;;
	DB	4CH	;<
	DB	7EH	;=
	DB	6EH	;>
	DB	6FH	;?
	DB	7CH	;@
	DB	0C1H	;A
	DB	0C2H	;B
	DB	0C3H	;C
	DB	0C4H	;D
	DB	0C5H	;E
	DB	0C6H	;F
	DB	0C7H	;G
	DB	0C8H	;H
	DB	0C9H	;I
	DB	0D1H	;J
	DB	0D2H	;K
	DB	0D3H	;L
	DB	0D4H	;M
	DB	0D5H	;N
	DB	0D6H	;O
	DB	0D7H	;P
	DB	0D8H	;Q
	DB	0D9H	;R
	DB	0E2H	;S
	DB	0E3H	;T
	DB	0E4H	;U
	DB	0E5H	;V
	DB	0E6H	;W
	DB	0E7H	;X
	DB	0E8H	;Y
	DB	0E9H	;Z
	DB	4AH	;[
	DB	0E0H	;\
	DB	5AH	;]
	DB	5FH	;^
	DB	6DH	;_
	DB	79H	;`
	DB	81H	;a
	DB	82H	;b
	DB	83H	;c
	DB	84H	;d
	DB	85H	;e
	DB	86H	;f
	DB	87H	;g
	DB	88H	;h
	DB	89H	;i
	DB	91H	;j
	DB	92H	;k
	DB	93H	;l
	DB	94H	;m
	DB	95H	;n
	DB	96H	;o
	DB	97H	;p
	DB	98H	;q
	DB	99H	;r
	DB	0A2H	;s
	DB	0A3H	;t
	DB	0A4H	;u
	DB	0A5H	;v
	DB	0A6H	;w
	DB	0A7H	;x
	DB	0A8H	;y
	DB	0A9H	;z
	DB	0C0H	;{
	DB	6AH	;|
	DB	0D0H	;}
	DB	0A1H	;~
	DB	0FFH	;DEL
;----------------------------------------------------------------------
	END
