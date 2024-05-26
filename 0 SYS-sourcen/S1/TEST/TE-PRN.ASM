'T e s t   C R C    von Programm im RAM'	MACRO-80 3.44	09-Dec-81	PAGE	1


                                	TITLE	'T e s t   C R C    von Programm im RAM'
                                	PAGE	86
'T e s t   C R C    von Programm im RAM'	MACRO-80 3.44	09-Dec-81	PAGE	1-1


                                
                                ;	PN	TE
                                ;**********************************************************************
                                ;*                                                                    *
                                ;*       T e s t   C R C    von Programm im RAM                       *
                                ;*       --------------------------------------                       *
                                ;*   Aufruf:                                                          *
                                ;*                                                                    *
                                ;*             ( PUSH  AF              ; Retten AF )                  *
                                ;*       *Test*  CALL  CRCT            ; Test CRC  (equ TEST1  )      *
                                ;*       *Set**  CALL  CRCS            ; Set  CRC  (equ SET1   )      *
                                ;*               DA    ANFNG           ; Anfang d.gesichert.Bereichs  *
                                ;*               DA    LAENG           ; Laenge ...                   *
                                ;*               DA    CRCKW           ; CRC-Kontroll-Wert ...        *
                                ;*                                     ; Fehler: ===> /Z-Flag         *
                                ;*               ...                   ; ...  Fortsetzung d.Programms *
                                ;*                                                                    *
                                ;**********************************************************************
                                	ORG	07800H	;
  7800'   E3                    TEST1:	EX	(SP),HL
  7801'   C5                    	PUSH	BC
  7802'   D5                    	PUSH	DE
                                			;
  7803'   23                    	INC	HL	; skip CALL SET1
  7804'   23                    	INC	HL
  7805'   23                    	INC	HL
                                			;
  7806'   5E                    	LD	E,(HL)	; DE := Adr.Anfang ...
  7807'   23                    	INC	HL
  7808'   56                    	LD	D,(HL)
  7809'   23                    	INC	HL
                                			;
  780A'   4E                    	LD	C,(HL)	; BC := Laenge ...
  780B'   23                    	INC	HL
  780C'   46                    	LD	B,(HL)
  780D'   23                    	INC	HL
                                			;
  780E'   E5                    	PUSH	HL	; Berechnung CRC
  780F'   EB                    	EX	DE,HL
  7810'   CD 787A'              	CALL	CRC1
  7813'   E1                    	POP	HL
                                			;
  7814'   4E                    	LD	C,(HL)	; Vergleich ...
  7815'   23                    	INC	HL
  7816'   46                    	LD	B,(HL)
  7817'   23                    	INC	HL
  7818'   EB                    	EX	DE,HL
  7819'   B7                    	OR	A
  781A'   ED 42                 	SBC	HL,BC
  781C'   EB                    	EX	DE,HL
                                			;
  781D'   D1                    	POP	DE
  781E'   C1                    	POP	BC
  781F'   E3                    	EX	(SP),HL
  7820'   C9                    	RET
                                			;
                                ;**********************************************************************
                                ;	END	
                                	TITLE	'P R O M - T e s t'
                                	PAGE
'P R O M - T e s t'	MACRO-80 3.44	09-Dec-81	PAGE	1-2


                                
                                ;	PN	TE
                                ;**********************************************************************
                                ;*                                                                    *
                                ;*       P R O M - T e s t   laut Tabelle     RAM-frei,               *
                                ;*       ---------------------------------    Stack nur f.CALL PROMT  *
                                ;*                                                                    *
                                ;*       SP:  Tabellen-Adresse    <--->                               *
                                ;*       DE:  Adr.f.Fehler-Meldg. <--->                               *
                                ;*       del: HL' BC' DE' AF IX IY                                    *
                                ;*                                                                    *
                                ;*       Nutzbare Unterprogramme:                                     *
                                ;*             CRC1               CRC Bereich                         *
                                ;*             CRCA1              CRC = CRC # (A)                     *
                                ;*                                                                    *
                                ;**********************************************************************
                                			;
  7821'   D9                    	EXX		; Return
  7822'   C9                    	RET
                                			;
  7823'   D9                    PROMT:	EXX		; Test:   laden PROM-Adresse
  7824'   01 0400               	LD	BC,0400H	;         Laenge Test-Bereich
  7827'   3B                    	DEC	SP
  7828'   E1                    	POP	HL
  7829'   69                    	LD	L,C	;         0
  782A'   7C                    	LD	A,H	;         H(PROM-Adr.)
  782B'   FE FF                 	CP	0FFH	;         Ende PROM-Tabelle ?
  782D'   28 F2                 	JR	Z,PROMT-2
  782F'   08                    	EX	AF,AF'		;         Retten PROM-Adr.
  7830'   DD 21 7836'           	LD	IX,$+6
  7834'   18 0D                 	JR	CRC	;         Berechnung CRC
                                			;
  7836'   E1                    	POP	HL	;         HL:= CRC lt. Tabelle
  7837'   ED 52                 	SBC	HL,DE
  7839'   28 E9                 	JR	Z,PROMT+1	;         ---> naechster PROM
                                			;
  783B'   D9                    PROMF:	EXX		; Anzeige Fehler
  783C'   08                    	EX	AF,AF'
  783D'   21 7823'              	LD	HL,PROMT
  7840'   C3 79DD'              	JP	CVABX-2	;         2 Space / 2 Hexa
                                			;
                                ;        --------------------------------------------------------------
                                			; CRC   Bereich:
  7843'   11 FFFF               CRC:	LD	DE,-1	; --------------
  7846'   7E                    	LD	A,(HL)	; HL': Start-Adresse        --->
  7847'   FD 21 784D'           	LD	IY,$+6	; BC': Bereichs-Laenge      --->
  784B'   18 08                 	JR	CRCA	; DE': CRC                 <--- 
  784D'   23                    	INC	HL	; IX : Return-Adr.         <--->
  784E'   0B                    	DEC	BC	; del: IY AF
  784F'   78                    	LD	A,B
  7850'   B1                    	OR	C
  7851'   20 F3                 	JR	NZ,CRC+3
  7853'   DD E9                 	JP	(IX)
                                			;
                                ;        --------------------------------------------------------------
                                	PAGE	
'P R O M - T e s t'	MACRO-80 3.44	09-Dec-81	PAGE	1-3


                                
                                ;        --------------------------------------------------------------
                                			;
  7855'   AA                    CRCA:	XOR	D	; CRC := CRC # (A):
  7856'   57                    	LD	D,A	; -----------------
                                			; DE': CRC                 <--->
  7857'   0F                    	RRCA		; A:   Byte                 --->
  7858'   0F                    	RRCA		; IY:  Return-Adr.         <--->
  7859'   0F                    	RRCA		; del: AF
  785A'   0F                    	RRCA
  785B'   E6 0F                 	AND	0FH
  785D'   AA                    	XOR	D
  785E'   57                    	LD	D,A
                                			;
  785F'   0F                    	RRCA
  7860'   0F                    	RRCA
  7861'   0F                    	RRCA
  7862'   E6 1F                 	AND	1FH
  7864'   AB                    	XOR	E
  7865'   5F                    	LD	E,A
                                			;
  7866'   7A                    	LD	A,D
  7867'   0F                    	RRCA
  7868'   0F                    	RRCA
  7869'   0F                    	RRCA
  786A'   0F                    	RRCA
  786B'   E6 F0                 	AND	0F0H
  786D'   AB                    	XOR	E
  786E'   5F                    	LD	E,A
                                			;
  786F'   7A                    	LD	A,D
  7870'   0F                    	RRCA
  7871'   0F                    	RRCA
  7872'   0F                    	RRCA
  7873'   E6 E0                 	AND	0E0H
  7875'   AA                    	XOR	D
                                			;
  7876'   53                    	LD	D,E
  7877'   5F                    	LD	E,A
                                			;
  7878'   FD E9                 	JP	(IY)
                                			;
                                ;        --------------------------------------------------------------
  787A'   DD E5                 CRC1:	PUSH	IX	; CRC Bereich  (CALL/RET-faehig)
  787C'   FD E5                 	PUSH	IY	; ------------------------------
  787E'   DD 21 7884'           	LD	IX,$+6	; HL:  Adr. Bereich         --->
  7882'   18 BF                 	JR	CRC	; BC:  Laenge Bereich       --->
  7884'   FD E1                 	POP	IY	; DE:  CRC                 <---
  7886'   DD E1                 	POP	IX	; del: AF
  7888'   C9                    	RET		; Stack: 1
                                			;
                                ;        --------------------------------------------------------------
  7889'   FD E5                 CRCA1:	PUSH	IY	; CRC := CRC # (A)
  788B'   FD 21 0006            	LD	IY,+6	;              (CALL/RET-faehig)
  788F'   18 C4                 	JR	CRCA	; ------------------------------
  7891'   FD E1                 	POP	IY	; DE:  CRC                 <--->
  7893'   C9                    	RET		; A:   Byte                 --->
                                			; del: AF
                                			;
                                ;**********************************************************************
                                ;	END	
                                	TITLE	'R A M - T e s t'
                                	PAGE
'R A M - T e s t'	MACRO-80 3.44	09-Dec-81	PAGE	1-4


                                
                                ;	PN	TE
                                ;**********************************************************************
                                ;*                                                                    *
                                ;*       R A M - T e s t                    RAM-frei,                 *
                                ;*       ---------------                    Stack nur fuer CALL RAMT  *
                                ;**********************************************************************
                                ;*                                                                    *
                                ;*       Folgende Tests werden ausgefuehrt:                           *
                                ;*       ----------------------------------                           *
                                ;*                                                                    *
                                ;*       Fuer jeden Bereich ...                                       *
                                ;*                                                                    *
                                ;*       - fuer jede der 9 zyklischen Bit-Positionen                  *
                                ;*         von rechts nach links ueber den Bereich                    *
                                ;*         mit dem Start-Byte 1000.0000 und Cy=0 bzw.                 *
                                ;*                            0111.1111 und Cy=1                      *
                                ;*         zyklisch links rotierend ueber Cy schreiben bzw.testen     *
                                ;*                                         (Test "a" bzw."b")         *
                                ;*                                                                    *
                                ;*       - fuer jede der zyklischen Byte-Positionen                   *
                                ;*         von links nach rechts zyklisch ueber den Bereich           *
                                ;*         16-mal 55H bzw.AAH und 1-mal das Komplement schreiben,     *
                                ;*         17-mal den RAM-Inhalt unter passendem Auffuellen links     *
                                ;*         nach rechts schieben und anschliessend testen, ob das      *
                                ;*         anfangs geschriebene wieder dasteht                        *
                                ;*                                         (Test "c" bzw."d")         *
                                ;*                                                                    *
                                ;*       - von rechts nach links ueber den Bereich                    *
                                ;*         das Byte 0100.0111 und Cy=0                                *
                                ;*         zyklisch links rotierend ueber Cy schreiben,               *
                                ;*         warten (11-mal ein Doppel-Register durchzaehlen) und       *
                                ;*         anschliessend testen, ob das geschriebene noch dasteht     *
                                ;*                                         ("REFRESH"-Test "r")       *
                                ;*                                                                    *
                                ;*       Dabei wird jeder RAM-Bereich nur soweit getestet, bis der    *
                                ;*       erste Fehler festgestellt wird und dann mit nachgestelltem   *
                                ;*       Test-Kennzeichen in der Fehler-Liste angezeigt.              *
                                ;*                                                                    *
                                ;*       Fuer jede RAM-Bereichs-Liste ...                             *
                                ;*                                                                    *
                                ;*         einmal von links und einmal von rechts die Liste hindurch  *
                                ;*         jeden RAM-Bereich in seinem ersten Byte mit dem hoeher-    *
                                ;*         wertigen Byte-Wert seiner Adresse kennzeichnen und an-     *
                                ;*         schliessend testen, ob jeder Bereich noch seine Kenn-      *
                                ;*         zeichnung hat                                              *
                                ;*                              (Test "s" auf STE-Adressierung)       *
                                ;*                                                                    *
                                ;*       Dabei ist zu beachten, dass STE mit fehlerhaftem STE-Adress- *
                                ;*       Dekoder im allgemeinen auch die Antwort anderer STE          *
                                ;*       verfaelschen. In jedem Falle ist aber unter den mit "s"      *
                                ;*       als fehlerhaft angegebenen STE eine fehlerhafte              *
                                ;*                                                                    *
                                ;*--------------------------------------------------------------------*
                                ;*                                                                    *
                                ;*       SP:  RAM-Tab.            <--->                               *
                                ;*       del: alle sonst.Reg.ausser DE (akt.BS-Adr.f.Fehler-Anzeige)  *
                                ;*                                                                    *
                                ;*       Nutzbare Unterprogramme:                                     *
                                ;*             ROTCY       "Rotation A ueber Cy" (-> "Spitzen-Test")  *
                                ;*             SHIFT       "Schiebe-o.WC-Test"                        *
                                ;*             RAMT+4      beide Tests, Fehler-Auswert.programmierbar *
                                ;*                                                                    *
                                ;**********************************************************************
                                ;	END	
                                	TITLE	''
                                	PAGE
''	MACRO-80 3.44	09-Dec-81	PAGE	1-5


                                
                                ;	PN	TE
                                ;**********************************************************************
                                			;
  7894'   FD 21 78DA'           RAMT:	LD	IY,RAMRR	; Adr.d.Fehler-Anzeige-Routine
  7898'   F1                    	POP	AF	; skip Start-FF
                                			;
                                			; ----------------------------
  7899'                         NXTR	EQU	$	; naechster Bereich
  7899'   21 6100               	LD	HL,6100H	;       Anzeige H='a'/Refr.T.=0
                                			;
  789C'   D9                    	EXX
  789D'   F1                    	POP	AF
  789E'   F5                    	PUSH	AF
  789F'   B7                    	OR	A
  78A0'   CA 7993'              	JP	Z,ADRT	; ====> Test auf STE-Adresierung
                                			;
                                			; ------------------------------
  78A3'   AF                    PEAK:	XOR	A	; zykl.v.hinten ueber d.Bereich
  78A4'   37                    	SCF		;     +        +    ...
  78A5'   DD 21 78AB'           	LD	IX,$+6	; ++++ ++++++++ ++++...
  78A9'   18 3E                 	JR	ROTCY	;      schreiben und dann testen
                                			; ------------------------------
  78AB'   D9                    VALLY:	EXX
                                			;
  78AC'   24                    	INC	H	; Anzeige = 'b'
                                			;
  78AD'   D9                    	EXX
  78AE'   AF                    	XOR	A	; zykl.v.hinten ueber d.Bereich
  78AF'   3D                    	DEC	A	; ++ ++++++++ ++++++...
  78B0'   DD                    	DB	0DDH	;   +        +      ...
  78B1'   2E B5'                	LD	L,LOW($+4)	;      schreiben und dann testen
  78B3'   18 34                 	JR	ROTCY	; ------------------------------
                                			;         Anzeige = 'c'
                                			;
  78B5'                         SHFT1	EQU	$	; AA.55.55...55.AA.55.55...55.AA
                                			;       16 mal       ...
  78B5'   11 55AA               	LD	DE,055AAH	;    +--------+    +--------+
  78B8'   DD                    	DB	0DDH	;            zyklisch schreiben,
  78B9'   2E BD'                	LD	L,LOW($+4)	;  17 mal zykl.ueber RAM-Bereich
  78BB'   18 06                 	JR	SHFT2+6	;       rotieren und dann testen
                                			; ------------------------------
  78BD'                         SHFT2	EQU	$	;         Anzeige = 'd'
  78BD'   11 AA55               	LD	DE,0AA55H	;
  78C0'   DD                    	DB	0DDH	; analog mit ...
  78C1'   2E C5'                	LD	L,LOW($+4)	; 55.AA.AA...AA.55.AA.AA...AA.55
  78C3'   18 76                 	JR	SHIFT	;
                                			; ------------------------------
  78C5'   D9                    RFRSH:	EXX		;         Anzeige = 'r' /...
                                			;            Warten 11 Zyklen/..
  78C6'   21 720B               	LD	HL,720BH	;            Test nicht zyklisch
                                			;
  78C9'   D9                    	EXX
  78CA'   3E 8E                 	LD	A,8EH	; Rotieren ueb.Cy 8E, Warten u.
  78CC'   B7                    	OR	A	;                         Testen
  78CD'   DD                    	DB	0DDH
  78CE'   2E D2'                	LD	L,LOW($+4)
  78D0'   18 17                 	JR	ROTCY
  78D2'   D9                    	EXX
                                			;
                                	PAGE	
''	MACRO-80 3.44	09-Dec-81	PAGE	1-6


                                
                                			;
  78D3'   E1                    ADSET:	POP	HL	; Bereich mit H(Adr) markieren
  78D4'   65                    	LD	H,L
  78D5'   2E 00                 	LD	L,0
  78D7'   74                    	LD	(HL),H
  78D8'   18 BF                 	JR	NXTR
                                			;
  78DA'   D9                    RAMRR:	EXX		; RAMeRRor: dd', Byte-Adr.in HL
                                			;                Bit-Pos. in A
  78DB'   C1                    	POP	BC
  78DC'   C5                    	PUSH	BC
  78DD'   79                    	LD	A,C
  78DE'   4C                    	LD	C,H
  78DF'   21 78E5'              	LD	HL,$+6	; (primitiv-Anzeige nur f.TEST):
  78E2'   C3 79DD'              	JP	CVABX-2	;         Adresse (hexa)
  78E5'   79                    	LD	A,C	;         Test-Code
  78E6'   12                    	LD	(DE),A
  78E7'   18 EA                 	JR	ADSET
                                			;
                                ;        --------------------------------------------------------------
                                	PAGE
''	MACRO-80 3.44	09-Dec-81	PAGE	1-7


                                
                                ;        --------------------------------------------------------------
                                			; Start mit dd'
                                			; L:      Warte-Zeit in dd-Zykl.
                                			;         ungerade: nach 1.Rot.-
                                			;                   Zykl.-> Ende
                                			; A, Cy:  9 Test-Bits
                                			; del:    BC AF
                                			;         BC' HL' DE' AF'
                                			; ------------------------------
  78E9'   06 09                 ROTCY:	LD	B,9	; fuer jed.Bit u.Cy je 1 Zyklus
  78EB'   D9                    	EXX		; <====   Start-/aktueller Wert
                                			;
  78EC'   4F                    	LD	C,A	; ------------------------------
  78ED'   17                    	RLA		; Byte:   A     /    B
  78EE'   47                    	LD	B,A	; Cy:     Cy    /    C-Bit 7
                                			;
  78EF'   D9                    	EXX		; laden: Adr.(HL'), Laenge(DE')
  78F0'   08                    	EX	AF,AF'
  78F1'   D1                    	POP	DE
  78F2'   D5                    	PUSH	DE
  78F3'   63                    	LD	H,E
  78F4'   2E 00                 	LD	L,0
  78F6'   5D                    	LD	E,L
  78F7'   19                    	ADD	HL,DE
  78F8'   08                    	EX	AF,AF'		;<--+ schreib u.l.rotier.Byte/Cy
                                			;   ! rueckw. ueb.d.RAM-Bereich
  78F9'   2B                    	DEC	HL	;   !
  78FA'   77                    	LD	(HL),A	;   !
  78FB'   17                    	RLA		;   !
                                			;   !
  78FC'   1B                    	DEC	DE	;   !
  78FD'   08                    	EX	AF,AF'		;   !
  78FE'   7A                    	LD	A,D	;   !
  78FF'   B3                    	OR	E	;   !
  7900'   20 F6                 	JR	NZ,$-8	; $-$-+
  7902'   D9                    	EXX
                                			;
  7903'   7D                    	LD	A,L	; Warten ??
                                			;
  7904'   D9                    	EXX
  7905'   B7                    	OR	A
  7906'   28 09                 	JR	Z,$+11	; ---+
  7908'   6F                    	LD	L,A			;    !
  7909'   13                    	INC	DE			; <+ !
  790A'   7A                    	LD	A,D			;  ! !
  790B'   B3                    	OR	E				;  ! !
  790C'   20 FB                 	JR	NZ,$-3	; -+ !
  790E'   2D                    	DEC	L				;  ! !
  790F'   20 F8                 	JR	NZ,$-6	; -+ !
  7911'   D9                    	EXX					; <--+
                                							;
                                	PAGE	
''	MACRO-80 3.44	09-Dec-81	PAGE	1-8


                                
                                							;
  7912'   79                    	LD	A,C			; laden: A, Cy
  7913'   17                    	RLA
  7914'   78                    	LD	A,B
                                							;
  7915'   D9                    	EXX					; laden: Adr./ Laenge
  7916'   08                    	EX	AF,AF'
  7917'   D1                    	POP	DE
  7918'   D5                    	PUSH	DE
  7919'   63                    	LD	H,E
  791A'   2E 00                 	LD	L,0
  791C'   5D                    	LD	E,L
  791D'   19                    	ADD	HL,DE
  791E'   08                    	EX	AF,AF'		; <---+ testen ueb.d.RAM-Bereich
                                								;     !
  791F'   2B                    	DEC	HL				;     !
  7920'   4F                    	LD	C,A				;     !
  7921'   17                    	RLA						;     !
                                								;     !
  7922'   08                    	EX	AF,AF'		;     !
  7923'   79                    	LD	A,C				;     !
  7924'   AE                    	XOR	(HL)			;     !
  7925'   20 12                 	JR	NZ,ROTCF	; ========> Auswertung Fehler
                                								;     !
  7927'   1B                    ROTCR:	DEC	DE	; <===!==== Restart nach Fehler
  7928'   7A                    	LD	A,D				;     !
  7929'   B3                    	OR	E					;     !
  792A'   20 F2                 	JR	NZ,$-12		; ----+
  792C'   D9                    	EXX
                                								;
  792D'   79                    	LD	A,C				; laden: A, Cy
  792E'   17                    	RLA
  792F'   78                    	LD	A,B
  7930'   CB 45                 	BIT	0,L				;         Rot.-Zyklus ??
                                								;
  7932'   D9                    	EXX						; Zyklus / Normal End
  7933'   20 02                 	JR	NZ,$+4
  7935'   10 B4                 	DJNZ	ROTCY+2	;     ---> dd'
  7937'   DD E9                 	JP	(IX)
                                								; Abnormal End: Fehler-Auswertg.
  7939'   FD E9                 ROTCF:	JP	(IY)	;     ---> dd'
                                								;          Fehler-Ort: HL= Adr.
                                								;                      A = Bit
                                ;        --------------------------------------------------------------
                                	PAGE	
''	MACRO-80 3.44	09-Dec-81	PAGE	1-9


                                
                                ;        --------------------------------------------------------------
                                			; Start mit dd'
                                			; DE':    definieren d.Testfolge
                                			; del:    BC AF
                                			;         BC' HL' AF'
  793B'   D9                    SHIFT:	EXX			; ------------------------------
                                								;
  793C'   24                    	INC	H					;         Anzeige-Code
  793D'   0E 11                 	LD	C,17			;         Zyklen-Laenge
  793F'   41                    	LD	B,C
                                								;
  7940'   D9                    	EXX
  7941'   C1                    	POP	BC				; laden: Adr.(HL'), Laenge(BC')
  7942'   C5                    	PUSH	BC
  7943'   61                    	LD	H,C
  7944'   2E 00                 	LD	L,0
  7946'   4D                    	LD	C,L
                                			;
  7947'   7B                    	LD	A,E				; <---+   zykl.schreiben:
  7948'   08                    	EX	AF,AF'		;     !         1*(E')  (B)*(D')
  7949'   7A                    	LD	A,D				;     !
  794A'   D9                    	EXX						;     !
  794B'   10 02                 	DJNZ	$+4			;     !
  794D'   08                    	EX	AF,AF'		;     !
  794E'   41                    	LD	B,C				;     !
                                								;     !
  794F'   D9                    	EXX						;     !
  7950'   77                    	LD	(HL),A		;     !
  7951'   23                    	INC	HL				;     !
  7952'   0B                    	DEC	BC				;     !
  7953'   78                    	LD	A,B				;     !
  7954'   B1                    	OR	C					;     !
  7955'   20 F0                 	JR	NZ,$-14		; ----+
  7957'   D9                    	EXX
                                								;
  7958'   41                    	LD	B,C				; (B) * ...
                                								;
  7959'   D9                    	EXX						; <---------+
  795A'   C1                    	POP	BC				;       ... laden: Adr. / Laenge
  795B'   C5                    	PUSH	BC			;           !
  795C'   61                    	LD	H,C				;           !
  795D'   2E 00                 	LD	L,0
  795F'   4D                    	LD	C,L
  7960'   D9                    	EXX
                                								;
  7961'   78                    	LD	A,B				;       ... um 1 Byte nach
  7962'   B9                    	CP	C					;             rechts schieben u.
                                								;             passend auffuellen
  7963'   D9                    	EXX
  7964'   7B                    	LD	A,E
  7965'   28 01                 	JR	Z,$+3
  7967'   7A                    	LD	A,D
  7968'   08                    	EX	AF,AF'
                                			;
  7969'   7E                    	LD	A,(HL)		; <--+
  796A'   08                    	EX	AF,AF'		;    !
  796B'   77                    	LD	(HL),A		;    !
  796C'   23                    	INC	HL				;    !
  796D'   0B                    	DEC	BC				;    !
  796E'   78                    	LD	A,B				;    !
  796F'   B1                    	OR	C					;    !
  7970'   20 F7                 	JR	NZ,$-7		; ---+
  7972'   D9                    	EXX
                                								;           !
  7973'   10 E4                 	DJNZ	$-26		; ----------+
  7975'   41                    	LD	B,C
                                								;
                                								;
  7976'   D9                    	EXX						; laden: Adr. / Laenge
  7977'   C1                    	POP	BC
  7978'   C5                    	PUSH	BC
  7979'   61                    	LD	H,C
  797A'   2E 00                 	LD	L,0
  797C'   4D                    	LD	C,L
                                			;
  797D'   7B                    	LD	A,E				; <---+ zykl.testen: ...
  797E'   08                    	EX	AF,AF'		;     !
  797F'   7A                    	LD	A,D				;     !
  7980'   D9                    	EXX						;     !
  7981'   10 02                 	DJNZ	$+4			;     !
''	MACRO-80 3.44	09-Dec-81	PAGE	1-10


  7983'   08                    	EX	AF,AF'		;     !
  7984'   41                    	LD	B,C				;     !
                                								;     !
  7985'   D9                    	EXX						;     !
  7986'   AE                    	XOR	(HL)			;     !
  7987'   20 08                 	JR	NZ,SHFTF	; ========> Auswertung   Fehler
  7989'   23                    SHFTR:	INC	HL	; <===!==== Restart nach Fehler
  798A'   0B                    	DEC	BC				;     !
  798B'   78                    	LD	A,B				;     !
  798C'   B1                    	OR	C					;     !
  798D'   20 EE                 	JR	NZ,$-16		; ----+
                                								;
  798F'   DD E9                 	JP	(IX)			; Normal End: --->  dd'
                                								;
  7991'   FD E9                 SHFTF:	JP	(IY)	; Abnormal End: Fehler-Auswertg.
                                								; --->   dd'
                                								;        Fehler-Ort: HL= Adr.
                                								;                    A = Bit
                                								;
                                ;        --------------------------------------------------------------
                                	PAGE
''	MACRO-80 3.44	09-Dec-81	PAGE	1-11


                                
                                ;        --------------------------------------------------------------
                                			; Start mit dd'
                                			;
  7993'   67                    ADRT:	LD	H,A	; laden HL mit SP
  7994'   6F                    	LD	L,A
  7995'   39                    	ADD	HL,SP
  7996'   5F                    	LD	E,A	; E := 0
  7997'   37                    	SCF		; Setzen: 1.Durchlauf
  7998'   08                    	EX	AF,AF'		; <============
                                								;
                                								; ruecksetzen "SP" (/schreiben 
  7999'   2B                    	DEC	HL				; <-----------+         Kennung)
  799A'   7E                    	LD	A,(HL)		;             !
  799B'   B7                    	OR	A					;             !
  799C'   28 0A                 	JR	Z,$+12		; -----+      !
  799E'   2B                    	DEC	HL				;      !      !
  799F'   08                    	EX	AF,AF'		;      !      !
  79A0'   38 03                 	JR	C,$+5			; ---+ !      !
  79A2'   56                    	LD	D,(HL)		;    ! !      !
  79A3'   7A                    	LD	A,D				;    ! !      !
  79A4'   12                    	LD	(DE),A		;    ! !      !
  79A5'   08                    	EX	AF,AF'		; <--+ !      !
  79A6'   18 F1                 	JR	$-13			; -----!------+
                                								;      !
  79A8'   23                    	INC	HL				; <----+ Testen Kennung
  79A9'   56                    	LD	D,(HL)		;      !
  79AA'   23                    	INC	HL				;      !
  79AB'   7E                    	LD	A,(HL)		;      !
  79AC'   B7                    	OR	A					;      !
  79AD'   28 12                 	JR	Z,$+20		; -----!--+
  79AF'   7A                    	LD	A,D				;      !  !
  79B0'   EB                    	EX	DE,HL			;      !  !
  79B1'   BE                    	CP	(HL)			;      !  !
  79B2'   EB                    	EX	DE,HL			;      !  !
  79B3'   28 F3                 	JR	Z,$-11		; -----+  !
                                								;      !  !
  79B5'   D9                    	EXX						;      !  ! Fehler-Anzeige
  79B6'   21 79BB'              	LD	HL,$+5		;      !  !
  79B9'   18 22                 	JR	CVABX-2		;      !  !
  79BB'   3E 73                 	LD	A,'s'			;      !  !
  79BD'   12                    	LD	(DE),A		;      !  !
  79BE'   D9                    	EXX						;      !  !
  79BF'   18 E7                 	JR	$-23			; -----+  !
                                								;         !
  79C1'   08                    	EX	AF,AF'		; <-------+ 2.Durchlauf ?
  79C2'   2B                    	DEC	HL
  79C3'   30 03                 	JR	NC,$+5		; ---+
  79C5'   3F                    	CCF						;    !
  79C6'   18 D0                 	JR	ADRT+5		;  ==!====>
  79C8'   D9                    	EXX						; <--+
  79C9'   F1                    	POP	AF
  79CA'   C9                    	RET
                                			;
                                ;**********************************************************************
                                ;	END
                                	TITLE	''
                                	PAGE
''	MACRO-80 3.44	09-Dec-81	PAGE	1-12


                                
                                ;	PN	TE
                                ;**********************************************************************
                                			;
  79CB'   7C                    CVHLX:	LD	A,H	; Binaerzahl in HL 
  79CC'   CD 79D4'              	CALL	CVABX-11	;             als 4 Hexa ab (DE)
  79CF'   7D                    	LD	A,L	; ------------------------------
  79D0'   CD 79D4'              	CALL	CVABX-11	; del: AF
  79D3'   C9                    	RET
                                			;
                                ;        --------------------------------------------------------------
                                			; CVABX (CALL-faehig)
                                			; ------------------------------
  79D4'   E5                    	PUSH	HL	;                 EQU  CVABX-11 
  79D5'   21 79DA'              	LD	HL,$+5	; del: AF, AF'
  79D8'   18 05                 	JR	CVABX
  79DA'   E1                    	POP	HL
  79DB'   C9                    	RET
                                			;
                                ;        --------------------------------------------------------------
  79DC'   13                    	INC	DE	; 1 ... 3 Leerschritte
  79DD'   13                    	INC	DE	;              vor dem Schreiben
  79DE'   13                    	INC	DE
                                			;
  79DF'   EB                    CVABX:	EX	DE,HL	; Binaerzahl in A 
  79E0'   77                    	LD	(HL),A	;             als 2 Hexa ab (DE)
  79E1'   3E 33                 	LD	A,33H	; ------------------------------
  79E3'   ED 67                 	RRD		;         HL:  Return-Adresse
                                			; --->    DE:  Adr.nach 2.Hexa
  79E5'   23                    	INC	HL	;         del: AF
  79E6'   FE 3A                 	CP	3AH
  79E8'   38 02                 	JR	C,$+4
  79EA'   C6 07                 	ADD	A,07H
  79EC'   77                    	LD	(HL),A
  79ED'   2B                    	DEC	HL
                                			;
  79EE'   7E                    	LD	A,(HL)
  79EF'   FE 3A                 	CP	3AH
  79F1'   38 03                 	JR	C,$+5
  79F3'   C6 07                 	ADD	A,07H
  79F5'   77                    	LD	(HL),A
                                			;
  79F6'   23                    	INC	HL
  79F7'   23                    	INC	HL
  79F8'   EB                    	EX	DE,HL
  79F9'   E9                    	JP	(HL)
                                			;
                                ;**********************************************************************
                                	PAGE	
''	MACRO-80 3.44	09-Dec-81	PAGE	1-13


                                
                                ;**********************************************************************
                                			;
  79FA'   E3                    	EX	(SP),HL	; Anzeige Text ab Adr.nach CALL
  79FB'   18 02                 	JR	DISPL	; ...        (CALL-/RET-faehig)
  79FD'   E3                    	EX	(SP),HL	; -----------------------------
  79FE'   C9                    	RET	
                                			;
  79FF'   7E                    DISPL:	LD	A,(HL)	; bis Bit 7 = 1       nach (DE)
  7A00'   CB BF                 	RES	7,A	; ------------------------------
                                			; Steuerzeichen:
  7A02'   FE 1E                 	CP	1EH	;    1E:    New-Line
  7A04'   28 09                 	JR	Z,NL	; ------------------------------
                                			; DE:    aktuelle BS-Pos.  <--->
                                			; del:   AF, nur bei RPT B 
  7A06'   12                    	LD	(DE),A
  7A07'   13                    	INC	DE
  7A08'   CB 7E                 DSPLE:	BIT	7,(HL)	; <------
  7A0A'   23                    	INC	HL
  7A0B'   28 F2                 	JR	Z,DISPL
  7A0D'   E9                    	JP	(HL)	; =======>
                                			;
  7A0E'   13                    	INC	DE
  7A0F'   7B                    NL:	LD	A,E	; neue Zeile
  7A10'   E6 0F                 	AND	0FH
  7A12'   20 FA                 	JR	NZ,NL-1
                                			;
  7A14'   7A                    	LD	A,D
  7A15'   E6 0F                 	AND	0FH
  7A17'   83                    	ADD	A,E
  7A18'   0F                    	RRCA
  7A19'   0F                    	RRCA
  7A1A'   0F                    	RRCA
  7A1B'   0F                    	RRCA
  7A1C'   D6 05                 	SUB	5
  7A1E'   28 E8                 	JR	Z,DSPLE
  7A20'   30 FA                 	JR	NC,$-4
  7A22'   18 EA                 	JR	NL-1
                                			;
                                ;**********************************************************************
                                	PAGE	
''	MACRO-80 3.44	09-Dec-81	PAGE	1-14


                                
                                ;**********************************************************************
  7A24'   FB                    	EI		; PIO-Programmierung
  7A25'   ED 4D                 	RETI		; ------------------
                                			;
  7A27'   3E CF                 TASTP:	LD	A,0CFH	; Port A: Bit-Modus
  7A29'   D3 86                 	OUT	(TAPIO+2),A
  7A2B'   3E 01                 	LD	A,1	;         Bit 0 Eingabe
  7A2D'   D3 86                 	OUT	(TAPIO+2),A
  7A2F'   3E 03                 	LD	A,03H	;         kein Interrupt
  7A31'   D3 86                 	OUT	(TAPIO+2),A
  7A33'   D3 87                 	OUT	(TAPIO+3),A	; Port B: ...
  7A35'   3E CF                 	LD	A,0CFH	;         Bit-Modus
  7A37'   D3 87                 	OUT	(TAPIO+3),A
  7A39'   3E FF                 	LD	A,0FFH	;         alle Bits Eingabe
  7A3B'   D3 87                 	OUT	(TAPIO+3),A
  7A3D'   C9                    	RET
                                			; ------------------------------
                                			; --->    del:  A
                                ;        --------------------------------------------------------------
                                			; Tastatur-Abfrage: Code in A
                                			; ----------------- =========
  7A3E'   DB 85                 TASTE:	IN	A,(TAPIO+1)	;         lesen Tasten-Code,(C)
  7A40'   08                    	EX	AF,AF'
  7A41'   3E FE                 	LD	A,0FEH	;         ruecksetzen Tastatur
  7A43'   D3 84                 	OUT	(TAPIO),A
  7A45'   3E FC                 	LD	A,0FCH	;         aktivieren Tastatur
  7A47'   D3 84                 	OUT	(TAPIO),A
  7A49'   08                    	EX	AF,AF'
  7A4A'   B7                    	OR	A
  7A4B'   28 F1                 	JR	Z,TASTE
  7A4D'   C9                    	RET
                                			;
                                ;**********************************************************************
                                ;	END	
                                	TITLE	'EPROM-, RAM- und Tastatur-Test  DEG 2000  / TAP2'
                                	PAGE
'EPROM-, RAM- und Tastatur-Test  DEG 2000  / TAP2'	MACRO-80 3.44	09-Dec-81	PAGE	1-15


                                
                                ;	PN	TE
                                ;**********************************************************************
  7800'                         ANFNG	EQU	TEST1	; Adresse EPROM fuer "TEST"
                                			;
  003A                          SYS1	EQU	003AH	; System ohne BS-Loeschen
  3000                          BSANF	EQU	3000H	; Adresse Bildschirm-RAM
  0800                          BSLNG	EQU	800H	; Laenge Bildschirm-RAM
                                			;
  3000                          VON	EQU	3000H	; Parameter f.BS-/RAM-Verschiebg
  8000                          NACH	EQU	8000H	;           fuer best.RAM-Tests
  5000                          UM	EQU	NACH-VON
                                			;
  0084                          TAPIO	EQU	84H	; Adresse Tastatur-PIO
                                			;
                                ;**********************************************************************
                                ;*                                                                    *
                                ;*       EPROM-, RAM- und Tastatur-Test  DEG 2000  / TAP2:            *
                                ;*       -------------------------------------------------            *
                                ;*       (die korrekte Funktion der Speicherblocksteuerung            *
                                ;*                                               wird vorausgesetzt)  *
                                ;*                                                                    *
                                ;*       Aufruf: TEST                                                 *
                                ;*                                                                    *
                                ;*       Aufgabe:                                                     *
                                ;*                                                                    *
                                ;*             - Kontrolle der Pruefsummen je STE                     *
                                ;*                                ----> Anzeige der fehlerhaften STE  *
                                ;*                                                                    *
                                ;*             - RAM-Test:      1- und 0-Spike-Test     --> "a", "b"  *
                                ;*                              ("WC")-Shift-Test       --> "c", "d"  *
                                ;*                              Test auf Refresh            --> "r"   *
                                ;*                              Test auf STE-Adressierung   --> "s"   *
                                ;*                                ----> Anzeige der fehlerhaften STE  *
                                ;*                                                                    *
                                ;*             - Tastaturtest                                         *
                                ;*                                ----> Anzeige Tasten-Code ISO-7 und *
                                ;*                                                        hexadezimal *
                                ;*                                                                    *
                                ;*                                                                    *
                                ;*       Zur Sicherung in den RAM geladener Programmteile:            *
                                ;*       -------------------------------------------------            *
                                ;*             - Kontrolle der Pruefsumme eines Programms             *
                                ;*                                                                    *
                                ;*             - Berechnung der Pruefsumme eines Programms            *
                                ;*                                                                    *
                                ;**********************************************************************
                                	PAGE	
'EPROM-, RAM- und Tastatur-Test  DEG 2000  / TAP2'	MACRO-80 3.44	09-Dec-81	PAGE	1-16


                                
                                ;**********************************************************************
                                			;
  7A4E'   7A4E'                 	DW	$
  7A50'   54 41 53 54           	DB	'TAST'
                                			;
  7A54'   31 7BF6'              	LD	SP,TAST+4
                                			;
  7A57'   11 32E4               TTEST:	LD	DE,BSANF+740	; Tastatur-Test und -Abfrage
  7A5A'   21 7A5F'              	LD	HL,$+5	; --------------------------
  7A5D'   18 A0                 	JR	DISPL
  7A5F'   54 61 73 74           	DB	'Taste:   '
  7A63'   65 3A 20 20           
  7A67'   20                    
  7A68'   BF                    	DB	3FH OR 80H
  7A69'   EB                    	EX	DE,HL
  7A6A'   11 0050               	LD	DE,80
  7A6D'   36 14                 	LD	(HL),14H
  7A6F'   2B                    	DEC	HL
  7A70'   ED 52                 	SBC	HL,DE
  7A72'   36 13                 	LD	(HL),13H
  7A74'   19                    	ADD	HL,DE
  7A75'   19                    	ADD	HL,DE
  7A76'   36 12                 	LD	(HL),12H
  7A78'   ED 52                 	SBC	HL,DE
  7A7A'   EB                    	EX	DE,HL
  7A7B'   4B                    	LD	C,E
                                			;
  7A7C'   18 C2                 	JR	TASTE+2	; Tastatur ruecksetzen
                                			;
  7A7E'   18 BE                 TZYK:	JR	TASTE	; Tasten-Code lesen
  7A80'   3B                    	DEC	SP
  7A81'   3B                    	DEC	SP
  7A82'   59                    	LD	E,C
  7A83'   12                    	LD	(DE),A	; anzeigen:  ISO-7-Bit-Code
  7A84'   21 7A7E'              	LD	HL,TZYK	;            2 Hexa
  7A87'   C3 79DC'              	JP	CVABX-3
                                			;
                                ;**********************************************************************
                                	PAGE	
'EPROM-, RAM- und Tastatur-Test  DEG 2000  / TAP2'	MACRO-80 3.44	09-Dec-81	PAGE	1-17


                                
                                ;**********************************************************************
                                			;
  7A8A'   7A8A'                 TEST:	DW	$
  7A8C'   54 45 53 54           	DB	'TEST'
                                			;
  7A90'   31 7B1E'              	LD	SP,STACK
                                ;        --------------------------------------------------------------
                                			;
  7A93'   21 37FF               BSCLR:	LD	HL,BSANF+BSLNG-1	; Bildschirm loeschen
  7A96'   36 20                 	LD	(HL),' '
  7A98'   11 37FE               	LD	DE,BSANF+BSLNG-2
  7A9B'   01 07FE               	LD	BC,BSLNG-2
  7A9E'   ED B8                 	LDDR
                                			;
                                ;        --------------------------------------------------------------
                                			;
  7AA0'   21 7AA5'              PTEST:	LD	HL,$+5	; PROM-Test
  7AA3'   18 B8                 	JR	TTEST+6	; ---------        (DISPL)
  7AA5'   3F 3F 20 50           	DB	'?? PROM:'
  7AA9'   52 4F 4D 3A           
  7AAD'   9E                    	DB	1EH OR 80H
                                			;
  7AAE'   D3 C4                 	OUT	(0C4H),A	; Reset- u.Umschalt-Sperre aus
                                			;
  7AB0'   3E 38                 	LD	A,38H	; System 1:      (0 -> aktiv:..)
  7AB2'   D3 C0                 	OUT	(0C0H),A	;            7:BS-Ram30  (7024)
                                			;            6:BS-Video1 (7024)
                                			;            2:PFS-E40 
                                			;            1:OFS-R10/E28
                                			;            0:ZRE-E00/R0C
  7AB4'   3E 03                 	LD	A,003H	; System 2:      (1 -> aktiv:..)
  7AB6'   D3 C1                 	OUT	(0C1H),A	;            1:PFS-E80 (Basic)
                                			;            0:PFS-EC0 (System)
                                			;
  7AB8'   C3 7823'              	JP	PROMT	; UP PROM-Test
                                			;
                                ;        --------------------------------------------------------------
                                	PAGE	
'EPROM-, RAM- und Tastatur-Test  DEG 2000  / TAP2'	MACRO-80 3.44	09-Dec-81	PAGE	1-18


                                
                                ;        --------------------------------------------------------------
                                			;
  7ABB'   21 7AC0'              RTEST:	LD	HL,$+5	; RAM-Test
  7ABE'   18 E3                 	JR	PTEST+3	; --------         (DISPL)
  7AC0'   1E1E                  	DW	1E1EH
  7AC2'   3F 3F 20 52           	DB	'?? RAM:'
  7AC6'   41 4D 3A              
  7AC9'   9E                    	DB	1EH OR 80H
  7ACA'   1B                    	DEC	DE
                                			;
  7ACB'   3E 00                 RTST1:	LD	A,00H	; System 2:...
  7ACD'   D3 C1                 	OUT	(0C1H),A	;          ... nicht aktiv
                                			;
  7ACF'   3E 20                 	LD	A,20H	; System 1:...
  7AD1'   D3 C0                 	OUT	(0C0H),A	;          ... alles aktiv
                                			;
  7AD3'   C3 7894'              	JP	RAMT	; UP RAM-Test
                                			;
  7AD6'   D9                    RTST2:	EXX		; Verschieb.BS-/Programm-Inhalt:
  7AD7'   11 8000               	LD	DE,NACH	;         ... physisch
  7ADA'   21 3000               	LD	HL,VON
  7ADD'   01 5000               	LD	BC,5000H	;                      (Laenge)
  7AE0'   ED B0                 	LDIR
                                			;
  7AE2'   21 C897'              	LD	HL,RAMT+5000H+3	;         ... logisch
  7AE5'   06 00                 	LD	B,0	;             ... Programm
                                			;
  7AE7'   7E                    	LD	A,(HL)
  7AE8'   C6 50                 	ADD	A,HIGH(UM)
  7AEA'   77                    	LD	(HL),A
  7AEB'   3B                    	DEC	SP
  7AEC'   F1                    	POP	AF
  7AED'   4F                    	LD	C,A
  7AEE'   09                    	ADD	HL,BC
  7AEF'   B7                    	OR	A
  7AF0'   20 F5                 	JR	NZ,$-9
  7AF2'   D9                    	EXX
                                			;
  7AF3'   21 5000               	LD	HL,UM	;             ... BS-Position
  7AF6'   19                    	ADD	HL,DE
  7AF7'   EB                    	EX	DE,HL
                                			;
  7AF8'   18 D9                 	JR	RTST2-3				; Test BS-RAM      (UP RAM-Test)
                                			;
  7AFA'   3E A7                 RTST3:	LD	A,0A7H	; System 1:      (0 -> aktiv:..)
  7AFC'   D3 C0                 	OUT	(0C0H),A			;            6:BS-Video1 (7024)
                                										;            4:OPS-RC0
                                										;            3:OPS-R80
  7AFE'   3E 84                 	LD	A,84H					; System 2:      (1 -> aktiv:..)
  7B00'   D3 C1                 	OUT	(0C1H),A			;            7:OPS-R00
                                										;            2:OPS-R40
                                										;
  7B02'   31 CBE8'              	LD	SP,RAM3-2+UM	; Korrektur SP
  7B05'   C3 C894'              	JP	RAMT+UM				; UP RAM-Test
                                										;
  7B08'   3E 00                 BSRST:	LD	A,00H		; System 2: ...
  7B0A'   D3 C1                 	OUT	(0C1H),A			;           ... nicht aktiv
                                										;
  7B0C'   3E 20                 	LD	A,20H					; System 1: ...
  7B0E'   D3 C0                 	OUT	(0C0H),A			;           ... alles aktiv
                                										;
  7B10'   21 8000               	LD	HL,NACH				; restore BS-Inhalt
  7B13'   11 3000               	LD	DE,VON
  7B16'   01 0800               	LD	BC,800H
  7B19'   ED B0                 	LDIR
                                			;
                                ;        --------------------------------------------------------------
                                			;
  7B1B'   C3 7A24'              	JP	TASTP-3	; Prog.Tastatur-PIO incl.EI/RETI
                                			;
                                ;**********************************************************************
                                ;	END	
                                	TITLE	'T a b e l l e n     T A P 2'
                                	PAGE
'T a b e l l e n     T A P 2'	MACRO-80 3.44	09-Dec-81	PAGE	1-19


                                
                                ;	PN	TE
                                ;**********************************************************************
                                ;*                                                                    *
                                ;*       T a b e l l e n     T A P 2                                  *
                                ;*                                                                    *
                                ;**********************************************************************
                                ;*                                                                    *
                                ;*       EPROM - T a b e l l e      P R O M                           *
                                ;*       ==================================                           *
                                ;*                                                                    *
                                ;*       Jede Eintragung hat folgenden Aufbau:                        *
                                ;*                                                                    *
                                ;*       - 1 Byte High-Teil der EPROM-Adresse,                        *
                                ;*         (der niederwertige Teil wird als 0 angenommen)             *
                                ;*                                                                    *
                                ;*       - 2 Bytes Kontroll-Wert der Pruefsumme (L-Teil, H-Teil)      *
                                ;*                                                                    *
                                ;*                                                                    *
                                ;*       RAM - T a b e l l e n     R A M 1 - 3                        *
                                ;*       =====================================                        *
                                ;*                                                                    *
                                ;*       Jede Eintragung hat folgendes Format:                        *
                                ;*                                                                    *
                                ;*       - 1 Byte High-Teil der Adresse des RAM-Bereichs              *
                                ;*                                                                    *
                                ;*       - 1 Byte High-Teil der Bereichslaenge                        *
                                ;*                                                                    *
                                ;*       (der niederwertige Teil wird stets als 0 angenommen)         *
                                ;*                                                                    *
                                ;*                                                                    *
                                ;**********************************************************************
                                ;*                                                                    *
                                ;*       Zwischen den Tabellen befinden sich Steuer-Bytes (FF bzw.    *
                                ;*       FF00) und Pseudo-Stack fuer RET und anderes                  *
                                ;*                                                                    *
                                ;**********************************************************************
                                			;
  7B1E'                         STACK	EQU	$	; Pseudo-Stack
                                			; ------------
                                			;
                                ;**********************************************************************
                                	PAGE	
'T a b e l l e n     T A P 2'	MACRO-80 3.44	09-Dec-81	PAGE	1-20


                                
                                ;**********************************************************************
                                			;
  7B1E'   00                    PROM:	DB	000H	; System 1
  7B1F'   340E                  	DW	0340EH
                                			;
  7B21'   04                    	DB	004H
  7B22'   CFB6                  	DW	0CFB6H
                                			;
  7B24'   08                    	DB	008H
  7B25'   83BA                  	DW	083BAH
                                			;
  7B27'   10                    	DB	010H	;         EDIT
  7B28'   FDAE                  	DW	0FDAEH
                                			;
  7B2A'   14                    	DB	014H
  7B2B'   F6F8                  	DW	0F6F8H
                                			;
  7B2D'   18                    	DB	018H
  7B2E'   D51F                  	DW	0D51FH
                                			;
  7B30'   1C                    	DB	01CH
  7B31'   A089                  	DW	0A089H
                                			;
  7B33'   20                    	DB	020H
  7B34'   C731                  	DW	0C731H
                                			;
  7B36'   24                    	DB	024H
  7B37'   B4C4                  	DW	0B4C4H
                                			;
  7B39'   40                    	DB	040H
  7B3A'   BE83                  	DW	0BE83H
                                			;
  7B3C'   44                    	DB	044H
  7B3D'   8865                  	DW	08865H
                                			;
  7B3F'   48                    	DB	048H
  7B40'   B2E0                  	DW	0B2E0H
                                			;
  7B42'   4C                    	DB	04CH
  7B43'   5A7C                  	DW	05A7CH
                                			;
  7B45'   50                    	DB	050H
  7B46'   D3F3                  	DW	0D3F3H
                                			;
  7B48'   54                    	DB	054H
  7B49'   9CF4                  	DW	09CF4H
                                			;
  7B4B'   58                    	DB	058H
  7B4C'   EE97                  	DW	0EE97H
                                			;
  7B4E'   5C                    	DB	05CH
  7B4F'   414E                  	DW	0414EH
                                			;
  7B51'   60                    	DB	060H
  7B52'   9D20                  	DW	09D20H
                                			;
  7B54'   64                    	DB	064H
  7B55'   B412                  	DW	0B412H
                                			;
  7B57'   68                    	DB	068H
  7B58'   BF86                  	DW	0BF86H
                                			;
  7B5A'   6C                    	DB	06CH
  7B5B'   06F8                  	DW	006F8H
                                			;
  7B5D'   70                    	DB	070H
  7B5E'   D1A8                  	DW	0D1A8H
                                			;
  7B60'   74                    PROM0:	DB	074H	; Programm-PROM "Test"
  7B61'   FFFF                  	DW	0FFFFH
                                			;
  7B63'   78                    	DB	078H
  7B64'   9410                  	DW	09410H
                                			;
  7B66'   7C                    	DB	07CH
  7B67'   598E                  	DW	0598EH
                                			;
                                ;        --------------------------------------------------------------
  7B69'   80                    	DB	080H	; System 2:
  7B6A'   B175                  	DW	0B175H	;         BSC...
'T a b e l l e n     T A P 2'	MACRO-80 3.44	09-Dec-81	PAGE	1-21


                                			;
  7B6C'   84                    	DB	084H
  7B6D'   03C8                  	DW	003C8H
                                			;
  7B6F'   88                    	DB	088H
  7B70'   33F9                  	DW	033F9H
                                			;
  7B72'   8C                    	DB	08CH
  7B73'   FA89                  	DW	0FA89H
                                			;
  7B75'   90                    	DB	090H
  7B76'   1086                  	DW	01086H
                                			;
  7B78'   94                    	DB	094H
  7B79'   F4CF                  	DW	0F4CFH
                                			;
  7B7B'   98                    	DB	098H
  7B7C'   5CC6                  	DW	05CC6H
                                			;
  7B7E'   9C                    	DB	09CH
  7B7F'   4075                  	DW	04075H
                                			;
  7B81'   A0                    	DB	0A0H
  7B82'   5BF2                  	DW	05BF2H
                                			;
  7B84'   A4                    	DB	0A4H
  7B85'   6360                  	DW	06360H
                                			;
  7B87'   A8                    	DB	0A8H
  7B88'   8DA0                  	DW	08DA0H
                                			;
  7B8A'   AC                    	DB	0ACH
  7B8B'   D6CC                  	DW	0D6CCH
                                			;
  7B8D'   B0                    	DB	0B0H
  7B8E'   4A5E                  	DW	04A5EH
                                			;
  7B90'   B4                    	DB	0B4H
  7B91'   77EB                  	DW	077EBH
                                			;
  7B93'   B8                    	DB	0B8H
  7B94'   77EB                  	DW	077EBH
                                			;
  7B96'   BC                    	DB	0BCH
  7B97'   77EB                  	DW	077EBH
                                			;
                                ;        --------------------------------------------------------------
  7B99'   C0                    	DB	0C0H	;         System-Programme
  7B9A'   A899                  	DW	0A899H
                                			;
  7B9C'   C4                    	DB	0C4H
  7B9D'   1D64                  	DW	01D64H
                                			;
  7B9F'   C8                    	DB	0C8H
  7BA0'   45F8                  	DW	045F8H
                                			;
  7BA2'   CC                    	DB	0CCH
  7BA3'   EB13                  	DW	0EB13H
                                			;
  7BA5'   D0                    	DB	0D0H
  7BA6'   AFDC                  	DW	0AFDCH
                                			;
  7BA8'   D4                    	DB	0D4H
  7BA9'   755D                  	DW	0755DH
                                			;
  7BAB'   D8                    	DB	0D8H
  7BAC'   F8FB                  	DW	0F8FBH
                                			;
  7BAE'   DC                    	DB	0DCH
  7BAF'   8656                  	DW	08656H
                                			;
  7BB1'   E0                    	DB	0E0H
  7BB2'   8230                  	DW	08230H
                                			;
  7BB4'   E4                    	DB	0E4H
  7BB5'   9279                  	DW	09279H
                                			;
  7BB7'   E8                    	DB	0E8H
  7BB8'   07B9                  	DW	007B9H
                                			;
  7BBA'   EC                    	DB	0ECH
  7BBB'   FFB5                  	DW	0FFB5H
'T a b e l l e n     T A P 2'	MACRO-80 3.44	09-Dec-81	PAGE	1-22


                                			;
  7BBD'   F0                    	DB	0F0H
  7BBE'   4DA1                  	DW	04DA1H
                                			;
  7BC0'   F4                    	DB	0F4H
  7BC1'   C7B5                  	DW	0C7B5H
                                			;
  7BC3'   F8                    	DB	0F8H
  7BC4'   77B8                  	DW	077B8H
                                			;
  7BC6'   FC                    	DB	0FCH
  7BC7'   C6BD                  	DW	0C6BDH
                                			;
                                ;**********************************************************************
  7BC9'   FF                    	DB	0FFH	;         Ende-Kennzeichen PROM
  7BCA'   7ABB'                 	DW	RTEST	;         Return-Adr. PROMT
  7BCC'   00FF                  	DW	0FFH	;         Start-Kennzeichen RAM1
                                ;**********************************************************************
                                			;
  7BCE'   0C                    RAM1:	DB	0CH	; RAM-Tabelle 1: System 1
  7BCF'   04                    	DB	04H
                                			;
  7BD0'   C0                    	DB	0C0H
  7BD1'   40                    	DB	40H
                                			;
  7BD2'   80                    	DB	80H
  7BD3'   40                    	DB	40H
                                			;
  7BD4'   28                    	DB	28H
  7BD5'   08                    	DB	08H
                                			;
                                ;**********************************************************************
                                	PAGE	
'T a b e l l e n     T A P 2'	MACRO-80 3.44	09-Dec-81	PAGE	1-23


                                
                                ;**********************************************************************
  7BD6'   00FF                  	DW	0FFH	;         Ende-Kennzeichen RAM1
  7BD8'   7AD6'                 	DW	RTST2	;         Return-Adr. RAMT
                                			;
  7BDA'   0B                    RLTAB:	DB	11	;         Tabelle der zu 
  7BDB'   06                    	DB	6	;           verschieb.Adr.-Werte
  7BDC'   39                    	DB	57	;           relativ zu RAMT+3
  7BDD'   03                    	DB	3
  7BDE'   D4                    	DB	212
                                			;
  7BDF'   00                    	DB	0	;         Ende-Kennzeichen RLTAB
  7BE0'   00FF                  	DW	0FFH	;         Start-Kennzeichen RAM2
                                ;**********************************************************************
                                			;
  7BE2'   30                    RAM2:	DB	30H	; RAM-Tabelle 2: BS-RAM 1
  7BE3'   08                    	DB	08H
                                			;
                                ;**********************************************************************
  7BE4'   00FF                  	DW	0FFH	;         Ende-Kennzeichen RAM2
  7BE6'   CAFA'                 	DW	RTST3+UM	;         Return-Adr.RAMT
  7BE8'   00FF                  	DW	0FFH	;         Start-Kennzeichen RAM3
                                ;**********************************************************************
                                			;
  7BEA'   00                    RAM3:	DB	00H	; RAM-Tabelle 3: System 2
  7BEB'   40                    	DB	40H
                                			;
  7BEC'   40                    	DB	40H
  7BED'   40                    	DB	40H
                                			;
                                ;**********************************************************************
  7BEE'   00FF                  	DW	0FFH	;         Ende-Kennzeichen RAM3
  7BF0'   CB08'                 	DW	BSRST+UM	;         Return-Adr.RAMT
                                			;
  7BF2'                         TAST	EQU	$	; Fuer "TAST"/TTEST...
  7BF2'   7A27'                 	DW	TASTP	;         ... EI / RETI
  7BF4'   7A57'                 	DW	TTEST	;         ... TASTP
  7BF6'   7A7E'                 	DW	TZYK	;         ... TASTE+2
  7BF8'   7A80'                 	DW	TZYK+2	;         ... TASTE
                                			;
                                ;**********************************************************************
  7BFA'                         END	EQU	$	; Soll-Wert ANFNG+400H
                                ;**********************************************************************
                                	END	
'T a b e l l e n     T A P 2'	MACRO-80 3.44	09-Dec-81	PAGE	S


Macros:

Symbols:
7993'	ADRT            78D3'	ADSET           7800'	ANFNG           
3000 	BSANF           7A93'	BSCLR           0800 	BSLNG           
7B08'	BSRST           7843'	CRC             787A'	CRC1            
7855'	CRCA            7889'	CRCA1           79DF'	CVABX           
79CB'	CVHLX           79FF'	DISPL           7A08'	DSPLE           
7BFA'	END             8000 	NACH            7A0F'	NL              
7899'	NXTR            78A3'	PEAK            7B1E'	PROM            
7B60'	PROM0           783B'	PROMF           7823'	PROMT           
7AA0'	PTEST           7BCE'	RAM1            7BE2'	RAM2            
7BEA'	RAM3            78DA'	RAMRR           7894'	RAMT            
78C5'	RFRSH           7BDA'	RLTAB           7939'	ROTCF           
7927'	ROTCR           78E9'	ROTCY           7ABB'	RTEST           
7ACB'	RTST1           7AD6'	RTST2           7AFA'	RTST3           
78B5'	SHFT1           78BD'	SHFT2           7991'	SHFTF           
7989'	SHFTR           793B'	SHIFT           7B1E'	STACK           
003A 	SYS1            0084 	TAPIO           7BF2'	TAST            
7A3E'	TASTE           7A27'	TASTP           7A8A'	TEST            
7800'	TEST1           7A57'	TTEST           7A7E'	TZYK            
5000 	UM              78AB'	VALLY           3000 	VON             



No Fatal error(s)


    
7ACB'	