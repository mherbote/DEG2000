''	MACRO-80 3.44	09-Dec-81	PAGE	1


  0D00                          SM.FKTAB  EQU	00D00H
  21EF                          ATACO     EQU	021EFH
  3000                          SD.BWSA   EQU	03000H
  4026                          TA.ABFR1  EQU   04026H
  4033                          SY.SETCHL EQU	04033H
  4036                          SY.RESC   EQU	04036H
  4040                          PRINT     EQU	04040H
  4070                          PUF.KASS  EQU   04070H
                                
                         C      	INCLUDE K0.ASM	;EQUAL - Anweisungen fuer Assembler
                         C      	TITLE 'EQUAL - Anweisungen fuer Assembler'
                         C      	PAGE	87
'EQUAL - Anweisungen fuer Assembler'	MACRO-80 3.44	09-Dec-81	PAGE	1-1


                         C      
                         C      ;         PN    UE01
                         C      ;****************************************************************
                         C      ;*                  EQUAL - Anweisungen fuer Assembler          *
                         C      ;****************************************************************
  00F7                   C      UE.TACL  EQU	0F7H	;Kursor nach links
  00F9                   C      UE.TACR  EQU	0F9H	; ''    nach rechts
  00CD                   C      UE.TASYS EQU	0CDH	;SYS-Taste
  001E                   C      UE.TAQUI EQU	01EH	;ET1
  007D                   C      UE.SVL   EQU	07DH	;Laenge der SAVE-Bloecke
  0060                   C      UE.COTAL EQU	060H	;Laenge ASC/KOI Codetabelle
  0132                   C      UE.KMPUL EQU	132H	;max. Laenge E/A-Puffer
                         C      
  000B                   C      UE.SYSTB EQU	0000BH	;SY.SYSTB
  0CFE                   C      UE.STANF EQU	00CFEH	;STACK
  0DC4                   C      UE.EDEND EQU	00DC4H	;Speicherpl. fuer Adr. Editorende
  0E5A                   C      UE.ZEIN  EQU	00E5AH	;Pufferzaehler Eingabe
  0E66                   C      UE.PUF   EQU	00E66H	;System-Puffer
  3000                   C      UE.BWSA  EQU	03000H	;Bildwiederholspeicher
  8010                   C      UE.KPUFF EQU	08010H	;E/A Puffer
  8830                   C      UE.TEXAN EQU	08830H	;Begin Editorraum
                         C      
  5400'                  C      UE.BRKMB EQU	K1.BRKMB ;04000H	;phys. Kass.Routine
  54F4'                  C      UE.CRC   EQU	K1.CRC	;04740H	;CRC-Berechnung
                         C      
                         C      ;         END
                         C      ;         PN    UB
                         C                ORG   2B00H
  2B00'                  C      UB.ZN:    DS	1,0
  2B01'                  C      UB.KTAB:  DS	27,0
  2B1C'   0000           C      UB.PAR1:  DW	0
  2B1E'   0000           C      UB.PAR2:  DW	0
  2B20'   0000           C      UB.PAR3:  DW	0
  2B22'   0000           C      UB.PAR4:  DW	0
  2B24'   0000           C      UB.PAR5:  DW	0
  2B26'                  C      UB.PATAB: DS	4,0
  2B2A'   00             C      UB.SATZ:  DB	0
  2B2B'   37             C                DB	55
  2B2C'   80             C                DB	80H
  2B2D'   20 20 20 20    C                DB	'                                                       '
  2B31'   20 20 20 20    C      
  2B35'   20 20 20 20    C      
  2B39'   20 20 20 20    C      
  2B3D'   20 20 20 20    C      
  2B41'   20 20 20 20    C      
  2B45'   20 20 20 20    C      
  2B49'   20 20 20 20    C      
  2B4D'   20 20 20 20    C      
  2B51'   20 20 20 20    C      
  2B55'   20 20 20 20    C      
  2B59'   20 20 20 20    C      
  2B5D'   20 20 20 20    C      
  2B61'   20 20 20       C      
  2B64'                  C      UB.DTAB:  DS	41,0
  2B8D'                  C      UB.END    EQU	$
                         C      ;         END
                         C      ;         PN    BC
                         C      ;----------------------------------------------------------------------
                         C      ;
                         C      ;        BEREICHE FUER KASSETTENKOPIEREN
                         C      ;
                         C      ;----------------------------------------------------------------------
  E000                   C      BC.TAB1    EQU	0E000H
  0000                   C      BC.EGG     EQU	0	;EINGABEGERAET
  0001                   C      BC.AGG     EQU	1	;AUSGABEGERAET
  E002                   C      BC.VTABA   EQU	0E002H
  EC82                   C      BC.VTABE   EQU	0E002H+3200
  F902                   C      BC.TAB2    EQU	0E002H+3200+3200
  F96A                   C      BC.TAB2A   EQU	0E002H+3200+3200+104
  F9D2                   C      BC.TAB3    EQU	0E002H+3200+3200+104+104
  FA3A                   C      BC.END     EQU	0E002H+3200+3200+104+104+104
                         C      ;	ORG	0E000H
                         C      ;BC.TAB1:   DS	2
                         C      ;
                         C      ;BC.EGG     EQU	0	;EINGABEGERAET
                         C      ;BC.AGG     EQU	1	;AUSGABEGERAET
                         C      ;----------------------------------------------------------------------
                         C      ;BC.VTABA:  DS	3200
                         C      ;BC.VTABE:  DS	3200
                         C      ;----------------------------------------------------------------------
                         C      ;BC.TAB2:   DS	104
                         C      ;BC.TAB2A:  DS	104
'EQUAL - Anweisungen fuer Assembler'	MACRO-80 3.44	09-Dec-81	PAGE	1-2


                         C      ;BC.TAB3:   DS	104
                         C      ;BC.END     EQU	$
                         C      ;----------------------------------------------------------------------
                         C      ;         END
                                ;	
                                	ORG	05400H
                         C      	INCLUDE K1.ASM	;BAMOS/Emulator  ---  Kassettenmagnetband
                         C      	TITLE 'BAMOS/Emulator  ---  Kassettenmagnetband'
                         C      	PAGE
'BAMOS/Emulator  ---  Kassettenmagnetband'	MACRO-80 3.44	09-Dec-81	PAGE	1-3


                         C      
                         C      ;****************************************************************
                         C      ;*               BAMOS/Emulator  ---  Kassettenmagnetband       *
                         C      ;* OS - Version  -----------------------------------------------*
                         C      ;*               Programmierer: Marcus Herbote                  *
                         C      ;* V 1 . 2       -----------------------------------------------*
                         C      ;*               Stand        : 18.November 2022                *
                         C      ;****************************************************************
                         C      
                         C      ;****************************************************************
                         C      ;*               Geraetebedienroutine fuer Kassettenmagnetband  *
                         C      ;*               Anschluss von zwei Laufwerken K5200            *
                         C      ;*               an einer AKB K5020                             *
                         C      ;*               -----------------------------------------------*
                         C      ;*               E/A-Tabelle                                    *
                         C      ;*               Byte  0   Status                               *
                         C      ;*               Byte  1   Fehlerschluessel                     *
                         C      ;*               Byte  2   Laenge der Daten im Puffer           *
                         C      ;*                         1, 10H, 20H, 80H                     *
                         C      ;*               Byte  3   Basisadresse der AKB                 *
                         C      ;*               Byte  4   Subadresse                           *
                         C      ;*               Byte  5   Kommando                             *
                         C      ;*               Byte  6   HS-Bereich                           *
                         C      ;*               Byte  7   H-Teil Blockadresse                  *
                         C      ;*               Byte  8   L-Teil Blockadresse                  *
                         C      ;*                         n      bei suchen Bandmarke          *
                         C      ;*               -----------------------------------------------*
                         C      ;*               Byte  9 1 0F0H  Startbyte                      *
                         C      ;*               Byte 10 2       Kommando                       *
                         C      ;*               Byte 11 3       Subadresse                     *
                         C      ;*               Byte 12 4       Anzahl BM  bei 71, 75          *
                         C      ;*               Byte 12 4       'B'        bei 51              *
                         C      ;*               Byte 12 4       'S'        bei 61              *
                         C      ;*               Byte 12 4       HS-Bereich bei 02              *
                         C      ;*               Byte 12 4       Laenge     bei 08              *
                         C      ;*               Byte 12 4 0FFH             bei 31,41,21,11,15  *
                         C      ;*               Byte 13 5       H(Puffer)  bei 02              *
                         C      ;*               Byte 13 5       HS-Bereich bei 08              *
                         C      ;*               Byte 13 5 0FFH             bei 51,61,71,75     *
                         C      ;*               Byte 14 6       L(Puffer)  bei 02              *
                         C      ;*               Byte 14 6       H(Puffer)  bei 08              *
                         C      ;*               Byte 15 7       L(Puffer)  bei 08              *
                         C      ;*               Byte 15 7 0FFH             bei 02              *
                         C      ;*               Byte 16 8 0FFH             bei 08              *
                         C      ;****************************************************************
                         C      ;*               Kommandos:                                     *
                         C      ;*                 Hex   Kommando                               *
                         C      ;*                 02    naechsten Record einlesen              *
                         C      ;*                 08    naechsten Record schreiben             *
                         C      ;*                 11    einen Block vorsetzen                  *
                         C      ;*                 15    einen Block ruecksetzen                *
                         C      ;*                 21    umspulen                               *
                         C      ;*                 31    reservieren ein                        *
                         C      ;*                 41    reservieren aus                        *
                         C      ;*                 51    schreiben einer Bandmarke              *
                         C      ;*                 61    schreiben Schlussluecke                *
                         C      ;*                 71    suche n-te Bandmarke vorwaerts         *
                         C      ;*                 75    suche n-te Bandmarke rueckwaerts       *
                         C      ;****************************************************************
                         C      	PAGE
'BAMOS/Emulator  ---  Kassettenmagnetband'	MACRO-80 3.44	09-Dec-81	PAGE	1-4


                         C      
                         C      ;****************************************************************
                         C      ;*               Status                                         *
                         C      ;*               Bit 0     0 Geraet frei                        *
                         C      ;*                         1 Geraet besetzt                     *
                         C      ;*               Bit 1     0                                    *
                         C      ;*                         1 Datentraegerende                   *
                         C      ;*               Bit 2     0 Aufzeichnen erlaubt                *
                         C      ;*                         1 Aufzeichnen verboten               *
                         C      ;*               Bit 3     0 Kassettenseite A                   *
                         C      ;*                         1 Kassettenseite B                   *
                         C      ;*               Bit 4     0 Geraet       bereit                *
                         C      ;*                         1 Geraet nicht bereit                *
                         C      ;*               Bit 5     0 Geraet nicht reserviert            *
                         C      ;*                         1 Geraet       reserviert            *
                         C      ;*               Bit 6     0 Aufzeichnungsverf.  38 CM*S**-1    *
                         C      ;*                         1 Aufzeichnungsverf.  19 CM*S**-1    *
                         C      ;*               Bit 7     0 Kommando fehlerfrei ausgefuehrt    *
                         C      ;*                         1 Fehler (siehe Fehlerschluessel)    *
                         C      ;*               -----------------------------------------------*
                         C      ;*               Fehlerschluessel                               *
                         C      ;*                 Hex   Fehler                                 *
                         C      ;*                 10    falsches Kommando                      *
                         C      ;*                 11    angewaehltes Geraet nicht reserviert   *
                         C      ;*                 12    Subadresse falsch                      *
                         C      ;*                 13    Pufferl. kleiner 12 oder groesser 256  *
                         C      ;*                 14    Ende der Aufzeichnungen auf dieser     *
                         C      ;*                       Kassettenseite (Lesen)                 *
                         C      ;*                 15    angewaehltes Geraet besetzt            *
                         C      ;*                 16    Ende/Anfang der Aufzeichnungen         *
                         C      ;*                       (Bandmarke suchen)                     *
                         C      ;*                 17    gelesener Block laenger 260 Byte       *
                         C      ;*                 18    Bandmarke nicht gefunden               *
                         C      ;*                 19    Aufzeichnen verboten                   *
                         C      ;*                       (mit Kommando: Aufzeichnen)            *
                         C      ;****************************************************************
                         C          PAGE
'BAMOS/Emulator  ---  Kassettenmagnetband'	MACRO-80 3.44	09-Dec-81	PAGE	1-5


                         C      
                         C      ;****************************************************************
                         C      ;*               Hinweise zur Arbeit mit der Geraetebedienr.    *
                         C      ;*                - E/A-Tabelle laden (Basisadresse AKB)        *
                         C      ;*                - Adresse E/A-Tabelle in IX laden             *
                         C      ;*                - laden Schluessel fuer Kommando , Subadresse *
                         C      ;*                    Adresse Eintrittspunkt                    *
                         C      ;*                - Aufruf Geraetebedienroutine immer mit       *
                         C      ;*                    CALL   KR.BRKMB                           *
                         C      ;*                - wird keine Parallelarbeit mit anderen       *
                         C      ;*                  Programmen gewuenscht , kann wie in         *
                         C      ;*                  folgendem Beispiel verfahren werden:        *
                         C      ;*                        ...                                   *
                         C      ;*                        CALL KR.BRKMB ;Aufruf                 *
                         C      ;*                  MARKE:HALT                                  *
                         C      ;*                        JR   MARKE-#                          *
                         C      ;*                  ADREP:............  ;Adresse Eintrittspunkt *
                         C      ;*                        ...                                   *
                         C      ;*                - bei Rueckkehr der Bedienroutine zum Ein-    *
                         C      ;*                  trittspunkt ist die Adresse des folgenden   *
                         C      ;*                  Befehls , bei dem der letzte Interrupt      *
                         C      ;*                  angenommen wurde , noch im SP .             *
                         C      ;*                  Wird , wie im obigen Beispiel , diese       *
                         C      ;*                  Adresse nicht mehr benoetigt , so ist der   *
                         C      ;*                  SP  um 2 zu erhoehen.                       *
                         C      ;****************************************************************
                         C      	TITLE	'Steuerteil Geraetebedienroutine'
                         C          PAGE
'Steuerteil Geraetebedienroutine'	MACRO-80 3.44	09-Dec-81	PAGE	1-6


                         C      
                         C      ;	ORG	05400H
                         C      ;****************************************************************
                         C      ;*               Steuerteil der Geraetebedienroutine            *
                         C      ;****************************************************************
  5400'                  C      K1.BRKMB:
  5400'   F3             C          DI
  5401'   CD 54DD'       C          CALL    RRET
                         C      
                         C      ;****************************************************************
                         C      ;*               Analyse Kommando                               *
                         C      ;****************************************************************
  5404'   DD 7E 05       C          LD  A,(IX+5)
  5407'   FE 02          C          CP  002H    ;naechsten Record einlesen
  5409'   CA 548D'       C          JP  Z,STT02
  540C'   FE 08          C          CP  008H    ;naechsten Record schreiben
  540E'   CA 54AB'       C          JP  Z,STT08
  5411'   FE 11          C          CP  011H    ;einen Block vorsetzen
  5413'   CA 5465'       C          JP  Z,STT11
  5416'   FE 15          C          CP  015H    ;einen Block ruecksetzen
  5418'   CA 5465'       C          JP  Z,STT15
  541B'   FE 21          C          CP  021H    ;umspulen
  541D'   CA 5465'       C          JP  Z,STT21
  5420'   FE 31          C          CP  031H    ;reservieren ein
  5422'   CA 5465'       C          JP  Z,STT31
  5425'   FE 41          C          CP  041H    ;reservieren aus
  5427'   CA 5465'       C          JP  Z,STT41
  542A'   FE 51          C          CP  051H    ;schreiben einer Bandmarke
  542C'   CA 5471'       C          JP  Z,STT51
  542F'   FE 61          C          CP  061H    ;schreiben Schlussluecke
  5431'   CA 5475'       C          JP  Z,STT61
  5434'   FE 71          C          CP  071H    ;suche n-te Bandmarke vorwaerts
  5436'   CA 5479'       C          JP  Z,STT71    
  5439'   FE 75          C          CP  075H    ;suche n-te Bandmarke rueckwaerts
  543B'   CA 5479'       C          JP  Z,STT75
  543E'   C3 54D9'       C          JP  STF07   ;falsches Kommando
                         C      
                         C      ;****************************************************************
                         C      ;*               Kernroutine MB                                 *
                         C      ;****************************************************************
  5441'                  C      K1.KERN:
  5441'   DD 36 09 F0    C          LD  (IX+9),0F0H
  5445'   DD 7E 05       C          LD  A,(IX+5)    ;Kommando
  5448'   DD 77 0A       C          LD  (IX+10),A
  544B'   DD 7E 04       C          LD  A,(IX+4)    ;Subadresse
  544E'   DD 77 0B       C          LD  (IX+11),A
                         C      
  5451'   DD 4E 03       C          LD  C,(IX+3)    ;Basisadresse der AKB
  5454'   DD E5          C          PUSH    IX
  5456'   E1             C          POP HL
  5457'   11 0009        C          LD  DE,9
  545A'   19             C          ADD  HL,DE
  545B'   ED B3          C          OTIR            ;KM - Routine aufrufen
  545D'   DD E5          C          PUSH    IX
  545F'   E1             C          POP HL
  5460'   06 06          C          LD  B,6
  5462'   ED B2          C          INIR            ;Status und Fehler holen
  5464'   C9             C          RET
                         C          TITLE   '4-/5-Byte IO-Kommandos'
                         C          PAGE
'4-/5-Byte IO-Kommandos'	MACRO-80 3.44	09-Dec-81	PAGE	1-7


                         C      
                         C      ;****************************************************************
                         C      ;*               reservieren ein / aus                          *
                         C      ;****************************************************************
  5465'                  C      STT31:
  5465'                  C      STT41:
                         C      ;****************************************************************
                         C      ;*               umspulen                                       *
                         C      ;****************************************************************
  5465'                  C      STT21:
                         C      ;****************************************************************
                         C      ;*               vor-/ruecksetzen um einen Block                *
                         C      ;****************************************************************
  5465'                  C      STT11:
  5465'                  C      STT15:
  5465'   DD 36 0C FF    C          LD  (IX+12),0FFH
                         C      
  5469'   06 04          C          LD  B,4
  546B'   CD 5441'       C          CALL K1.KERN
  546E'   C3 54EA'       C          JP	KOMED	;Kommandoende
                         C      
                         C      ;****************************************************************
                         C      ;*               schreiben einer Bandmarke                      *
                         C      ;****************************************************************
  5471'                  C      STT51:
  5471'   3E 42          C          LD  A,'B'
  5473'   18 09          C          JR  STT5
                         C      ;****************************************************************
                         C      ;*               schreiben einer Schlussluecke                  *
                         C      ;****************************************************************
  5475'                  C      STT61:
  5475'   3E 53          C          LD  A,'S'
  5477'   18 05          C          JR  STT5
                         C      ;****************************************************************
                         C      ;*               suche Bandmarke vorwaerts / rueckwaerts        *
                         C      ;****************************************************************
  5479'                  C      STT71:
  5479'                  C      STT75:
  5479'   DD 7E 08       C          LD  A,(IX+8)
  547C'   18 00          C          JR  STT5
  547E'                  C      STT5:
  547E'   DD 77 0C       C          LD  (IX+12),A
  5481'   DD 36 0D FF    C          LD  (IX+13),0FFH
                         C      
  5485'   06 05          C          LD  B,5
  5487'   CD 5441'       C          CALL K1.KERN
  548A'   C3 54EA'       C          JP	KOMED	;Kommandoende
                         C      
                         C          TITLE   '7-/8-Byte IO-Kommandos'
                         C          PAGE
'7-/8-Byte IO-Kommandos'	MACRO-80 3.44	09-Dec-81	PAGE	1-8


                         C      
                         C      ;****************************************************************
                         C      ;*               Eingabezweig                                   *
                         C      ;****************************************************************
  548D'                  C      STT02:
  548D'   DD 7E 06       C          LD  A,(IX+6)
  5490'   DD 77 0C       C          LD  (IX+12),A
                         C      
  5493'   DD 7E 07       C          LD  A,(IX+7)
  5496'   DD 77 0D       C          LD  (IX+13),A
  5499'   DD 7E 08       C          LD  A,(IX+8)
  549C'   DD 77 0E       C          LD  (IX+14),A
                         C      
  549F'   DD 36 0F FF    C          LD  (IX+15),0FFH
                         C      
  54A3'   06 07          C          LD  B,7
  54A5'   CD 5441'       C          CALL K1.KERN
  54A8'   C3 54EA'       C          JP	KOMED	;Kommandoende
                         C          
                         C      ;****************************************************************
                         C      ;*               Aufzeichnungszweig                             *
                         C      ;****************************************************************
  54AB'                  C      STT08:
  54AB'   DD 7E 02       C          LD  A,(IX+2)
  54AE'   DD 77 0C       C          LD  (IX+12),A
                         C      
  54B1'   DD 7E 06       C          LD  A,(IX+6)
  54B4'   DD 77 0D       C          LD  (IX+13),A
                         C      
  54B7'   DD 7E 07       C          LD  A,(IX+7)
  54BA'   DD 77 0E       C          LD  (IX+14),A
  54BD'   DD 7E 08       C          LD  A,(IX+8)
  54C0'   DD 77 0F       C          LD  (IX+15),A
                         C      
  54C3'   DD 36 10 FF    C          LD  (IX+16),0FFH
                         C      
  54C7'   06 08          C          LD  B,8
  54C9'   CD 5441'       C          CALL K1.KERN
  54CC'   C3 54EA'       C          JP	KOMED	;Kommandoende
                         C      
                         C          PAGE
'7-/8-Byte IO-Kommandos'	MACRO-80 3.44	09-Dec-81	PAGE	1-9


                         C      
                         C      ;****************************************************************
                         C      ;*               Fehler                                         *
                         C      ;****************************************************************
  54CF'                  C      STF99:
  54CF'   DD 75 01       C      	LD	(IX+1),L	;Fehlerschluessel laden
  54D2'   DD CB 00 FE    C      	SET	7,(IX)	;Fehlerbit setzen
  54D6'                  C      STFRS:
  54D6'   C3 54EA'       C      	JP	KOMED	;Kommandoende
                         C      
  54D9'                  C      STF07:
  54D9'   2E 10          C      	LD	L,10H	;falsches Kommando
  54DB'   18 F2          C      	JR	STF99
                         C      
                         C          PAGE
'7-/8-Byte IO-Kommandos'	MACRO-80 3.44	09-Dec-81	PAGE	1-10


                         C      
                         C      ;****************************************************************
                         C      ;*               Register AF , BC , DE , HL retten in SP        *
                         C      ;****************************************************************
  54DD'                  C      RRET:
  54DD'   E3             C          EX  (SP),HL
  54DE'   D5             C      	PUSH	DE
  54DF'   C5             C      	PUSH	BC
  54E0'   F5             C      	PUSH	AF
  54E1'   E9             C          JP  (HL)
                         C      ;****************************************************************
                         C      ;*               Register AF , BC , DE , HL laden aus SP        *
                         C      ;****************************************************************
  54E2'                  C      RLAD:
  54E2'   E3             C          EX  (SP),HL
  54E3'   33             C          INC SP
  54E4'   33             C          INC SP
  54E5'   F1             C      	POP	AF
  54E6'   C1             C      	POP	BC
  54E7'   D1             C      	POP	DE
  54E8'   E3             C          EX  (SP),HL
  54E9'   C9             C      	RET
                         C      
                         C      ;****************************************************************
                         C      ;*               Verzweigung aus Steuerteil zum Eintrittspunkt  *
                         C      ;*               des Steuerprogrammes                           *
                         C      ;****************************************************************
  54EA'                  C      KOMED:
  54EA'   F3             C      	DI
  54EB'   DD CB 00 86    C      	RES 0,(IX)
  54EF'   CD 54E2'       C      	CALL	RLAD
  54F2'   FB             C      	EI
  54F3'   C9             C      	RET
                         C          PAGE
'7-/8-Byte IO-Kommandos'	MACRO-80 3.44	09-Dec-81	PAGE	1-11


                         C      
                         C      ;****************************************************************
                         C      ;*               CRC-Zeichen berechnen                          *
                         C      ;*               <B>  = Blocklaenge , 0 = 256                   *
                         C      ;*               <HL> = Pufferadresse                           *
                         C      ;*               in  DE  nach Aufruf CRC-Zeichen                *
                         C      ;*                <D> = 1.Byte , wird zuerst gesendet           *
                         C      ;*                <E> = 2.Byte , wird danach gesendet           *
                         C      ;****************************************************************
  54F4'                  C      K1.CRC:
  54F4'   11 0000        C      	LD	DE,0
  54F7'                  C      CRC0:
  54F7'   C5             C      	PUSH	BC	;Bytelaenge
  54F8'   06 08          C      	LD	B,8
  54FA'   4E             C      	LD	C,(HL)
  54FB'                  C      CRC1:
  54FB'   79             C      	LD	A,C
  54FC'   AA             C      	XOR	D
  54FD'   0F             C      	RRCA		;Ergebnis Antivalenz Wort-Byte/CRC-Byte,Bit 0
  54FE'   F5             C      	PUSH	AF
  54FF'   CB 1B          C      	RR	E	;Verschiebung von DE um 1 Bit nach rechts
  5501'   CB 1A          C      	RR	D
  5503'   F1             C      	POP	AF	;Rueckretten F
  5504'   30 08          C      	JR	NC,CRC2	;Sprung wenn Antivalenz 0 + 0 = 0
  5506'   7A             C      	LD	A,D	;Korrektur = Umkehr Bit 13/Bit 0
  5507'   EE 01          C      	XOR	1	;Maske fuer D
  5509'   57             C      	LD	D,A	;Korrektur  D
  550A'   7B             C      	LD	A,E
  550B'   EE 20          C      	XOR	20H	;Maske fuer E
  550D'   5F             C      	LD	E,A	;Korrektur  E
  550E'                  C      CRC2:
  550E'   CB 09          C      	RRC	C	;Schieben Datenbyte
  5510'   10 E9          C      	DJNZ	CRC1
  5512'   C1             C      	POP	BC	;Byte abgearbeitet
  5513'   0B             C      	DEC	BC
  5514'   79             C      	LD	A,C
  5515'   B0             C      	OR	B
  5516'   C8             C      	RET	Z
  5517'   23             C      	INC	HL
  5518'   18 DD          C      	JR	CRC0
                         C      
                         C      ;	END
                                ;
                                ;	INCLUDE	KR.ASM	;Kassettengrundroutinen
                                ;	INCLUDE	UF.ASM	;Fehleranzeige und Behandlung
                                ;	INCLUDE	UA.ASM	;Ausschriften
                         C      	INCLUDE K2.ASM	;Grundroutinen
                         C      	TITLE	'Kassettengrundroutinen'
                         C      	PAGE
'Kassettengrundroutinen'	MACRO-80 3.44	09-Dec-81	PAGE	1-12


                         C      
                         C      ;****************************************************************
                         C      ;*               Anschlussroutinen fuer BAMOS/Emulator          *
                         C      ;* OS - Version  -----------------------------------------------*
                         C      ;*               Programmierer: Marcus Herbote                  *
                         C      ;* V 1 . 2       -----------------------------------------------*
                         C      ;*               Stand        : 18.November 2022                *
                         C      ;****************************************************************
                         C      ;	PN	KR
                         C      ;---------------------------------------------------------------------
                         C      ;        Kassettengrundroutinen
                         C      ;---------------------------------------------------------------------
  551A'   551A'          C      	DW	$
  551C'   4B 31 52 45    C      	DB	'K1RE'
  5520'                  C      KR.GR1:
  5520'   3E 01          C      	LD	A,01H
  5522'   18 08          C      	JR	KR.GR3
                         C      ;
  5524'   5524'          C      	DW	$
  5526'   4B 32 52 45    C      	DB	'K2RE'
  552A'                  C      KR.GR2:
  552A'   3E 02          C      	LD	A,02H
  552C'                  C      KR.GR3:
  552C'   CD 6D65'       C      	CALL	U1.KTINI
  552F'   DD 77 04       C      	LD	(IX+4),A
  5532'   CD 6A86'       C      	CALL	UR.KRE
  5535'   C9             C      	RET
                         C      ;-------------------------------------------------------------------
  5536'   5536'          C      	DW	$
  5538'   4B 31 4C 2B    C      	DB	'K1L+'
  553C'   CD 5520'       C      	CALL	KR.GR1
  553F'   18 09          C      	JR	$+11
                         C      ;
  5541'   5541'          C      	DW	$
  5543'   4B 32 4C 2B    C      	DB	'K2L+'
  5547'   CD 552A'       C      	CALL	KR.GR2
  554A'   21 0001        C      	LD	HL,1	; IX + 8 := 1 / Anzahl BM
  554D'   CD 6E9C'       C      	CALL	XY.STDX
  5550'   08             C      	DB	8
  5551'   CD 6A9E'       C      	CALL	UR.KLV
  5554'   C9             C      	RET
                         C      ;---------------------------------------------------------------------
  5555'   5555'          C      	DW	$
  5557'   4B 31 4C 2D    C      	DB	'K1L-'
  555B'   CD 5520'       C      	CALL	KR.GR1
  555E'   18 09          C      	JR	$+11
                         C      ;
  5560'   5560'          C      	DW	$
  5562'   4B 32 4C 2D    C      	DB	'K2L-'
  5566'   CD 552A'       C      	CALL	KR.GR2
  5569'   21 0001        C      	LD	HL,1	; IX + 8 := 1 / Anzahl BM
  556C'   CD 6E9C'       C      	CALL	XY.STDX
  556F'   08             C      	DB	8
  5570'   CD 6AA4'       C      	CALL	UR.KLR
  5573'   C9             C      	RET
                         C      ;---------------------------------------------------------------------
  5574'   5574'          C      	DW	$
  5576'   4B 31 52 2B    C      	DB	'K1R+'
  557A'   CD 5520'       C      	CALL	KR.GR1
  557D'   18 09          C      	JR	$+11
                         C      ;
  557F'   557F'          C      	DW	$
  5581'   4B 32 52 2B    C      	DB	'K2R+'
  5585'   CD 552A'       C      	CALL	KR.GR2
  5588'   CD 6AB6'       C      	CALL	UR.KBV
  558B'   C9             C      	RET
                         C      ;--------------------------------------------------------------------
  558C'   558C'          C      	DW	$
  558E'   4B 31 52 2D    C      	DB	'K1R-'
  5592'   CD 5520'       C      	CALL	KR.GR1
  5595'   18 09          C      	JR	$+11
                         C      ;
  5597'   5597'          C      	DW	$
  5599'   4B 32 52 2D    C      	DB	'K2R-'
  559D'   CD 552A'       C      	CALL	KR.GR2
  55A0'   CD 6ABC'       C      	CALL	UR.KBR
  55A3'   C9             C      	RET
                         C      ;--------------------------------------------------------------------
  55A4'   55A4'          C      	DW	$
  55A6'   4B 31 52 57    C      	DB	'K1RW'
  55AA'   CD 5520'       C      	CALL	KR.GR1
  55AD'   18 09          C      	JR	$+11
'Kassettengrundroutinen'	MACRO-80 3.44	09-Dec-81	PAGE	1-13


                         C      ;
  55AF'   55AF'          C      	DW	$
  55B1'   4B 32 52 57    C      	DB	'K2RW'
  55B5'   CD 552A'       C      	CALL	KR.GR2
  55B8'   CD 6A8E'       C      	CALL	UR.KRW
  55BB'   18 14          C      	JR	KR.CKRA
                         C      ;---------------------------------------------------------------------
  55BD'   55BD'          C      	DW	$
  55BF'   4B 31 52 41    C      	DB	'K1RA'
  55C3'   CD 5520'       C      	CALL	KR.GR1
  55C6'   18 09          C      	JR	$+11
                         C      ;
  55C8'   55C8'          C      	DW	$
  55CA'   4B 32 52 41    C      	DB	'K2RA'
  55CE'   CD 552A'       C      	CALL	KR.GR2
  55D1'                  C      KR.CKRA:
  55D1'   CD 6A98'       C      	CALL	UR.KRA
  55D4'   C9             C      	RET
                         C      ;---------------------------------------------------------------------
  55D5'                  C      KR.KARO:
  55D5'   CD 5400'       C      	CALL	UE.BRKMB	;AUFRUF PHYS.KASS.ROUTINE
  55D8'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  55D9'                  C      KR.VORSP:
  55D9'   11 3327        C      	LD	DE,UE.BWSA+327H
  55DC'   CD 6FDC'       C      	CALL	UC.CVDB
  55DF'   45             C      	LD	B,L
  55E0'   3E 46          C      	LD	A,'F'
  55E2'   32 2B1E'       C      	LD	(UB.PAR2),A
  55E5'   CD 6A86'       C      	CALL	UR.KRE
  55E8'   CD 6ACB'       C      	CALL	UR.POSIK
  55EB'   C9             C      	RET
                         C      ;---------------------------------------------------------------------
  55EC'   55EC'          C      	DW	$
  55EE'   58 4B 41 31    C      	DB	'XKA1'
  55F2'   CD 5520'       C      	CALL	KR.GR1
  55F5'   18 09          C      	JR	$+11
                         C      ;
  55F7'   55F7'          C      	DW	$
  55F9'   58 4B 41 32    C      	DB	'XKA2'
  55FD'   CD 552A'       C      	CALL	KR.GR2
  5600'   CD 55D9'       C      	CALL	KR.VORSP
  5603'   CD 5F85'       C      	CALL	FD.FDINP
  5606'   CD 6A8E'       C      	CALL	UR.KRW
  5609'   CD 6A98'       C      	CALL	UR.KRA
  560C'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  560D'   560D'          C      	DW	$
  560F'   59 4B 41 31    C      	DB	'YKA1'
  5613'   CD 5520'       C      	CALL	KR.GR1
  5616'   18 09          C      	JR	$+11
                         C      ;
  5618'   5618'          C      	DW	$
  561A'   59 4B 41 32    C      	DB	'YKA2'
  561E'   CD 552A'       C      	CALL	KR.GR2
  5621'   CD 6A86'       C      	CALL	UR.KRE
  5624'   11 3327        C      	LD	DE,UE.BWSA+327H
  5627'   CD 6FDC'       C      	CALL	UC.CVDB
  562A'   2D             C      	DEC	L
  562B'   28 09          C      	JR	Z,$+11
  562D'   DD 75 0A       C      	LD	(IX+10),L
  5630'   CD 565D'       C      	CALL	KR.TYPT
  5633'   CD 6A9E'       C      	CALL	UR.KLV
  5636'   CD 5FD8'       C      	CALL	FD.FDOUT
  5639'   C9             C      	RET
                         C      ;---------------------------------------------------------------------------
  563A'   563A'          C      	DW	$
  563C'   4B 31 43 4C    C      	DB	'K1CL'
  5640'   CD 5520'       C      	CALL	KR.GR1
  5643'   18 09          C      	JR	$+11
                         C      ;
  5645'   5645'          C      	DW	$
  5647'   4B 32 43 4C    C      	DB	'K2CL'
  564B'   CD 552A'       C      	CALL	KR.GR2
  564E'   CD 6AAA'       C      	CALL	UR.KBM
  5651'   CD 6AB0'       C      	CALL	UR.KSL
  5654'   CD 6A8E'       C      	CALL	UR.KRW
  5657'   CD 6A98'       C      	CALL	UR.KRA
  565A'   C3 000B        C      	JP	UE.SYSTB
                         C      ;--------------------------------------------------------------------
  565D'                  C      KR.TYPT:
  565D'   13             C      	INC	DE
  565E'   1A             C      	LD	A,(DE)
'Kassettengrundroutinen'	MACRO-80 3.44	09-Dec-81	PAGE	1-14


  565F'   32 2B1E'       C      	LD	(UB.PAR2),A
  5662'   C9             C      	RET
                         C      ;--------------------------------------------------------------------
                         C      ;	END
                         C      	TITLE	'Fehleranzeige und Behandlung'
                         C      	PAGE
'Fehleranzeige und Behandlung'	MACRO-80 3.44	09-Dec-81	PAGE	1-15


                         C      
                         C      ;	PN	UF
                         C      ;***************************************************************
                         C      ;
                         C      ;      Fehleranzeige  UND  BEHANDLUNG
                         C      ;
                         C      ;***************************************************************
  5663'                  C      UF.RET:
  5663'   F1             C      	POP	AF
  5664'   C1             C      	POP	BC
  5665'   D1             C      	POP	DE
  5666'   E1             C      	POP	HL
  5667'   C9             C      	RET
                         C      ;---------------------Ausfhr. Kass.kommando lt.Steuerblock-------------
  5668'                  C      UF.EXEC:
  5668'   E5             C      	PUSH	HL
  5669'   D5             C      	PUSH	DE
  566A'   C5             C      	PUSH	BC
  566B'   F5             C      	PUSH	AF
  566C'   DD CB 00 BE    C      	RES	7,(IX)
  5670'   DD 36 01 00    C      	LD	(IX+1),0
  5674'   DD 36 06 01    C      	LD	(IX+6),1	;HS-Bereich
  5678'   DD 7E 05       C      	LD	A,(IX+5)	;Kommando
  567B'   FE 71          C      	CP	071H
  567D'   28 0C          C      	JR	Z,UF.EXEC2
  567F'   FE 75          C      	CP	075H
  5681'   28 08          C      	JR	Z,UF.EXEC2
  5683'   DD 36 07 0E    C      	LD	(IX+7),HIGH(UE.PUF)
  5687'   DD 36 08 66    C      	LD	(IX+8),LOW(UE.PUF)
  568B'                  C      UF.EXEC2:	
  568B'   CD 55D5'       C      	CALL	KR.KARO
  568E'                  C      UF.EXEC1:
  568E'   DD CB 00 7E    C      	BIT	7,(IX)
  5692'   28 CF          C      	JR	Z,UF.RET
                         C      ;-------------------------Fehlerbehandlung---------------
  5694'                  C      UF.ERANZ:
  5694'   E5             C      	PUSH	HL
  5695'   D5             C      	PUSH	DE
  5696'   C5             C      	PUSH	BC
  5697'   F5             C      	PUSH	AF
  5698'   F5             C      	PUSH	AF
  5699'   3E 13          C      	LD	A,19
  569B'   32 2B00'       C      	LD	(UB.ZN),A
  569E'   21 58F7'       C      	LD	HL,UA.ZKF	;IN: <A> Fehlerschluessel
  56A1'   CD 6B2E'       C      	CALL	UR.MIMO
  56A4'   F1             C      	POP	AF
  56A5'   F5             C      	PUSH	AF
  56A6'   EB             C      	EX	DE,HL
  56A7'   CD 6F20'       C      	CALL	UC.CVBX+2
  56AA'   F1             C      	POP	AF
  56AB'   FE 17          C      	CP	17H
  56AD'   CA 572F'       C      	JP	Z,UF.FL17
  56B0'   FE 18          C      	CP	18H
  56B2'   CA 5723'       C      	JP	Z,UF.FL18
  56B5'   FE 00          C      	CP	00H
  56B7'   CA 5715'       C      	JP	Z,UF.BEHB
  56BA'   FE 11          C      	CP	11H
  56BC'   CA 5715'       C      	JP	Z,UF.BEHB
  56BF'   FE 19          C      	CP	19H
  56C1'   28 1D          C      	JR	Z,UF.AZVB
  56C3'   FE 14          C      	CP	14H
  56C5'   CA 5732'       C      	JP	Z,UF.FL14
  56C8'   FE 16          C      	CP	16H
  56CA'   CA 5735'       C      	JP	Z,UF.FL16
  56CD'   C3 5663'       C      	JP	UF.RET
                         C      ;----------------------------------------------------------------------
  56D0'                  C      UF.SYS:
  56D0'   DD 7E 01       C      	LD	A,(IX+1)
  56D3'   11 35A8        C      	LD	DE,UE.BWSA+5A8H
  56D6'   CD 6F20'       C      	CALL	UC.CVBX+2
  56D9'   00             C      	NOP
  56DA'   00             C      	NOP
  56DB'   00             C      	NOP
  56DC'                  C      UF.SYS1:
  56DC'   31 0CFE        C      	LD	SP,UE.STANF
  56DF'   C9             C      	RET
                         C      ;----------------------------------------------------------
  56E0'                  C      UF.AZVB:
  56E0'   DD CB 00 96    C      	RES	2,(IX)	;Aufzeichnen verboten
  56E4'   DD 36 05 41    C      	LD	(IX+5),41H
  56E8'   CD 55D5'       C      	CALL	KR.KARO
  56EB'   DD CB 00 7E    C      	BIT	7,(IX)
'Fehleranzeige und Behandlung'	MACRO-80 3.44	09-Dec-81	PAGE	1-16


  56EF'   20 DF          C      	JR	NZ,UF.SYS
  56F1'   21 5867'       C      	LD	HL,UA.FRZ
  56F4'   CD 6B2E'       C      	CALL	UR.MIMO
  56F7'   38 E3          C      	JR	C,UF.SYS1
  56F9'   DD 36 05 31    C      	LD	(IX+5),31H
  56FD'   CD 55D5'       C      	CALL	KR.KARO
  5700'   DD CB 00 66    C      	BIT	4,(IX)
  5704'   20 CA          C      	JR	NZ,UF.SYS
  5706'   DD CB 00 7E    C      	BIT	7,(IX)
  570A'   20 C4          C      	JR	NZ,UF.SYS
  570C'   DD CB 00 56    C      	BIT	2,(IX)
  5710'   20 BE          C      	JR	NZ,UF.SYS
  5712'   C3 571D'       C      	JP	UF.BEHB1
                         C      ;----------------------------------------------------------
  5715'                  C      UF.BEHB:
  5715'   21 5867'       C      	LD	HL,UA.FRZ
  5718'   CD 6B2E'       C      	CALL	UR.MIMO
  571B'   38 BF          C      	JR	C,UF.SYS1
  571D'                  C      UF.BEHB1:
  571D'   DD 71 05       C      	LD	(IX+5),C	;??? Inhalt von C
  5720'   C3 566C'       C      	JP	UF.EXEC+4
                         C      ;---------------------------------------
  5723'                  C      UF.FL18:
  5723'   21 586D'       C      	LD	HL,UA.BMGF
  5726'   CD 6B2E'       C      	CALL	UR.MIMO
  5729'   DA 56DC'       C      	JP	C,UF.SYS1
  572C'   C3 5663'       C      	JP	UF.RET
                         C      ;------------------------------------------
  572F'                  C      UF.FL17:
  572F'   C3 5663'       C      	JP	UF.RET
                         C      ;-------------------------------------
  5732'                  C      UF.FL14:
  5732'   C3 5663'       C      	JP	UF.RET
                         C      
  5735'                  C      UF.FL16:
  5735'   21 5867'       C      	LD	HL,UA.FRZ
  5738'   CD 6B2E'       C      	CALL	UR.MIMO
  573B'   C3 5663'       C      	JP	UF.RET
                         C      ;----------------------------------------------------------------------
                         C      ;	END
                         C          PAGE
'Fehleranzeige und Behandlung'	MACRO-80 3.44	09-Dec-81	PAGE	1-17


                         C      
                         C      ;--------------------------------------------------------------------
                         C      	TITLE	'Ausschriften'
                         C      	PAGE
'Ausschriften'	MACRO-80 3.44	09-Dec-81	PAGE	1-18


                         C      
                         C      ;	PN	UA01
                         C      ;----------------------------------------------------------------------
                         C      ;
                         C      ;     AUSSCHRIFTEN
                         C      ;
                         C      ;----------------------------------------------------------------------
  573E'                  C      UA.DS:
  573E'   00             C      	DB	0
  573F'   01             C      	DB	1
  5740'   00             C      	DB	0
  5741'   01             C      	DB	1
  5742'   20 20 44 53    C      	DB	'  DS************   '
  5746'   2A 2A 2A 2A    C      
  574A'   2A 2A 2A 2A    C      
  574E'   2A 2A 2A 2A    C      
  5752'   20 20 20       C      
  5755'   01             C      	DB	1
  5756'   00             C      	DB	0
  5757'   00             C      	DB	0
  5758'   00             C      	DB	0
  5759'   00             C      	DB	0
  575A'   00             C      	DB	0
  575B'   00             C      	DB	0
  575C'   00             C      	DB	0
  575D'   00             C      	DB	0
                         C      ;----------------------------------------------------------------------
  575E'                  C      UA.KNAME:
  575E'   06             C      	DB	06H
  575F'   10             C      	DB	16
  5760'   40             C      	DB	40H
  5761'   20 4B 61 73    C      	DB	' KassettenName: '
  5765'   73 65 74 74    C      
  5769'   65 6E 4E 61    C      
  576D'   6D 65 3A 20    C      
  5771'                  C      UA.NR:
  5771'   03             C      	DB	03H
  5772'   10             C      	DB	16
  5773'   40             C      	DB	40H
  5774'   20 4B 61 73    C      	DB	' Kassetten-Nr.: '
  5778'   73 65 74 74    C      
  577C'   65 6E 2D 4E    C      
  5780'   72 2E 3A 20    C      
  5784'                  C      UA.KOMMT:
  5784'   0B             C      	DB	0BH
  5785'   10             C      	DB	16
  5786'   80             C      	DB	80H
  5787'   20 20 20 20    C      	DB	'     Kommentar: '
  578B'   20 4B 6F 6D    C      
  578F'   6D 65 6E 74    C      
  5793'   61 72 3A 20    C      
                         C      ;----------------------------------------------------------------------
  5797'                  C      UA.Z7E:
  5797'   45 69 6E 67    C      	DB	'Eingabe      =====>     Ausgabe'
  579B'   61 62 65 20    C      
  579F'   20 20 20 20    C      
  57A3'   20 3D 3D 3D    C      
  57A7'   3D 3D 3E 20    C      
  57AB'   20 20 20 20    C      
  57AF'   41 75 73 67    C      
  57B3'   61 62 65       C      
  57B6'                  C      UA.GER:
  57B6'   20 20 20 20    C      	DB	'       Geraet: '
  57BA'   20 20 20 47    C      
  57BE'   65 72 61 65    C      
  57C2'   74 3A 20       C      
                         C      ;----------------------------------------------------------------------
  57C5'                  C      UA.KOPFR:
  57C5'   01             C      	DB	01H
  57C6'   33             C      	DB	51
  57C7'   80             C      	DB	80H
  57C8'   20 20 20 20    C      	DB	'                Datei               kopieren J/N ? '
  57CC'   20 20 20 20    C      
  57D0'   20 20 20 20    C      
  57D4'   20 20 20 20    C      
  57D8'   44 61 74 65    C      
  57DC'   69 20 20 20    C      
  57E0'   20 20 20 20    C      
  57E4'   20 20 20 20    C      
  57E8'   20 20 20 20    C      
  57EC'   6B 6F 70 69    C      
  57F0'   65 72 65 6E    C      
'Ausschriften'	MACRO-80 3.44	09-Dec-81	PAGE	1-19


  57F4'   20 4A 2F 4E    C      
  57F8'   20 3F 20       C      
  57FB'                  C      UA.EABFR:
  57FB'   01             C      	DB	01H
  57FC'   33             C      	DB	51
  57FD'   80             C      	DB	80H
  57FE'   20 20 20 20    C      	DB	'                Eingaben in Ordnung  ---->   J/N ? '
  5802'   20 20 20 20    C      
  5806'   20 20 20 20    C      
  580A'   20 20 20 20    C      
  580E'   45 69 6E 67    C      
  5812'   61 62 65 6E    C      
  5816'   20 69 6E 20    C      
  581A'   4F 72 64 6E    C      
  581E'   75 6E 67 20    C      
  5822'   20 2D 2D 2D    C      
  5826'   2D 3E 20 20    C      
  582A'   20 4A 2F 4E    C      
  582E'   20 3F 20       C      
  5831'                  C      UA.VORH:
  5831'   01             C      	DB	1
  5832'   33             C      	DB	51
  5833'   80             C      	DB	80H
  5834'   2A 2A 2A 2A    C      	DB	'************* Datei vorh.;SYS-Ende,kopieren  J/N ? '
  5838'   2A 2A 2A 2A    C      
  583C'   2A 2A 2A 2A    C      
  5840'   2A 20 44 61    C      
  5844'   74 65 69 20    C      
  5848'   76 6F 72 68    C      
  584C'   2E 3B 53 59    C      
  5850'   53 2D 45 6E    C      
  5854'   64 65 2C 6B    C      
  5858'   6F 70 69 65    C      
  585C'   72 65 6E 20    C      
  5860'   20 4A 2F 4E    C      
  5864'   20 3F 20       C      
                         C      ;----------------------------------------------------------------------
  5867'                  C      UA.FRZ:
  5867'   02             C      	DB	2
  5868'   03             C      	DB	3
  5869'   80             C      	DB	80H
  586A'   3F 3F 20       C      	DB	'?? '
  586D'                  C      UA.BMGF:
  586D'   01             C      	DB	01H
  586E'   07             C      	DB	7
  586F'   80             C      	DB	80H
  5870'   42 4D 20 21    C      	DB	'BM ! ??'
  5874'   20 3F 3F       C      
  5877'                  C      UA.DOK:
  5877'   00             C      	DB	0
  5878'   04             C      	DB	4
  5879'   80             C      	DB	80H
  587A'   69 2E 4F 2E    C      	DB	'i.O.'
  587E'                  C      UA.DF:
  587E'   00             C      	DB	0
  587F'   04             C      	DB	4
  5880'   80             C      	DB	80H
  5881'   46 68 6C 2E    C      	DB	'Fhl.'
                         C      ;----------------------------------------------------------------------
  5885'                  C      UA.ZKDAT:
  5885'   06             C      	DB	6
  5886'   10             C      	DB	16
  5887'   40             C      	DB	40H
  5888'   20 20 20 20    C      	DB	'     Dateiname: '
  588C'   20 44 61 74    C      
  5890'   65 69 6E 61    C      
  5894'   6D 65 3A 20    C      
  5898'                  C      UA.ZKLAD:
  5898'   04             C      	DB	4
  5899'   10             C      	DB	16
  589A'   08             C      	DB	08H
  589B'   20 20 20 4C    C      	DB	'   Ladeadresse: '
  589F'   61 64 65 61    C      
  58A3'   64 72 65 73    C      
  58A7'   73 65 3A 20    C      
                         C      ;------------------------------------------------------------------
  58AB'                  C      UA.ZKBEG:
  58AB'   04             C      	DB	4
  58AC'   10             C      	DB	16
  58AD'   08             C      	DB	08H
  58AE'   20 20 20 20    C      	DB	'        Beginn: '
  58B2'   20 20 20 20    C      
  58B6'   42 65 67 69    C      
'Ausschriften'	MACRO-80 3.44	09-Dec-81	PAGE	1-20


  58BA'   6E 6E 3A 20    C      
  58BE'                  C      UA.ZKEND:
  58BE'   04             C      	DB	4
  58BF'   10             C      	DB	16
  58C0'   08             C      	DB	08H
  58C1'   20 20 20 20    C      	DB	'          Ende: '
  58C5'   20 20 20 20    C      
  58C9'   20 20 45 6E    C      
  58CD'   64 65 3A 20    C      
  58D1'                  C      UA.STADR:
  58D1'   04             C      	DB	4
  58D2'   10             C      	DB	16
  58D3'   08             C      	DB	08H
  58D4'   20 20 53 74    C      	DB	'  Startadresse: '
  58D8'   61 72 74 61    C      
  58DC'   64 72 65 73    C      
  58E0'   73 65 3A 20    C      
  58E4'                  C      UA.ZKDL:
  58E4'   01             C      	DB	1
  58E5'   10             C      	DB	16
  58E6'   20             C      	DB	20H
  58E7'   20 4C 6F 65    C      	DB	' Loeschen J/N : '
  58EB'   73 63 68 65    C      
  58EF'   6E 20 4A 2F    C      
  58F3'   4E 20 3A 20    C      
  58F7'                  C      UA.ZKF:
  58F7'   00             C      	DB	0
  58F8'   08             C      	DB	8
  58F9'   00             C      	DB	0
  58FA'   46 65 68 6C    C      	DB	'Fehler: '
  58FE'   65 72 3A 20    C      
                         C      ;----------------------------------------------------------------------
  5902'                  C      UA.ZKRES:
  5902'   03             C      	DB	3
  5903'   10             C      	DB	16
  5904'   10             C      	DB	10H
  5905'   52 65 73 65    C      	DB	'Reservebloecke: '
  5909'   72 76 65 62    C      
  590D'   6C 6F 65 63    C      
  5911'   6B 65 3A 20    C      
  5915'                  C      UA.ZKSDT:
  5915'   04             C      	DB	4
  5916'   12             C      	DB	18
  5917'   40             C      	DB	40H
  5918'   20 20 20 20    C      	DB	'     Dateiname:   '
  591C'   20 44 61 74    C      
  5920'   65 69 6E 61    C      
  5924'   6D 65 3A 20    C      
  5928'   20 20          C      
  592A'                  C      UA.ZKBEL:
  592A'   00             C      	DB	0
  592B'   10             C      	DB	16
  592C'   00             C      	DB	0
  592D'   42 6C 6F 65    C      	DB	'Bloecke belegt: '
  5931'   63 6B 65 20    C      
  5935'   62 65 6C 65    C      
  5939'   67 74 3A 20    C      
  593D'                  C      UA.ZKBLG:
  593D'   00             C      	DB	0
  593E'   10             C      	DB	16
  593F'   00             C      	DB	0
  5940'   42 6C 6F 65    C      	DB	'Bloecke gesamt: '
  5944'   63 6B 65 20    C      
  5948'   67 65 73 61    C      
  594C'   6D 74 3A 20    C      
                         C      ;----------------------------------------------------------------------
  5950'                  C      UA.ZKBM:
  5950'   42 61 6E 64    C      	DB	'Bandmarke'
  5954'   6D 61 72 6B    C      
  5958'   65             C      
                         C      ;----------------------------------------------------------------------
  5959'                  C      UA.LD:
  5959'   26             C      	DB	38
  595A'   0F             C      	DB	15
  595B'   80             C      	DB	80H
  595C'   20 20 20 20    C      	DB	'               '
  5960'   20 20 20 20    C      
  5964'   20 20 20 20    C      
  5968'   20 20 20       C      
  596B'                  C      UA.ZRSCH:
  596B'   01             C      	DB	1
  596C'   16             C      	DB	22
  596D'   80             C      	DB	80H
'Ausschriften'	MACRO-80 3.44	09-Dec-81	PAGE	1-21


  596E'   56 65 72 7A    C      	DB	'Verz. schreiben J/N ? '
  5972'   2E 20 73 63    C      
  5976'   68 72 65 69    C      
  597A'   62 65 6E 20    C      
  597E'   4A 2F 4E 20    C      
  5982'   3F 20          C      
  5984'                  C      UA.ANZWD:
  5984'   01             C      	DB	1
  5985'   16             C      	DB	22
  5986'   80             C      	DB	80H
  5987'   41 6E 7A 65    C      	DB	'Anzeige wdhln.  J/N ? '
  598B'   69 67 65 20    C      
  598F'   77 64 68 6C    C      
  5993'   6E 2E 20 20    C      
  5997'   4A 2F 4E 20    C      
  599B'   3F 20          C      
                         C      ;----------------------------------------------------------------------
  599D'                  C      UA.ALTR:
  599D'   20 41 55 53    C      	DB	' AUSGLEICH LAUFWERKSTOLERANZEN  '
  59A1'   47 4C 45 49    C      
  59A5'   43 48 20 4C    C      
  59A9'   41 55 46 57    C      
  59AD'   45 52 4B 53    C      
  59B1'   54 4F 4C 45    C      
  59B5'   52 41 4E 5A    C      
  59B9'   45 4E 20 20    C      
                         C      ;----------------------------------------------------------------------
                         C      ;	END
                                ;
                                ;	INCLUDE	KI.ASM	;Initialisieren von MRES Kassetten
                                ;	INCLUDE	KV.ASM	;Anzeigen und Aendern des MRES-Verzeichnisses
                                ;	INCLUDE	KH.ASM	;Kommandos: KRDx und KWRx
                                ;	INCLUDE	FD.ASM	;Ein-/Ausgabe im freien Format
                                ;	INCLUDE LD.ASM	;Laden von MRES-P-Dateien
                                ;	INCLUDE RL.ASM	;Relativloader fuer O-Dateien
                                ;	INCLUDE SV.ASM	;Retten von Maschinencodeprogrammen als MRES - P-Datei
                         C      	INCLUDE K3.ASM	;MRES Routinen
                         C      	TITLE	'Initialisieren von MRES Kassetten'
                         C      	PAGE
'Initialisieren von MRES Kassetten'	MACRO-80 3.44	09-Dec-81	PAGE	1-22


                         C      
                         C      ;	PN	KI
                         C      ;----------------------------------------------------------------------
                         C      ;
                         C      ;      INITIALISIEREN VON MRES KASSETTEN
                         C      ;
                         C      ;----------------------------------------------------------------------
  59BD'   59BD'          C      	DW	$
  59BF'   49 4E 49 54    C      	DB	'INIT'
  59C3'   21 4070        C      	LD	HL,PUF.KASS	;Puffer fC<r Umbenennung Kassette lC6schen
  59C6'   11 4071        C      	LD	DE,PUF.KASS+1
  59C9'   01 000F        C      	LD	BC,15
  59CC'   36 20          C      	LD	(HL),020H
  59CE'   ED B0          C      	LDIR
  59D0'   3A 3327        C      	LD	A,(UE.BWSA+327H)
  59D3'   CD 6E40'       C      	CALL	U1.TST
  59D6'   D8             C      	RET	C
  59D7'   F5             C      	PUSH	AF
  59D8'   CD 6D65'       C      	CALL	U1.KTINI
  59DB'   F1             C      	POP	AF
  59DC'   DD 77 04       C      	LD	(IX+4),A	;GERAETEADR. -->TAB
  59DF'   CD 6A86'       C      	CALL	UR.KRE	;RES. EIN
  59E2'   DD CB 00 56    C      	BIT	2,(IX)
  59E6'   28 05          C      	JR	Z,$+7
  59E8'   3E 19          C      	LD	A,19H
  59EA'   CD 5694'       C      	CALL	UF.ERANZ
  59ED'   CD 6A94'       C      	CALL	UR.KRWW	;RUECKSPULEN MIT WARTEN
  59F0'   CD 6AAA'       C      	CALL	UR.KBM	;BM SCHREIBEN
  59F3'   21 0E66        C      	LD	HL,UE.PUF	;AUFBAU 1.BLOCK
  59F6'   3E 40          C      	LD	A,40H
  59F8'   06 50          C      	LD	B,80
  59FA'   CD 6E21'       C      	CALL	U1.TR
  59FD'   3E 00          C      	LD	A,00H
  59FF'   06 30          C      	LD	B,48
  5A01'   CD 6E21'       C      	CALL	U1.TR
  5A04'   DD 36 02 80    C      	LD	(IX+2),80H
  5A08'   DD 36 05 08    C      	LD	(IX+5),08H	;CMD SCHREIBEN
  5A0C'   CD 5668'       C      	CALL	UF.EXEC
  5A0F'   CD 5AB8'       C      	CALL	KI.KO03
  5A12'                  C      KI.KN:
  5A12'   CD 6E2C'       C      	CALL	U1.BILO
  5A15'   3E 0D          C      	LD	A,13
  5A17'   32 2B00'       C      	LD	(UB.ZN),A	;ZEILENNR. 15
  5A1A'   21 575E'       C      	LD	HL,UA.KNAME	;ABFRAGE KASS.NAME
  5A1D'   CD 6B2E'       C      	CALL	UR.MIMO
  5A20'   D8             C      	RET	C
  5A21'   E5             C      	PUSH	HL
  5A22'   C5             C      	PUSH	BC
  5A23'   11 4070        C      	LD	DE,PUF.KASS
  5A26'   01 0006        C      	LD	BC,6
  5A29'   ED B0          C      	LDIR
  5A2B'   C1             C      	POP	BC
  5A2C'   E1             C      	POP	HL
  5A2D'   06 06          C      	LD	B,6
  5A2F'   11 0E6A        C      	LD	DE,UE.PUF+4	;NAME IN PUFFER
  5A32'   CD 7035'       C      	CALL	UC.KONV	;MIT KONVERTIERUNG IN DKOI-CODE
  5A35'                  C      KI.NMR:
  5A35'   21 5771'       C      	LD	HL,UA.NR	;ABFR. KASS.NUMMER
  5A38'   CD 6B2E'       C      	CALL	UR.MIMO
  5A3B'   38 D5          C      	JR	C,KI.KN	;BEI SYS-TASTE ZU VORHERIGER
  5A3D'   E5             C      	PUSH	HL
  5A3E'   C5             C      	PUSH	BC
  5A3F'   11 4076        C      	LD	DE,PUF.KASS+6
  5A42'   01 0003        C      	LD	BC,3
  5A45'   ED B0          C      	LDIR
  5A47'   C1             C      	POP	BC
  5A48'   E1             C      	POP	HL
  5A49'   06 03          C      	LD	B,3
  5A4B'   11 0E8B        C      	LD	DE,UE.PUF+37
  5A4E'   CD 7035'       C      	CALL	UC.KONV
  5A51'                  C      KI.KM:
  5A51'   21 5784'       C      	LD	HL,UA.KOMMT	;ABFR. KOMMENTAR
  5A54'   CD 6B2E'       C      	CALL	UR.MIMO
  5A57'   38 B9          C      	JR	C,KI.KN
  5A59'   06 0B          C      	LD	B,11
  5A5B'   11 0E8E        C      	LD	DE,UE.PUF+40
  5A5E'   CD 7035'       C      	CALL	UC.KONV
  5A61'   CD 5668'       C      	CALL	UF.EXEC	;3.BLOCK SCHREIBEN
  5A64'   CD 5AC3'       C      	CALL	KI.RENA	;Kassette umbenennen
  5A67'   CD 6AAA'       C      	CALL	UR.KBM	;BM , 1.LABEL BEENDET
  5A6A'   21 599D'       C      	LD	HL,UA.ALTR
  5A6D'   11 0E66        C      	LD	DE,UE.PUF
'Initialisieren von MRES Kassetten'	MACRO-80 3.44	09-Dec-81	PAGE	1-23


  5A70'   01 0020        C      	LD	BC,20H
  5A73'   ED B0          C      	LDIR		;AUSGLEICH LFWSTLNZ->PUFFER
  5A75'   DD 36 02 20    C      	LD	(IX+2),20H	;NEUE BLOCKLAENGE
  5A79'   DD 36 05 08    C      	LD	(IX+5),08H
  5A7D'   CD 5668'       C      	CALL	UF.EXEC	;SCHREIBEN
  5A80'   21 573E'       C      	LD	HL,UA.DS
  5A83'   11 0E66        C      	LD	DE,UE.PUF
  5A86'   01 0020        C      	LD	BC,32
  5A89'   ED B0          C      	LDIR		;DS-SATZ --> PUFFER
  5A8B'   CD 5668'       C      	CALL	UF.EXEC
  5A8E'   3E A5          C      	LD	A,0A5H
  5A90'   06 20          C      	LD	B,32
  5A92'   21 0E66        C      	LD	HL,UE.PUF
  5A95'   CD 6E21'       C      	CALL	U1.TR
  5A98'   06 68          C      	LD	B,68H	;103 VERZ.SAETZE
  5A9A'                  C      KI.VERZ:
  5A9A'   C5             C      	PUSH	BC
  5A9B'   CD 5668'       C      	CALL	UF.EXEC
  5A9E'   C1             C      	POP	BC
  5A9F'   10 F9          C      	DJNZ	KI.VERZ
  5AA1'   CD 6AAA'       C      	CALL	UR.KBM
  5AA4'   CD 6D02'       C      	CALL	U1.VS1	;1.DATEIVORSATZ -->PUFFER
  5AA7'   DD 36 05 08    C      	LD	(IX+5),08H
  5AAB'   CD 5668'       C      	CALL	UF.EXEC
  5AAE'   CD 6AB0'       C      	CALL	UR.KSL	;SCHLUSSLUECKE SCHREIBEN
  5AB1'   CD 6A8E'       C      	CALL	UR.KRW
  5AB4'   CD 6A98'       C      	CALL	UR.KRA
  5AB7'   C9             C      	RET
                         C      ;
  5AB8'                  C      KI.KO03:
  5AB8'   CD 5668'       C      	CALL	UF.EXEC	;FUER KI14
  5ABB'   06 31          C      	LD	B,49
  5ABD'   2B             C      	DEC	HL
  5ABE'   10 FD          C      	DJNZ	$-1
  5AC0'   36 D9          C      	LD	(HL),0D9H
  5AC2'   C9             C      	RET
                         C      ;
  5AC3'                  C      KI.RENA:	;Kassettendateiname umbenennen
  5AC3'   E5             C      	PUSH	HL
  5AC4'   D5             C      	PUSH	DE
  5AC5'   C5             C      	PUSH	BC
  5AC6'   F5             C      	PUSH	AF
  5AC7'   21 407A        C      	LD	HL,PUF.KASS+10
  5ACA'   36 00          C      	LD	(HL),0	;AbschluC neuer Name
  5ACC'   21 5AE2'       C      	LD	HL,KI.RENA9+2
  5ACF'   DD 7E 04       C      	LD	A,(IX+4)	;SubAdresse
  5AD2'   77             C      	LD	(HL),A
  5AD3'   21 5AE0'       C      	LD	HL,KI.RENA9
  5AD6'   01 0730        C      	LD	BC,00730H	;AKB-Adresse + LC$nge Parameterbereich
  5AD9'   ED B3          C      	OTIR
  5ADB'   F1             C      	POP	AF
  5ADC'   C1             C      	POP	BC
  5ADD'   D1             C      	POP	DE
  5ADE'   E1             C      	POP	HL
  5ADF'   C9             C      	RET
  5AE0'                  C      KI.RENA9:
  5AE0'   F0             C      	DB	0F0H
  5AE1'   44             C      	DB	044H	;Kommando
  5AE2'   00             C      	DB	0		;SubAdresse
  5AE3'   01             C      	DB	1		;HSbereich
  5AE4'   40             C      	DB	HIGH(PUF.KASS)
  5AE5'   70             C      	DB	LOW(PUF.KASS)
  5AE6'   FF             C      	DB	0FFH
                         C      ;---------------------------------------------------------------------
                         C      ;	END
                         C      	TITLE	'Anzeigen und Aendern des MRES-Verzeichnisses'
                         C      	PAGE
'Anzeigen und Aendern des MRES-Verzeichnisses'	MACRO-80 3.44	09-Dec-81	PAGE	1-24


                         C      
                         C      ;	PN	KV
                         C      ;----------------------------------------------------------------------
                         C      ;
                         C      ;    ANZEIGEN UND AENDERN DES VERZEICHNISSES VON MRES KASSETTEN
                         C      ;
                         C      ;----------------------------------------------------------------------
  5AE7'   5AE7'          C      	DW	$
  5AE9'   44 49 52 20    C      	DB	'DIR '
  5AED'   3A 3326        C      	LD	A,(UE.BWSA+326H)
  5AF0'   CD 6E40'       C      	CALL	U1.TST
  5AF3'   D8             C      	RET	C
  5AF4'   CD 6D65'       C      	CALL	U1.KTINI
  5AF7'   DD 77 04       C      	LD	(IX+4),A
  5AFA'   CD 6E2C'       C      	CALL	U1.BILO
  5AFD'   CD 6A86'       C      	CALL	UR.KRE
  5B00'   CD 6A94'       C      	CALL	UR.KRWW
  5B03'   CD 6D19'       C      	CALL	U1.DSVG
  5B06'   C5             C      	PUSH	BC
                         C      ;----------------------------------------------------------------------
  5B07'   CD 6CA2'       C      	CALL	U1.KBR4	;KASS.NAME,NR.,KOMMENTAR ANZEIGEN
  5B0A'   DD 36 05 02    C      	LD	(IX+5),02H
  5B0E'   CD 5668'       C      	CALL	UF.EXEC
  5B11'   21 0E6A        C      	LD	HL,UE.PUF+4
  5B14'   11 3240        C      	LD	DE,3240H	;=8.ZEILE,16.SPALTE
  5B17'   06 06          C      	LD	B,6
  5B19'   CD 702B'       C      	CALL	UC.DKONV
  5B1C'   21 0E8B        C      	LD	HL,UE.PUF+37
  5B1F'   13             C      	INC	DE
  5B20'   13             C      	INC	DE
  5B21'   06 03          C      	LD	B,3
  5B23'   CD 702B'       C      	CALL	UC.DKONV
  5B26'   13             C      	INC	DE
  5B27'   13             C      	INC	DE
  5B28'   06 0B          C      	LD	B,11
  5B2A'   CD 702B'       C      	CALL	UC.DKONV
  5B2D'   21 3290        C      	LD	HL,3290H
  5B30'   3E 3D          C      	LD	A,'='
  5B32'   77             C      	LD	(HL),A
  5B33'   E5             C      	PUSH	HL
  5B34'   D1             C      	POP	DE
  5B35'   13             C      	INC	DE
  5B36'   01 0017        C      	LD	BC,23
  5B39'   ED B0          C      	LDIR
                         C      ;----------------------------------------------------------------------
  5B3B'   06 03          C      	LD	B,3	;POSITIONIEREN VOR DS-SATZ
  5B3D'   CD 5668'       C      	CALL	UF.EXEC
  5B40'   10 FB          C      	DJNZ	$-3
  5B42'   CD 6D93'       C      	CALL	U1.VERIN
  5B45'   CD 6A94'       C      	CALL	UR.KRWW
  5B48'   06 07          C      	LD	B,7
  5B4A'   CD 6DBD'       C      	CALL	U1.VORS1
  5B4D'   C1             C      	POP	BC
  5B4E'   05             C      	DEC	B
  5B4F'   CD 5D7C'       C      	CALL	KV.ANZ
  5B52'   04             C      	INC	B
  5B53'   05             C      	DEC	B
  5B54'   CA 5C9E'       C      	JP	Z,KV.KRW
  5B57'   04             C      	INC	B
  5B58'   C5             C      	PUSH	BC
                         C      ;----------------------------------------------------------------------
  5B59'                  C      KV.ANF:
  5B59'   05             C      	DEC	B
  5B5A'   78             C      	LD	A,B
  5B5B'   58             C      	LD	E,B
  5B5C'   D6 09          C      	SUB	9
  5B5E'   38 05          C      	JR	C,$+7
  5B60'   0E 09          C      	LD	C,9
  5B62'   41             C      	LD	B,C
  5B63'   18 03          C      	JR	$+5
  5B65'   43             C      	LD	B,E
  5B66'   48             C      	LD	C,B
  5B67'   AF             C      	XOR	A
  5B68'   F5             C      	PUSH	AF	;A=RESTL.ANZAHL ODER 0
  5B69'   C5             C      	PUSH	BC
  5B6A'   21 2B2A'       C      	LD	HL,UB.SATZ
  5B6D'   36 00          C      	LD	(HL),00H
  5B6F'   23             C      	INC	HL
  5B70'   36 37          C      	LD	(HL),55
  5B72'   23             C      	INC	HL
  5B73'   36 80          C      	LD	(HL),80H
  5B75'   23             C      	INC	HL
'Anzeigen und Aendern des MRES-Verzeichnisses'	MACRO-80 3.44	09-Dec-81	PAGE	1-25


  5B76'   06 37          C      	LD	B,55
  5B78'   3E 20          C      	LD	A,20H
  5B7A'   CD 6E21'       C      	CALL	U1.TR	;AUSGABESATZ LOESCHEN
  5B7D'   3E 0D          C      	LD	A,13
  5B7F'   32 2B00'       C      	LD	(UB.ZN),A
  5B82'   CD 6E2C'       C      	CALL	U1.BILO
  5B85'   11 2B3C'       C      	LD	DE,UB.SATZ+18
  5B88'   D5             C      	PUSH	DE
  5B89'   21 ECA2        C      	LD	HL,BC.VTABE+32	;ADR. VERZ.TABELLE
  5B8C'   E5             C      	PUSH	HL
                         C      ;---------------------------MAX 9 SAETZE ANZEIGEN----------------------
  5B8D'                  C      KV.ZLTR:
  5B8D'   CD 5D04'       C      	CALL	KV.BSTR	;VTABE-->UB.SATZ
  5B90'   D1             C      	POP	DE	;VERZ.ADR.
  5B91'   E1             C      	POP	HL	;ADR.AUSGABESATZ
  5B92'   E5             C      	PUSH	HL
  5B93'   D5             C      	PUSH	DE
  5B94'   01 0012        C      	LD	BC,18
  5B97'   B7             C      	OR	A
  5B98'   ED 42          C      	SBC	HL,BC
  5B9A'   CD 6B2E'       C      	CALL	UR.MIMO	;ANZEIGE EINE ZEILE
  5B9D'   E1             C      	POP	HL	;VERZ.ADR
  5B9E'   D1             C      	POP	DE
  5B9F'   01 0020        C      	LD	BC,32
  5BA2'   09             C      	ADD	HL,BC
  5BA3'   C1             C      	POP	BC
  5BA4'   05             C      	DEC	B
  5BA5'   28 05          C      	JR	Z,$+7
  5BA7'   C5             C      	PUSH	BC
  5BA8'   D5             C      	PUSH	DE
  5BA9'   E5             C      	PUSH	HL	;NEUE VERZ.TAB ADR
  5BAA'   18 E1          C      	JR	KV.ZLTR
                         C      ;----------------------------------------------------------------------
  5BAC'   41             C      	LD	B,C	;ANZAHL DER ANGEZEIGTEN ZEILEN
  5BAD'   3A 2B00'       C      	LD	A,(UB.ZN)
  5BB0'   90             C      	SUB	B
  5BB1'   32 2B00'       C      	LD	(UB.ZN),A	;KURSOR AUF ANFANG 12.ZEILE
  5BB4'   C5             C      	PUSH	BC
  5BB5'   D5             C      	PUSH	DE
  5BB6'   E5             C      	PUSH	HL
                         C      ;------------------------VERZ. ZEIGER AUF 1.ANGEZEIGTE EINTR.
  5BB7'   C5             C      	PUSH	BC
  5BB8'   01 0020        C      	LD	BC,32
  5BBB'   B7             C      	OR	A
  5BBC'   ED 42          C      	SBC	HL,BC
  5BBE'   C1             C      	POP	BC
  5BBF'   10 F6          C      	DJNZ	$-8
  5BC1'   E5             C      	PUSH	HL
                         C      ;----------------------------------------------------------------------
  5BC2'                  C      KV.TABTR:
  5BC2'   21 5959'       C      	LD	HL,UA.LD
  5BC5'   CD 6B2E'       C      	CALL	UR.MIMO	;KURSOR AUF ANF.12.ZEILE
  5BC8'   DA 5C08'       C      	JP	C,KV.ZEIHO
  5BCB'   D1             C      	POP	DE
  5BCC'   D5             C      	PUSH	DE	;ZIELADR.IN VTAB
  5BCD'   CD 5D31'       C      	CALL	KV.SPTR	;ZEILE WIEDER IN SPEICHER
  5BD0'   E1             C      	POP	HL	;ZIELADR.IN VTAB
  5BD1'   01 0020        C      	LD	BC,32
  5BD4'   09             C      	ADD	HL,BC
  5BD5'   FD E1          C      	POP	IY
  5BD7'   D1             C      	POP	DE
  5BD8'   C1             C      	POP	BC
  5BD9'   05             C      	DEC	B
  5BDA'   28 07          C      	JR	Z,$+9
  5BDC'   C5             C      	PUSH	BC
  5BDD'   D5             C      	PUSH	DE
  5BDE'   FD E5          C      	PUSH	IY
  5BE0'   E5             C      	PUSH	HL
  5BE1'   18 DF          C      	JR	KV.TABTR
                         C      ;--------------------WEITERBLAETTERN ODER AUSGABE----------------------
  5BE3'   F1             C      	POP	AF
  5BE4'   B7             C      	OR	A
  5BE5'   28 42          C      	JR	Z,KV.AUSG	;KEINE WEITEREN ANZEIGEN
  5BE7'   D6 09          C      	SUB	9
  5BE9'   38 05          C      	JR	C,$+7
  5BEB'   06 09          C      	LD	B,9
  5BED'   48             C      	LD	C,B
  5BEE'   18 05          C      	JR	$+7
  5BF0'   C6 09          C      	ADD	A,9
  5BF2'   47             C      	LD	B,A
  5BF3'   48             C      	LD	C,B
  5BF4'   AF             C      	XOR	A
  5BF5'   F5             C      	PUSH	AF
'Anzeigen und Aendern des MRES-Verzeichnisses'	MACRO-80 3.44	09-Dec-81	PAGE	1-26


  5BF6'   C5             C      	PUSH	BC
  5BF7'   D5             C      	PUSH	DE
  5BF8'   E5             C      	PUSH	HL
  5BF9'   3E 0D          C      	LD	A,13
  5BFB'   32 2B00'       C      	LD	(UB.ZN),A
  5BFE'   CD 6E2C'       C      	CALL	U1.BILO
  5C01'   E1             C      	POP	HL
  5C02'   D1             C      	POP	DE
  5C03'   D5             C      	PUSH	DE
  5C04'   E5             C      	PUSH	HL
  5C05'   C3 5B8D'       C      	JP	KV.ZLTR
                         C      ;----------------------------------------------------------------------
  5C08'                  C      KV.ZEIHO:
  5C08'   21 2B00'       C      	LD	HL,UB.ZN
  5C0B'   7E             C      	LD	A,(HL)
  5C0C'   D6 0F          C      	SUB	15
  5C0E'   38 15          C      	JR	C,$+23	;WENN IN 12. ZEILE SYS GEDRUECKT
  5C10'   35             C      	DEC	(HL)
  5C11'   35             C      	DEC	(HL)	;ZEILENNR.-2
  5C12'   E1             C      	POP	HL
  5C13'   01 0020        C      	LD	BC,32
  5C16'   B7             C      	OR	A
  5C17'   ED 42          C      	SBC	HL,BC	;VERZ.ZEIGER RUECKSETZEN
  5C19'   FD E1          C      	POP	IY
  5C1B'   D1             C      	POP	DE
  5C1C'   C1             C      	POP	BC
  5C1D'   04             C      	INC	B
  5C1E'   C5             C      	PUSH	BC
  5C1F'   D5             C      	PUSH	DE
  5C20'   FD E5          C      	PUSH	IY
  5C22'   E5             C      	PUSH	HL
  5C23'   18 01          C      	JR	$+3
  5C25'   35             C      	DEC	(HL)
  5C26'   C3 5BC2'       C      	JP	KV.TABTR
                         C      ;----------------------------------------------------------------------
  5C29'                  C      KV.AUSG:
  5C29'   E5             C      	PUSH	HL
  5C2A'   21 596B'       C      	LD	HL,UA.ZRSCH
  5C2D'   CD 6B2E'       C      	CALL	UR.MIMO
  5C30'   7E             C      	LD	A,(HL)
  5C31'   E1             C      	POP	HL
  5C32'   FE 4A          C      	CP	'J'
  5C34'   28 11          C      	JR	Z,$+19
  5C36'   21 5984'       C      	LD	HL,UA.ANZWD
  5C39'   CD 6B2E'       C      	CALL	UR.MIMO
  5C3C'   7E             C      	LD	A,(HL)
  5C3D'   FE 4A          C      	CP	'J'
  5C3F'   C1             C      	POP	BC
  5C40'   C2 5C9E'       C      	JP	NZ,KV.KRW
  5C43'   C5             C      	PUSH	BC
  5C44'   C3 5B59'       C      	JP	KV.ANF
                         C      ;--------------------------------Dateien am Ende loeschen ? ---------
  5C47'   CD 5D72'       C      	CALL	KV.SBC
  5C4A'   20 34          C      	JR	NZ,$+54
  5C4C'   3A EC85        C      	LD	A,(BC.VTABE+3)
  5C4F'   3D             C      	DEC	A
  5C50'   5F             C      	LD	E,A
  5C51'   16 00          C      	LD	D,0
  5C53'   3E 01          C      	LD	A,1
  5C55'   82             C      	ADD	A,D
  5C56'   57             C      	LD	D,A
  5C57'   1D             C      	DEC	E
  5C58'   28 05          C      	JR	Z,$+7
  5C5A'   CD 5D72'       C      	CALL	KV.SBC
  5C5D'   28 F4          C      	JR	Z,$-10
  5C5F'   C1             C      	POP	BC	;D: Anzahl zu loeschender Dateien
  5C60'   79             C      	LD	A,C
  5C61'   92             C      	SUB	D
  5C62'   32 0E67        C      	LD	(UE.PUF+1),A	;DS-Satz korrigieren
  5C65'   78             C      	LD	A,B
  5C66'   92             C      	SUB	D
  5C67'   32 0E69        C      	LD	(UE.PUF+3),A
  5C6A'   CD 6ABC'       C      	CALL	UR.KBR
  5C6D'   CD 6ABC'       C      	CALL	UR.KBR
  5C70'   CD 6AB6'       C      	CALL	UR.KBV
  5C73'   DD 36 05 08    C      	LD	(IX+5),08H
  5C77'   CD 5668'       C      	CALL	UF.EXEC	;und schreiben
  5C7A'   47             C      	LD	B,A
  5C7B'   05             C      	DEC	B
  5C7C'   28 20          C      	JR	Z,$+34
  5C7E'   04             C      	INC	B
  5C7F'   C5             C      	PUSH	BC
                         C      ;-------------------------------------Verzeichnis schreiben -----------
'Anzeigen und Aendern des MRES-Verzeichnisses'	MACRO-80 3.44	09-Dec-81	PAGE	1-27


  5C80'   C1             C      	POP	BC
  5C81'   05             C      	DEC	B
  5C82'   21 ECA2        C      	LD	HL,BC.VTABE+32
  5C85'   C5             C      	PUSH	BC
  5C86'   11 0E66        C      	LD	DE,UE.PUF
  5C89'   01 0020        C      	LD	BC,32
  5C8C'   ED B0          C      	LDIR
  5C8E'   CD 6AB6'       C      	CALL	UR.KBV
  5C91'   CD 6ABC'       C      	CALL	UR.KBR
  5C94'   DD 36 05 08    C      	LD	(IX+5),08H	;OHNE RAW
  5C98'   CD 5668'       C      	CALL	UF.EXEC
  5C9B'   C1             C      	POP	BC
  5C9C'   10 E7          C      	DJNZ	$-23
                         C      ;---------------------------------------------------------------------
  5C9E'                  C      KV.KRW:
  5C9E'   CD 6A8E'       C      	CALL	UR.KRW
  5CA1'   CD 6A98'       C      	CALL	UR.KRA
  5CA4'   3A 3328        C      	LD	A,(UE.BWSA+328H)
  5CA7'   FE 44          C      	CP	'D'
  5CA9'   C0             C      	RET	NZ
  5CAA'   21 323D        C      	LD	HL,UE.BWSA+23DH
  5CAD'   00             C      	NOP
  5CAE'   CD 5CEA'       C      	CALL	KV.DRU1
  5CB1'   21 328D        C      	LD	HL,UE.BWSA+28DH
  5CB4'   CD 5CEA'       C      	CALL	KV.DRU1
  5CB7'   CD 4040        C      	CALL	PRINT
  5CBA'   21 2B64'       C      	LD	HL,UB.DTAB
  5CBD'   11 2B65'       C      	LD	DE,UB.DTAB+1
  5CC0'   01 0028        C      	LD	BC,40
  5CC3'   36 20          C      	LD	(HL),20H
  5CC5'   ED B0          C      	LDIR
  5CC7'   3A EC85        C      	LD	A,(BC.VTABE+3)
  5CCA'   47             C      	LD	B,A
  5CCB'   05             C      	DEC	B
  5CCC'   21 EC82        C      	LD	HL,BC.VTABE
  5CCF'   11 0020        C      	LD	DE,32
  5CD2'                  C      KV.P1:
  5CD2'   C5             C      	PUSH	BC
  5CD3'   19             C      	ADD	HL,DE
  5CD4'   E5             C      	PUSH	HL
  5CD5'   D5             C      	PUSH	DE
  5CD6'   11 2B64'       C      	LD	DE,UB.DTAB
  5CD9'   CD 5D04'       C      	CALL	KV.BSTR
  5CDC'   21 2B64'       C      	LD	HL,UB.DTAB
  5CDF'   06 28          C      	LD	B,40
  5CE1'   CD 5CEC'       C      	CALL	KV.DRU
  5CE4'   D1             C      	POP	DE
  5CE5'   E1             C      	POP	HL
  5CE6'   C1             C      	POP	BC
  5CE7'   10 E9          C      	DJNZ	KV.P1
  5CE9'   C9             C      	RET
                         C      
  5CEA'                  C      KV.DRU1:
  5CEA'   06 1E          C      	LD	B,30
  5CEC'                  C      KV.DRU:
  5CEC'   7E             C      	LD	A,(HL)
  5CED'   23             C      	INC	HL
  5CEE'   CD 5CF9'       C      	CALL	KV.KO02
  5CF1'   10 F9          C      	DJNZ	KV.DRU
  5CF3'   3E 1E          C      	LD	A,1EH
  5CF5'   CD 4040        C      	CALL	PRINT
  5CF8'   C9             C      	RET
                         C      ;
  5CF9'                  C      KV.KO02:
  5CF9'   CB BF          C      	RES	7,A	;FUER KV17 (DRUCKERAUSGABE)
  5CFB'   FE 20          C      	CP	20H
  5CFD'   30 02          C      	JR	NC,$+4
  5CFF'   3E 2A          C      	LD	A,2AH
  5D01'   C3 4040        C      	JP	PRINT
                         C      ;---------------------------------------------------------------------
  5D04'                  C      KV.BSTR:
  5D04'   01 0006        C      	LD	BC,6	;Aufbereitung des Verz.Satzes
  5D07'   C5             C      	PUSH	BC
  5D08'   ED B0          C      	LDIR		;Transport VTABE--->UB.SATZ
  5D0A'   13             C      	INC	DE
  5D0B'   13             C      	INC	DE
  5D0C'   13             C      	INC	DE
  5D0D'   01 0002        C      	LD	BC,2
  5D10'   ED B0          C      	LDIR
  5D12'   13             C      	INC	DE
  5D13'   13             C      	INC	DE
  5D14'   13             C      	INC	DE
  5D15'   C1             C      	POP	BC
'Anzeigen und Aendern des MRES-Verzeichnisses'	MACRO-80 3.44	09-Dec-81	PAGE	1-28


  5D16'   C5             C      	PUSH	BC
  5D17'   ED B0          C      	LDIR
  5D19'   13             C      	INC	DE
  5D1A'   13             C      	INC	DE
  5D1B'   13             C      	INC	DE
  5D1C'   C1             C      	POP	BC
  5D1D'   ED B0          C      	LDIR
  5D1F'   13             C      	INC	DE
  5D20'   13             C      	INC	DE
  5D21'   13             C      	INC	DE
  5D22'   01 0003        C      	LD	BC,3
  5D25'   ED B0          C      	LDIR
  5D27'   13             C      	INC	DE
  5D28'   13             C      	INC	DE
  5D29'   13             C      	INC	DE
  5D2A'   6E             C      	LD	L,(HL)	;Konvertierung Labelnummer
  5D2B'   26 00          C      	LD	H,0
  5D2D'   CD 6F97'       C      	CALL	UC.CVBD2
  5D30'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  5D31'                  C      KV.SPTR:
  5D31'   7E             C      	LD	A,(HL)
  5D32'   FE 09          C      	CP	09H	;Soll Satz geloescht werden?
  5D34'   20 02          C      	JR	NZ,$+4
  5D36'   AF             C      	XOR	A
  5D37'   77             C      	LD	(HL),A
  5D38'   01 0006        C      	LD	BC,6
  5D3B'   C5             C      	PUSH	BC
  5D3C'   ED B0          C      	LDIR		;Ruecktransport BWSA--->VTABE
  5D3E'   23             C      	INC	HL
  5D3F'   23             C      	INC	HL
  5D40'   23             C      	INC	HL
  5D41'   01 0002        C      	LD	BC,2
  5D44'   ED B0          C      	LDIR
  5D46'   23             C      	INC	HL
  5D47'   23             C      	INC	HL
  5D48'   23             C      	INC	HL
  5D49'   C1             C      	POP	BC
  5D4A'   C5             C      	PUSH	BC
  5D4B'   ED B0          C      	LDIR
  5D4D'   23             C      	INC	HL
  5D4E'   23             C      	INC	HL
  5D4F'   23             C      	INC	HL
  5D50'   C1             C      	POP	BC
  5D51'   ED B0          C      	LDIR
  5D53'   23             C      	INC	HL
  5D54'   23             C      	INC	HL
  5D55'   23             C      	INC	HL
  5D56'   01 0003        C      	LD	BC,3
  5D59'   ED B0          C      	LDIR
  5D5B'   23             C      	INC	HL
  5D5C'   23             C      	INC	HL
  5D5D'   23             C      	INC	HL
  5D5E'   D5             C      	PUSH	DE
  5D5F'   EB             C      	EX	DE,HL
  5D60'   CD 5D67'       C      	CALL	KV.DBCVM
  5D63'   7D             C      	LD	A,L
  5D64'   E1             C      	POP	HL
  5D65'   77             C      	LD	(HL),A
  5D66'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  5D67'                  C      KV.DBCVM:
  5D67'   06 02          C      	LD	B,2	;FELDLAENGE
  5D69'   CD 6FDC'       C      	CALL	UC.CVDB	;KONVERTIER. DEZI-->BINAER
  5D6C'   D0             C      	RET	NC		;OHNE FEHLER
  5D6D'   C0             C      	RET	NZ
  5D6E'   13             C      	INC	DE	;1.ZEICHEN WAR KEINE DEZ.ZAHL
  5D6F'   10 F8          C      	DJNZ	$-6
  5D71'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  5D72'                  C      KV.SBC:
  5D72'   01 0020        C      	LD	BC,32
  5D75'   B7             C      	OR	A
  5D76'   ED 42          C      	SBC	HL,BC
  5D78'   7E             C      	LD	A,(HL)
  5D79'   FE 00          C      	CP	00H
  5D7B'   C9             C      	RET	
                         C      ;---------------------------------------------------------------------
  5D7C'                  C      KV.ANZ:
  5D7C'   C5             C      	PUSH	BC
  5D7D'   68             C      	LD	L,B
  5D7E'   26 00          C      	LD	H,0
  5D80'   11 3332        C      	LD	DE,3332H
'Anzeigen und Aendern des MRES-Verzeichnisses'	MACRO-80 3.44	09-Dec-81	PAGE	1-29


  5D83'   CD 6F93'       C      	CALL	UC.CVBD3
  5D86'   13             C      	INC	DE
  5D87'   13             C      	INC	DE
  5D88'   21 5D92'       C      	LD	HL,KV.AVZS
  5D8B'   01 0011        C      	LD	BC,17
  5D8E'   ED B0          C      	LDIR
  5D90'   C1             C      	POP	BC
  5D91'   C9             C      	RET
                         C      ;-----------------------------------------------------------------------
  5D92'                  C      KV.AVZS:
  5D92'   56 65 72 7A    C      	DB	'Verzeichnissaetze'
  5D96'   65 69 63 68    C      
  5D9A'   6E 69 73 73    C      
  5D9E'   61 65 74 7A    C      
  5DA2'   65             C      
                         C      ;----------------------------------------------------------------------
                         C      ;	END
                         C      	TITLE	'Kommandos: KRDx und KWRx'
                         C      	PAGE
'Kommandos: KRDx und KWRx'	MACRO-80 3.44	09-Dec-81	PAGE	1-30


                         C      
                         C      ;	PN	KH
                         C      ;**********************************************************************
                         C      ;
                         C      ;   Kommando:
                         C      ;        KRDx...Block einlesen und anzeigen
                         C      ;               zusaetlich werden die entsprechenden Puffer-
                         C      ;               adressen angezeigt.
                         C      ;        KWRx...Block schreiben, standardmaessig nach 'KRDx'
                         C      ;               Ansonsten muessen Blockadresse und Blocklaenge in der
                         C      ;               Verstaendigungstabelle eingetragen werden.
                         C      ;
                         C      ;**********************************************************************
  5DA3'   5DA3'          C      	DW	$
  5DA5'   4B 52 44 31    C      	DB	'KRD1'
  5DA9'   18 06          C      	JR	KH.RDSTA
                         C      ;
  5DAB'   5DAB'          C      	DW	$
  5DAD'   4B 52 44 32    C      	DB	'KRD2'
  5DB1'                  C      KH.RDSTA:
  5DB1'   CD 6D65'       C      	CALL	U1.KTINI	;Initialisierung E/A-Tab.
  5DB4'   3A 3325        C      	LD	A,(UE.BWSA+325H)
  5DB7'   E6 0F          C      	AND	0FH
  5DB9'   DD 77 04       C      	LD	(IX+4),A	;Subadresse eintragen
  5DBC'                  C      KH.RES:
  5DBC'   CD 6A86'       C      	CALL	UR.KRE	;Reservieren
  5DBF'                  C      KH.RD1:
  5DBF'   DD 36 05 02    C      	LD	(IX+5),02H	;Block wiedergeben
  5DC3'   CD 5668'       C      	CALL	UF.EXEC
  5DC6'   DD 7E 02       C      	LD	A,(IX+2)	;Laenge = 1, dann BM
  5DC9'   FE 01          C      	CP	1
  5DCB'   CA 5E2E'       C      	JP	Z,KH.RDBM
  5DCE'   CD 5F0B'       C      	CALL	KH.BILO
  5DD1'   CD 5E3F'       C      	CALL	KH.ANZBL	;Block anzeigen
  5DD4'                  C      KH.RD3:
  5DD4'   CD 6C5A'       C      	CALL	UR.TAREP	;Tastaturabfrage
  5DD7'   FE 89          C      	CP	089H
  5DD9'   28 E4          C      	JR	Z,KH.RD1	;---> P 10
  5DDB'   FE 8B          C      	CP	08BH
  5DDD'                  C      KH.RD6:
  5DDD'   CC 5E25'       C      	CALL	Z,KH.RD2	;---> P 12
  5DE0'   28 DD          C      	JR	Z,KH.RD1
  5DE2'   FE CD          C      	CP	0CDH
  5DE4'                  C      KH.RD4:
  5DE4'   28 3B          C      	JR	Z,KH.SYSRT	;---> SYS
  5DE6'   FE 85          C      	CP	85H
  5DE8'   CC 5F03'       C      	CALL	Z,KH.KBRS	;---> P 6
  5DEB'   FE 86          C      	CP	86H
  5DED'   DD 36 08 01    C      	LD	(IX+8),1
  5DF1'   F5             C      	PUSH	AF
  5DF2'   CC 6A9E'       C      	CALL	Z,UR.KLV	;---> P 7
  5DF5'   F1             C      	POP	AF
  5DF6'   28 DC          C      	JR	Z,KH.RD3
  5DF8'   FE 87          C      	CP	87H
  5DFA'   F5             C      	PUSH	AF
  5DFB'   CC 6A98'       C      	CALL	Z,UR.KRA	;---> P 8
  5DFE'   F1             C      	POP	AF
  5DFF'   28 D3          C      	JR	Z,KH.RD3
  5E01'   FE 88          C      	CP	88H
  5E03'   F5             C      	PUSH	AF
  5E04'   CC 6AA4'       C      	CALL	Z,UR.KLR	;---> P 9
  5E07'   F1             C      	POP	AF
  5E08'   28 CA          C      	JR	Z,KH.RD3
  5E0A'   FE E2          C      	CP	0E2H	;CTRL,US,B : BM SCHREIBEN
  5E0C'   F5             C      	PUSH	AF
  5E0D'   CC 6AAA'       C      	CALL	Z,UR.KBM
  5E10'   F1             C      	POP	AF
  5E11'   CA 5DD4'       C      	JP	Z,KH.RD3
  5E14'   FE 83          C      	CP	83H
  5E16'   CA 5DBC'       C      	JP	Z,KH.RES	;---> P 4
  5E19'   FE 84          C      	CP	84H
  5E1B'   CC 6A94'       C      	CALL	Z,UR.KRWW	;---> P 5
  5E1E'   C3 5DD4'       C      	JP	KH.RD3
  5E21'                  C      KH.SYSRT:
  5E21'   CD 5F0B'       C      	CALL	KH.BILO	;Systemruecksprung
  5E24'   C9             C      	RET
  5E25'                  C      KH.RD2:
  5E25'   F5             C      	PUSH	AF	;Flags retten
  5E26'   CD 6ABC'       C      	CALL	UR.KBR	;Block ruecksetzen
  5E29'   CD 6ABC'       C      	CALL	UR.KBR
  5E2C'   F1             C      	POP	AF
  5E2D'   C9             C      	RET
'Kommandos: KRDx und KWRx'	MACRO-80 3.44	09-Dec-81	PAGE	1-31


  5E2E'                  C      KH.RDBM:
  5E2E'   CD 5F0B'       C      	CALL	KH.BILO
  5E31'   21 5950'       C      	LD	HL,UA.ZKBM	;"Bandmarke"
  5E34'   11 3000        C      	LD	DE,UE.BWSA
  5E37'   01 0009        C      	LD	BC,9
  5E3A'   ED B0          C      	LDIR
  5E3C'   C3 5DD4'       C      	JP	KH.RD3
  5E3F'                  C      KH.ANZBL:
  5E3F'   CD 5F0B'       C      	CALL	KH.BILO
  5E42'                  C      KH.ANZB1:
  5E42'   21 0E66        C      	LD	HL,UE.PUF
  5E45'   CD 5E49'       C      	CALL	KH.AZBLD	;Bild anzeigen (24 Zeilen)
  5E48'   C9             C      	RET		; IN...HL:=akt. Pufferadresse
  5E49'                  C      KH.AZBLD:
  5E49'   06 18          C      	LD	B,24	; 24 Zeilen anzeigen
  5E4B'   11 3000        C      	LD	DE,UE.BWSA
  5E4E'                  C      KH.AZBL1:
  5E4E'   C5             C      	PUSH	BC
  5E4F'   CD 5E5E'       C      	CALL	KH.AZ1Z	; 1 Zeile anzeigen
  5E52'   C1             C      	POP	BC
  5E53'   E5             C      	PUSH	HL	;akt. Pufferadresse retten
  5E54'   EB             C      	EX	DE,HL
  5E55'   11 0050        C      	LD	DE,80
  5E58'   19             C      	ADD	HL,DE	;neuen Zeilenanfang berechnen
  5E59'   EB             C      	EX	DE,HL
  5E5A'   E1             C      	POP	HL
  5E5B'   10 F1          C      	DJNZ	KH.AZBL1
  5E5D'   C9             C      	RET
                         C      ;                                IN...HL:= Pufferadresse
                         C      ;                                     DE:= Zeilenanfang
  5E5E'                  C      KH.AZ1Z:
  5E5E'   D5             C      	PUSH	DE	;eine Zeile anzeigen
  5E5F'   E5             C      	PUSH	HL
  5E60'   D5             C      	PUSH	DE
  5E61'   E1             C      	POP	HL
  5E62'   01 0040        C      	LD	BC,64
  5E65'   09             C      	ADD	HL,BC
  5E66'   E5             C      	PUSH	HL
  5E67'   C1             C      	POP	BC	;BC:= Anfang ASCII-Darstellung
  5E68'   E1             C      	POP	HL
  5E69'   CD 5E82'       C      	CALL	KH.AZADR	;Adresse anzeigen
  5E6C'   13             C      	INC	DE
  5E6D'   13             C      	INC	DE
  5E6E'   CD 5E8B'       C      	CALL	KH.AZ4BY	;1. Vierergruppe
  5E71'   13             C      	INC	DE
  5E72'   13             C      	INC	DE
  5E73'   CD 5E8B'       C      	CALL	KH.AZ4BY	;2.      ''
  5E76'   13             C      	INC	DE
  5E77'   13             C      	INC	DE
  5E78'   CD 5E8B'       C      	CALL	KH.AZ4BY	;3.      ''
  5E7B'   13             C      	INC	DE
  5E7C'   13             C      	INC	DE
  5E7D'   CD 5E8B'       C      	CALL	KH.AZ4BY	;4.      ''
  5E80'   D1             C      	POP	DE
  5E81'   C9             C      	RET
  5E82'                  C      KH.AZADR:
  5E82'   7C             C      	LD	A,H	;Anzeige der Adresse
  5E83'   CD 6F20'       C      	CALL	UC.CVBX+2
  5E86'   7D             C      	LD	A,L
  5E87'   CD 6F20'       C      	CALL	UC.CVBX+2
  5E8A'   C9             C      	RET
  5E8B'                  C      KH.AZ4BY:
  5E8B'   AF             C      	XOR	A	;Anzeige einer Vierergruppe
  5E8C'   32 2B1C'       C      	LD	(UB.PAR1),A
  5E8F'                  C      KH.AZ4B0:
  5E8F'   7E             C      	LD	A,(HL)
  5E90'   F5             C      	PUSH	AF
  5E91'   CD 6F20'       C      	CALL	UC.CVBX+2	;Code als Hexadezimalzahl
  5E94'   F1             C      	POP	AF
  5E95'   13             C      	INC	DE
  5E96'   23             C      	INC	HL
  5E97'   FE 20          C      	CP	20H
  5E99'   38 15          C      	JR	C,KH.AZ4B1	;nicht darstellbar
  5E9B'   FE 7F          C      	CP	7FH
  5E9D'   30 11          C      	JR	NC,KH.AZ4B1	;nicht darstellbar
  5E9F'                  C      KH.AZ4B3:
  5E9F'   02             C      	LD	(BC),A	;Code als ASCII-Zeichen
  5EA0'   03             C      	INC	BC
  5EA1'   CD 5EB4'       C      	CALL	KH.BLEVG	;Test auf Blockende
  5EA4'   3A 2B1C'       C      	LD	A,(UB.PAR1)
  5EA7'   3C             C      	INC	A
  5EA8'   FE 04          C      	CP	4
  5EAA'   C8             C      	RET	Z
'Kommandos: KRDx und KWRx'	MACRO-80 3.44	09-Dec-81	PAGE	1-32


  5EAB'   32 2B1C'       C      	LD	(UB.PAR1),A
  5EAE'   18 DF          C      	JR	KH.AZ4B0
  5EB0'                  C      KH.AZ4B1:
  5EB0'   3E 7F          C      	LD	A,07FH
  5EB2'   18 EB          C      	JR	KH.AZ4B3
  5EB4'                  C      KH.BLEVG:
  5EB4'   D5             C      	PUSH	DE	;Blockendetest
  5EB5'   E5             C      	PUSH	HL
  5EB6'   11 0E66        C      	LD	DE,UE.PUF	;DE:= Pufferanfang
  5EB9'   B7             C      	OR	A
  5EBA'   ED 52          C      	SBC	HL,DE	;HL:= Anzahl der angezeigten
  5EBC'   EB             C      	EX	DE,HL
  5EBD'   CD 6E8C'       C      	CALL	XY.LIDX
  5EC0'   09             C      	DB	9
  5EC1'   B7             C      	OR	A
  5EC2'   ED 52          C      	SBC	HL,DE
  5EC4'   E1             C      	POP	HL
  5EC5'   D1             C      	POP	DE
  5EC6'   28 01          C      	JR	Z,KH.BLEV1
  5EC8'   C9             C      	RET
  5EC9'                  C      KH.BLEV1:
  5EC9'   06 0C          C      	LD	B,12
  5ECB'                  C      KH.BLEV2:
  5ECB'   33             C      	INC	SP
  5ECC'   10 FD          C      	DJNZ	KH.BLEV2
  5ECE'   C9             C      	RET		;---> Anzeige beendet
                         C      ;*********************************************************************
  5ECF'   5ECF'          C      	DW	$
  5ED1'   4B 57 52 31    C      	DB	'KWR1'
  5ED5'   18 06          C      	JR	KH.WRSTA
                         C      ;
  5ED7'   5ED7'          C      	DW	$
  5ED9'   4B 57 52 32    C      	DB	'KWR2'
  5EDD'                  C      KH.WRSTA:
  5EDD'   3A 3325        C      	LD	A,(UE.BWSA+325H)
  5EE0'   DD 21 2B01'    C      	LD	IX,UB.KTAB	;Block aufzeichnen
  5EE4'   DD CB 00 56    C      	BIT	2,(IX)
  5EE8'   28 07          C      	JR	Z,$+9
  5EEA'   F5             C      	PUSH	AF
  5EEB'   3E 19          C      	LD	A,19H
  5EED'   CD 5694'       C      	CALL	UF.ERANZ
  5EF0'   F1             C      	POP	AF
  5EF1'   E6 0F          C      	AND	0FH
  5EF3'   DD 77 04       C      	LD	(IX+4),A
  5EF6'   DD 36 05 08    C      	LD	(IX+5),08H
  5EFA'   CD 5668'       C      	CALL	UF.EXEC
  5EFD'   CD 6ABC'       C      	CALL	UR.KBR
  5F00'   C3 5DBF'       C      	JP	KH.RD1
  5F03'                  C      KH.KBRS:
  5F03'   CD 6ABC'       C      	CALL	UR.KBR
  5F06'   CD 5F0B'       C      	CALL	KH.BILO
  5F09'   D1             C      	POP	DE
  5F0A'   C9             C      	RET
                         C      ;----------------------------------------------------
  5F0B'                  C      KH.BILO:
  5F0B'   21 3000        C      	LD	HL,3000H
  5F0E'   01 077F        C      	LD	BC,24*80 -1	;800H
  5F11'   36 20          C      	LD	(HL),20H
  5F13'   E5             C      	PUSH	HL
  5F14'   D1             C      	POP	DE
  5F15'   13             C      	INC	DE
  5F16'   ED B0          C      	LDIR
  5F18'   C9             C      	RET
                         C      ;------------------------------------------------------
                         C      ;	END
                         C      	TITLE	'Ein-/Ausgabe im freien Format'
                         C      	PAGE
'Ein-/Ausgabe im freien Format'	MACRO-80 3.44	09-Dec-81	PAGE	1-33


                         C      
                         C      ;	PN	FD
                         C      ;**********************************************************************
                         C      ;
                         C      ;      Ein-/Ausgabe von Dateien im freien Format in bzw. aus demEditor-
                         C      ;      raum von bzw. auf MRES-Kassetten
                         C      ;
                         C      ;**********************************************************************
                         C      ;      Positionieren auf Datei, IN: <C>:= Labelnummer
                         C      ;
  5F19'                  C      FD.POSK:
  5F19'   C5             C      	PUSH	BC
  5F1A'   41             C      	LD	B,C
  5F1B'   04             C      	INC	B
  5F1C'   CD 6ACB'       C      	CALL	UR.POSIK
  5F1F'   CD 5F31'       C      	CALL	FD.KO01
  5F22'   3A 0E66        C      	LD	A,(UE.PUF)
  5F25'   B9             C      	CP	C
  5F26'   C1             C      	POP	BC
  5F27'   20 01          C      	JR	NZ,$+3
  5F29'   C9             C      	RET
  5F2A'   D1             C      	POP	DE
  5F2B'   3E 94          C      	LD	A,94H
  5F2D'   CD 5694'       C      	CALL	UF.ERANZ
  5F30'   C9             C      	RET
                         C      ;
  5F31'   DD 36 05 02    C      FD.KO01:	LD	(IX+5),2	;FUER FD19
  5F35'   C3 5668'       C      	JP	UF.EXEC
                         C      ;----------------------------------------------------------------------
                         C      ;      Datei im Verzeichnis suchen
                         C      ;      HL:= Dateiname, <B>:= Anzahl Verzeichniseintragungen + 1
                         C      ;      <D>:= Dateityp
                         C      ;      O:  CY:= 0 Datei nicht vorhanden, <C> unveraendert
                         C      ;          CY:= 1 <C>:= Labelnummer
                         C      ;      K:  B
  5F38'                  C      FD.DASU:
  5F38'   D5             C      	PUSH	DE
  5F39'   05             C      	DEC	B
  5F3A'   28 0A          C      	JR	Z,$+12
  5F3C'   CD 5F31'       C      	CALL	FD.KO01
  5F3F'   CD 6D4A'       C      	CALL	U1.NMVGL
  5F42'   38 05          C      	JR	C,$+7
  5F44'   10 F6          C      	DJNZ	$-8
  5F46'   B7             C      	OR	A
  5F47'   D1             C      	POP	DE
  5F48'   C9             C      	RET
  5F49'   5F             C      	LD	E,A
  5F4A'   3A 0E6C        C      	LD	A,(UE.PUF+6)
  5F4D'   BA             C      	CP	D
  5F4E'   20 F4          C      	JR	NZ,$-10
  5F50'   4B             C      	LD	C,E
  5F51'   37             C      	SCF
  5F52'   18 F3          C      	JR	$-11
                         C      ;----------------------------------------------------------------------
                         C      ;      Reservebloecke schreiben
                         C      ;
  5F54'                  C      FD.WRRES:
  5F54'   C5             C      	PUSH	BC
  5F55'   D5             C      	PUSH	DE
  5F56'   E5             C      	PUSH	HL
  5F57'   21 5902'       C      	LD	HL,UA.ZKRES
  5F5A'   CD 6B2E'       C      	CALL	UR.MIMO
  5F5D'   EB             C      	EX	DE,HL
  5F5E'   CD 6FDC'       C      	CALL	UC.CVDB
  5F61'   7C             C      	LD	A,H
  5F62'   B5             C      	OR	L
  5F63'   20 04          C      	JR	NZ,$+6
  5F65'   E1             C      	POP	HL
  5F66'   D1             C      	POP	DE
  5F67'   C1             C      	POP	BC
  5F68'   C9             C      	RET
  5F69'   E5             C      	PUSH	HL
  5F6A'   21 0E66        C      	LD	HL,UE.PUF
  5F6D'   01 0090        C      	LD	BC,90H
  5F70'   CD 6C93'       C      	CALL	U1.CLRB
  5F73'   21 0080        C      	LD	HL,80H
  5F76'   CD 6EAC'       C      	CALL	XY.STIDX
  5F79'   09             C      	DB	9
  5F7A'   E1             C      	POP	HL
  5F7B'   CD 72C5'       C      	CALL	UK.KBA
  5F7E'   2B             C      	DEC	HL
  5F7F'   7C             C      	LD	A,H
'Ein-/Ausgabe im freien Format'	MACRO-80 3.44	09-Dec-81	PAGE	1-34


  5F80'   B5             C      	OR	L
  5F81'   20 E6          C      	JR	NZ,$-24
  5F83'   18 E0          C      	JR	$-30
                         C      ;----------------------------------------------------------------------
                         C      ;      F/S - Datei in den Editorraum einlesen
                         C      ;
  5F85'                  C      FD.FDINP:
  5F85'   21 0000        C      	LD	HL,0
  5F88'   CD 6E9C'       C      	CALL	XY.STDX
  5F8B'   11             C      	DB	17
  5F8C'   CD 7214'       C      	CALL	UK.KLPFB	;Pufferbereitstellung
  5F8F'   21 3328        C      	LD	HL,UE.BWSA+328H
  5F92'   06 05          C      	LD	B,5
  5F94'   7E             C      	LD	A,(HL)
  5F95'   FE 45          C      	CP	'E'
  5F97'   28 05          C      	JR	Z,$+7
  5F99'   23             C      	INC	HL
  5F9A'   10 F8          C      	DJNZ	$-6
  5F9C'   18 05          C      	JR	$+7
  5F9E'   2A 0DC4        C      	LD	HL,(UE.EDEND)
  5FA1'   18 03          C      	JR	$+5
  5FA3'   21 8830        C      	LD	HL,UE.TEXAN
  5FA6'   D9             C      	EXX
  5FA7'   CD 71D1'       C      	CALL	DC.INIT	;Dekomprimierung initialisieren
  5FAA'   D9             C      	EXX
  5FAB'   3A 2B1E'       C      	LD	A,(UB.PAR2)	;Dateitypmerker
  5FAE'   FE 53          C      	CP	'S'
  5FB0'   F5             C      	PUSH	AF
  5FB1'   CC 5FCC'       C      	CALL	Z,FD.SDIN	;Zeicheneingabe S- Datei
  5FB4'   77             C      	LD	(HL),A
  5FB5'   B7             C      	OR	A
  5FB6'   28 12          C      	JR	Z,$+20
  5FB8'   F1             C      	POP	AF
  5FB9'   28 07          C      	JR	Z,$+9
  5FBB'   C4 71D7'       C      	CALL	NZ,UK.GETK	;Zeicheneingabe F- Datei
  5FBE'   77             C      	LD	(HL),A	;Zeichen in Speicher eintragen
  5FBF'   BE             C      	CP	(HL)	;Echolesen
  5FC0'   20 10          C      	JR	NZ,$+18
  5FC2'   B7             C      	OR	A	;<A>:= 0, Z:= 1
  5FC3'   C8             C      	RET	Z
  5FC4'   23             C      	INC	HL	;HL:= HL + 1
  5FC5'   22 0DC4        C      	LD	(UE.EDEND),HL	;Textende
  5FC8'   18 E1          C      	JR	$-29
  5FCA'   F1             C      	POP	AF
  5FCB'   C9             C      	RET
  5FCC'                  C      FD.SDIN:
  5FCC'   D9             C      	EXX
  5FCD'   CD 7196'       C      	CALL	DC.DCMPR
  5FD0'   D9             C      	EXX
  5FD1'   C9             C      	RET
  5FD2'   3E 93          C      	LD	A,93H	;Fehlerschluessel
  5FD4'   CD 5694'       C      	CALL	UF.ERANZ
  5FD7'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
                         C      ;      Ausgabe einer F/S - Datei (neuer Bestand)
                         C      ;
  5FD8'                  C      FD.FDOUT:
  5FD8'   21 0000        C      	LD	HL,0	;Blockzaehler loeschen
  5FDB'   CD 6E9C'       C      	CALL	XY.STDX
  5FDE'   11             C      	DB	17
  5FDF'   21 0080        C      	LD	HL,80H	;Blocklaenge eintragen
  5FE2'   CD 6EAC'       C      	CALL	XY.STIDX
  5FE5'   09             C      	DB	9
  5FE6'   CD 72A0'       C      	CALL	UK.KSPFB	;Pufferbereitstellung
  5FE9'   21 8830        C      	LD	HL,UE.TEXAN	;HL:= Textanfang
  5FEC'   ED 5B 0DC4     C      	LD	DE,(UE.EDEND)	;BC:= Textende
  5FF0'   D9             C      	EXX
  5FF1'   CD 7190'       C      	CALL	CP.INIT
  5FF4'   D9             C      	EXX
  5FF5'   B7             C      	OR	A	;CY:= 0
  5FF6'   E5             C      	PUSH	HL
  5FF7'   ED 52          C      	SBC	HL,DE
  5FF9'   30 13          C      	JR	NC,$+21
  5FFB'   E1             C      	POP	HL
  5FFC'   3A 2B1E'       C      	LD	A,(UB.PAR2)
  5FFF'   FE 53          C      	CP	'S'
  6001'   F5             C      	PUSH	AF
  6002'   7E             C      	LD	A,(HL)
  6003'   CC 6026'       C      	CALL	Z,FD.SDOUT
  6006'   F1             C      	POP	AF
  6007'   7E             C      	LD	A,(HL)
  6008'   C4 727C'       C      	CALL	NZ,UK.PUTK
  600B'   23             C      	INC	HL
'Ein-/Ausgabe im freien Format'	MACRO-80 3.44	09-Dec-81	PAGE	1-35


  600C'   18 E7          C      	JR	$-23
  600E'   E1             C      	POP	HL	;Endebehandlung
  600F'   01 0120        C      	LD	BC,288
  6012'   AF             C      	XOR	A
  6013'   CD 727C'       C      	CALL	UK.PUTK
  6016'   0B             C      	DEC	BC
  6017'   78             C      	LD	A,B
  6018'   B1             C      	OR	C
  6019'   20 F7          C      	JR	NZ,$-7
  601B'   CD 61E9'       C      	CALL	FD.DSPBB
  601E'   CD 5F54'       C      	CALL	FD.WRRES	;Reservebloecke schreiben
  6021'   CD 6E7C'       C      	CALL	XY.LDDX	;HL:= Blockzaehler
  6024'   11             C      	DB	17
  6025'   C9             C      	RET
  6026'                  C      FD.SDOUT:
  6026'   D9             C      	EXX
  6027'   CD 712D'       C      	CALL	CP.COMPR
  602A'   D9             C      	EXX
  602B'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
                         C      ;      Ausgabe einer F/S - Datei (alter Bestand)
                         C      ;
  602C'                  C      FD.FDOWR:
  602C'   21 0000        C      	LD	HL,0
  602F'   CD 6E9C'       C      	CALL	XY.STDX
  6032'   11             C      	DB	17
  6033'   21 8830        C      	LD	HL,UE.TEXAN
  6036'   D9             C      	EXX
  6037'   CD 7190'       C      	CALL	CP.INIT
  603A'   D9             C      	EXX
  603B'   E5             C      	PUSH	HL
  603C'                  C      FD.FDOW1:
  603C'   CD 607C'       C      	CALL	FD.FDUP
  603F'   E1             C      	POP	HL
  6040'                  C      FD.FDOW2:
  6040'   E5             C      	PUSH	HL
  6041'   ED 5B 0DC4     C      	LD	DE,(UE.EDEND)
  6045'   B7             C      	OR	A
  6046'   ED 52          C      	SBC	HL,DE
  6048'   30 1B          C      	JR	NC,FD.FDOW3
  604A'   E1             C      	POP	HL
  604B'   3A 2B1E'       C      	LD	A,(UB.PAR2)
  604E'   FE 53          C      	CP	'S'
  6050'   7E             C      	LD	A,(HL)
  6051'   28 41          C      	JR	Z,FD.SDOW
  6053'   CD 727C'       C      	CALL	UK.PUTK
  6056'   0B             C      	DEC	BC
  6057'                  C      FD.FDOW4:
  6057'   23             C      	INC	HL
  6058'   78             C      	LD	A,B
  6059'   B1             C      	OR	C
  605A'   20 E4          C      	JR	NZ,FD.FDOW2
  605C'   CD 72C5'       C      	CALL	UK.KBA	;Block schreiben
  605F'   E5             C      	PUSH	HL
  6060'   CD 6072'       C      	CALL	FD.DECBZ
  6063'   18 D7          C      	JR	FD.FDOW1
  6065'                  C      FD.FDOW3:
  6065'   E1             C      	POP	HL
  6066'   AF             C      	XOR	A	;Endekennzeichen 00H 
  6067'   CD 727C'       C      	CALL	UK.PUTK
  606A'   CD 72C5'       C      	CALL	UK.KBA
  606D'   CD 6072'       C      	CALL	FD.DECBZ
  6070'   B7             C      	OR	A
  6071'   C9             C      	RET
  6072'                  C      FD.DECBZ:
  6072'   CD 6E7C'       C      	CALL	XY.LDDX
  6075'   11             C      	DB	17
  6076'   2B             C      	DEC	HL
  6077'   CD 6E9C'       C      	CALL	XY.STDX
  607A'   11             C      	DB	17
  607B'   C9             C      	RET
  607C'                  C      FD.FDUP:
  607C'   CD 7237'       C      	CALL	UK.KBW
  607F'   DD 7E 02       C      	LD	A,(IX+2)	;Laenge = 1, dann BM
  6082'   FE 01          C      	CP	1
  6084'   CA 620E'       C      	JP	Z,FD.BMGF
  6087'   CD 6ABC'       C      	CALL	UR.KBR
  608A'   CD 6E8C'       C      	CALL	XY.LIDX
  608D'   09             C      	DB	9
  608E'   E5             C      	PUSH	HL
  608F'   C1             C      	POP	BC
  6090'   CD 72A0'       C      	CALL	UK.KSPFB
  6093'   C9             C      	RET
'Ein-/Ausgabe im freien Format'	MACRO-80 3.44	09-Dec-81	PAGE	1-36


  6094'                  C      FD.SDOW:
  6094'   CD 6026'       C      	CALL	FD.SDOUT
  6097'   78             C      	LD	A,B
  6098'   A1             C      	AND	C
  6099'   FE FF          C      	CP	0FFH
  609B'   28 1B          C      	JR	Z,FD.SDK1
  609D'   FE FE          C      	CP	0FEH
  609F'   28 03          C      	JR	Z,FD.SDK2
  60A1'   C3 6057'       C      	JP	FD.FDOW4
  60A4'                  C      FD.SDK2:
  60A4'   EB             C      	EX	DE,HL
  60A5'   CD 607C'       C      	CALL	FD.FDUP
  60A8'   3E 09          C      	LD	A,09H
  60AA'   CD 727C'       C      	CALL	UK.PUTK
  60AD'   0B             C      	DEC	BC
  60AE'                  C      FD.SDK0:
  60AE'   3E 3B          C      	LD	A,';'
  60B0'   CD 727C'       C      	CALL	UK.PUTK
  60B3'   0B             C      	DEC	BC
  60B4'   EB             C      	EX	DE,HL
  60B5'   C3 6057'       C      	JP	FD.FDOW4
  60B8'                  C      FD.SDK1:
  60B8'   EB             C      	EX	DE,HL
  60B9'   CD 607C'       C      	CALL	FD.FDUP
  60BC'   18 F0          C      	JR	FD.SDK0
                         C      ;--------------------------------------------------------------
                         C      ;        Startroutine Ein-/Ausgabe
                         C      ;
  60BE'                  C      FD.FSTRT:
  60BE'   CD 6E2C'       C      	CALL	U1.BILO
  60C1'   CD 6D65'       C      	CALL	U1.KTINI
  60C4'   3A 3326        C      	LD	A,(UE.BWSA+326H)
  60C7'   CD 6E40'       C      	CALL	U1.TST
  60CA'   DA 60F6'       C      	JP	C,FD.STRT1
  60CD'   DD 77 04       C      	LD	(IX+4),A
  60D0'   CD 6A86'       C      	CALL	UR.KRE
  60D3'   CD 6A94'       C      	CALL	UR.KRWW
  60D6'   CD 6D19'       C      	CALL	U1.DSVG
  60D9'   3E 0E          C      	LD	A,14
  60DB'   32 2B00'       C      	LD	(UB.ZN),A
  60DE'   3A 3328        C      	LD	A,(UE.BWSA+328H)
  60E1'   FE 53          C      	CP	'S'
  60E3'   28 02          C      	JR	Z,$+4
  60E5'   3E 46          C      	LD	A,'F'
  60E7'   57             C      	LD	D,A
  60E8'   32 2B1E'       C      	LD	(UB.PAR2),A
  60EB'   21 5915'       C      	LD	HL,UA.ZKSDT
  60EE'   28 03          C      	JR	Z,$+5
  60F0'   21 5885'       C      	LD	HL,UA.ZKDAT
  60F3'   CD 6B2E'       C      	CALL	UR.MIMO
  60F6'                  C      FD.STRT1:
  60F6'   FD E1          C      	POP	IY
  60F8'   D8             C      	RET	C
  60F9'   FD E5          C      	PUSH	IY
  60FB'   3E 53          C      	LD	A,'S'
  60FD'   BA             C      	CP	D
  60FE'   CC 6129'       C      	CALL	Z,FD.DECHL
  6101'   CD 5F38'       C      	CALL	FD.DASU
  6104'   DC 610B'       C      	CALL	C,FD.SETJ
  6107'   D4 6123'       C      	CALL	NC,FD.SETN
  610A'   C9             C      	RET
  610B'                  C      FD.SETJ:
  610B'   C5             C      	PUSH	BC
  610C'   D5             C      	PUSH	DE
  610D'   E5             C      	PUSH	HL
  610E'   EB             C      	EX	DE,HL
  610F'   06 08          C      	LD	B,8
  6111'   13             C      	INC	DE
  6112'   10 FD          C      	DJNZ	$-1
  6114'   21 0E6E        C      	LD	HL,UE.PUF+8
  6117'   01 0006        C      	LD	BC,6
  611A'   ED B0          C      	LDIR
  611C'   E1             C      	POP	HL
  611D'   D1             C      	POP	DE
  611E'   C1             C      	POP	BC
  611F'   3E 4A          C      	LD	A,'J'
  6121'   18 02          C      	JR	$+4
  6123'                  C      FD.SETN:
  6123'   3E 4E          C      	LD	A,'N'
  6125'   32 2B1C'       C      	LD	(UB.PAR1),A
  6128'   C9             C      	RET
  6129'                  C      FD.DECHL:
  6129'   2B             C      	DEC	HL
'Ein-/Ausgabe im freien Format'	MACRO-80 3.44	09-Dec-81	PAGE	1-37


  612A'   2B             C      	DEC	HL
  612B'   C9             C      	RET
                         C      ;****************************************************************
                         C      ;        Ausgabeprogramm
                         C      ;****************************************************************
  612C'   612C'          C      	DW	$
  612E'   41 55 53 20    C      	DB	'AUS '
  6132'                  C      FD.FOUT1:
  6132'   CD 60BE'       C      	CALL	FD.FSTRT
  6135'   3A 2B1C'       C      	LD	A,(UB.PAR1)
  6138'   FE 4A          C      	CP	'J'	;DATEI SCHON VORHANDEN ?
  613A'   CA 61A5'       C      	JP	Z,FD.FOLWR	;JA
                         C      ;-------------------------------NEIN--> NEUE ERSTELLEN-----------------
  613D'   79             C      	LD	A,C	;NEXT RECORD
  613E'   32 2B1C'       C      	LD	(UB.PAR1),A
  6141'   3E 7F          C      	LD	A,7FH
  6143'   32 2B20'       C      	LD	(UB.PAR3),A	;PARAMETER KOMMENTARABFRAGE JA
  6146'   CD 6DC9'       C      	CALL	U1.VZS	;NEUEN VERZ.SATZ SCHREIBEN
  6149'   CD 5F19'       C      	CALL	FD.POSK
  614C'   C5             C      	PUSH	BC
  614D'   CD 5FD8'       C      	CALL	FD.FDOUT
  6150'   E5             C      	PUSH	HL	;BLOCKZAEHLER
  6151'   CD 6AAA'       C      	CALL	UR.KBM
  6154'   21 0020        C      	LD	HL,32
  6157'   CD 6EAC'       C      	CALL	XY.STIDX
  615A'   09             C      	DB	9
  615B'   CD 6D09'       C      	CALL	U1.VSX
  615E'   E1             C      	POP	HL
  615F'   C1             C      	POP	BC
  6160'   E5             C      	PUSH	HL
  6161'   79             C      	LD	A,C
  6162'   3C             C      	INC	A
  6163'   32 0E66        C      	LD	(UE.PUF),A
  6166'   F5             C      	PUSH	AF
  6167'   DD 36 05 08    C      	LD	(IX+5),08H
  616B'   CD 5668'       C      	CALL	UF.EXEC
  616E'   CD 6A94'       C      	CALL	UR.KRWW
  6171'   CD 6D19'       C      	CALL	U1.DSVG
  6174'   CD 6ABC'       C      	CALL	UR.KBR
  6177'   F1             C      	POP	AF
  6178'   32 0E67        C      	LD	(UE.PUF+1),A
  617B'   78             C      	LD	A,B
  617C'   3C             C      	INC	A
  617D'   32 0E69        C      	LD	(UE.PUF+3),A
  6180'   DD 36 05 08    C      	LD	(IX+5),08H
  6184'   CD 5668'       C      	CALL	UF.EXEC
  6187'   DD 36 05 02    C      	LD	(IX+5),02H
  618B'   CD 5668'       C      	CALL	UF.EXEC
  618E'   10 FB          C      	DJNZ	$-3
  6190'   CD 6ABC'       C      	CALL	UR.KBR
  6193'   E1             C      	POP	HL
  6194'   22 0E7F        C      	LD	(UE.PUF+25),HL
  6197'   DD 36 05 08    C      	LD	(IX+5),08H
  619B'   CD 5668'       C      	CALL	UF.EXEC
  619E'                  C      FD.END:
  619E'   CD 6A8E'       C      	CALL	UR.KRW
  61A1'   CD 6A98'       C      	CALL	UR.KRA
  61A4'   C9             C      	RET
  61A5'                  C      FD.FOLWR:
  61A5'   21 58E4'       C      	LD	HL,UA.ZKDL	;DATEI UEBERSCHREIBEN?
  61A8'   CD 6B2E'       C      	CALL	UR.MIMO
  61AB'   D8             C      	RET	C
  61AC'   7E             C      	LD	A,(HL)
  61AD'   FE 4A          C      	CP	'J'
  61AF'   C0             C      	RET	NZ
  61B0'   CD 5F19'       C      	CALL	FD.POSK
  61B3'   CD 602C'       C      	CALL	FD.FDOWR
  61B6'   CD 61E9'       C      	CALL	FD.DSPBB
  61B9'   CD 6203'       C      	CALL	FD.RDEND
  61BC'   CD 61F9'       C      	CALL	FD.DSPBG
  61BF'   18 DD          C      	JR	$-33
                         C      ;**********************************************************************
                         C      ;      Eingabeprogramm
                         C      ;**********************************************************************
  61C1'   61C1'          C      	DW	$
  61C3'   45 49 4E 20    C      	DB	'EIN '
  61C7'                  C      FD.FDIN2:
  61C7'   CD 60BE'       C      	CALL	FD.FSTRT
  61CA'   3A 2B1C'       C      	LD	A,(UB.PAR1)
  61CD'   FE 4A          C      	CP	'J'
  61CF'   28 07          C      	JR	Z,$+9
  61D1'   3E 91          C      	LD	A,91H
  61D3'   CD 5694'       C      	CALL	UF.ERANZ
'Ein-/Ausgabe im freien Format'	MACRO-80 3.44	09-Dec-81	PAGE	1-38


  61D6'   18 C6          C      	JR	FD.END
  61D8'   CD 5F19'       C      	CALL	FD.POSK
  61DB'   CD 5F85'       C      	CALL	FD.FDINP
  61DE'   CD 61E9'       C      	CALL	FD.DSPBB
  61E1'   CD 6203'       C      	CALL	FD.RDEND
  61E4'   CD 61F9'       C      	CALL	FD.DSPBG
  61E7'   18 B5          C      	JR	FD.END
                         C      ;----------------------------------------------------------------------
  61E9'                  C      FD.DSPBB:
  61E9'   CD 6E7C'       C      	CALL	XY.LDDX
  61EC'   11             C      	DB	17
  61ED'   EB             C      	EX	DE,HL
  61EE'   21 592A'       C      	LD	HL,UA.ZKBEL
  61F1'   CD 6B2E'       C      	CALL	UR.MIMO
  61F4'   EB             C      	EX	DE,HL
  61F5'   CD 6F93'       C      	CALL	UC.CVBD3
  61F8'   C9             C      	RET
  61F9'                  C      FD.DSPBG:
  61F9'   CD 6E7C'       C      	CALL	XY.LDDX
  61FC'   11             C      	DB	17
  61FD'   EB             C      	EX	DE,HL
  61FE'   21 593D'       C      	LD	HL,UA.ZKBLG
  6201'   18 EE          C      	JR	$-16
  6203'                  C      FD.RDEND:
  6203'   CD 7237'       C      	CALL	UK.KBW
  6206'   DD 7E 02       C      	LD	A,(IX+2)	;Laenge = 1, dann BM
  6209'   FE 01          C      	CP	1
  620B'   C8             C      	RET	Z
  620C'   18 F5          C      	JR	FD.RDEND
  620E'                  C      FD.BMGF:
  620E'   3E 95          C      	LD	A,95H
  6210'   CD 5694'       C      	CALL	UF.ERANZ
  6213'   D1             C      	POP	DE
  6214'   D1             C      	POP	DE
  6215'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
                         C      ;	END
                         C      	TITLE	'Laden von MRES-P-Dateien'
                         C      	PAGE
'Laden von MRES-P-Dateien'	MACRO-80 3.44	09-Dec-81	PAGE	1-39


                         C      
                         C      ;	PN	LD
                         C      ;***********************************************************
                         C      ;
                         C      ;        Laden von MRES-P-Dateien
                         C      ;
                         C      ;***********************************************************
  6216'   6216'          C      	DW	$
  6218'   4C 4F 41 44    C      	DB	'LOAD'
  621C'   3A 3327        C      	LD	A,(UE.BWSA+327H)
  621F'   CD 6E40'       C      	CALL	U1.TST
  6222'   D8             C      	RET	C
  6223'   CD 6D65'       C      	CALL	U1.KTINI
  6226'   DD 77 04       C      	LD	(IX+4),A
  6229'   CD 6E2C'       C      	CALL	U1.BILO
  622C'   3E 0D          C      	LD	A,13
  622E'   32 2B00'       C      	LD	(UB.ZN),A
  6231'                  C      LD.DATN:
  6231'   21 5885'       C      	LD	HL,UA.ZKDAT	;Dateiname ?
  6234'   CD 6B2E'       C      	CALL	UR.MIMO
  6237'   D8             C      	RET	C
  6238'   CD 6A86'       C      	CALL	UR.KRE
  623B'   CD 6A94'       C      	CALL	UR.KRWW
  623E'   CD 6D19'       C      	CALL	U1.DSVG
  6241'   3E 01          C      	LD	A,01H
  6243'   B8             C      	CP	B
  6244'   28 0A          C      	JR	Z,LD.LD21	;NEU INITIALISIERTE KASSETTE
  6246'                  C      LD.LD2:
  6246'   CD 7237'       C      	CALL	UK.KBW
  6249'   CD 6D4A'       C      	CALL	U1.NMVGL	;Dateiname vergleichen
  624C'   38 08          C      	JR	C,LD.DATFU	;---> Datei gefunden
  624E'   10 F6          C      	DJNZ	LD.LD2
  6250'                  C      LD.LD21:
  6250'   3E 91          C      	LD	A,91H	;Datei nicht vorhanden
  6252'   CD 5694'       C      	CALL	UF.ERANZ	;FEHLERANZEIGE
  6255'   C9             C      	RET
  6256'                  C      LD.DATFU:
  6256'   3A 0E6C        C      	LD	A,(UE.PUF+6)	;TYP
  6259'   FE 4F          C      	CP	'O'
  625B'   F5             C      	PUSH	AF
  625C'   21 0E7D        C      	LD	HL,UE.PUF+23
  625F'   7E             C      	LD	A,(HL)
  6260'   F5             C      	PUSH	AF
  6261'   47             C      	LD	B,A
  6262'   04             C      	INC	B
  6263'   CD 6ACB'       C      	CALL	UR.POSIK	;Positionieren
  6266'   CD 7237'       C      	CALL	UK.KBW
  6269'   F1             C      	POP	AF
  626A'   21 0E66        C      	LD	HL,UE.PUF
  626D'   BE             C      	CP	(HL)
  626E'   28 07          C      	JR	Z,LD.DATPO	;Datei richtig positioniert
  6270'   F1             C      	POP	AF
  6271'   3E 94          C      	LD	A,94H
  6273'   CD 5694'       C      	CALL	UF.ERANZ
  6276'   C9             C      	RET
  6277'                  C      LD.DATPO:
  6277'   F1             C      	POP	AF
  6278'   CA 630D'       C      	JP	Z,RL.BEG
  627B'   3A 3329        C      	LD	A,(UE.BWSA+329H)
  627E'   FE 56          C      	CP	'V'
  6280'   20 57          C      	JR	NZ,LD.LD3
  6282'   21 5898'       C      	LD	HL,UA.ZKLAD	;Ladeadresse ?
  6285'   CD 6B2E'       C      	CALL	UR.MIMO
  6288'   DA 6231'       C      	JP	C,LD.DATN
  628B'   CD 6E4A'       C      	CALL	U1.PRADR	;ADRESSE EINGEGEBEN
  628E'   38 F2          C      	JR	C,$-12
  6290'   EB             C      	EX	DE,HL
  6291'   21 2B1C'       C      	LD	HL,UB.PAR1
  6294'   CD 6F80'       C      	CALL	UC.CVXA
  6297'                  C      LD.LD4:
  6297'   CD 7214'       C      	CALL	UK.KLPFB
  629A'   CD 71D7'       C      	CALL	UK.GETK
  629D'   CD 71D7'       C      	CALL	UK.GETK
  62A0'   67             C      	LD	H,A
  62A1'   CD 71D7'       C      	CALL	UK.GETK
  62A4'   6F             C      	LD	L,A
  62A5'   7A             C      	LD	A,D
  62A6'   B3             C      	OR	E
  62A7'   28 09          C      	JR	Z,LD.LD5
  62A9'   ED 5B 2B1C'    C      	LD	DE,(UB.PAR1)
  62AD'   EB             C      	EX	DE,HL
  62AE'   B7             C      	OR	A
'Laden von MRES-P-Dateien'	MACRO-80 3.44	09-Dec-81	PAGE	1-40


  62AF'   ED 52          C      	SBC	HL,DE
  62B1'   EB             C      	EX	DE,HL	;DE:= Verschiebung zur ersten
  62B2'                  C      LD.LD5:
  62B2'   CD 6ABC'       C      	CALL	UR.KBR
  62B5'   CD 62DE'       C      	CALL	LD.LADER
  62B8'   22 2B1E'       C      	LD	(UB.PAR2),HL
  62BB'   21 3329        C      	LD	HL,UE.BWSA+329H
  62BE'   06 04          C      	LD	B,4
  62C0'   7E             C      	LD	A,(HL)
  62C1'   FE 53          C      	CP	'S'
  62C3'   28 0A          C      	JR	Z,LD.START
  62C5'   23             C      	INC	HL
  62C6'   10 F8          C      	DJNZ	$-6
  62C8'   CD 6A8E'       C      	CALL	UR.KRW
  62CB'   CD 6A98'       C      	CALL	UR.KRA
  62CE'   C9             C      	RET
  62CF'                  C      LD.START:
  62CF'   CD 6A8E'       C      	CALL	UR.KRW
  62D2'   CD 6A98'       C      	CALL	UR.KRA
  62D5'   2A 2B1E'       C      	LD	HL,(UB.PAR2)
  62D8'   E9             C      	JP	(HL)
  62D9'                  C      LD.LD3:
  62D9'   11 0000        C      	LD	DE,0
  62DC'   18 B9          C      	JR	LD.LD4
                         C      ;--------------------------------------------------------------
  62DE'                  C      LD.LADER:
  62DE'   CD 7214'       C      	CALL	UK.KLPFB
  62E1'                  C      LD.LAD2:
  62E1'   CD 71D7'       C      	CALL	UK.GETK
  62E4'   FE 00          C      	CP	0
  62E6'   28 16          C      	JR	Z,LD.LDEND
  62E8'   47             C      	LD	B,A
  62E9'   CD 71D7'       C      	CALL	UK.GETK
  62EC'   67             C      	LD	H,A
  62ED'   CD 71D7'       C      	CALL	UK.GETK
  62F0'   6F             C      	LD	L,A
  62F1'   19             C      	ADD	HL,DE
  62F2'                  C      LD.LAD1:
  62F2'   CD 71D7'       C      	CALL	UK.GETK
  62F5'   77             C      	LD	(HL),A
  62F6'   BE             C      	CP	(HL)
  62F7'   20 0E          C      	JR	NZ,LD.LADF
  62F9'   23             C      	INC	HL
  62FA'   10 F6          C      	DJNZ	LD.LAD1
  62FC'   18 E3          C      	JR	LD.LAD2
  62FE'                  C      LD.LDEND:
  62FE'   CD 71D7'       C      	CALL	UK.GETK
  6301'   67             C      	LD	H,A
  6302'   CD 71D7'       C      	CALL	UK.GETK
  6305'   6F             C      	LD	L,A
  6306'   C9             C      	RET
  6307'                  C      LD.LADF:
  6307'   3E 93          C      	LD	A,93H
  6309'   CD 5694'       C      	CALL	UF.ERANZ
  630C'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
                         C      ;	END
                         C      	TITLE	'Relativloader fuer O-Dateien'
                         C      	PAGE
'Relativloader fuer O-Dateien'	MACRO-80 3.44	09-Dec-81	PAGE	1-41


                         C      
                         C      ;	PN	RL
                         C      ;----------------------------------------------------------------------
                         C      ;
                         C      ;     RELATIVLOADER FUER O-DATEIEN
                         C      ;
                         C      ;----------------------------------------------------------------------
  630D'                  C      RL.BEG:
  630D'   21 58AB'       C      	LD	HL,UA.ZKBEG	;BEGINN ?
  6310'   CD 6B2E'       C      	CALL	UR.MIMO
  6313'   DA 6231'       C      	JP	C,LD.DATN
  6316'   CD 6E4A'       C      	CALL	U1.PRADR
  6319'   38 F2          C      	JR	C,RL.BEG
  631B'   EB             C      	EX	DE,HL
  631C'   21 2B26'       C      	LD	HL,UB.PATAB
  631F'   CD 6F80'       C      	CALL	UC.CVXA
  6322'                  C      RL.UG:
  6322'   CD 7237'       C      	CALL	UK.KBW
  6325'   2A 2B26'       C      	LD	HL,(UB.PATAB)	;BGADR---->HL
  6328'   0E 01          C      	LD	C,001H	;LADEN BLOCKZAEHLER MIT
                         C      			;ANFANGSWERT
  632A'   CD 63B5'       C      	CALL	RL.UP6	; AUFRUF EINGABE-UP
                         C      ;********** TEST BEFEHLSKENNZEICHENBYTE *******************************
  632D'                  C      RL.M16:
  632D'   CB 5A          C      	BIT	3,D	;TEST ORG-BEFEHL
  632F'   C2 6409'       C      	JP	NZ,RL.OB	;JA--->FEHLER
  6332'   CB 62          C      	BIT	4,D	;TEST BER -BEFEHL
  6334'   C2 639E'       C      	JP	NZ,RL.M10
  6337'   3E 07          C      	LD	A,007H
  6339'   A2             C      	AND	D	;TEST BEFEHLS LAENGE=0 ?
  633A'   CA 63AF'       C      	JP	Z,RL.M11
  633D'   47             C      	LD	B,A	;BEFEHLSLAENGE-->B
  633E'                  C      RL.M12:
  633E'   CD 63B5'       C      	CALL	RL.UP6
  6341'   72             C      	LD	(HL),D
  6342'   23             C      	INC	HL
  6343'   10 F9          C      	DJNZ	RL.M12	;EINGABE BEFEHL
  6345'   CD 63B5'       C      	CALL	RL.UP6
  6348'   CB 7A          C      	BIT	7,D	;TEST BEFEHLSKENNZEICHENBYTE ?
  634A'   20 E1          C      	JR	NZ,RL.M16	; JA
                         C      ;******* TEST ADRESSKENNZEICHENBYTE ***********************************
  634C'   CB 6A          C      	BIT	5,D	;TEST OB REL.ADR. FOLGT
  634E'   CA 640D'       C      	JP	Z,RL.RA	;NEIN-->FEHLER
  6351'   CB 72          C      	BIT	6,D	;FOLGT BEZUGNAHME AUF
                         C      			;SYMBOLVERZEICHNIS
  6353'   C2 6411'       C      	JP	NZ,RL.SV	;JA--->FEHLER
  6356'   CB 52          C      	BIT	2,D	;MINUS ?
  6358'   C2 6415'       C      	JP	NZ,RL.MN
  635B'                  C      RL.M17:
  635B'   3E 03          C      	LD	A,003H
  635D'   A2             C      	AND	D	;TEST ADRESSLAENGE
  635E'   F5             C      	PUSH	AF
  635F'   E5             C      	PUSH	HL
  6360'   CD 63B5'       C      	CALL	RL.UP6
  6363'   62             C      	LD	H,D	;ADRESSE ---->HL
  6364'   CD 63B5'       C      	CALL	RL.UP6
  6367'   6A             C      	LD	L,D
  6368'   C5             C      	PUSH	BC
  6369'   E5             C      	PUSH	HL
  636A'   21 2B26'       C      	LD	HL,UB.PATAB
  636D'   4E             C      	LD	C,(HL)	;BEGINN(LADE)ADRESSE--->BC
  636E'   23             C      	INC	HL
  636F'   46             C      	LD	B,(HL)
  6370'   E1             C      	POP	HL
  6371'   09             C      	ADD	HL,BC	;ERMITTELN SPEICHERADRESSE
  6372'   EB             C      	EX	DE,HL	;SP.ADR.--->DE
  6373'   C1             C      	POP	BC
  6374'   E1             C      	POP	HL
  6375'   F1             C      	POP	AF
  6376'   28 04          C      	JR	Z,RL.M13
  6378'   CB 47          C      	BIT	0,A	;NUR L-TEIL DER ADRESSE ?
  637A'   28 10          C      	JR	Z,RL.M14	; JA
                         C      ;********** ADRESSE IN SPEICHER EINTRAGEN *****************************
  637C'                  C      RL.M13:
  637C'   73             C      	LD	(HL),E
  637D'   F5             C      	PUSH	AF
  637E'   7B             C      	LD	A,E
  637F'   BE             C      	CP	(HL)
  6380'   C2 6400'       C      	JP	NZ,RL.ECHO
  6383'   F1             C      	POP	AF
  6384'   23             C      	INC	HL
  6385'   FE 03          C      	CP	003H
'Relativloader fuer O-Dateien'	MACRO-80 3.44	09-Dec-81	PAGE	1-42


  6387'   28 03          C      	JR	Z,RL.M14
  6389'   B7             C      	OR	A	;NUR H-TEIL DER ADRESSE ?
  638A'   20 08          C      	JR	NZ,RL.M15	; JA
  638C'                  C      RL.M14:
  638C'   72             C      	LD	(HL),D
  638D'   F5             C      	PUSH	AF
  638E'   7A             C      	LD	A,D
  638F'   BE             C      	CP	(HL)
  6390'   20 6E          C      	JR	NZ,RL.ECHO
  6392'   F1             C      	POP	AF
  6393'   23             C      	INC	HL
  6394'                  C      RL.M15:
  6394'   CD 63B5'       C      	CALL	RL.UP6
  6397'   CB 7A          C      	BIT	7,D	; TEST BEFEHLSKENNZEICHENBYTE
  6399'   20 92          C      	JR	NZ,RL.M16
  639B'   C3 6419'       C      	JP	RL.BF	; NEIN--->FEHLER
                         C      ;----------------------------------------------------------------------
  639E'                  C      RL.M10:
  639E'   CD 63B5'       C      	CALL	RL.UP6	;BEI BER-BEFEHL ADDIEREN DER
  63A1'   D5             C      	PUSH	DE	;DEF. BEREICHSLAENGE ZU
  63A2'   CD 63B5'       C      	CALL	RL.UP6	;ADRESSE
  63A5'   7A             C      	LD	A,D
  63A6'   D1             C      	POP	DE
  63A7'   5F             C      	LD	E,A
  63A8'   19             C      	ADD	HL,DE
  63A9'   CD 63B5'       C      	CALL	RL.UP6
  63AC'   C3 632D'       C      	JP	RL.M16
  63AF'                  C      RL.M11:
  63AF'   CD 63B5'       C      	CALL	RL.UP6	;BEI BFL=0 SPRUNG ZUM TEST
  63B2'   C3 635B'       C      	JP	RL.M17	;ADRESSKENNZEICHENBYTE
                         C      ;******* UP ZUR ZEICHENWEISE EINGABE DER O-DATEI **********************
  63B5'                  C      RL.UP6:
  63B5'   CD 71D7'       C      	CALL	UK.GETK
  63B8'   57             C      	LD	D,A
  63B9'   0D             C      	DEC	C	;REDUZIEREN BLOCKLAENGE
  63BA'   C0             C      	RET	NZ		;RET BEI UNGLEICH NULL
  63BB'   A7             C      	AND	A	;IST NAECHSTE BLOCKLAENGE NULL ?
  63BC'   28 04          C      	JR	Z,RL.M21	;JA-->VERZWEIGUNG ENDEBEH
  63BE'   4F             C      	LD	C,A	;NEIN-->EINTRAGEN BLKLAENGE
  63BF'   0C             C      	INC	C
  63C0'   18 F3          C      	JR	RL.UP6
                         C      ;*********** ENDEBEHANDLUNG *******************************************
  63C2'                  C      RL.M21:
  63C2'   D1             C      	POP	DE
  63C3'   E5             C      	PUSH	HL
  63C4'   3E 0F          C      	LD	A,15
  63C6'   32 2B00'       C      	LD	(UB.ZN),A
  63C9'   21 58C1'       C      	LD	HL,UA.ZKEND+3
  63CC'   11 3460        C      	LD	DE,3460H
  63CF'   01 0010        C      	LD	BC,16
  63D2'   ED B0          C      	LDIR
  63D4'   21 2B00'       C      	LD	HL,UB.ZN
  63D7'   34             C      	INC	(HL)
  63D8'   E1             C      	POP	HL
  63D9'   2B             C      	DEC	HL
  63DA'   11 3470        C      	LD	DE,3470H	;HINTER AUSSCHRIFT ENDE
  63DD'   CD 6F3A'       C      	CALL	UC.CVHLX
  63E0'   21 58D1'       C      	LD	HL,UA.STADR	;STARTADRESSE ?
  63E3'   CD 6B2E'       C      	CALL	UR.MIMO
  63E6'   D8             C      	RET	C
  63E7'   EB             C      	EX	DE,HL
  63E8'   21 2B28'       C      	LD	HL,UB.PATAB+2
  63EB'   CD 6F80'       C      	CALL	UC.CVXA	;STARTADR.-->BINAER
  63EE'   3A 3329        C      	LD	A,(UE.BWSA+329H)
  63F1'   FE 53          C      	CP	'S'
  63F3'   20 04          C      	JR	NZ,$+6
  63F5'   2A 2B28'       C      	LD	HL,(UB.PATAB+2)
  63F8'   E9             C      	JP	(HL)
  63F9'   CD 6A8E'       C      	CALL	UR.KRW
  63FC'   CD 6A98'       C      	CALL	UR.KRA
  63FF'   C9             C      	RET
                         C      ;---------------------------------------------------------------------
  6400'                  C      RL.ECHO:
  6400'   D1             C      	POP	DE
  6401'   3E 93          C      	LD	A,93H
  6403'   18 16          C      	JR	RL.FMELD
  6405'                  C      RL.DATNV:
  6405'   3E 91          C      	LD	A,91H
  6407'   18 12          C      	JR	RL.FMELD
  6409'                  C      RL.OB:
  6409'   3E 96          C      	LD	A,96H
  640B'   18 0E          C      	JR	RL.FMELD
  640D'                  C      RL.RA:
'Relativloader fuer O-Dateien'	MACRO-80 3.44	09-Dec-81	PAGE	1-43


  640D'   3E 97          C      	LD	A,97H
  640F'   18 0A          C      	JR	RL.FMELD
  6411'                  C      RL.SV:
  6411'   3E 98          C      	LD	A,98H
  6413'   18 06          C      	JR	RL.FMELD
  6415'                  C      RL.MN:
  6415'   3E 99          C      	LD	A,99H
  6417'   18 02          C      	JR	RL.FMELD
  6419'                  C      RL.BF:
  6419'   3E 9A          C      	LD	A,9AH
  641B'                  C      RL.FMELD:
  641B'   CD 5694'       C      	CALL	UF.ERANZ
  641E'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
                         C      ;	END
                         C      	TITLE	'Retten von Maschinencodeprogrammen als MRES - P-Datei'
                         C      	PAGE
'Retten von Maschinencodeprogrammen als MRES - P-Datei'	MACRO-80 3.44	09-Dec-81	PAGE	1-44


                         C      
                         C      ;	PN	SV
                         C      ;**********************************************************************
                         C      ;
                         C      ;      Retten von Maschinencodeprogrammen als MRES - P-Datei
                         C      ;
                         C      ;**********************************************************************
  641F'   641F'          C      	DW	$
  6421'   53 41 56 45    C      	DB	'SAVE'
  6425'   3A 3327        C      	LD	A,(UE.BWSA+327H)
  6428'   CD 6E40'       C      	CALL	U1.TST
  642B'   D8             C      	RET	C
  642C'   CD 6D65'       C      	CALL	U1.KTINI
  642F'   DD 77 04       C      	LD	(IX+4),A
  6432'   AF             C      	XOR	A
  6433'   32 2B1D'       C      	LD	(UB.PAR1+1),A
  6436'   CD 6E2C'       C      	CALL	U1.BILO	;BS LOESCHEN
  6439'   CD 6A86'       C      	CALL	UR.KRE
  643C'   DD CB 00 56    C      	BIT	2,(IX)
  6440'   28 05          C      	JR	Z,$+7
  6442'   3E 19          C      	LD	A,19H
  6444'   CD 5694'       C      	CALL	UF.ERANZ
  6447'   CD 6A94'       C      	CALL	UR.KRWW
  644A'                  C      SV.SV20:
  644A'   CD 6D19'       C      	CALL	U1.DSVG
  644D'   C5             C      	PUSH	BC
  644E'   79             C      	LD	A,C
  644F'   32 2B1C'       C      	LD	(UB.PAR1),A	;NEXT RECORD
  6452'   3E 0D          C      	LD	A,13
  6454'   32 2B00'       C      	LD	(UB.ZN),A
  6457'                  C      SV.DATN:
  6457'   21 5885'       C      	LD	HL,UA.ZKDAT	;Dateiname ?
  645A'   CD 6B2E'       C      	CALL	UR.MIMO
  645D'   D8             C      	RET	C
  645E'   C1             C      	POP	BC
  645F'   05             C      	DEC	B
  6460'   28 1A          C      	JR	Z,SV.SV30	;NEUE KASSETTE
  6462'                  C      SV.SV21:
  6462'   CD 7237'       C      	CALL	UK.KBW
  6465'   CD 6D4A'       C      	CALL	U1.NMVGL
  6468'   38 04          C      	JR	C,SV.DATV1	;Dateiname bereits vorhanden
  646A'   10 F6          C      	DJNZ	SV.SV21
  646C'   18 0E          C      	JR	SV.SV30
  646E'                  C      SV.DATV1:
  646E'   3E 01          C      	LD	A,01H
  6470'   B8             C      	CP	B
  6471'   CC 65BA'       C      	CALL	Z,SV.DALO1
  6474'   28 0E          C      	JR	Z,SV.SV37
  6476'                  C      SV.DATVO:
  6476'   3E 92          C      	LD	A,92H
  6478'   CD 5694'       C      	CALL	UF.ERANZ
  647B'   C9             C      	RET
  647C'                  C      SV.SV30:
  647C'   3E 50          C      	LD	A,'P'
  647E'   32 2B1E'       C      	LD	(UB.PAR2),A
  6481'   CD 6DC9'       C      	CALL	U1.VZS
  6484'                  C      SV.SV37:
  6484'   3A 2B1D'       C      	LD	A,(UB.PAR1+1)
  6487'   FE 4C          C      	CP	'L'
  6489'   20 0B          C      	JR	NZ,SV.SV31
  648B'   21 58E4'       C      	LD	HL,UA.ZKDL
  648E'   CD 6B2E'       C      	CALL	UR.MIMO
  6491'   7E             C      	LD	A,(HL)
  6492'   FE 4A          C      	CP	'J'
  6494'   20 E0          C      	JR	NZ,SV.DATVO
  6496'                  C      SV.SV31:
  6496'   3A 2B1C'       C      	LD	A,(UB.PAR1)	;NEXT RECORD
  6499'   47             C      	LD	B,A
  649A'   C5             C      	PUSH	BC
  649B'   04             C      	INC	B
  649C'   CD 6ACB'       C      	CALL	UR.POSIK
  649F'   CD 7237'       C      	CALL	UK.KBW
  64A2'   21 0E66        C      	LD	HL,UE.PUF
  64A5'   C1             C      	POP	BC
  64A6'   7E             C      	LD	A,(HL)
  64A7'   B8             C      	CP	B
  64A8'   28 06          C      	JR	Z,SV.SAVE3
  64AA'   3E 94          C      	LD	A,94H
  64AC'   CD 5694'       C      	CALL	UF.ERANZ
  64AF'   C9             C      	RET
  64B0'                  C      SV.SAVE3:
  64B0'   21 58AB'       C      	LD	HL,UA.ZKBEG	;Beginn ?
'Retten von Maschinencodeprogrammen als MRES - P-Datei'	MACRO-80 3.44	09-Dec-81	PAGE	1-45


  64B3'   CD 6B2E'       C      	CALL	UR.MIMO
  64B6'   DA 6457'       C      	JP	C,SV.DATN
  64B9'   CD 6E4A'       C      	CALL	U1.PRADR
  64BC'   38 F2          C      	JR	C,SV.SAVE3
  64BE'   EB             C      	EX	DE,HL
  64BF'   21 2B1E'       C      	LD	HL,UB.PAR2
  64C2'   CD 6F80'       C      	CALL	UC.CVXA
  64C5'                  C      SV.SAVE4:
  64C5'   21 58BE'       C      	LD	HL,UA.ZKEND	;Ende ?
  64C8'   CD 6B2E'       C      	CALL	UR.MIMO
  64CB'   38 E3          C      	JR	C,SV.SAVE3
  64CD'   CD 6E4A'       C      	CALL	U1.PRADR
  64D0'   38 F3          C      	JR	C,SV.SAVE4
  64D2'   EB             C      	EX	DE,HL
  64D3'   21 2B20'       C      	LD	HL,UB.PAR3
  64D6'   CD 6F80'       C      	CALL	UC.CVXA
  64D9'   CD 6529'       C      	CALL	SV.BYANZ
  64DC'   38 D2          C      	JR	C,SV.SAVE3
  64DE'   28 D0          C      	JR	Z,SV.SAVE3
  64E0'   CD 654E'       C      	CALL	SV.SAVE
  64E3'   CD 6AAA'       C      	CALL	UR.KBM
  64E6'   CD 6534'       C      	CALL	SV.DATS1	;1.DATEISATZ SCHREIBEN
  64E9'   CD 6AB0'       C      	CALL	UR.KSL
  64EC'   CD 6A94'       C      	CALL	UR.KRWW
  64EF'   CD 6D19'       C      	CALL	U1.DSVG
  64F2'   05             C      	DEC	B
  64F3'   3A 2B1D'       C      	LD	A,(UB.PAR1+1)
  64F6'   FE 4C          C      	CP	'L'
  64F8'   28 13          C      	JR	Z,SV.SAVE5
  64FA'   21 0E67        C      	LD	HL,UE.PUF+1
  64FD'   34             C      	INC	(HL)	;NEXT RECORD+1
  64FE'   21 0E69        C      	LD	HL,UE.PUF+3
  6501'   46             C      	LD	B,(HL)
  6502'   34             C      	INC	(HL)	;ANZ.VERZ.EINTR.+1
  6503'                  C      SV.SAVE6:
  6503'   CD 6ABC'       C      	CALL	UR.KBR
  6506'   DD 36 05 08    C      	LD	(IX+5),08H	;NEUEN DS-SATZ AUSGEBEN
  650A'   CD 5668'       C      	CALL	UF.EXEC
  650D'                  C      SV.SAVE5:
  650D'   CD 7237'       C      	CALL	UK.KBW
  6510'   10 FB          C      	DJNZ	SV.SAVE5
  6512'   CD 6ABC'       C      	CALL	UR.KBR
  6515'   2A 2B24'       C      	LD	HL,(UB.PAR5)
  6518'   22 0E7F        C      	LD	(UE.PUF+25),HL	;DATEILAENGE EINTRAGEN
  651B'   DD 36 05 08    C      	LD	(IX+5),08H
  651F'   CD 5668'       C      	CALL	UF.EXEC
  6522'   CD 6A8E'       C      	CALL	UR.KRW
  6525'   CD 6A98'       C      	CALL	UR.KRA
  6528'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  6529'                  C      SV.BYANZ:
  6529'   2A 2B20'       C      	LD	HL,(UB.PAR3)	;Byteanzahl berechnen
  652C'   ED 5B 2B1E'    C      	LD	DE,(UB.PAR2)
  6530'   B7             C      	OR	A
  6531'   ED 52          C      	SBC	HL,DE
  6533'   C9             C      	RET
  6534'                  C      SV.DATS1:
  6534'   21 0020        C      	LD	HL,32	;1. Dateisatz schreiben
  6537'   CD 6EAC'       C      	CALL	XY.STIDX
  653A'   09             C      	DB	9
  653B'   CD 6D09'       C      	CALL	U1.VSX
  653E'   21 0E66        C      	LD	HL,UE.PUF
  6541'   3A 2B1C'       C      	LD	A,(UB.PAR1)	;NEXT RECORD
  6544'   3C             C      	INC	A
  6545'   77             C      	LD	(HL),A
  6546'   DD 36 05 08    C      	LD	(IX+5),08H
  654A'   CD 5668'       C      	CALL	UF.EXEC
  654D'   C9             C      	RET
  654E'                  C      SV.SAVE:
  654E'   21 0000        C      	LD	HL,0
  6551'   CD 6E9C'       C      	CALL	XY.STDX
  6554'   11             C      	DB	17
  6555'   21 0080        C      	LD	HL,80H	;Blocklaenge
  6558'   CD 6EAC'       C      	CALL	XY.STIDX
  655B'   09             C      	DB	9
  655C'   CD 72A0'       C      	CALL	UK.KSPFB	;Pufferbereitstellung
  655F'                  C      SV.SAVE1:
  655F'   CD 6529'       C      	CALL	SV.BYANZ	;Byteanzahl berechnen
  6562'   23             C      	INC	HL
  6563'   E5             C      	PUSH	HL
  6564'   7C             C      	LD	A,H
  6565'   B5             C      	OR	L
  6566'   E1             C      	POP	HL
'Retten von Maschinencodeprogrammen als MRES - P-Datei'	MACRO-80 3.44	09-Dec-81	PAGE	1-46


  6567'   28 13          C      	JR	Z,SV.SVLS2	;---> 0 Byte
  6569'   01 007D        C      	LD	BC,UE.SVL	;Satzlaenge
  656C'   B7             C      	OR	A
  656D'   ED 42          C      	SBC	HL,BC
  656F'   38 05          C      	JR	C,SV.SVLS	;---> letzter Satz
  6571'   CD 65C5'       C      	CALL	SV.SVSZ
  6574'   18 E9          C      	JR	SV.SAVE1
  6576'                  C      SV.SVLS:
  6576'   7D             C      	LD	A,L
  6577'   C6 7D          C      	ADD	A,UE.SVL	;A:= Laenge des letzten Satzes
  6579'   CD 65C7'       C      	CALL	SV.SVSZ2
  657C'                  C      SV.SVLS2:
  657C'   AF             C      	XOR	A
  657D'   CD 727C'       C      	CALL	UK.PUTK
  6580'   21 58D1'       C      	LD	HL,UA.STADR	;Startadresse
  6583'   CD 6B2E'       C      	CALL	UR.MIMO
  6586'   7E             C      	LD	A,(HL)
  6587'   FE 20          C      	CP	' '
  6589'   28 27          C      	JR	Z,SV.STAD0	;KEINE EINGABE (0000)
  658B'   EB             C      	EX	DE,HL
  658C'   21 2B22'       C      	LD	HL,UB.PAR4
  658F'   CD 6F80'       C      	CALL	UC.CVXA
  6592'                  C      SV.SVLS1:
  6592'   2A 2B22'       C      	LD	HL,(UB.PAR4)
  6595'   7C             C      	LD	A,H	;Startadresse ausgeben
  6596'   CD 727C'       C      	CALL	UK.PUTK
  6599'   7D             C      	LD	A,L
  659A'   CD 727C'       C      	CALL	UK.PUTK
  659D'   0E 03          C      	LD	C,3
  659F'                  C      SV.SVEN2:
  659F'   06 80          C      	LD	B,80H
  65A1'   AF             C      	XOR	A
  65A2'                  C      SV.SVEN1:
  65A2'   CD 727C'       C      	CALL	UK.PUTK
  65A5'   10 FB          C      	DJNZ	SV.SVEN1
  65A7'   0D             C      	DEC	C
  65A8'   20 F5          C      	JR	NZ,SV.SVEN2
  65AA'   CD 6E7C'       C      	CALL	XY.LDDX
  65AD'   11             C      	DB	17
  65AE'   22 2B24'       C      	LD	(UB.PAR5),HL
  65B1'   C9             C      	RET
  65B2'                  C      SV.STAD0:
  65B2'   21 0000        C      	LD	HL,0
  65B5'   22 2B22'       C      	LD	(UB.PAR4),HL
  65B8'   18 D8          C      	JR	SV.SVLS1
  65BA'                  C      SV.DALO1:
  65BA'   F5             C      	PUSH	AF
  65BB'   21 2B1C'       C      	LD	HL,UB.PAR1
  65BE'   35             C      	DEC	(HL)
  65BF'   23             C      	INC	HL
  65C0'   3E 4C          C      	LD	A,'L'
  65C2'   77             C      	LD	(HL),A
  65C3'   F1             C      	POP	AF
  65C4'   C9             C      	RET
  65C5'                  C      SV.SVSZ:
  65C5'   3E 7D          C      	LD	A,UE.SVL
  65C7'                  C      SV.SVSZ2:
  65C7'   F5             C      	PUSH	AF
  65C8'   CD 727C'       C      	CALL	UK.PUTK
  65CB'   ED 5B 2B1E'    C      	LD	DE,(UB.PAR2)
  65CF'   7A             C      	LD	A,D
  65D0'   CD 727C'       C      	CALL	UK.PUTK
  65D3'   7B             C      	LD	A,E
  65D4'   CD 727C'       C      	CALL	UK.PUTK
  65D7'   F1             C      	POP	AF
  65D8'   47             C      	LD	B,A
  65D9'                  C      SV.SVSZ1:
  65D9'   1A             C      	LD	A,(DE)
  65DA'   CD 727C'       C      	CALL	UK.PUTK
  65DD'   13             C      	INC	DE
  65DE'   10 F9          C      	DJNZ	SV.SVSZ1
  65E0'   ED 53 2B1E'    C      	LD	(UB.PAR2),DE
  65E4'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
                         C      ;	END
                                ;	
                                ;	INCLUDE	KX.ASM	;Kopieren von MRES-Kassetten Teil 1
                                ;	INCLUDE	KY.ASM	;Kopieren von MRES-Kassetten Teil 2
                                ;	INCLUDE	KU.ASM	;Unterprogramme fuer KOPI
                         C      	INCLUDE K6.ASM	;Kopieren MRES
                         C      	TITLE	'Kopieren von MRES-Kassetten Teil 1'
                         C      	PAGE
'Kopieren von MRES-Kassetten Teil 1'	MACRO-80 3.44	09-Dec-81	PAGE	1-47


                         C      
                         C      ;	PN	KX
                         C      ;------------------------------------------------------------------
                         C      ;
                         C      ;          KOPIEREN VON MRES-KASSETTEN       TEIL1
                         C      ;
                         C      ;----------------------------------------------------------------
  65E5'   65E5'          C      	DW	$
  65E7'   4B 4F 50 49    C      	DB	'KOPI'
  65EB'   CD 6D65'       C      	CALL	U1.KTINI
  65EE'   11 E000        C      	LD	DE,BC.TAB1
  65F1'   21 3327        C      	LD	HL,UE.BWSA+327H
  65F4'   7E             C      	LD	A,(HL)
  65F5'   CD 6E40'       C      	CALL	U1.TST
  65F8'   D8             C      	RET	C
  65F9'   12             C      	LD	(DE),A
  65FA'   23             C      	INC	HL
  65FB'   EE 33          C      	XOR	33H
  65FD'   BE             C      	CP	(HL)
  65FE'   C0             C      	RET	NZ
  65FF'   EE 30          C      	XOR	30H
  6601'   13             C      	INC	DE
  6602'   12             C      	LD	(DE),A
  6603'   3A 3326        C      	LD	A,(UE.BWSA+326H)
  6606'   FE 4A          C      	CP	'J'
  6608'   28 05          C      	JR	Z,$+7	;BEI KOPIJ WERDEN WEITERE PARAMETER
  660A'   23             C      	INC	HL	;IGNORIERT
  660B'   23             C      	INC	HL
  660C'   7E             C      	LD	A,(HL)
  660D'   FE 20          C      	CP	20H
  660F'   F5             C      	PUSH	AF
  6610'   20 0C          C      	JR	NZ,$+14
  6612'   CD 6CF0'       C      	CALL	U1.EIN
  6615'   CD 6E61'       C      	CALL	U1.KRWE
  6618'   CD 6CF9'       C      	CALL	U1.AUS
  661B'   CD 6E61'       C      	CALL	U1.KRWE
  661E'   CD 6759'       C      	CALL	KX.UPA
  6621'   F1             C      	POP	AF
  6622'   28 13          C      	JR	Z,$+21
  6624'   FE 41          C      	CP	'A'
  6626'   28 0A          C      	JR	Z,$+12
  6628'   FE 4C          C      	CP	'L'
  662A'   20 0B          C      	JR	NZ,$+13
  662C'   CD 6CC7'       C      	CALL	U1.COPB
  662F'   C3 66FF'       C      	JP	KX.RSPFR
  6632'   CD 6CC3'       C      	CALL	U1.COPB2
  6635'   18 FB          C      	JR	$-3
                         C      ;-------------------------------------------------------------------
  6637'   CD 6CF0'       C      	CALL	U1.EIN
  663A'   CD 6D19'       C      	CALL	U1.DSVG
  663D'   CD 6CA2'       C      	CALL	U1.KBR4
  6640'   CD 6CAD'       C      	CALL	U1.BREAD
  6643'   21 5797'       C      	LD	HL,UA.Z7E
  6646'   11 3163        C      	LD	DE,3163H
  6649'   01 001F        C      	LD	BC,31
  664C'   ED B0          C      	LDIR
  664E'   21 57B6'       C      	LD	HL,UA.GER
  6651'   11 31EA        C      	LD	DE,31EAH
  6654'   CD 6E26'       C      	CALL	U1.INFO
  6657'   21 5761'       C      	LD	HL,UA.KNAME+3
  665A'   11 323A        C      	LD	DE,323AH
  665D'   CD 6E26'       C      	CALL	U1.INFO
  6660'   21 5774'       C      	LD	HL,UA.NR+3
  6663'   11 328A        C      	LD	DE,328AH
  6666'   CD 6E26'       C      	CALL	U1.INFO
  6669'   21 5787'       C      	LD	HL,UA.KOMMT+3
  666C'   11 32DA        C      	LD	DE,32DAH
  666F'   CD 6E26'       C      	CALL	U1.INFO
  6672'   11 3203        C      	LD	DE,3203H
  6675'   3A E000        C      	LD	A,(BC.TAB1)
  6678'   CD 6F20'       C      	CALL	UC.CVBX+2
  667B'   11 321B        C      	LD	DE,321BH
  667E'   3A E001        C      	LD	A,(BC.TAB1+1)
  6681'   CD 6F20'       C      	CALL	UC.CVBX+2
  6684'   21 0E6A        C      	LD	HL,UE.PUF+4
  6687'   11 3253        C      	LD	DE,3253H
  668A'   06 06          C      	LD	B,6
  668C'   CD 702B'       C      	CALL	UC.DKONV
  668F'   21 0E8B        C      	LD	HL,UE.PUF+37
  6692'   11 32A3        C      	LD	DE,32A3H
  6695'   06 03          C      	LD	B,3
  6697'   CD 702B'       C      	CALL	UC.DKONV
'Kopieren von MRES-Kassetten Teil 1'	MACRO-80 3.44	09-Dec-81	PAGE	1-48


  669A'   11 32F3        C      	LD	DE,32F3H
  669D'   06 0B          C      	LD	B,11
  669F'   CD 702B'       C      	CALL	UC.DKONV
  66A2'   CD 6AB6'       C      	CALL	UR.KBV
  66A5'   CD 6AB6'       C      	CALL	UR.KBV
  66A8'   CD 6CAD'       C      	CALL	U1.BREAD
  66AB'   3A 0E69        C      	LD	A,(UE.PUF+3)
  66AE'   3D             C      	DEC	A
  66AF'   CA 670A'       C      	JP	Z,KX.ENDR
  66B2'   CD 6D93'       C      	CALL	U1.VERIN
  66B5'   CD 6CF9'       C      	CALL	U1.AUS
  66B8'   CD 6D19'       C      	CALL	U1.DSVG
  66BB'   CD 6CA2'       C      	CALL	U1.KBR4
  66BE'   DD 36 05 02    C      	LD	(IX+5),02H
  66C2'   CD 5668'       C      	CALL	UF.EXEC
  66C5'   21 0E6A        C      	LD	HL,UE.PUF+4
  66C8'   11 326B        C      	LD	DE,326BH
  66CB'   06 06          C      	LD	B,6
  66CD'   CD 702B'       C      	CALL	UC.DKONV
  66D0'   21 0E8B        C      	LD	HL,UE.PUF+37
  66D3'   11 32BB        C      	LD	DE,32BBH
  66D6'   06 03          C      	LD	B,3
  66D8'   CD 702B'       C      	CALL	UC.DKONV
  66DB'   11 330B        C      	LD	DE,330BH
  66DE'   06 0B          C      	LD	B,11
  66E0'   CD 702B'       C      	CALL	UC.DKONV
  66E3'   CD 6AB6'       C      	CALL	UR.KBV
  66E6'   CD 6AB6'       C      	CALL	UR.KBV
  66E9'   DD 36 05 02    C      	LD	(IX+5),02H
  66ED'   CD 5668'       C      	CALL	UF.EXEC
  66F0'   CD 6E2C'       C      	CALL	U1.BILO
  66F3'   11 E002        C      	LD	DE,BC.VTABA
  66F6'   CD 6D9B'       C      	CALL	U1.VERNI
  66F9'   CD 6DB5'       C      	CALL	U1.VORST
  66FC'   C3 6776'       C      	JP	KY.MD
  66FF'                  C      KX.RSPFR:
  66FF'   F5             C      	PUSH	AF
  6700'   23             C      	INC	HL
  6701'   23             C      	INC	HL
  6702'   7E             C      	LD	A,(HL)
  6703'   B7             C      	OR	A
  6704'   FE 52          C      	CP	'R'
  6706'   20 06          C      	JR	NZ,$+8
  6708'   18 01          C      	JR	$+3
  670A'                  C      KX.ENDR:
  670A'   F5             C      	PUSH	AF
  670B'   37             C      	SCF
  670C'   18 04          C      	JR	$+6
  670E'   FE 46          C      	CP	'F'
  6710'   20 15          C      	JR	NZ,$+23
  6712'   CD 6CF0'       C      	CALL	U1.EIN
  6715'   DC 6A8E'       C      	CALL	C,UR.KRW
  6718'   CD 6A98'       C      	CALL	UR.KRA
  671B'   CD 6CF9'       C      	CALL	U1.AUS
  671E'   CD 6A86'       C      	CALL	UR.KRE
  6721'   DC 6A94'       C      	CALL	C,UR.KRWW
  6724'   CD 6A98'       C      	CALL	UR.KRA
  6727'   F1             C      	POP	AF
  6728'   C9             C      	RET
  6729'                  C      KX.EXEC2:
  6729'   F5             C      	PUSH	AF
  672A'   DD CB 00 BE    C      	RES	7,(IX)
  672E'   DD 36 01 00    C      	LD	(IX+1),0
  6732'   CD 55D5'       C      	CALL	KR.KARO
  6735'   DD CB 00 7E    C      	BIT	7,(IX)
  6739'   28 0A          C      	JR	Z,$+12
  673B'   DD 7E 01       C      	LD	A,(IX+1)
  673E'   FE 14          C      	CP	14H
  6740'   28 05          C      	JR	Z,$+7
  6742'   CD 5694'       C      	CALL	UF.ERANZ
  6745'   F1             C      	POP	AF
  6746'   C9             C      	RET
  6747'   DD CB 00 BE    C      	RES	7,(IX)
  674B'   CD 6CF9'       C      	CALL	U1.AUS
  674E'   CD 6AB0'       C      	CALL	UR.KSL
  6751'   F1             C      	POP	AF
  6752'   06 06          C      	LD	B,6
  6754'   33             C      	INC	SP
  6755'   10 FD          C      	DJNZ	$-1	;STACK BERICHTIGEN
  6757'   18 A6          C      	JR	KX.RSPFR
  6759'                  C      KX.UPA:
  6759'   CD 6CF0'       C      	CALL	U1.EIN
  675C'   CD 6A86'       C      	CALL	UR.KRE
'Kopieren von MRES-Kassetten Teil 1'	MACRO-80 3.44	09-Dec-81	PAGE	1-49


  675F'   DD 36 00 00    C      	LD	(IX+0),0
  6763'   CD 6CF9'       C      	CALL	U1.AUS
  6766'   CD 6A86'       C      	CALL	UR.KRE
  6769'   DD CB 00 56    C      	BIT	2,(IX)
  676D'   28 05          C      	JR	Z,$+7
  676F'   D1             C      	POP	DE
  6770'   3E 19          C      	LD	A,19H
  6772'   CD 5694'       C      	CALL	UF.ERANZ
  6775'   C9             C      	RET
                         C      ;	END
                         C      	TITLE	'Kopieren von MRES-Kassetten Teil 2'
                         C      	PAGE
'Kopieren von MRES-Kassetten Teil 2'	MACRO-80 3.44	09-Dec-81	PAGE	1-50


                         C      
                         C      ;	PN	KY
                         C      ;---------------------------------------------------------------------
                         C      ;
                         C      ;          KOPIEREN VON MRES-KASSETTEN           TEIL 2
                         C      ;
                         C      ;--------------------------------------------------------------------
  6776'                  C      KY.MD:
  6776'   CD 6E2C'       C      	CALL	U1.BILO
  6779'   21 57C5'       C      	LD	HL,UA.KOPFR
  677C'   CD 69CF'       C      	CALL	KY.SATR
  677F'   3E 0D          C      	LD	A,13
  6781'   32 2B00'       C      	LD	(UB.ZN),A
  6784'   21 ECA2        C      	LD	HL,BC.VTABE+32
  6787'   FD 21 F902     C      	LD	IY,BC.TAB2
  678B'   FD 36 00 FF    C      	LD	(IY+0),0FFH
  678F'   3A EC85        C      	LD	A,(BC.VTABE+3)
  6792'   47             C      	LD	B,A
  6793'   05             C      	DEC	B
                         C      ;--------------------------------ABFRAGEZYKLUS------------------------
  6794'                  C      KY.DFR:
  6794'   C5             C      	PUSH	BC
  6795'   11 2B44'       C      	LD	DE,UB.SATZ+26
  6798'   01 0006        C      	LD	BC,6
  679B'   ED B0          C      	LDIR
  679D'   13             C      	INC	DE
  679E'   13             C      	INC	DE
  679F'   01 0002        C      	LD	BC,2
  67A2'   ED B0          C      	LDIR
  67A4'   01 0018        C      	LD	BC,24
  67A7'   09             C      	ADD	HL,BC
  67A8'   E5             C      	PUSH	HL
  67A9'   21 2B2A'       C      	LD	HL,UB.SATZ
  67AC'   CD 6B2E'       C      	CALL	UR.MIMO
  67AF'   DC 6A2B'       C      	CALL	C,KU.ZEIR
  67B2'   CD 69C6'       C      	CALL	KY.JHL	;BEI KOPIJ WIRD J GESETZT
  67B5'   7E             C      	LD	A,(HL)
  67B6'   FE 4A          C      	CP	'J'
  67B8'   C4 69F3'       C      	CALL	NZ,KU.TAB2L
  67BB'   E1             C      	POP	HL
  67BC'   01 0009        C      	LD	BC,9
  67BF'   B7             C      	OR	A
  67C0'   ED 42          C      	SBC	HL,BC
  67C2'   7E             C      	LD	A,(HL)
  67C3'   FD 77 00       C      	LD	(IY+0),A
  67C6'   FD 23          C      	INC	IY
  67C8'   FD 36 00 FF    C      	LD	(IY+0),0FFH
  67CC'   09             C      	ADD	HL,BC
  67CD'   3A E005        C      	LD	A,(BC.VTABA+3)
  67D0'   FE 01          C      	CP	01H
  67D2'   28 2E          C      	JR	Z,KY.EZYK1
  67D4'   E5             C      	PUSH	HL
  67D5'   01 0020        C      	LD	BC,32
  67D8'   B7             C      	OR	A
  67D9'   ED 42          C      	SBC	HL,BC
  67DB'   EB             C      	EX	DE,HL
  67DC'   E1             C      	POP	HL
  67DD'   DD 21 E002     C      	LD	IX,BC.VTABA
  67E1'   47             C      	LD	B,A
  67E2'   05             C      	DEC	B
  67E3'                  C      KY.VZVGL:
  67E3'   C5             C      	PUSH	BC
  67E4'   01 0020        C      	LD	BC,32
  67E7'   DD 09          C      	ADD	IX,BC
  67E9'   DD E5          C      	PUSH	IX
  67EB'   06 07          C      	LD	B,7
  67ED'   D5             C      	PUSH	DE
  67EE'                  C      KY.SVGL:
  67EE'   1A             C      	LD	A,(DE)
  67EF'   DD BE 00       C      	CP	(IX+0)
  67F2'   20 08          C      	JR	NZ,KY.NDA
  67F4'   DD 23          C      	INC	IX
  67F6'   13             C      	INC	DE
  67F7'   10 F5          C      	DJNZ	KY.SVGL
  67F9'   CD 6A5B'       C      	CALL	KU.DD	;DATEI SCHON VORHANDEN
  67FC'                  C      KY.NDA:
  67FC'   D1             C      	POP	DE
  67FD'   DD E1          C      	POP	IX
  67FF'   C1             C      	POP	BC
  6800'   10 E1          C      	DJNZ	KY.VZVGL
  6802'                  C      KY.EZYK1:
  6802'   C1             C      	POP	BC
'Kopieren von MRES-Kassetten Teil 2'	MACRO-80 3.44	09-Dec-81	PAGE	1-51


  6803'   10 8F          C      	DJNZ	KY.DFR
                         C      ;---------------------------------------------------------------------
  6805'                  C      KY.ATAA:
  6805'   06 03          C      	LD	B,3	;WARTESCHLEIFE FUER
  6807'   21 FFFF        C      	LD	HL,0FFFFH
  680A'   2B             C      	DEC	HL
  680B'   7C             C      	LD	A,H
  680C'   B5             C      	OR	L
  680D'   20 FB          C      	JR	NZ,$-3
  680F'   10 F6          C      	DJNZ	$-8
  6811'   21 57FB'       C      	LD	HL,UA.EABFR
  6814'   CD 69CF'       C      	CALL	KY.SATR
  6817'   21 2B2A'       C      	LD	HL,UB.SATZ
  681A'   CD 6B2E'       C      	CALL	UR.MIMO
  681D'   38 F8          C      	JR	C,$-6
  681F'   CD 69C6'       C      	CALL	KY.JHL
  6822'   7E             C      	LD	A,(HL)
  6823'   FE 4A          C      	CP	'J'
  6825'   C2 6776'       C      	JP	NZ,KY.MD
                         C      ;--------------------------------Labelnummern fuer Ausgabe ---------
  6828'                  C      KY.ATAB:
  6828'   06 00          C      	LD	B,0
  682A'   21 F902        C      	LD	HL,BC.TAB2
  682D'   11 F9D2        C      	LD	DE,BC.TAB3
  6830'   7E             C      	LD	A,(HL)
  6831'   FE FF          C      	CP	0FFH	;KEINE DATEI KOPIEREN
  6833'   CA 670A'       C      	JP	Z,KX.ENDR
  6836'   3A E003        C      	LD	A,(BC.VTABA+1)
  6839'                  C      KY.ATABE:
  6839'   12             C      	LD	(DE),A
  683A'   23             C      	INC	HL
  683B'   13             C      	INC	DE
  683C'   04             C      	INC	B
  683D'   F5             C      	PUSH	AF
  683E'   7E             C      	LD	A,(HL)
  683F'   FE FF          C      	CP	0FFH
  6841'   28 04          C      	JR	Z,KY.WEI
  6843'   F1             C      	POP	AF
  6844'   3C             C      	INC	A
  6845'   18 F2          C      	JR	KY.ATABE
                         C      ;------------------------------TAB:NR DER VERZ.EINTRAGUNGEN (EING.)------
  6847'                  C      KY.WEI:
  6847'   F1             C      	POP	AF
  6848'   C5             C      	PUSH	BC
  6849'   AF             C      	XOR	A
  684A'   57             C      	LD	D,A
  684B'   3A EC85        C      	LD	A,(BC.VTABE+3)
  684E'   47             C      	LD	B,A
  684F'   05             C      	DEC	B
  6850'   21 F902        C      	LD	HL,BC.TAB2
  6853'   FD 21 F96A     C      	LD	IY,BC.TAB2A
  6857'   DD 21 ECA2     C      	LD	IX,BC.VTABE+32
  685B'                  C      KY.ZYK:
  685B'   14             C      	INC	D
  685C'   7E             C      	LD	A,(HL)
  685D'   DD BE 17       C      	CP	(IX+23)
  6860'   20 0B          C      	JR	NZ,KY.NE
  6862'   7A             C      	LD	A,D
  6863'   FD 77 00       C      	LD	(IY+0),A
  6866'   FD 36 01 FF    C      	LD	(IY+1),0FFH
  686A'   23             C      	INC	HL
  686B'   FD 23          C      	INC	IY
  686D'                  C      KY.NE:
  686D'   C5             C      	PUSH	BC
  686E'   01 0020        C      	LD	BC,32
  6871'   DD 09          C      	ADD	IX,BC
  6873'   C1             C      	POP	BC
  6874'   10 E5          C      	DJNZ	KY.ZYK
                         C      ;------------------------------------AUFBAU AUSGABEVERZ.-----
  6876'   3A E005        C      	LD	A,(BC.VTABA+3)
  6879'   47             C      	LD	B,A
  687A'   FE 01          C      	CP	01H
  687C'   28 08          C      	JR	Z,KY.EVZ
  687E'   21 E002        C      	LD	HL,BC.VTABA
  6881'   CD 69EA'       C      	CALL	KU.VVOR
  6884'   18 03          C      	JR	KY.EVZ1
  6886'                  C      KY.EVZ:
  6886'   21 E022        C      	LD	HL,BC.VTABA+32
  6889'                  C      KY.EVZ1:
  6889'   DD 21 F96A     C      	LD	IX,BC.TAB2A
  688D'   FD 21 F9D2     C      	LD	IY,BC.TAB3
  6891'   EB             C      	EX	DE,HL
  6892'   21 ECA2        C      	LD	HL,BC.VTABE+32
'Kopieren von MRES-Kassetten Teil 2'	MACRO-80 3.44	09-Dec-81	PAGE	1-52


  6895'   DD 7E 00       C      	LD	A,(IX+0)
  6898'   FE 01          C      	CP	01H
  689A'   28 05          C      	JR	Z,KY.VSTR
  689C'   3D             C      	DEC	A
  689D'   47             C      	LD	B,A
  689E'   CD 69EA'       C      	CALL	KU.VVOR
  68A1'                  C      KY.VSTR:
  68A1'   01 0020        C      	LD	BC,32
  68A4'   ED B0          C      	LDIR
  68A6'   FD 7E 00       C      	LD	A,(IY+0)
  68A9'   EB             C      	EX	DE,HL
  68AA'   01 0009        C      	LD	BC,9
  68AD'   B7             C      	OR	A
  68AE'   ED 42          C      	SBC	HL,BC
  68B0'   77             C      	LD	(HL),A
  68B1'   09             C      	ADD	HL,BC
  68B2'   EB             C      	EX	DE,HL
  68B3'   DD 7E 01       C      	LD	A,(IX+1)
  68B6'   FE FF          C      	CP	0FFH
  68B8'   28 10          C      	JR	Z,KY.COPY
  68BA'   DD 96 00       C      	SUB	(IX+0)
  68BD'   3D             C      	DEC	A
  68BE'   47             C      	LD	B,A
  68BF'   FE 00          C      	CP	00H
  68C1'   C4 69EA'       C      	CALL	NZ,KU.VVOR
  68C4'   FD 23          C      	INC	IY
  68C6'   DD 23          C      	INC	IX
  68C8'   18 D7          C      	JR	KY.VSTR
                         C      ;------------------------------------VERZ.SCHREIBEN (NUR NEUE SAETZE)---
  68CA'                  C      KY.COPY:
  68CA'   DD 21 2B01'    C      	LD	IX,UB.KTAB
  68CE'   CD 6D7E'       C      	CALL	U1.KTIN1
  68D1'   DD 36 0A 20    C      	LD	(IX+10),20H
  68D5'   CD 6CF9'       C      	CALL	U1.AUS
  68D8'   3A E005        C      	LD	A,(BC.VTABA+3)
  68DB'   47             C      	LD	B,A
  68DC'   CD 6AB6'       C      	CALL	UR.KBV	;AUSGABEKASSETTE
  68DF'   3D             C      	DEC	A
  68E0'   20 FA          C      	JR	NZ,$-4	;VORSTELLEN BIS HINTER LETZTEN ALTEN
  68E2'   21 E002        C      	LD	HL,BC.VTABA	;VERZ.SATZ
  68E5'   11 0020        C      	LD	DE,32
  68E8'   19             C      	ADD	HL,DE
  68E9'   10 FA          C      	DJNZ	$-4	;AUSGABEVERZ.ZEIGER
  68EB'   C1             C      	POP	BC
  68EC'   78             C      	LD	A,B
  68ED'   F5             C      	PUSH	AF
  68EE'                  C      KY.VSCHR:
  68EE'   11 0E66        C      	LD	DE,UE.PUF
  68F1'   01 0020        C      	LD	BC,32
  68F4'   ED B0          C      	LDIR
  68F6'   CD 6AB6'       C      	CALL	UR.KBV
  68F9'   CD 6ABC'       C      	CALL	UR.KBR
  68FC'   DD 36 05 08    C      	LD	(IX+5),08H
  6900'   CD 5668'       C      	CALL	UF.EXEC
  6903'   3D             C      	DEC	A
  6904'   20 E8          C      	JR	NZ,KY.VSCHR
                         C      ;----------------------------------------------------------------
  6906'   11 33FA        C      	LD	DE,33FAH	;''ES WIRD KOPIERT''
  6909'   21 69B6'       C      	LD	HL,KY.EWK
  690C'   01 0010        C      	LD	BC,16
  690F'   ED B0          C      	LDIR
                         C      ;------------------------------KOPIEREN--------------------------
  6911'   21 F902        C      	LD	HL,BC.TAB2
  6914'   11 F9D2        C      	LD	DE,BC.TAB3
  6917'   FD 21 F96A     C      	LD	IY,BC.TAB2A
  691B'   1A             C      	LD	A,(DE)
  691C'   47             C      	LD	B,A
  691D'   04             C      	INC	B
  691E'   CD 6ACB'       C      	CALL	UR.POSIK
  6921'   7E             C      	LD	A,(HL)
  6922'   47             C      	LD	B,A
  6923'   04             C      	INC	B
  6924'                  C      KY.KOPV:
  6924'   CD 6CF0'       C      	CALL	U1.EIN
  6927'   CD 6ACB'       C      	CALL	UR.POSIK
  692A'                  C      KY.KOP:
  692A'   CD 6CAD'       C      	CALL	U1.BREAD
  692D'   7E             C      	LD	A,(HL)
  692E'   FE 01          C      	CP	01H
  6930'   CC 6D09'       C      	CALL	Z,U1.VSX
                         C      ;------------------------ANZEIGE WELCHE DATEI KOPIERT WIRD-------------
  6933'   E5             C      	PUSH	HL
  6934'   D5             C      	PUSH	DE
'Kopieren von MRES-Kassetten Teil 2'	MACRO-80 3.44	09-Dec-81	PAGE	1-53


  6935'   FD 7E 00       C      	LD	A,(IY+0)
  6938'   47             C      	LD	B,A
  6939'   05             C      	DEC	B
  693A'   21 ECA2        C      	LD	HL,BC.VTABE+32
  693D'   FE 01          C      	CP	01H
  693F'   28 03          C      	JR	Z,KY.KOPAN
  6941'   CD 69EA'       C      	CALL	KU.VVOR
  6944'                  C      KY.KOPAN:
  6944'   11 34F0        C      	LD	DE,34F0H
  6947'   01 0006        C      	LD	BC,6
  694A'   ED B0          C      	LDIR
  694C'   13             C      	INC	DE
  694D'   13             C      	INC	DE
  694E'   01 0002        C      	LD	BC,2
  6951'   ED B0          C      	LDIR
  6953'   FD 23          C      	INC	IY
  6955'   D1             C      	POP	DE
  6956'   E1             C      	POP	HL
                         C      ;--------------------------------------------------------------------
  6957'   1A             C      	LD	A,(DE)
  6958'   FE 01          C      	CP	01H
  695A'   CC 6D02'       C      	CALL	Z,U1.VS1
  695D'   32 0E66        C      	LD	(UE.PUF),A
  6960'   CD 6CB8'       C      	CALL	U1.BWRIT
  6963'   CD 6CC7'       C      	CALL	U1.COPB
  6966'   23             C      	INC	HL
  6967'   7E             C      	LD	A,(HL)
  6968'   FE FF          C      	CP	0FFH
  696A'   28 0B          C      	JR	Z,KY.EOV
  696C'   2B             C      	DEC	HL
  696D'   96             C      	SUB	(HL)
  696E'   23             C      	INC	HL
  696F'   13             C      	INC	DE
  6970'   47             C      	LD	B,A
  6971'   FE 01          C      	CP	01H
  6973'   20 AF          C      	JR	NZ,KY.KOPV
  6975'   18 B3          C      	JR	KY.KOP
                         C      ;-------------------------------------------------------------
  6977'                  C      KY.EOV:
  6977'   CD 6D09'       C      	CALL	U1.VSX
  697A'   3A E003        C      	LD	A,(BC.VTABA+1)
  697D'   47             C      	LD	B,A
  697E'   F1             C      	POP	AF
  697F'   F5             C      	PUSH	AF
  6980'   80             C      	ADD	A,B
  6981'   32 0E66        C      	LD	(UE.PUF),A
  6984'   CD 6D7E'       C      	CALL	U1.KTIN1
  6987'   DD 36 0A 20    C      	LD	(IX+10),20H
  698B'   CD 6CB8'       C      	CALL	U1.BWRIT
  698E'   CD 6AB0'       C      	CALL	UR.KSL
  6991'   CD 670A'       C      	CALL	KX.ENDR
  6994'   CD 6A86'       C      	CALL	UR.KRE
  6997'   CD 6D19'       C      	CALL	U1.DSVG
  699A'   F1             C      	POP	AF
  699B'   F5             C      	PUSH	AF
  699C'   81             C      	ADD	A,C	;NEXT RECORD UND
  699D'   32 0E67        C      	LD	(UE.PUF+1),A
  69A0'   F1             C      	POP	AF
  69A1'   80             C      	ADD	A,B	;ANZAHL VERZ.EINTR. KORRIGIEREN
  69A2'   32 0E69        C      	LD	(UE.PUF+3),A
  69A5'   CD 6ABC'       C      	CALL	UR.KBR
  69A8'   DD 36 05 08    C      	LD	(IX+5),08H
  69AC'   CD 5668'       C      	CALL	UF.EXEC	;NEUEN DS-SATZ SCHREIBEN
  69AF'   CD 6A8E'       C      	CALL	UR.KRW
  69B2'   CD 6A98'       C      	CALL	UR.KRA
  69B5'   C9             C      	RET
                         C      ;---------------------------------------------------------------
  69B6'                  C      KY.EWK:
  69B6'   45 73 20 77    C      	DB	'Es wird kopiert:'
  69BA'   69 72 64 20    C      
  69BE'   6B 6F 70 69    C      
  69C2'   65 72 74 3A    C      
                         C      ;---------------------------------------------------------------
  69C6'                  C      KY.JHL:
  69C6'   3A 2B1E'       C      	LD	A,(UB.PAR2)
  69C9'   FE 4A          C      	CP	'J'
  69CB'   20 01          C      	JR	NZ,$+3
  69CD'   77             C      	LD	(HL),A
  69CE'   C9             C      	RET
                         C      ;--------------------------------------------------------------
  69CF'                  C      KY.SATR:
  69CF'   11 2B2A'       C      	LD	DE,UB.SATZ
  69D2'   01 0036        C      	LD	BC,54
'Kopieren von MRES-Kassetten Teil 2'	MACRO-80 3.44	09-Dec-81	PAGE	1-54


  69D5'   ED B0          C      	LDIR
  69D7'   3A 3326        C      	LD	A,(UE.BWSA+326H)
  69DA'   FE 4A          C      	CP	'J'
  69DC'   CC 69E3'       C      	CALL	Z,KY.AJ
  69DF'   32 2B1E'       C      	LD	(UB.PAR2),A
  69E2'   C9             C      	RET
  69E3'                  C      KY.AJ:
  69E3'   F5             C      	PUSH	AF
  69E4'   AF             C      	XOR	A
  69E5'   32 2B2A'       C      	LD	(UB.SATZ),A
  69E8'   F1             C      	POP	AF
  69E9'   C9             C      	RET
                         C      ;--------------------------------------------------------------
                         C      ;	END
                         C      	TITLE	'Unterprogramme fuer KOPI'
                         C      	PAGE
'Unterprogramme fuer KOPI'	MACRO-80 3.44	09-Dec-81	PAGE	1-55


                         C      
                         C      ;	PN	KU
                         C      ;------------------------------------------------------------------
                         C      ;
                         C      ;          UNTERPROGRAMME FUER KOPI
                         C      ;
                         C      ;--------------------------------------------------------
  69EA'                  C      KU.VVOR:
  69EA'   C5             C      	PUSH	BC
  69EB'   01 0020        C      	LD	BC,32
  69EE'   09             C      	ADD	HL,BC
  69EF'   C1             C      	POP	BC
  69F0'   10 F8          C      	DJNZ	KU.VVOR
  69F2'   C9             C      	RET
  69F3'                  C      KU.TAB2L:
  69F3'   D1             C      	POP	DE
  69F4'   E1             C      	POP	HL
  69F5'   FD 7E 00       C      	LD	A,(IY+0)
  69F8'   FE FF          C      	CP	0FFH
  69FA'   28 22          C      	JR	Z,$+36
  69FC'   FD E5          C      	PUSH	IY
  69FE'   06 00          C      	LD	B,00H
  6A00'   FD 7E 00       C      	LD	A,(IY+0)
  6A03'   FE FF          C      	CP	0FFH
  6A05'   20 02          C      	JR	NZ,$+4
  6A07'   18 05          C      	JR	$+7
  6A09'   FD 23          C      	INC	IY
  6A0B'   04             C      	INC	B
  6A0C'   18 F2          C      	JR	$-12
  6A0E'   FD E1          C      	POP	IY
  6A10'   FD E5          C      	PUSH	IY
  6A12'   FD 7E 01       C      	LD	A,(IY+1)
  6A15'   FD 77 00       C      	LD	(IY+0),A
  6A18'   FD 23          C      	INC	IY
  6A1A'   10 F6          C      	DJNZ	$-8
  6A1C'   FD E1          C      	POP	IY
  6A1E'   C1             C      	POP	BC
  6A1F'   05             C      	DEC	B
  6A20'   78             C      	LD	A,B
  6A21'   FE 00          C      	CP	00H
  6A23'   28 03          C      	JR	Z,$+5
  6A25'   C3 6794'       C      	JP	KY.DFR
  6A28'   C3 6805'       C      	JP	KY.ATAA
  6A2B'                  C      KU.ZEIR:
  6A2B'   D1             C      	POP	DE
  6A2C'   E1             C      	POP	HL
  6A2D'   3A 2B00'       C      	LD	A,(UB.ZN)
  6A30'   D6 02          C      	SUB	2
  6A32'   FE 0D          C      	CP	13
  6A34'   30 04          C      	JR	NC,$+6
  6A36'   C1             C      	POP	BC
  6A37'   C3 6776'       C      	JP	KY.MD
  6A3A'   32 2B00'       C      	LD	(UB.ZN),A
  6A3D'   01 0029        C      	LD	BC,41
  6A40'   B7             C      	OR	A
  6A41'   ED 42          C      	SBC	HL,BC
  6A43'   FD 2B          C      	DEC	IY
  6A45'   7E             C      	LD	A,(HL)
  6A46'   FD BE 00       C      	CP	(IY+0)
  6A49'   CC 6A58'       C      	CALL	Z,KU.DECIY
  6A4C'   FD 23          C      	INC	IY
  6A4E'   01 0017        C      	LD	BC,23
  6A51'   B7             C      	OR	A
  6A52'   ED 42          C      	SBC	HL,BC
  6A54'   C1             C      	POP	BC
  6A55'   04             C      	INC	B
  6A56'   18 CA          C      	JR	$-52
  6A58'                  C      KU.DECIY:
  6A58'   FD 2B          C      	DEC	IY
  6A5A'   C9             C      	RET
  6A5B'                  C      KU.DD:
  6A5B'   E5             C      	PUSH	HL
  6A5C'   21 5831'       C      	LD	HL,UA.VORH
  6A5F'   CD 6B2E'       C      	CALL	UR.MIMO
  6A62'   38 17          C      	JR	C,$+25
  6A64'   7E             C      	LD	A,(HL)
  6A65'   FE 4A          C      	CP	'J'
  6A67'   28 0C          C      	JR	Z,$+14
  6A69'   FD 2B          C      	DEC	IY
  6A6B'   FD 36 00 FF    C      	LD	(IY+0),0FFH
  6A6F'   11 0050        C      	LD	DE,80
  6A72'   B7             C      	OR	A
'Unterprogramme fuer KOPI'	MACRO-80 3.44	09-Dec-81	PAGE	1-56


  6A73'   ED 52          C      	SBC	HL,DE
  6A75'   36 20          C      	LD	(HL),20H
  6A77'   21 2B00'       C      	LD	HL,UB.ZN
  6A7A'   35             C      	DEC	(HL)
  6A7B'   E1             C      	POP	HL
  6A7C'   C9             C      	RET
  6A7D'   E1             C      	POP	HL
  6A7E'   D1             C      	POP	DE
  6A7F'   DD 21 2B01'    C      	LD	IX,UB.KTAB
  6A83'   C3 670A'       C      	JP	KX.ENDR
                         C      ;	END
                                ;	
                         C      	INCLUDE K7.ASM	;Routinen fuer Kassette,Monitor UND Tastatur (UR.ASM)
                         C      	TITLE 'Routinen fuer Kassette,Monitor UND Tastatur'
                         C      	PAGE
'Routinen fuer Kassette,Monitor UND Tastatur'	MACRO-80 3.44	09-Dec-81	PAGE	1-57


                         C      
                         C      ;	PN	UR
                         C      ;	ORG	49A0H
                         C      ;----------------------------------------------------------------------
                         C      ;
                         C      ;   ROUTINEN FUER KASSETTE,MONITOR UND TASTATUR
                         C      ;
                         C      ;----------------------------------------------------------------------
                         C      ;   1.     KASSETTE
                         C      ;----------------------------------------------------------------------
  6A86'                  C      UR.KRE:
  6A86'   DD 36 05 31    C      	LD	(IX+5),31H
  6A8A'                  C      UR.KRE1:
  6A8A'   CD 5668'       C      	CALL	UF.EXEC
  6A8D'   C9             C      	RET
  6A8E'                  C      UR.KRW:
  6A8E'   DD 36 05 21    C      	LD	(IX+5),21H
  6A92'   18 F6          C      	JR	UR.KRE1	;Umspulen
  6A94'                  C      UR.KRWW:
  6A94'   CD 6A8E'       C      	CALL	UR.KRW
  6A97'   C9             C      	RET
  6A98'                  C      UR.KRA:
  6A98'   DD 36 05 41    C      	LD	(IX+5),41H
  6A9C'   18 EC          C      	JR	UR.KRE1	;Reservieren aus
  6A9E'                  C      UR.KLV:
  6A9E'   DD 36 05 71    C      	LD	(IX+5),71H
  6AA2'   18 E6          C      	JR	UR.KRE1	;Label vorsetzen
  6AA4'                  C      UR.KLR:
  6AA4'   DD 36 05 75    C      	LD	(IX+5),75H
  6AA8'   18 E0          C      	JR	UR.KRE1	;LABEL RUECKSETZEN
  6AAA'                  C      UR.KBM:
  6AAA'   DD 36 05 51    C      	LD	(IX+5),51H
  6AAE'   18 DA          C      	JR	UR.KRE1	;BANDMARKE SCHREIBEN
  6AB0'                  C      UR.KSL:
  6AB0'   DD 36 05 61    C      	LD	(IX+5),61H
  6AB4'   18 D4          C      	JR	UR.KRE1	;SCHLUSSLUECKE SCHREIBEN
  6AB6'                  C      UR.KBV:
  6AB6'   DD 36 05 11    C      	LD	(IX+5),11H
  6ABA'   18 CE          C      	JR	UR.KRE1	;Block vorsetzen
  6ABC'                  C      UR.KBR:
  6ABC'   DD 36 05 15    C      	LD	(IX+5),15H
  6AC0'   18 C8          C      	JR	UR.KRE1
                         C      ;--------------------------------------------------------------------
  6AC2'                  C      UR.RPOS:
  6AC2'   E5             C      	PUSH	HL
  6AC3'   D5             C      	PUSH	DE
  6AC4'   F5             C      	PUSH	AF
  6AC5'   C5             C      	PUSH	BC
  6AC6'   AF             C      	XOR	A
  6AC7'   3D             C      	DEC	A
  6AC8'   4F             C      	LD	C,A
  6AC9'   18 06          C      	JR	POSIK1
  6ACB'                  C      UR.POSIK:
  6ACB'   E5             C      	PUSH	HL
  6ACC'   D5             C      	PUSH	DE
  6ACD'   F5             C      	PUSH	AF
  6ACE'   C5             C      	PUSH	BC	;Positionieren
  6ACF'   AF             C      	XOR	A
  6AD0'   4F             C      	LD	C,A
  6AD1'                  C      POSIK1:
  6AD1'   06 00          C      	LD	B,0
  6AD3'   11 0000        C      	LD	DE,0
  6AD6'                  C      UR.LES:
  6AD6'   DD 36 05 02    C      	LD	(IX+5),02H
  6ADA'   CD 5668'       C      	CALL	UF.EXEC	;BLOCK LESEN
  6ADD'   DD 7E 02       C      	LD	A,(IX+2)
  6AE0'   FE 01          C      	CP	1	;BANDMARKE?
  6AE2'   28 19          C      	JR	Z,UR.BM
  6AE4'   04             C      	INC	B	;ANZAHL BLOECKE
  6AE5'   78             C      	LD	A,B
  6AE6'   FE 04          C      	CP	4
  6AE8'   28 21          C      	JR	Z,UR.OK
  6AEA'   21 0000        C      	LD	HL,0
  6AED'   CD 6E8C'       C      	CALL	XY.LIDX
  6AF0'   09             C      	DB	9	;HL<--BLOCKLAENGE
  6AF1'   19             C      	ADD	HL,DE
  6AF2'   EB             C      	EX	DE,HL
  6AF3'   21 012C        C      	LD	HL,300
  6AF6'   B7             C      	OR	A
  6AF7'   ED 52          C      	SBC	HL,DE
  6AF9'   38 10          C      	JR	C,UR.OK
  6AFB'   18 D9          C      	JR	UR.LES
'Routinen fuer Kassette,Monitor UND Tastatur'	MACRO-80 3.44	09-Dec-81	PAGE	1-58


  6AFD'                  C      UR.BM:
  6AFD'   AF             C      	XOR	A
  6AFE'   B1             C      	OR	C
  6AFF'   28 04          C      	JR	Z,$+6
  6B01'   C1             C      	POP	BC
  6B02'   04             C      	INC	B
  6B03'   18 C9          C      	JR	UR.POSIK+3
  6B05'   C1             C      	POP	BC
  6B06'   05             C      	DEC	B
  6B07'   28 21          C      	JR	Z,UR.RSP
  6B09'   18 C3          C      	JR	UR.POSIK+3
  6B0B'                  C      UR.OK:
  6B0B'   AF             C      	XOR	A
  6B0C'   B1             C      	OR	C
  6B0D'   28 08          C      	JR	Z,$+10
  6B0F'   DD 70 08       C      	LD	(IX+8),B
  6B12'   CD 6AA4'       C      	CALL	UR.KLR
  6B15'   18 13          C      	JR	UR.RSP
  6B17'   DD 36 05 15    C      	LD	(IX+5),15H
  6B1B'   CD 5668'       C      	CALL	UF.EXEC
  6B1E'   10 F7          C      	DJNZ	$-7
  6B20'   C1             C      	POP	BC
  6B21'   05             C      	DEC	B
  6B22'   28 06          C      	JR	Z,UR.RSP
  6B24'   DD 70 08       C      	LD	(IX+8),B
  6B27'   CD 6A9E'       C      	CALL	UR.KLV
  6B2A'                  C      UR.RSP:
  6B2A'   F1             C      	POP	AF
  6B2B'   D1             C      	POP	DE
  6B2C'   E1             C      	POP	HL
  6B2D'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
                         C      ;     2.     MONITOR
                         C      ;----------------------------------------------------------------------
  6B2E'                  C      UR.MIMO:
  6B2E'   D5             C      	PUSH	DE	;Register DE, BC retten
  6B2F'   C5             C      	PUSH	BC
  6B30'   46             C      	LD	B,(HL)	;Anzahl einzugebender Zeichen
  6B31'   23             C      	INC	HL
  6B32'   4E             C      	LD	C,(HL)	;Laenge der Zeichenkette
  6B33'   23             C      	INC	HL
  6B34'   5E             C      	LD	E,(HL)	;Zeichenschluessel
  6B35'   23             C      	INC	HL
  6B36'   3A 2B00'       C      	LD	A,(UB.ZN)	;Zeilennummer
  6B39'   57             C      	LD	D,A	;D:= Zeilennummer
  6B3A'   AF             C      	XOR	A
  6B3B'   B9             C      	CP	C
  6B3C'   28 0C          C      	JR	Z,UR.MIMO1	;Anzeige entfaellt
  6B3E'   D5             C      	PUSH	DE
  6B3F'   CD 6B70'       C      	CALL	UR.DSPZK	;Anzeige
  6B42'                  C      UR.MIMO2:
  6B42'   D1             C      	POP	DE
  6B43'   CD 6B7D'       C      	CALL	UR.ZINP	;Zeicheneingabe ueber Tastatur
  6B46'   C1             C      	POP	BC
  6B47'   D1             C      	POP	DE
  6B48'   18 07          C      	JR	UR.MIMO3
  6B4A'                  C      UR.MIMO1:
  6B4A'   D5             C      	PUSH	DE
  6B4B'   CD 6B60'       C      	CALL	UR.BBSAD	;BWS - Adresse berechnen
  6B4E'   EB             C      	EX	DE,HL	;HL:= akt. Bildschirmposition
  6B4F'   18 F1          C      	JR	UR.MIMO2
  6B51'                  C      UR.MIMO3:
  6B51'   F5             C      	PUSH	AF
  6B52'   3A 2B00'       C      	LD	A,(UB.ZN)
  6B55'   3C             C      	INC	A
  6B56'   FE 18          C      	CP	24
  6B58'   CC 6C60'       C      	CALL	Z,UR.BILRO	;Zeile 24 ---> Bild rollen
  6B5B'   32 2B00'       C      	LD	(UB.ZN),A
  6B5E'   F1             C      	POP	AF
  6B5F'   C9             C      	RET
  6B60'                  C      UR.BBSAD:
  6B60'   E5             C      	PUSH	HL	;Berechnung der BWS-Adresse
  6B61'   C5             C      	PUSH	BC	;IN:    D...Zeilennummer
  6B62'   21 2FB0        C      	LD	HL,UE.BWSA-80	;OUT:   DE..BWS-Adresse
  6B65'   01 0050        C      	LD	BC,80	;BC:= Zeichen/Zeile
  6B68'                  C      UR.BBSA1:
  6B68'   09             C      	ADD	HL,BC
  6B69'   15             C      	DEC	D
  6B6A'   20 FC          C      	JR	NZ,UR.BBSA1
  6B6C'   EB             C      	EX	DE,HL
  6B6D'   C1             C      	POP	BC
  6B6E'   E1             C      	POP	HL
  6B6F'   C9             C      	RET
'Routinen fuer Kassette,Monitor UND Tastatur'	MACRO-80 3.44	09-Dec-81	PAGE	1-59


  6B70'                  C      UR.DSPZK:
  6B70'   D5             C      	PUSH	DE	;Anzeige
  6B71'   C5             C      	PUSH	BC	;IN   HL...Anfangsadresse ZK
  6B72'   CD 6B60'       C      	CALL	UR.BBSAD	;      D...Zeilennummer
  6B75'   06 00          C      	LD	B,0	;      C...Zeichenkettenlaenge
  6B77'   ED B0          C      	LDIR		;OUT  HL...akt. BWS-Adresse
  6B79'   EB             C      	EX	DE,HL
  6B7A'   C1             C      	POP	BC
  6B7B'   D1             C      	POP	DE
  6B7C'   C9             C      	RET
  6B7D'                  C      UR.ZINP:
  6B7D'   E5             C      	PUSH	HL	;Zeicheneingabe ueber Tastatur
  6B7E'   AF             C      	XOR	A	;IN    B...Zeichenanzahl (max.)
  6B7F'   50             C      	LD	D,B	;     HL...akt. Adresse
  6B80'   B8             C      	CP	B	;      E...Zeichenschluessel
  6B81'   28 3D          C      	JR	Z,UR.RET0	;keine Zeicheneingabe
  6B83'                  C      UR.ZINP1:
  6B83'   CD 4033        C      	CALL	SY.SETCHL	;Kursor setzen
  6B86'                  C      UR.ZINP2:
  6B86'   CD 6C5A'       C      	CALL	UR.TAREP	;Tastaturabfrage
  6B89'   CD 6BCA'       C      	CALL	UR.TCL	; <---
  6B8C'   CD 6BDF'       C      	CALL	UR.TCR	; --->
  6B8F'   CD 6BF2'       C      	CALL	UR.TSYS	; SYS
  6B92'   CD 6BFA'       C      	CALL	UR.TQUIT	; POS.QUIT
  6B95'   CD 6C02'       C      	CALL	UR.ZKONT	;Zeichenkontrolle
  6B98'   CD 4036        C      	CALL	SY.RESC	;Kursor loeschen
  6B9B'   77             C      	LD	(HL),A	;Zeichen anzeigen
  6B9C'   23             C      	INC	HL	;akt. Adresse erhoehen
  6B9D'   10 E4          C      	DJNZ	UR.ZINP1	;B > 0, naechstes Zeichen
  6B9F'   CD 4033        C      	CALL	SY.SETCHL	;Kursor setzen
  6BA2'                  C      UR.ZINP5:
  6BA2'   CD 6C5A'       C      	CALL	UR.TAREP
  6BA5'   FE F7          C      	CP	UE.TACL
  6BA7'   CC 6BC3'       C      	CALL	Z,UR.ZINP7
  6BAA'   FE 1E          C      	CP	UE.TAQUI
  6BAC'   28 06          C      	JR	Z,UR.ZINP3	;---> POS.QUIT
  6BAE'   FE CD          C      	CP	UE.TASYS
  6BB0'   28 08          C      	JR	Z,UR.ZINP4	;---> SYS
  6BB2'   18 EE          C      	JR	UR.ZINP5
  6BB4'                  C      UR.ZINP3:
  6BB4'   CD 4036        C      	CALL	SY.RESC	;Kursor loeschen
  6BB7'   E1             C      	POP	HL	;BWS - Adresse auskellern
  6BB8'   AF             C      	XOR	A	;CY:= 0
  6BB9'   C9             C      	RET
  6BBA'                  C      UR.ZINP4:
  6BBA'   CD 4036        C      	CALL	SY.RESC	;Kursor loeschen
  6BBD'   E1             C      	POP	HL
  6BBE'   37             C      	SCF		;CY:= 1
  6BBF'   C9             C      	RET
  6BC0'                  C      UR.RET0:
  6BC0'   E1             C      	POP	HL	;keine Zeicheneingabe
  6BC1'   AF             C      	XOR	A
  6BC2'   C9             C      	RET
  6BC3'                  C      UR.ZINP7:
  6BC3'   CD 6BCA'       C      	CALL	UR.TCL
  6BC6'   33             C      	INC	SP
  6BC7'   33             C      	INC	SP
  6BC8'   18 BC          C      	JR	UR.ZINP2
  6BCA'                  C      UR.TCL:
  6BCA'   FE F7          C      	CP	UE.TACL	;   <---
  6BCC'   C0             C      	RET	NZ		;Taste nicht gedrueckt
  6BCD'   F5             C      	PUSH	AF	;Tastencode retten
  6BCE'   04             C      	INC	B
  6BCF'   7A             C      	LD	A,D
  6BD0'   B8             C      	CP	B
  6BD1'   38 09          C      	JR	C,UR.TCLN	;Linksbewegung nicht zulaessig
  6BD3'   CD 4036        C      	CALL	SY.RESC	;Kursor loeschen
  6BD6'   2B             C      	DEC	HL	;BWS - Adresse decrementieren
  6BD7'   CD 4033        C      	CALL	SY.SETCHL	;Kursor setzen
  6BDA'   F1             C      	POP	AF	;Code auskellern
  6BDB'   C9             C      	RET
  6BDC'                  C      UR.TCLN:
  6BDC'   05             C      	DEC	B
  6BDD'   F1             C      	POP	AF
  6BDE'   C9             C      	RET
  6BDF'                  C      UR.TCR:
  6BDF'   FE F9          C      	CP	UE.TACR	;   --->
  6BE1'   C0             C      	RET	NZ
  6BE2'   F5             C      	PUSH	AF
  6BE3'   78             C      	LD	A,B
  6BE4'   FE 02          C      	CP	2
  6BE6'   38 08          C      	JR	C,UR.TCRN
  6BE8'   05             C      	DEC	B
'Routinen fuer Kassette,Monitor UND Tastatur'	MACRO-80 3.44	09-Dec-81	PAGE	1-60


  6BE9'   CD 4036        C      	CALL	SY.RESC
  6BEC'   23             C      	INC	HL
  6BED'   CD 4033        C      	CALL	SY.SETCHL
  6BF0'                  C      UR.TCRN:
  6BF0'   F1             C      	POP	AF
  6BF1'   C9             C      	RET
  6BF2'                  C      UR.TSYS:
  6BF2'   FE CD          C      	CP	UE.TASYS	; SYS-Taste
  6BF4'   C0             C      	RET	NZ
  6BF5'   33             C      	INC	SP
  6BF6'   33             C      	INC	SP	;Returnadresse uebergehen
  6BF7'   C3 6BBA'       C      	JP	UR.ZINP4
  6BFA'                  C      UR.TQUIT:
  6BFA'   FE 1E          C      	CP	UE.TAQUI	; POS.QUIT
  6BFC'   C0             C      	RET	NZ
  6BFD'   33             C      	INC	SP
  6BFE'   33             C      	INC	SP
  6BFF'   C3 6BB4'       C      	JP	UR.ZINP3
  6C02'                  C      UR.ZKONT:
  6C02'   FE 7F          C      	CP	7FH
  6C04'   30 22          C      	JR	NC,UR.ZKON1
  6C06'   CB 7B          C      	BIT	7,E	;Zeichenschluesselauswertung
  6C08'   C0             C      	RET	NZ		;Bit 7 = L, alle Tasten erlaubt
  6C09'   FE 20          C      	CP	20H
  6C0B'   C8             C      	RET	Z		;Leertaste
  6C0C'   CB 6B          C      	BIT	5,E
  6C0E'   37             C      	SCF
  6C0F'   C4 6C2D'       C      	CALL	NZ,UR.ALPHA
  6C12'   D0             C      	RET	NC		;Bit 5 = L, nur Buchstaben
  6C13'   CB 63          C      	BIT	4,E
  6C15'   37             C      	SCF
  6C16'   C4 6C38'       C      	CALL	NZ,UR.NUM
  6C19'   D0             C      	RET	NC		;Bit 4 = L, nur Ziffern
  6C1A'   CB 73          C      	BIT	6,E
  6C1C'   37             C      	SCF
  6C1D'   C4 6C41'       C      	CALL	NZ,UR.ALPNU
  6C20'   D0             C      	RET	NC		;Bit 6 = L, Buchstaben und
                         C      			;            Ziffern
  6C21'   CB 5B          C      	BIT	3,E
  6C23'   37             C      	SCF
  6C24'   C4 6C4B'       C      	CALL	NZ,UR.HEXAZ
  6C27'   D0             C      	RET	NC		;BIT 3 = L ,HEXAZEICHEN
  6C28'                  C      UR.ZKON1:
  6C28'   33             C      	INC	SP
  6C29'   33             C      	INC	SP
  6C2A'   C3 6B86'       C      	JP	UR.ZINP2	;unerlaubter Tastencode
  6C2D'                  C      UR.ALPHA:
  6C2D'   FE 41          C      	CP	41H
  6C2F'   D8             C      	RET	C
  6C30'   FE 5B          C      	CP	5BH
  6C32'   38 02          C      	JR	C,UR.ALPH1
  6C34'   37             C      	SCF
  6C35'   C9             C      	RET
  6C36'                  C      UR.ALPH1:
  6C36'   3F             C      	CCF
  6C37'   C9             C      	RET
  6C38'                  C      UR.NUM:
  6C38'   FE 30          C      	CP	30H
  6C3A'   D8             C      	RET	C
  6C3B'   FE 3A          C      	CP	3AH
  6C3D'   38 F7          C      	JR	C,UR.ALPH1
  6C3F'   37             C      	SCF
  6C40'   C9             C      	RET
  6C41'                  C      UR.ALPNU:
  6C41'   CD 6C2D'       C      	CALL	UR.ALPHA
  6C44'   D0             C      	RET	NC
  6C45'   CD 6C38'       C      	CALL	UR.NUM
  6C48'   D0             C      	RET	NC
  6C49'   37             C      	SCF
  6C4A'   C9             C      	RET
  6C4B'                  C      UR.HEXAZ:
  6C4B'   CD 6C38'       C      	CALL	UR.NUM
  6C4E'   D0             C      	RET	NC
  6C4F'   FE 41          C      	CP	'A'
  6C51'   D8             C      	RET	C
  6C52'   FE 47          C      	CP	'G'
  6C54'   38 02          C      	JR	C,UR.HEXZ1
  6C56'   37             C      	SCF
  6C57'   C9             C      	RET
  6C58'                  C      UR.HEXZ1:
  6C58'   3F             C      	CCF
  6C59'   C9             C      	RET
                         C      
'Routinen fuer Kassette,Monitor UND Tastatur'	MACRO-80 3.44	09-Dec-81	PAGE	1-61


  6C5A'                  C      UR.TAREP:
  6C5A'   CD 4026        C      	CALL	TA.ABFR1	;TASTATURROUTINE FUER ATS
  6C5D'   28 FB          C      	JR	Z,$-3	;ES LIEGT KEIN ZEICHEN AN
  6C5F'   C9             C      	RET
                         C      
  6C60'                  C      UR.BILRO:
  6C60'   C5             C      	PUSH	BC
  6C61'   D5             C      	PUSH	DE
  6C62'   E5             C      	PUSH	HL
  6C63'   01 03C0        C      	LD	BC,960
  6C66'   11 3370        C      	LD	DE,UE.BWSA+880
  6C69'   21 33C0        C      	LD	HL,UE.BWSA+960
  6C6C'   ED B0          C      	LDIR
  6C6E'   3E 20          C      	LD	A,20H	;letzte Zeile loeschen
  6C70'   06 50          C      	LD	B,80
  6C72'                  C      UR.BILR1:
  6C72'   12             C      	LD	(DE),A
  6C73'   10 FD          C      	DJNZ	UR.BILR1
  6C75'   E1             C      	POP	HL
  6C76'   AF             C      	XOR	A
  6C77'   01 0050        C      	LD	BC,80
  6C7A'   ED 42          C      	SBC	HL,BC	;aktuelle BWS-Adresse nach  ROLL
  6C7C'   3A 2B00'       C      	LD	A,(UB.ZN)
  6C7F'   D1             C      	POP	DE
  6C80'   C1             C      	POP	BC
  6C81'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
                         C      ;	END
                                ;	
                                ;	INCLUDE	U1.ASM	;Allgemeine Unterprogramme
                                ;	INCLUDE	XY.ASM	;Handling f. IX/IY-adressierte Bereiche
                                ;	INCLUDE	UC.ASM	;Konvertierungen
                                ;	INCLUDE	CP.ASM	;Komprimierung
                                ;	INCLUDE	DC.ASM	;Dekomprimierung
                                ;	INCLUDE	UK.ASM	;Einzelzeicheneingabe fuer KMBG
                         C      	INCLUDE K8.ASM	;Allgemeine Unterprogramme
                         C      	TITLE	'Allgemeine Unterprogramme'
                         C      	PAGE
'Allgemeine Unterprogramme'	MACRO-80 3.44	09-Dec-81	PAGE	1-62


                         C      
                         C      ;	PN	U1
                         C      ;----------------------------------------------------------------------
                         C      ;
                         C      ;        Allgemeine Unterprogramme
                         C      ;
                         C      ;----------------------------------------------------------------------
  6C82'                  C      U1.RSAVE:
  6C82'   E3             C      	EX	(SP),HL	;Register retten (nicht AF)
  6C83'   D5             C      	PUSH	DE
  6C84'   C5             C      	PUSH	BC
  6C85'   FD E5          C      	PUSH	IY
  6C87'   DD E5          C      	PUSH	IX
  6C89'   E9             C      	JP	(HL)
  6C8A'                  C      U1.RRST:
  6C8A'   E1             C      	POP	HL	;Register wieder herstellen
  6C8B'   DD E1          C      	POP	IX
  6C8D'   FD E1          C      	POP	IY
  6C8F'   C1             C      	POP	BC
  6C90'   D1             C      	POP	DE
  6C91'   E3             C      	EX	(SP),HL
  6C92'   C9             C      	RET
  6C93'                  C      U1.CLRB:
  6C93'   E5             C      	PUSH	HL	;Bereich loeschen
  6C94'   D5             C      	PUSH	DE
  6C95'   C5             C      	PUSH	BC
  6C96'   E5             C      	PUSH	HL	;IN:  HL= Bereichsanfang
  6C97'   D1             C      	POP	DE	;     BC= Bereichslaenge
  6C98'   13             C      	INC	DE
  6C99'   AF             C      	XOR	A
  6C9A'   77             C      	LD	(HL),A
  6C9B'   0B             C      	DEC	BC
  6C9C'   ED B0          C      	LDIR
  6C9E'   C1             C      	POP	BC
  6C9F'   D1             C      	POP	DE
  6CA0'   E1             C      	POP	HL
  6CA1'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  6CA2'                  C      U1.KBR4:
  6CA2'   C5             C      	PUSH	BC
  6CA3'   06 04          C      	LD	B,4
  6CA5'   CD 6ABC'       C      	CALL	UR.KBR
  6CA8'   10 FB          C      	DJNZ	$-3
  6CAA'   C1             C      	POP	BC
  6CAB'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  6CAC'                  C      U1.WAIT:
                         C      	; PUSH	AF
                         C      	; CALL	UE.BERT
                         C      	; JR	C,$-3
                         C      	; POP	AF
  6CAC'   C9             C      	RET
                         C      ;--------------------------------------------------------------------
  6CAD'                  C      U1.BREAD:
  6CAD'   CD 6CF0'       C      	CALL	U1.EIN	;BLOCK LESEN VON EINGABE
  6CB0'   DD 36 05 02    C      	LD	(IX+5),02H
  6CB4'   CD 5668'       C      	CALL	UF.EXEC
  6CB7'   C9             C      	RET
  6CB8'                  C      U1.BWRIT:
  6CB8'   CD 6CF9'       C      	CALL	U1.AUS	;BLOCK SCHREIBEN AUF AUSGABE
  6CBB'   DD 36 05 08    C      	LD	(IX+5),08H
  6CBF'   CD 5668'       C      	CALL	UF.EXEC
  6CC2'   C9             C      	RET
  6CC3'                  C      U1.COPB2:
  6CC3'   F5             C      	PUSH	AF
  6CC4'   37             C      	SCF
  6CC5'   18 02          C      	JR	$+4
  6CC7'                  C      U1.COPB:
  6CC7'   F5             C      	PUSH	AF
  6CC8'   B7             C      	OR	A
  6CC9'   CD 6CF0'       C      	CALL	U1.EIN
  6CCC'   DD 36 05 02    C      	LD	(IX+5),02H
  6CD0'   DC 6729'       C      	CALL	C,KX.EXEC2
  6CD3'   D4 5668'       C      	CALL	NC,UF.EXEC
  6CD6'   F5             C      	PUSH	AF
  6CD7'   CD 6CF9'       C      	CALL	U1.AUS
  6CDA'   DD 7E 09       C      	LD	A,(IX+9)
  6CDD'   DD B6 0A       C      	OR	(IX+10)
  6CE0'   28 08          C      	JR	Z,$+10
  6CE2'   CD 6CB8'       C      	CALL	U1.BWRIT
  6CE5'   F1             C      	POP	AF
  6CE6'   38 DC          C      	JR	C,$-34
'Allgemeine Unterprogramme'	MACRO-80 3.44	09-Dec-81	PAGE	1-63


  6CE8'   30 DE          C      	JR	NC,$-32
  6CEA'   CD 6AAA'       C      	CALL	UR.KBM
  6CED'   F1             C      	POP	AF
  6CEE'   F1             C      	POP	AF
  6CEF'   C9             C      	RET
  6CF0'                  C      U1.EIN:
  6CF0'   F5             C      	PUSH	AF
  6CF1'   3A E000        C      	LD	A,(BC.TAB1)
  6CF4'   DD 77 03       C      	LD	(IX+3),A
  6CF7'   F1             C      	POP	AF
  6CF8'   C9             C      	RET
  6CF9'                  C      U1.AUS:
  6CF9'   F5             C      	PUSH	AF
  6CFA'   3A E001        C      	LD	A,(BC.TAB1+1)
  6CFD'   DD 77 03       C      	LD	(IX+3),A
  6D00'   F1             C      	POP	AF
  6D01'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  6D02'                  C      U1.VS1:
  6D02'   E5             C      	PUSH	HL
  6D03'   C5             C      	PUSH	BC
  6D04'   F5             C      	PUSH	AF
  6D05'   3E 01          C      	LD	A,01H	;1.DATEIVORSATZ IM PUFFER
  6D07'   18 04          C      	JR	$+6
  6D09'                  C      U1.VSX:
  6D09'   E5             C      	PUSH	HL
  6D0A'   C5             C      	PUSH	BC
  6D0B'   F5             C      	PUSH	AF
  6D0C'   AF             C      	XOR	A	;00-DATEIVORSATZ IM PUFFER
  6D0D'   06 20          C      	LD	B,32
  6D0F'   21 0E66        C      	LD	HL,UE.PUF
  6D12'   CD 6E21'       C      	CALL	U1.TR
  6D15'   F1             C      	POP	AF
  6D16'   C1             C      	POP	BC
  6D17'   E1             C      	POP	HL
  6D18'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  6D19'                  C      U1.DSVG:
  6D19'   E5             C      	PUSH	HL
  6D1A'   D5             C      	PUSH	DE
  6D1B'   F5             C      	PUSH	AF
  6D1C'   06 07          C      	LD	B,7	;MRES KASSETTE ?
  6D1E'   CD 6DBD'       C      	CALL	U1.VORS1
  6D21'   11 0E6C        C      	LD	DE,UE.PUF+6
  6D24'   21 5744'       C      	LD	HL,UA.DS+6
  6D27'   06 0E          C      	LD	B,14
  6D29'   1A             C      	LD	A,(DE)
  6D2A'   BE             C      	CP	(HL)
  6D2B'   20 10          C      	JR	NZ,$+18
  6D2D'   13             C      	INC	DE
  6D2E'   23             C      	INC	HL
  6D2F'   10 F8          C      	DJNZ	$-6
  6D31'   3A 0E67        C      	LD	A,(UE.PUF+1)
  6D34'   4F             C      	LD	C,A	;C <-- NEXT RECORD
  6D35'   3A 0E69        C      	LD	A,(UE.PUF+3)
  6D38'   47             C      	LD	B,A	;B <-- ANZ.VERZ.EINTRAG.
  6D39'   F1             C      	POP	AF
  6D3A'   D1             C      	POP	DE
  6D3B'   E1             C      	POP	HL
  6D3C'   C9             C      	RET
  6D3D'   F1             C      	POP	AF
  6D3E'   D1             C      	POP	DE
  6D3F'   E1             C      	POP	HL
  6D40'   FD E1          C      	POP	IY
  6D42'   3E 90          C      	LD	A,90H
  6D44'   CD 5694'       C      	CALL	UF.ERANZ
  6D47'   C3 000B        C      	JP	UE.SYSTB
                         C      ;----------------------------------------------------------------------
  6D4A'                  C      U1.NMVGL:
  6D4A'   C5             C      	PUSH	BC
  6D4B'   D5             C      	PUSH	DE
  6D4C'   E5             C      	PUSH	HL
  6D4D'   06 06          C      	LD	B,6
  6D4F'   11 0E66        C      	LD	DE,UE.PUF
  6D52'   1A             C      	LD	A,(DE)
  6D53'   BE             C      	CP	(HL)	;HL:ZU SUCHENDER PROGR.NAME
  6D54'   20 0C          C      	JR	NZ,$+14
  6D56'   23             C      	INC	HL
  6D57'   13             C      	INC	DE
  6D58'   10 F8          C      	DJNZ	$-6
  6D5A'   3A 0E7D        C      	LD	A,(UE.PUF+23)	;LABELNR. -->A
  6D5D'   37             C      	SCF		;CY=1,WENN PROGR. GEFUNDEN
  6D5E'   E1             C      	POP	HL
'Allgemeine Unterprogramme'	MACRO-80 3.44	09-Dec-81	PAGE	1-64


  6D5F'   D1             C      	POP	DE
  6D60'   C1             C      	POP	BC
  6D61'   C9             C      	RET
  6D62'   B7             C      	OR	A
  6D63'   18 F9          C      	JR	$-5
                         C      ;----------------------------------------------------------------------
  6D65'                  C      U1.KTINI:
  6D65'   E5             C      	PUSH	HL
  6D66'   C5             C      	PUSH	BC
  6D67'   F5             C      	PUSH	AF
  6D68'   CD 6E2C'       C      	CALL	U1.BILO	;UNTERE HAELFTE BS LOESCHEN
  6D6B'   DD 21 2B01'    C      	LD	IX,UB.KTAB	;ADR. STEUERTAB. F.KASS.ROUTINE
  6D6F'   DD E5          C      	PUSH	IX
  6D71'   E1             C      	POP	HL
  6D72'   AF             C      	XOR	A
  6D73'   06 1B          C      	LD	B,27
  6D75'   CD 6E21'       C      	CALL	U1.TR	;TAB. AUF 00 LOESCHEN
  6D78'   DD 36 03 30    C      	LD	(IX+3),30H
                         C      ;	CALL	UE.KINI
  6D7C'   18 03          C      	JR	$+5
  6D7E'                  C      U1.KTIN1:
  6D7E'   E5             C      	PUSH	HL
  6D7F'   C5             C      	PUSH	BC
  6D80'   F5             C      	PUSH	AF
                         C      ;	LD	(IX+11),7	;ANZAHL LESE/SCHREIBWDHLGNN
                         C      ;	LD	(IX+12),4	;ANZAHL
  6D81'   21 0E66        C      	LD	HL,UE.PUF
  6D84'   CD 6EAC'       C      	CALL	XY.STIDX
  6D87'   07             C      	DB	7	;SYSTEMPUFFERADR.-->TAB
  6D88'   21 8010        C      	LD	HL,UE.KPUFF
  6D8B'   CD 6E9C'       C      	CALL	XY.STDX
  6D8E'   19             C      	DB	25	;E/A PUFFERADR.-->TAB	;???
  6D8F'   F1             C      	POP	AF
  6D90'   C1             C      	POP	BC
  6D91'   E1             C      	POP	HL
  6D92'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  6D93'                  C      U1.VERIN:
  6D93'   E5             C      	PUSH	HL
  6D94'   C5             C      	PUSH	BC
  6D95'   F5             C      	PUSH	AF
  6D96'   11 EC82        C      	LD	DE,BC.VTABE	;VERZ. EINGABEGER. EINLESEN
  6D99'   18 03          C      	JR	$+5
  6D9B'                  C      U1.VERNI:
  6D9B'   E5             C      	PUSH	HL
  6D9C'   C5             C      	PUSH	BC
  6D9D'   F5             C      	PUSH	AF
  6D9E'   3A 0E69        C      	LD	A,(UE.PUF+3)	;ANZ. DATEIEN-->B
  6DA1'   47             C      	LD	B,A
  6DA2'   C5             C      	PUSH	BC
  6DA3'   21 0E66        C      	LD	HL,UE.PUF
  6DA6'   01 0020        C      	LD	BC,32
  6DA9'   ED B0          C      	LDIR
  6DAB'   CD 5668'       C      	CALL	UF.EXEC
  6DAE'   C1             C      	POP	BC
  6DAF'   10 F1          C      	DJNZ	$-13
  6DB1'   F1             C      	POP	AF
  6DB2'   C1             C      	POP	BC
  6DB3'   E1             C      	POP	HL
  6DB4'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  6DB5'                  C      U1.VORST:
  6DB5'   C5             C      	PUSH	BC
  6DB6'   CD 6A94'       C      	CALL	UR.KRWW
  6DB9'   06 06          C      	LD	B,6
  6DBB'   18 01          C      	JR	$+3
  6DBD'                  C      U1.VORS1:
  6DBD'   C5             C      	PUSH	BC
  6DBE'   DD 36 05 02    C      	LD	(IX+5),02H
  6DC2'   CD 5668'       C      	CALL	UF.EXEC
  6DC5'   10 FB          C      	DJNZ	$-3
  6DC7'   C1             C      	POP	BC
  6DC8'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  6DC9'                  C      U1.VZS:
  6DC9'   D5             C      	PUSH	DE
  6DCA'   C5             C      	PUSH	BC
  6DCB'   E5             C      	PUSH	HL
  6DCC'   F5             C      	PUSH	AF
  6DCD'   CD 6AB6'       C      	CALL	UR.KBV
  6DD0'   CD 6ABC'       C      	CALL	UR.KBR
  6DD3'   11 0E66        C      	LD	DE,UE.PUF
  6DD6'   01 0006        C      	LD	BC,6
'Allgemeine Unterprogramme'	MACRO-80 3.44	09-Dec-81	PAGE	1-65


  6DD9'   ED B0          C      	LDIR		;PROGR.NAME --> PUFFER
  6DDB'   3A 2B1E'       C      	LD	A,(UB.PAR2)	;DATEITYP
  6DDE'   12             C      	LD	(DE),A
  6DDF'   13             C      	INC	DE
  6DE0'   3E 44          C      	LD	A,'D'
  6DE2'   12             C      	LD	(DE),A
  6DE3'   13             C      	INC	DE
  6DE4'   3A 2B20'       C      	LD	A,(UB.PAR3)
  6DE7'   FE 7F          C      	CP	7FH
  6DE9'   20 0F          C      	JR	NZ,$+17
  6DEB'   21 5784'       C      	LD	HL,UA.KOMMT	;FRAGE KOMMENTAR WENN PAR3=7F
  6DEE'   CD 6B2E'       C      	CALL	UR.MIMO
  6DF1'   01 0006        C      	LD	BC,6
  6DF4'   ED B0          C      	LDIR
  6DF6'   06 09          C      	LD	B,9
  6DF8'   18 02          C      	JR	$+4
  6DFA'   06 0F          C      	LD	B,15
  6DFC'   3E 20          C      	LD	A,' '
  6DFE'   12             C      	LD	(DE),A
  6DFF'   13             C      	INC	DE
  6E00'   10 FC          C      	DJNZ	$-2
  6E02'   3A 2B1C'       C      	LD	A,(UB.PAR1)
  6E05'   12             C      	LD	(DE),A
  6E06'   13             C      	INC	DE
  6E07'   06 08          C      	LD	B,8
  6E09'   AF             C      	XOR	A
  6E0A'   12             C      	LD	(DE),A
  6E0B'   13             C      	INC	DE
  6E0C'   10 FC          C      	DJNZ	$-2
  6E0E'   21 0020        C      	LD	HL,32
  6E11'   CD 6EAC'       C      	CALL	XY.STIDX
  6E14'   09             C      	DB	9
  6E15'   DD 36 05 08    C      	LD	(IX+5),08H
  6E19'   CD 5668'       C      	CALL	UF.EXEC
  6E1C'   F1             C      	POP	AF
  6E1D'   E1             C      	POP	HL
  6E1E'   C1             C      	POP	BC
  6E1F'   D1             C      	POP	DE
  6E20'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  6E21'                  C      U1.TR:
  6E21'   77             C      	LD	(HL),A	;A=INHALT
  6E22'   23             C      	INC	HL
  6E23'   10 FC          C      	DJNZ	U1.TR	;B=ANZAHL
  6E25'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  6E26'                  C      U1.INFO:
  6E26'   01 000E        C      	LD	BC,14
  6E29'   ED B0          C      	LDIR
  6E2B'   C9             C      	RET
  6E2C'                  C      U1.BILO:
  6E2C'   CD 6C82'       C      	CALL	U1.RSAVE
  6E2F'   21 3370        C      	LD	HL,SD.BWSA + 11*80	;3370H
  6E32'   01 040F        C      	LD	BC,13*80 - 1	;1120  ( -80 ... eine Zeile )
  6E35'   36 20          C      	LD	(HL),20H
  6E37'   54             C      	LD	D,H
  6E38'   5D             C      	LD	E,L
  6E39'   13             C      	INC	DE
  6E3A'   ED B0          C      	LDIR
  6E3C'   CD 6C8A'       C      	CALL	U1.RRST
  6E3F'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  6E40'                  C      U1.TST:
  6E40'   B7             C      	OR	A
  6E41'   D6 30          C      	SUB	30H
  6E43'   47             C      	LD	B,A
  6E44'   05             C      	DEC	B
  6E45'   C8             C      	RET	Z
  6E46'   05             C      	DEC	B
  6E47'   C8             C      	RET	Z
  6E48'   37             C      	SCF
  6E49'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
  6E4A'                  C      U1.PRADR:
  6E4A'   E5             C      	PUSH	HL
  6E4B'   C5             C      	PUSH	BC
  6E4C'   06 04          C      	LD	B,4
  6E4E'   7E             C      	LD	A,(HL)
  6E4F'   FE 20          C      	CP	' '
  6E51'   28 07          C      	JR	Z,$+9
  6E53'   23             C      	INC	HL
  6E54'   10 F8          C      	DJNZ	$-6
  6E56'   B7             C      	OR	A
'Allgemeine Unterprogramme'	MACRO-80 3.44	09-Dec-81	PAGE	1-66


  6E57'   C1             C      	POP	BC
  6E58'   E1             C      	POP	HL
  6E59'   C9             C      	RET
  6E5A'   37             C      	SCF
  6E5B'   21 2B00'       C      	LD	HL,UB.ZN
  6E5E'   35             C      	DEC	(HL)
  6E5F'   18 F6          C      	JR	$-8
                         C      ;---------------------------------------------------------------------
  6E61'                  C      U1.KRWE:
  6E61'   CD 6A86'       C      	CALL	UR.KRE
  6E64'   CD 6A94'       C      	CALL	UR.KRWW
  6E67'   C9             C      	RET
                         C      ;---------------------------------------------------------------------
                         C      ;	END
                         C      	TITLE 'Handling f. IX/IY-adressierte Bereiche'
                         C      	PAGE
'Handling f. IX/IY-adressierte Bereiche'	MACRO-80 3.44	09-Dec-81	PAGE	1-67


                         C      
                         C      ;	PN	XY ; Unterprogramme
                         C      ;**********************************************************************
                         C      ;*                                                                    *
                         C      ;*       Handling f. IX/IY-adressierte Steuer-Bloecke bzw.            *
                         C      ;*                                     Arbeits-Bereiche               *
                         C      ;*                                                                    *
                         C      ;*--------------------------------------------------------------------*
                         C      ;*                                                                    *
                         C      ;*       Ausser den angegebenen Registern bzw. Flags wird nur noch    *
                         C      ;*       die angegebene Anzahl der ersten freien Stack-Plaetze (je    *
                         C      ;*       Byte) veraendert. Weiterer RAM-Platz wird nicht benoetigt.   *
                         C      ;*                                                                    *
                         C      ;**********************************************************************
                         C      ;*                                                                    *
                         C      ;*       Technische (Hilfs-) Unter-Programme                          *
                         C      ;*                                                                    *
                         C      ;**********************************************************************
                         C      			;
                         C      ;        Uebernahme von nach dem CALL stehenden Parameter
                         C      ;        ++++++++++++++++++++++++++++++++++++++++++++++++
                         C      ;        erwarten Stack:           Return-Adresse f.uebergeordnetes UP
                         C      ;                       (SP) -->   Return-Adresse f.CALPn
                         C      ;        geben Stack zurueck:      Return-Adresse f.uebergeordn.UP + n
                         C      ;                                  (DE)
                         C      ;                       (SP) -->   (HL)
                         C      ;        geben in Reg.zurueck:     (DE):  Wert    1.Parameter-Byte
                         C      ;                                  (HL):  Adresse 2.Parameter-Byte
                         C      ;        --------------------------------------------------------------
                         C      			;
  6E68'                  C      XY.CALP1	EQU	$	; 1 Byte-Parameter
                         C      			; ++++++++++++++++++++++++++++++
  6E68'   E5             C      	PUSH	HL	; Retten HL
  6E69'   E1             C      	POP	HL
                         C      			;
  6E6A'   EB             C      	EX	DE,HL	; DE <--> RET-Adr.f.CALPn
  6E6B'   E3             C      	EX	(SP),HL
  6E6C'   EB             C      	EX	DE,HL
                         C      			;
  6E6D'   E1             C      	POP	HL	; (SP) --> RET-Adr.f.ueberg.UP
                         C      			;
  6E6E'   E1             C      	POP	HL	; Laden u. korrig. ...
  6E6F'   23             C      	INC	HL
  6E70'   E5             C      	PUSH	HL
  6E71'                  C      XY.CALPE:
  6E71'   2B             C      	DEC	HL
                         C      			;
  6E72'   3B             C      	DEC	SP	; (SP) --> (DE)
  6E73'   3B             C      	DEC	SP
  6E74'   3B             C      	DEC	SP	; (SP) --> (HL)
  6E75'   3B             C      	DEC	SP
                         C      			;
  6E76'   D5             C      	PUSH	DE	; RET-Adr.f.CALPn
                         C      			;
  6E77'   5E             C      	LD	E,(HL)	; Laden DE, HL
  6E78'   16 00          C      	LD	D,0
  6E7A'   23             C      	INC	HL
                         C      			;
  6E7B'   C9             C      	RET
                         C      			;
                         C      			;
                         C      ;**********************************************************************
                         C      ;*                                                                    *
                         C      ;*       Lade-, Speicher- und Transport-Unterprogramme                *
                         C      ;*                                                                    *
                         C      ;**********************************************************************
                         C      ;
                         C      ;    CALL  LDDX    'Load':              HL := (IX+d)
                         C      ;    DB    d                                              Stack: 4
                         C      ;    -----------   ----------------------------------------------------
                         C      			;
  6E7C'                  C      XY.LDDX:
  6E7C'   CD 6E68'       C      	CALL	XY.CALP1	; Uebernahme d
                         C      			;
  6E7F'   DD E5          C      	PUSH	IX	; HL := IX+d
  6E81'   E1             C      	POP	HL	;               <--- LDDY
  6E82'   F5             C      	PUSH	AF
  6E83'   19             C      	ADD	HL,DE
  6E84'   F1             C      	POP	AF
                         C      			;
  6E85'   5E             C      	LD	E,(HL)	; HL := (IX+d)
  6E86'   23             C      	INC	HL
'Handling f. IX/IY-adressierte Bereiche'	MACRO-80 3.44	09-Dec-81	PAGE	1-68


  6E87'   56             C      	LD	D,(HL)
  6E88'   EB             C      	EX	DE,HL
                         C      			;
  6E89'   D1             C      	POP	DE	; Return
  6E8A'   D1             C      	POP	DE
  6E8B'   C9             C      	RET
                         C      			;
                         C      ;**********************************************************************
                         C      ;
                         C      ;    CALL  LIDX    'Load inverse':      LH := (IX+d)
                         C      ;    DB    d                                              Stack: 4
                         C      ;    -----------   ----------------------------------------------------
                         C      			;
  6E8C'                  C      XY.LIDX:
  6E8C'   CD 6E68'       C      	CALL	XY.CALP1	; Uebernahme d
                         C      			;
  6E8F'   DD E5          C      	PUSH	IX	; HL := IX+d
  6E91'   E1             C      	POP	HL	;               <--- LIDY
  6E92'   F5             C      	PUSH	AF
  6E93'   19             C      	ADD	HL,DE
  6E94'   F1             C      	POP	AF
                         C      			;
  6E95'   56             C      	LD	D,(HL)	; LH := (IX+d)
  6E96'   23             C      	INC	HL
  6E97'   5E             C      	LD	E,(HL)
  6E98'   EB             C      	EX	DE,HL
                         C      			;
  6E99'   D1             C      	POP	DE	; Return
  6E9A'   D1             C      	POP	DE
  6E9B'   C9             C      	RET
                         C      			;
                         C      ;**********************************************************************
                         C      ;
                         C      ;    CALL  STDX    'Store':            (IX+d) := HL
                         C      ;    DB    d                                                  Stack: 4
                         C      ;    -----------   ----------------------------------------------------
                         C      			;
  6E9C'                  C      XY.STDX:
  6E9C'   CD 6E68'       C      	CALL	XY.CALP1	; Uebernahme d
                         C      			;
  6E9F'   DD E5          C      	PUSH	IX	; HL := IX+d
  6EA1'   E1             C      	POP	HL	;               <--- STDY
  6EA2'   F5             C      	PUSH	AF
  6EA3'   19             C      	ADD	HL,DE
  6EA4'   F1             C      	POP	AF
                         C      			;
  6EA5'   D1             C      	POP	DE
  6EA6'   73             C      	LD	(HL),E	; (IX+d) := HL
  6EA7'   23             C      	INC	HL
  6EA8'   72             C      	LD	(HL),D
  6EA9'   EB             C      	EX	DE,HL
                         C      			;
  6EAA'   D1             C      	POP	DE	; Return
  6EAB'   C9             C      	RET
                         C      			;
                         C      ;**********************************************************************
                         C      ;
                         C      ;    CALL  STIDX    'Store inverse':    (IX+d) := LH
                         C      ;    DB    d                                                  Stack: 4
                         C      ;    -----------   ----------------------------------------------------
                         C      			;
  6EAC'                  C      XY.STIDX:
  6EAC'   CD 6E68'       C      	CALL	XY.CALP1	; Uebernahme d
                         C      			;
  6EAF'   DD E5          C      	PUSH	IX	; HL := IX+d
  6EB1'   E1             C      	POP	HL	;               <--- STIDY
  6EB2'   F5             C      	PUSH	AF
  6EB3'   19             C      	ADD	HL,DE
  6EB4'   F1             C      	POP	AF
                         C      			;
  6EB5'   D1             C      	POP	DE
  6EB6'   72             C      	LD	(HL),D	; (IX+d) := LH
  6EB7'   23             C      	INC	HL
  6EB8'   73             C      	LD	(HL),E
  6EB9'   EB             C      	EX	DE,HL
                         C      			;
  6EBA'   D1             C      	POP	DE	; Return
  6EBB'   C9             C      	RET
                         C      			;
                         C      ;**********************************************************************
                         C      ;
                         C      ;    CALL  INCDX    'Increment':        (IX+d) := (IX+d) + 1
                         C      ;    DB    d                                    Flags wie ADC HL,...
'Handling f. IX/IY-adressierte Bereiche'	MACRO-80 3.44	09-Dec-81	PAGE	1-69


                         C      ;                                                             Stack: 4
                         C      ;    -----------   ----------------------------------------------------
                         C      			;
  6EBC'                  C      XY.INCDX:
  6EBC'   CD 6E68'       C      	CALL	XY.CALP1	; Uebernahme d
                         C      			;
  6EBF'   DD E5          C      	PUSH	IX	; HL := IX+d
  6EC1'   E1             C      	POP	HL	;               <--- INCDY
  6EC2'   19             C      	ADD	HL,DE
                         C      			;
  6EC3'   5E             C      	LD	E,(HL)	; DE := (IX+d)
  6EC4'   23             C      	INC	HL
  6EC5'   56             C      	LD	D,(HL)
                         C      			;
  6EC6'   E5             C      	PUSH	HL	; DE := (IX+d) + 1
  6EC7'   21 0001        C      	LD	HL,1
  6ECA'   B7             C      	OR	A
  6ECB'   ED 5A          C      	ADC	HL,DE
  6ECD'   EB             C      	EX	DE,HL
  6ECE'   E1             C      	POP	HL
  6ECF'   72             C      	LD	(HL),D
  6ED0'   2B             C      	DEC	HL
  6ED1'   73             C      	LD	(HL),E
                         C      			;
  6ED2'   E1             C      	POP	HL	; Return
  6ED3'   D1             C      	POP	DE
  6ED4'   C9             C      	RET
                         C      			;
                         C      ;**********************************************************************
                         C      ;*                                                                    *
                         C      ;*       Unterprogramm  'Unbedingter Sprung'                          *
                         C      ;*                                                                    *
                         C      ;**********************************************************************
                         C      ;
                         C      ;    CALL  JMPDX   'Jump':              JMP  (IX+d)
                         C      ;    DB    d                                              Stack: 4
                         C      ;                                       Achtung!
                         C      ;                                           Veraendert freie Stack-Pl.
                         C      ;    -----------   ----------------------------------------------------
                         C      			;
  6ED5'                  C      XY.JMPDX:
  6ED5'   CD 6E68'       C      	CALL	XY.CALP1	; Uebernahme d
                         C      			;
  6ED8'   DD E5          C      	PUSH	IX	; HL := IX+d
  6EDA'   E1             C      	POP	HL	;               <--- JMPDY
  6EDB'   F5             C      	PUSH	AF
  6EDC'   19             C      	ADD	HL,DE
  6EDD'   F1             C      	POP	AF
                         C      			;
  6EDE'   5E             C      	LD	E,(HL)	; HL := (IX+d)
  6EDF'   23             C      	INC	HL
  6EE0'   56             C      	LD	D,(HL)
  6EE1'   EB             C      	EX	DE,HL
                         C      			;
  6EE2'   D1             C      	POP	DE	; Return = Jump
  6EE3'   E3             C      	EX	(SP),HL
  6EE4'   EB             C      	EX	DE,HL
  6EE5'   C9             C      	RET
                         C      			;
                         C      ;**********************************************************************
                         C      ;	END
                         C      	TITLE 'Konvertierungen'
                         C      	PAGE
'Konvertierungen'	MACRO-80 3.44	09-Dec-81	PAGE	1-70


                         C      
                         C      ;	PN	UC
                         C      ;----------------------------------------------------------------------
                         C      ;
                         C      ;       KONVERTIERUNGEN
                         C      ;
                         C      ;----------------------------------------------------------------------
                         C      ;                            HL := HL * 10
                         C      ;                                      (ohne Kontrolle auf Uebertrag)
  6EE6'                  C      UC.HL10N:
  6EE6'   E5             C      	PUSH	HL
  6EE7'   D1             C      	POP	DE	; alter Wert in DE
  6EE8'   29             C      	ADD	HL,HL
  6EE9'   29             C      	ADD	HL,HL
  6EEA'   19             C      	ADD	HL,DE
  6EEB'   29             C      	ADD	HL,HL
  6EEC'   C9             C      	RET
                         C      ;                            HL := HL * 10
                         C      ;                                            -->  C: Uebertrag in A
  6EED'                  C      UC.HL10C:
  6EED'   E5             C      	PUSH	HL
  6EEE'   D1             C      	POP	DE	; alter Wert in DE
  6EEF'   AF             C      	XOR	A
  6EF0'   29             C      	ADD	HL,HL
  6EF1'   30 01          C      	JR	NC,$+3
  6EF3'   3C             C      	INC	A
  6EF4'   87             C      	ADD	A,A
  6EF5'   29             C      	ADD	HL,HL
  6EF6'   30 01          C      	JR	NC,$+3
  6EF8'   3C             C      	INC	A
  6EF9'   19             C      	ADD	HL,DE
  6EFA'   30 01          C      	JR	NC,$+3
  6EFC'   3C             C      	INC	A
  6EFD'   87             C      	ADD	A,A
  6EFE'   29             C      	ADD	HL,HL
  6EFF'   30 01          C      	JR	NC,$+3
  6F01'   3C             C      	INC	A
  6F02'   B7             C      	OR	A
  6F03'   C8             C      	RET	Z
  6F04'   37             C      	SCF
  6F05'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      ;                            Division mit Rest:  A  := HL / DE
                         C      ;                                                HL := Rest
                         C      			;      Cy(A) --->  A=255
                         C      			;-------------------------------
  6F06'                  C      UC.DIVR:
  6F06'   AF             C      	XOR	A
  6F07'   ED 52          C      	SBC	HL,DE
  6F09'   3C             C      	INC	A
  6F0A'   20 03          C      	JR	NZ,$+5
  6F0C'   3D             C      	DEC	A
  6F0D'   38 03          C      	JR	C,$+5
  6F0F'   30 F6          C      	JR	NC,$-8
  6F11'   3D             C      	DEC	A
  6F12'   19             C      	ADD	HL,DE
  6F13'   C9             C      	RET
                         C      			;
                         C      ;**********************************************************************
                         C      ;*                                                                    *
                         C      ;*       CV...               Konvertierungen     (convert ...)        *
                         C      ;*                                                                    *
                         C      ;*--------------------------------------------------------------------*
                         C      ;*       ..A..:              in A                                     *
                         C      ;*       ..?*.:              von Typ *                                *
                         C      ;*       ..?.*:              nach Typ *                               *
                         C      ;*                                                                    *
                         C      ;*       Typen:              B - binaer                               *
                         C      ;*                           X - hexadezimal ASCII                    *
                         C      ;*                           A - Adresse binaer (L,H)                 *
                         C      ;*                           D - dezimal ASCII                        *
                         C      ;*                                                                    *
                         C      ;**********************************************************************
                         C      			;
                         C      ;                            In A:      Binaer < 16 --> ASCII hexa
                         C      ;                            ------------------------------------------
  6F14'                  C      UC.CVABX:
  6F14'   E6 0F          C      	AND	0FH
  6F16'   F6 30          C      	OR	30H
  6F18'   FE 3A          C      	CP	3AH
  6F1A'   D8             C      	RET	C
'Konvertierungen'	MACRO-80 3.44	09-Dec-81	PAGE	1-71


  6F1B'   C6 07          C      	ADD	A,7H
  6F1D'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      ;                            Byte binaer (HL) --> 2 ASCII hexa (DE)
                         C      ;                                                            HL+1, DE+2
                         C      ;                            ------------------------------------------
  6F1E'                  C      UC.CVBX:
  6F1E'   7E             C      	LD	A,(HL)
  6F1F'   23             C      	INC	HL	; benutzt: A, 2 Stack-P.
                         C      			;
  6F20'   F5             C      	PUSH	AF	;ENTRY,WENN ZEICHEN IN A
  6F21'   0F             C      	RRCA
  6F22'   0F             C      	RRCA
  6F23'   0F             C      	RRCA
  6F24'   0F             C      	RRCA
  6F25'   CD 6F29'       C      	CALL	$+4
  6F28'   F1             C      	POP	AF
                         C      			;
  6F29'   CD 6F14'       C      	CALL	UC.CVABX
  6F2C'   12             C      	LD	(DE),A
  6F2D'   13             C      	INC	DE
  6F2E'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      ;                       Adresse (L,H) binaer (HL) --> 4 ASCII hexa (DE)
                         C      ;                                                            HL+2, DE+4
                         C      ;                       -----------------------------------------------
  6F2F'                  C      UC.CVAX:
  6F2F'   23             C      	INC	HL
  6F30'   CD 6F1E'       C      	CALL	UC.CVBX	; benutzt: A, 3 Stack-P.
  6F33'   2B             C      	DEC	HL
  6F34'   2B             C      	DEC	HL
  6F35'   CD 6F1E'       C      	CALL	UC.CVBX
  6F38'   23             C      	INC	HL
  6F39'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      ;                       Adresse aus HL, binaer    --> 4 ASCII hexa (DE)
                         C      ;                                                                  DE+4
                         C      ;                       -----------------------------------------------
  6F3A'                  C      UC.CVHLX:
  6F3A'   7C             C      	LD	A,H
  6F3B'   CD 6F20'       C      	CALL	UC.CVBX+2	; benutzt: A, 3 Stack-P.
  6F3E'   7D             C      	LD	A,L
  6F3F'   CD 6F20'       C      	CALL	UC.CVBX+2
  6F42'   C9             C      	RET
                         C      			;
                         C      			;
                         C      ;      ---------------------------------------------------------------
                         C      ;                            In A:     ASCII hexa --> binaer < 16
                         C      ;
                         C      ;                                       Datenfehler: Cy, A undefiniert
                         C      ;                            ------------------------------------------
  6F43'                  C      UC.CVAXB:
  6F43'   D6 30          C      	SUB	30H
  6F45'   D8             C      	RET	C		;       (A) < '0'
  6F46'   FE 0A          C      	CP	10
  6F48'   3F             C      	CCF
  6F49'   D0             C      	RET	NC
  6F4A'   FE 11          C      	CP	11H
  6F4C'   D8             C      	RET	C		; '9' < (A) < 'A'
  6F4D'   FE 17          C      	CP	17H
  6F4F'   3F             C      	CCF
  6F50'   D8             C      	RET	C		; 'F' < (A)
  6F51'   D6 07          C      	SUB	7H
  6F53'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      ;                            2 ASCII hexa (DE) --> Byte binaer (HL)
                         C      ;                                                            DE+2, HL+1
                         C      ;
                         C      ;                                       mit Datenfehler-Behandlung
                         C      ;                            ------------------------------------------
  6F54'                  C      UC.CVXB:
  6F54'   C5             C      	PUSH	BC
                         C      			; benutzt: A, 3 Stack-P.
  6F55'   CD 6F65'       C      	CALL	UC.CVX1B
  6F58'   87             C      	ADD	A,A
  6F59'   87             C      	ADD	A,A
  6F5A'   87             C      	ADD	A,A
  6F5B'   87             C      	ADD	A,A
  6F5C'   4F             C      	LD	C,A
'Konvertierungen'	MACRO-80 3.44	09-Dec-81	PAGE	1-72


                         C      			;
  6F5D'   CD 6F65'       C      	CALL	UC.CVX1B
  6F60'   81             C      	ADD	A,C
                         C      			;
  6F61'   77             C      	LD	(HL),A
  6F62'   23             C      	INC	HL
  6F63'   C1             C      	POP	BC
  6F64'   C9             C      	RET
                         C      			;
  6F65'                  C      UC.CVX1B:
  6F65'   1A             C      	LD	A,(DE)	; ASCII hexa (DE) --> A binaer,
  6F66'   CD 6F43'       C      	CALL	UC.CVAXB	;                           DE+1
  6F69'   DC 6F6E'       C      	CALL	C,UC.CVXER
  6F6C'   13             C      	INC	DE
  6F6D'   C9             C      	RET
                         C      			;
  6F6E'                  C      UC.CVXER:
  6F6E'   EB             C      	EX	DE,HL       ; Datenfehler-Behandlung hexa
  6F6F'   CD 4033        C      	CALL	SY.SETCHL      ;         set cursor
  6F72'   CD 6C5A'       C          CALL  UR.TAREP  ; <-+     tast.request
  6F75'   77             C          LD    (HL),A    ;   |     write in conv.-area
  6F76'   CD 6F43'       C          CALL  UC.CVAXB  ;   |     conv.in A
  6F79'   38 F7          C          JR    C,$-7     ; --+     on error ...
  6F7B'   CD 4036        C          CALL	SY.RESC
  6F7E'   EB             C          EX    DE,HL
  6F7F'   C9             C          RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      ;                       4 ASCII hexa (DE) --> Adresse (L,H) binaer (HL)
                         C      ;                                                            DE+4, HL+2
                         C      ;
                         C      ;                                       mit Datenfehler-Behandlung
                         C      ;                       -----------------------------------------------
  6F80'                  C      UC.CVXA:
  6F80'   23             C      	INC	HL
  6F81'   CD 6F54'       C      	CALL	UC.CVXB	; benutzt: A, 4 Stack-P.
  6F84'   2B             C      	DEC	HL
  6F85'   2B             C      	DEC	HL
  6F86'   CD 6F54'       C      	CALL	UC.CVXB
  6F89'   23             C      	INC	HL
  6F8A'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      ;                     2 Byte binaer in HL ---> 1...5-stellig dezi (DE),
                         C      ;                                                             DE+1...5
                         C      ;                                  mit Vor-Null-Unterdrueckung
                         C      ;                                                    (nach nicht-dezi),
                         C      ;                                  zu wenig Stellen -->
                         C      ;                                      '*' in der obersten angeg.Stelle
                         C      ;                      ------------------------------------------------
  6F8B'                  C      UC.CVBD5:
  6F8B'   3E 05          C      	LD	A,5	; benutzt: A, 7 Stack-P.
  6F8D'   18 0E          C      	JR	$+16
  6F8F'                  C      UC.CVBD4:
  6F8F'   3E 04          C      	LD	A,4
  6F91'   18 0A          C      	JR	$+12
  6F93'                  C      UC.CVBD3:
  6F93'   3E 03          C      	LD	A,3
  6F95'   18 06          C      	JR	$+8
  6F97'                  C      UC.CVBD2:
  6F97'   3E 02          C      	LD	A,2
  6F99'   18 02          C      	JR	$+4
  6F9B'                  C      UC.CVBD1:
  6F9B'   3E 01          C      	LD	A,1
                         C      			;
  6F9D'   C5             C      UC.CVBD:	PUSH	BC	; Zeichenzahl in A
  6F9E'   E5             C      	PUSH	HL
  6F9F'   47             C      	LD	B,A
  6FA0'   CD 6FA8'       C      	CALL	UC.CVBD0
  6FA3'   10 FB          C      	DJNZ	$-3
  6FA5'   E1             C      	POP	HL
  6FA6'   C1             C      	POP	BC
  6FA7'   C9             C      	RET
                         C      			;
                         C      ;                          Abspaltung B-te Stelle dezi von HL nach (DE)
                         C      ;                                                                  DE+1
                         C      ;                          B-te nicht fuehrende Stelle: '*' nach (DE)
                         C      ;                          --------------------------------------------
  6FA8'                  C      UC.CVBD0:
  6FA8'   C5             C      	PUSH	BC	; benutzt: A, 5 Stack-P.
                         C      			; --------
  6FA9'   7D             C      	LD	A,L
  6FAA'   F6 30          C      	OR	'0'
'Konvertierungen'	MACRO-80 3.44	09-Dec-81	PAGE	1-73


  6FAC'   05             C      	DEC	B
  6FAD'   28 29          C          JR   Z,$+43	  ; -------+
                         C                        ;        |
  6FAF'   D5             C          PUSH DE       ;        |
  6FB0'   E5             C          PUSH HL       ; DE := (B-1)-te Zehner-Potenz
  6FB1'   21 0001        C          LD   HL,1     ;        |
  6FB4'   CD 6EE6'       C          CALL UC.HL10N ;        |
  6FB7'   10 FB          C          DJNZ $-3      ;        |
  6FB9'   EB             C          EX   DE,HL    ;        |
  6FBA'   E1             C          POP  HL       ;        |
                         C                        ;        |
  6FBB'   CD 6F06'       C          CALL UC.DIVR  ; A := HL / B-te Zehner-Potenz
  6FBE'   D1             C          POP  DE       ;        |     HL := Rest
                         C                        ;        |
  6FBF'   FE 0A          C          CP   10       ; test to decimal
  6FC1'   38 04          C          JR   C,$+6    ; ---+   |
  6FC3'   3E 2A          C          LD   A,'*'    ;    |   |
  6FC5'   18 11          C          JR   $+19     ; -------+
                         C                        ; <--+   |
  6FC7'   F6 30          C          OR   '0'      ; conv.to decimal
                         C                        ;        |
  6FC9'   FE 30          C          CP   '0'      ; Vor-Null ?
  6FCB'   20 0B          C          JR   NZ,$+13  ; -------+
  6FCD'   1B             C          DEC  DE       ;        |
  6FCE'   4F             C          LD   C,A      ;        |
  6FCF'   CD 7005'       C          CALL UC.CVD1B ;        |
  6FD2'   79             C          LD   A,C      ;        |
  6FD3'   13             C          INC  DE       ;        |
  6FD4'   30 02          C          JR   NC,$+4   ;        |
  6FD6'   3E 20          C          LD   A,' '    ;        |
                         C                        ; <------+
  6FD8'   12             C      	LD	(DE),A
  6FD9'   13             C      	INC	DE
  6FDA'   C1             C      	POP	BC
  6FDB'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      ;                      Dezi von (DE) bis (-->DE) nicht-dezi
                         C      ;                                                --->      binaer in HL
                         C      ;
                         C      ;                         Fehler:
                         C      ;                         -------
                         C      ;                         Cy, NZ: Zahl zu gross, HL ohne letzte Ziffer
                         C      ;                         Cy, Z:  Leere Zahl (1.Position keine Ziffer),
                         C      ;                                        -->     HL = 0
                         C      ;                      ------------------------------------------------
  6FDC'                  C      UC.CVDB:
  6FDC'   26 00          C      	LD	H,0
  6FDE'   CD 7005'       C      	CALL	UC.CVD1B
  6FE1'   6F             C      	LD	L,A
  6FE2'   30 04          C      	JR	NC,$+6
  6FE4'   AF             C      	XOR	A
  6FE5'   6F             C      	LD	L,A
  6FE6'   37             C      	SCF
  6FE7'   C9             C      	RET		; ---> abend C, Z
                         C      			;
  6FE8'   13             C      	INC	DE
  6FE9'   CD 7005'       C      	CALL	UC.CVD1B
  6FEC'   3F             C      	CCF
  6FED'   D0             C      	RET	NC		; ---> normal end
  6FEE'   D5             C          PUSH  DE
  6FEF'   F5             C          PUSH  AF
  6FF0'   CD 6EED'       C          CALL  UC.HL10C
  6FF3'   38 0B          C          JR    C,$+13    ; ----------+
  6FF5'   F1             C          POP   AF        ;           |
  6FF6'   85             C          ADD   A,L       ;           |
  6FF7'   6F             C          LD    L,A       ;           |
  6FF8'   30 03          C          JR    NC,$+5	; --+       |
  6FFA'   24             C          INC   H         ;   |       |
  6FFB'   28 04          C          JR    Z,$+6     ;   |    ---|--+
  6FFD'   D1             C          POP   DE        ; <-+       |  |
  6FFE'   18 E8          C          JR    $-22      ;           |  |
                         C                          ;      <----+  !
  7000'   E1             C          POP   HL        ; abend Cy, NZ !
  7001'   25             C          DEC   H         ;              |
  7002'   EB             C          EX    DE,HL     ;        <-----+
  7003'   D1             C          POP   DE
  7004'   C9             C          RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      ;                            Ziffer dezi (DE) ---> binaer nach A, DE+1
                         C      ;                                                  Cy: nicht-dezi
                         C      ;                            ------------------------------------------
'Konvertierungen'	MACRO-80 3.44	09-Dec-81	PAGE	1-74


  7005'                  C      UC.CVD1B:
  7005'   1A             C      	LD	A,(DE)
  7006'   D6 30          C      	SUB	30H
  7008'   D8             C      	RET	C
  7009'   FE 0A          C      	CP	10
  700B'   3F             C      	CCF
  700C'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      ;                    Byte binaer (HL) --> Byte ASCII-Symbol (DE)
                         C      ;                                         (sonst: 7FH )
                         C      ;                                                     HL+1, DE+1
                         C      ;                    --------------------------------------------------
  700D'                  C      UC.CVBC:
  700D'   7E             C      	LD	A,(HL)	; benutzt: A, 0 Stack-P.
  700E'   23             C      	INC	HL	; --------
  700F'   FE 20          C      	CP	20H
  7011'   30 02          C      	JR	NC,$+4
  7013'   3E 7F          C      	LD	A,7FH
  7015'   FE 7F          C      	CP	7FH
  7017'   38 02          C      	JR	C,$+4
  7019'   3E 7F          C      	LD	A,7FH
  701B'   12             C      	LD	(DE),A
  701C'   13             C      	INC	DE
  701D'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      ;                       Byte ASCII-Symbol (DE)   -->   Byte binaer (HL)
                         C      ;                                                      DE+1, HL+1
                         C      ;                       -----------------------------------------------
  701E'                  C      UC.CVCB:
  701E'   1A             C      	LD	A,(DE)	; benutzt: A, 0 Stack-P.
  701F'   13             C      	INC	DE
  7020'   FE 20          C      	CP	20H
  7022'   38 05          C      	JR	C,$+7
  7024'   FE 7E          C      	CP	7EH
  7026'   30 01          C      	JR	NC,$+3
  7028'   77             C      	LD	(HL),A
  7029'   23             C      	INC	HL
  702A'   C9             C      	RET
                         C      			;
                         C      
                         C      ;**********************************************************************
                         C      ;----------------------------------------------------------------------
                         C      ;
                         C      ;      KONVERTIERUNGEN
                         C      ;
                         C      ;----------------------------------------------------------------------
  702B'                  C      UC.DKONV:
  702B'   7E             C      	LD	A,(HL)	;DKOI--->ASCII
  702C'   CD 703F'       C      	CALL	UC.DK1	;(HL)--->(DE)
  702F'   12             C      	LD	(DE),A
  7030'   23             C      	INC	HL
  7031'   13             C      	INC	DE
  7032'   10 F7          C      	DJNZ	UC.DKONV
  7034'   C9             C      	RET
                         C      ;------------------------------------
  7035'                  C      UC.KONV:
  7035'   7E             C      	LD	A,(HL)	;ASCII--->DKOI
  7036'   CD 704A'       C      	CALL	UC.CKONV	;(HL) --->(DE)
  7039'   12             C      	LD	(DE),A
  703A'   23             C      	INC	HL
  703B'   13             C      	INC	DE
  703C'   10 F7          C      	DJNZ	UC.KONV
  703E'   C9             C      	RET
                         C      ;-----------------------------
  703F'                  C      UC.DK1:
  703F'   E5             C      	PUSH	HL	;DKOI--->ASCII
  7040'   D5             C      	PUSH	DE
  7041'   C5             C      	PUSH	BC
  7042'   21 706D'       C      	LD	HL,UC.ASCCO
  7045'   11 70CD'       C      	LD	DE,UC.DKOI
  7048'   18 09          C      	JR	UC.DK2
  704A'                  C      UC.CKONV:
  704A'   E5             C      	PUSH	HL	;ASCII ---> DKOI
  704B'   D5             C      	PUSH	DE
  704C'   C5             C      	PUSH	BC
  704D'   21 70CD'       C      	LD	HL,UC.DKOI	;HL:= Anfangsadresse
  7050'   11 706D'       C      	LD	DE,UC.ASCCO	;DE:= Anfangsadresse
  7053'                  C      UC.DK2:
  7053'   F5             C      	PUSH	AF	;Quellcodebyte retten
  7054'   AF             C      	XOR	A	;CY = 0
  7055'   ED 52          C      	SBC	HL,DE	;Tabellendistanz berechnen
'Konvertierungen'	MACRO-80 3.44	09-Dec-81	PAGE	1-75


  7057'   2B             C      	DEC	HL
  7058'   E5             C      	PUSH	HL
  7059'   C1             C      	POP	BC	;BC:= Tabellendistanz - 1
  705A'   EB             C      	EX	DE,HL	;HL:= Anfangsadresse
  705B'   F1             C      	POP	AF	;Zeichen wieder herstellen
  705C'   C5             C      	PUSH	BC	;Tabellendistanz retten
  705D'   01 0060        C      	LD	BC,UE.COTAL	;BC:= Tabellenlaenge
  7060'   ED B1          C      	CPIR		;Quellcodebyte suchen
  7062'   37             C      	SCF		;CY = 1
  7063'   C1             C      	POP	BC	;Tabellendistanz auskellern
  7064'   20 03          C      	JR	NZ,UC.KONV2	;---> Quellcodebyte nicht
  7066'   09             C      	ADD	HL,BC	;Zielcodeadresse berechnen
  7067'   AF             C      	XOR	A	;CY = 0
  7068'   7E             C      	LD	A,(HL)	;Zielcodebyte laden
  7069'                  C      UC.KONV2:
  7069'   C1             C      	POP	BC
  706A'   D1             C      	POP	DE
  706B'   E1             C      	POP	HL
  706C'   C9             C      	RET
                         C      ;****************************************************************
                         C      ;         ASCII - Codetabelle
                         C      ;****************************************************************
  706D'                  C      UC.ASCCO:
  706D'   20 21 22 23    C      	DB	' !"#$%&'
  7071'   24 25 26       C      
  7074'   27             C      	DB	27H	;'
  7075'   28 29 2A 2B    C      	DB	'()*+,-./'
  7079'   2C 2D 2E 2F    C      
  707D'   30 31 32 33    C      	DB	'0123456789'
  7081'   34 35 36 37    C      
  7085'   38 39          C      
  7087'   3A 3B 3C 3D    C      	DB	':;<=>?@'
  708B'   3E 3F 40       C      
  708E'   41 42 43 44    C      	DB	'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  7092'   45 46 47 48    C      
  7096'   49 4A 4B 4C    C      
  709A'   4D 4E 4F 50    C      
  709E'   51 52 53 54    C      
  70A2'   55 56 57 58    C      
  70A6'   59 5A          C      
  70A8'   5B 5C 5D 5E    C      	DB	'[\]^_`'
  70AC'   5F 60          C      
  70AE'   61 62 63 64    C      	DB	'abcdefghijklmnopqrstuvwxyz'
  70B2'   65 66 67 68    C      
  70B6'   69 6A 6B 6C    C      
  70BA'   6D 6E 6F 70    C      
  70BE'   71 72 73 74    C      
  70C2'   75 76 77 78    C      
  70C6'   79 7A          C      
  70C8'   7B 7C 7D 7E    C      	DB	'{|}~'
  70CC'   7F             C      	DB	7FH	;DEL
                         C      ;***************************************************************
                         C      ;         DKOI - Codetabelle
                         C      ;***************************************************************
  70CD'                  C      UC.DKOI:
  70CD'   40             C      	DB	40H	;blank
  70CE'   4F             C      	DB	4FH	;!
  70CF'   7F             C      	DB	7FH	;"
  70D0'   7B             C      	DB	7BH	;#
  70D1'   5B             C      	DB	5BH	;$
  70D2'   6C             C      	DB	6CH	;%
  70D3'   50             C      	DB	50H	;&
  70D4'   7D             C      	DB	7DH	;'
  70D5'   4D             C      	DB	4DH	;(
  70D6'   5D             C      	DB	5DH	;)
  70D7'   5C             C      	DB	5CH	;*
  70D8'   4E             C      	DB	4EH	;+
  70D9'   6B             C      	DB	6BH	;,
  70DA'   60             C      	DB	60H	;-
  70DB'   4B             C      	DB	4BH	;.
  70DC'   61             C      	DB	61H	;/
  70DD'   F0             C      	DB	0F0H	;0
  70DE'   F1             C      	DB	0F1H	;1
  70DF'   F2             C      	DB	0F2H	;2
  70E0'   F3             C      	DB	0F3H	;3
  70E1'   F4             C      	DB	0F4H	;4
  70E2'   F5             C      	DB	0F5H	;5
  70E3'   F6             C      	DB	0F6H	;6
  70E4'   F7             C      	DB	0F7H	;7
  70E5'   F8             C      	DB	0F8H	;8
  70E6'   F9             C      	DB	0F9H	;9
  70E7'   7A             C      	DB	7AH	;:
  70E8'   5E             C      	DB	5EH	;;
'Konvertierungen'	MACRO-80 3.44	09-Dec-81	PAGE	1-76


  70E9'   4C             C      	DB	4CH	;<
  70EA'   7E             C      	DB	7EH	;=
  70EB'   6E             C      	DB	6EH	;>
  70EC'   6F             C      	DB	6FH	;?
  70ED'   7C             C      	DB	7CH	;@
  70EE'   C1             C      	DB	0C1H	;A
  70EF'   C2             C      	DB	0C2H	;B
  70F0'   C3             C      	DB	0C3H	;C
  70F1'   C4             C      	DB	0C4H	;D
  70F2'   C5             C      	DB	0C5H	;E
  70F3'   C6             C      	DB	0C6H	;F
  70F4'   C7             C      	DB	0C7H	;G
  70F5'   C8             C      	DB	0C8H	;H
  70F6'   C9             C      	DB	0C9H	;I
  70F7'   D1             C      	DB	0D1H	;J
  70F8'   D2             C      	DB	0D2H	;K
  70F9'   D3             C      	DB	0D3H	;L
  70FA'   D4             C      	DB	0D4H	;M
  70FB'   D5             C      	DB	0D5H	;N
  70FC'   D6             C      	DB	0D6H	;O
  70FD'   D7             C      	DB	0D7H	;P
  70FE'   D8             C      	DB	0D8H	;Q
  70FF'   D9             C      	DB	0D9H	;R
  7100'   E2             C      	DB	0E2H	;S
  7101'   E3             C      	DB	0E3H	;T
  7102'   E4             C      	DB	0E4H	;U
  7103'   E5             C      	DB	0E5H	;V
  7104'   E6             C      	DB	0E6H	;W
  7105'   E7             C      	DB	0E7H	;X
  7106'   E8             C      	DB	0E8H	;Y
  7107'   E9             C      	DB	0E9H	;Z
  7108'   4A             C      	DB	4AH	;[
  7109'   E0             C      	DB	0E0H	;\
  710A'   5A             C      	DB	5AH	;]
  710B'   5F             C      	DB	5FH	;^
  710C'   6D             C      	DB	6DH	;_
  710D'   79             C      	DB	79H	;`
  710E'   81             C      	DB	81H	;a
  710F'   82             C      	DB	82H	;b
  7110'   83             C      	DB	83H	;c
  7111'   84             C      	DB	84H	;d
  7112'   85             C      	DB	85H	;e
  7113'   86             C      	DB	86H	;f
  7114'   87             C      	DB	87H	;g
  7115'   88             C      	DB	88H	;h
  7116'   89             C      	DB	89H	;i
  7117'   91             C      	DB	91H	;j
  7118'   92             C      	DB	92H	;k
  7119'   93             C      	DB	93H	;l
  711A'   94             C      	DB	94H	;m
  711B'   95             C      	DB	95H	;n
  711C'   96             C      	DB	96H	;o
  711D'   97             C      	DB	97H	;p
  711E'   98             C      	DB	98H	;q
  711F'   99             C      	DB	99H	;r
  7120'   A2             C      	DB	0A2H	;s
  7121'   A3             C      	DB	0A3H	;t
  7122'   A4             C      	DB	0A4H	;u
  7123'   A5             C      	DB	0A5H	;v
  7124'   A6             C      	DB	0A6H	;w
  7125'   A7             C      	DB	0A7H	;x
  7126'   A8             C      	DB	0A8H	;y
  7127'   A9             C      	DB	0A9H	;z
  7128'   C0             C      	DB	0C0H	;{
  7129'   6A             C      	DB	6AH	;|
  712A'   D0             C      	DB	0D0H	;}
  712B'   A1             C      	DB	0A1H	;~
  712C'   FF             C      	DB	0FFH	;DEL
                         C      ;----------------------------------------------------------------------
                         C      ;	END
                         C      	TITLE	'Komprimierung'
                         C      	PAGE
'Komprimierung'	MACRO-80 3.44	09-Dec-81	PAGE	1-77


                         C      
                         C      ;	PN	CP
                         C      ;**********************************************************************
                         C      ;*       COMPR:    Komprimierung                                      *
                         C      ;*                 EDIT - F/Q-Format   --->  MRES20 - Quelltextformat *
                         C      ;**********************************************************************
                         C      			;
  712D'                  C      CP.COMPR	EQU	$	; A  Uebergabe/-nahme Zeichen
                         C      			; HL: Status von COMPR
                         C      			; B:  dekr. Tabulator-Zaehler
                         C      			;-------------------------------
                         C      			; OUTA: Einzelzeichen-Ausgabe
                         C      			;         (Zeichen in Reg. A)
                         C      ;----------------------------------------------------------------------
                         C      			;
  712D'   FE 1E          C      	CP	1EH	; NL ?
  712F'   28 01          C      	JR	Z,CP.NL
  7131'   E9             C      	JP	(HL)
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Status "New-Line"
                         C      			;-------------------------------
  7132'                  C      CP.NL:
  7132'   CD 6EBC'       C      	CALL	XY.INCDX	;         Satz-Zaehler + 1
  7135'   13             C      	DB	19
  7136'   06 03          C      	LD	B,3	;         noch 3 TAB erlaubt
  7138'   3E 0A          C      	LD	A,0AH	;         MRES20-NL
  713A'   18 04          C      	JR	CP.OUTT
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Status "String"
                         C      			;-------------------------------
  713C'                  C      CP.STRNG:
  713C'   FE 27          C      	CP	27H	;         Apostroph
  713E'   20 20          C      	JR	NZ,CP.OUT
                         C      			;
  7140'                  C      CP.OUTT:
  7140'   21 7150'       C      	LD	HL,CP.TEXT	;         --> Status "Text"
  7143'   18 1B          C      	JR	CP.OUT
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Status "Space"
                         C      			;-------------------------------
  7145'                  C      CP.SPACE:
  7145'   FE 20          C      	CP	' '
  7147'   C8             C      	RET	Z
  7148'   FE 09          C      	CP	09H	;         Tabulator
  714A'   C8             C      	RET	Z
  714B'   21 7150'       C      	LD	HL,CP.TEXT	;         ---> Status "Text"
  714E'   18 08          C      	JR	CP.TEXT+8
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Status "Text"
                         C      			;-------------------------------
  7150'                  C      CP.TEXT:
  7150'   FE 20          C      	CP	' '
  7152'   28 2E          C      	JR	Z,CP.TAB
  7154'   FE 09          C      	CP	09H	;         Tabulator
  7156'   28 2A          C      	JR	Z,CP.TAB
  7158'   FE 3B          C      	CP	';'
  715A'   28 0B          C      	JR	Z,CP.SOKOM
  715C'   FE 27          C      	CP	27H	;         Apostroph
  715E'   28 1D          C      	JR	Z,CP.SOSTR
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Status "Kom"
                         C      			;-------------------------------
  7160'                  C      CP.KOM	EQU	$
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Einzelzeichen-Ausgabe u. Ret.
                         C      			;-------------------------------
  7160'                  C      CP.OUT:
  7160'   CD 727C'       C      	CALL	UK.PUTK
  7163'   D9             C      	EXX
  7164'   0B             C      	DEC	BC
  7165'   D9             C      	EXX
  7166'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Start "Kommentar"
                         C      			;-------------------------------
'Komprimierung'	MACRO-80 3.44	09-Dec-81	PAGE	1-78


  7167'                  C      CP.SOKOM:
  7167'   78             C          LD	A,B	;         0 oder 3 TAB vorher
  7168'   FE 03          C          CP   3
  716A'   28 0A          C          JR   Z,$+12
  716C'   B7             C          OR   A
  716D'   28 07          C          JR   Z,$+9      ;         ---+
  716F'   3E 09          C          LD   A,09H      ;         <-+|
  7171'   CD 7160'       C          CALL CP.OUT     ;           ||
  7174'   10 F9          C          DJNZ $-5        ;         --+|
  7176'   3E 3B          C          LD   A,';'      ;         <--+
  7178'   21 7160'       C          LD   HL,CP.KOM
  717B'   18 E3          C          JR   CP.OUT
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Start "String"
                         C      			;-------------------------------
  717D'                  C      CP.SOSTR:
  717D'   21 713C'       C      	LD	HL,CP.STRNG
  7180'   18 DE          C      	JR	CP.OUT
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Tabulator-Behandlung
                         C      			;-------------------------------
  7182'                  C      CP.TAB:
  7182'   78             C      	LD	A,B
  7183'   B7             C      	OR	A
  7184'   3E 20          C      	LD	A,' '
  7186'   28 D8          C      	JR	Z,CP.OUT
  7188'   05             C      	DEC	B
  7189'   3E 09          C      	LD	A,09H	;         Tabulator MRES20
  718B'   21 7145'       C      	LD	HL,CP.SPACE
  718E'   18 D0          C      	JR	CP.OUT
                         C      			;
                         C      ;**********************************************************************
                         C      			;
  7190'                  C      CP.INIT:
  7190'   06 03          C      	LD	B,3	; Initialisierung COMPR
  7192'   21 7150'       C      	LD	HL,CP.TEXT
  7195'   C9             C      	RET
                         C      			;
                         C      ;**********************************************************************
                         C      ;	END
                         C      	TITLE	'Dekomprimierung'
                         C      	PAGE
'Dekomprimierung'	MACRO-80 3.44	09-Dec-81	PAGE	1-79


                         C      
                         C      ;	PN	DC
                         C      ;**********************************************************************
                         C      ;*       DCMPR:    Dekomprimierung                                    *
                         C      ;*                 MRES20-Quelltexte   --->   EDIT - Format F         *
                         C      ;**********************************************************************
                         C      			;
  7196'                  C      DC.DCMPR	EQU	$
                         C      			; A:  Uebergabe/-nahme Zeichen
                         C      			; HL: Status-Register DCMPR
                         C      			; B:  Position (Spalte)
                         C      			;-------------------------------
                         C      			; INA: Einzelzeichen-Eingabe
                         C      			;      nach Reg. A
                         C      ;        --------------------------------------------------------------
  7196'   04             C      	INC	B	;         Position + 1
  7197'   E9             C      	JP	(HL)
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Status "Neue Zeile"
                         C      			;-------------------------------
  7198'                  C      DC.NL:
  7198'   CD 6EBC'       C      	CALL	XY.INCDX	;         Satzzaehler + 1
  719B'   13             C      	DB	19
  719C'   3E 1E          C      	LD	A,1EH	;         EDIT-New-Line
  719E'   06 01          C      	LD	B,1	;         Pos.=1
  71A0'   21 71A4'       C      	LD	HL,DC.TEXT	;         Status "TEXT"
  71A3'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Status "Text"
                         C      			;-------------------------------
  71A4'                  C      DC.TEXT:
  71A4'   CD 71D7'       C      	CALL	UK.GETK	;         Einzelzeichen-Eingabe
  71A7'   B7             C      	OR	A
  71A8'   C8             C      	RET	Z
  71A9'   FE 0A          C      	CP	0AH	;         NL ?
  71AB'   28 EB          C      	JR	Z,DC.NL
  71AD'   FE 09          C      	CP	09H	;         TAB ?
  71AF'   28 01          C      	JR	Z,DC.TAB
  71B1'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Tabulator-Behandlung
                         C      			;-------------------------------
  71B2'                  C      DC.TAB:
  71B2'   78             C      	LD	A,B
  71B3'   FE 28          C      	CP	40
  71B5'   D0             C      	RET	NC
  71B6'   21 71BC'       C      	LD	HL,DC.SPACE	;         ---> Status "Space"
  71B9'   3E 20          C      	LD	A,' '	;         anstelle TAB Space
  71BB'   C9             C      	RET
                         C      			;
                         C      ;        --------------------------------------------------------------
                         C      			; Status "Space"
                         C      			;-------------------------------
  71BC'                  C      DC.SPACE:
  71BC'   78             C      	LD	A,B
  71BD'   FE 0B          C      	CP	10+1
  71BF'   28 0B          C      	JR	Z,DC.EOSPC
  71C1'   FE 11          C      	CP	16+1
  71C3'   28 07          C      	JR	Z,DC.EOSPC
  71C5'   FE 24          C      	CP	35+1
  71C7'   28 03          C      	JR	Z,DC.EOSPC
  71C9'   3E 20          C      	LD	A,' '
  71CB'   C9             C      	RET
                         C      			;
  71CC'                  C      DC.EOSPC:
  71CC'   21 71A4'       C      	LD	HL,DC.TEXT	; TAB-Position erreicht
  71CF'   18 D3          C      	JR	DC.TEXT
                         C      			;
                         C      			;
                         C      ;**********************************************************************
  71D1'                  C      DC.INIT:
  71D1'   21 71A4'       C      	LD	HL,DC.TEXT	; Initialisierung
  71D4'   06 01          C      	LD	B,1
  71D6'   C9             C      	RET
                         C      			;
                         C      ;**********************************************************************
                         C      ;	END
                         C      	TITLE	'Einzelzeicheneingabe fuer KMBG'
                         C      	PAGE
'Einzelzeicheneingabe fuer KMBG'	MACRO-80 3.44	09-Dec-81	PAGE	1-80


                         C      
                         C      ;	PN	UK
                         C      ;----------------------------------------------------------------------
                         C      ;
                         C      ;        Einzelzeicheneingabe fuer KMBG
                         C      ;
                         C      ;----------------------------------------------------------------------
                         C      ;
  71D7'                  C      UK.GETK:
  71D7'   CD 6C82'       C      	CALL	U1.RSAVE
  71DA'   CD 6E8C'       C      	CALL	XY.LIDX	;HL:= Blocklaenge
  71DD'   07             C      	DB	7
  71DE'   E5             C      	PUSH	HL
  71DF'   CD 6E7C'       C      	CALL	XY.LDDX
  71E2'   17             C      	DB	23
  71E3'   EB             C      	EX	DE,HL	;DE:= Pufferzaehler
  71E4'   AF             C      	XOR	A
  71E5'   E1             C      	POP	HL	;HL:= Blocklaenge
  71E6'   ED 52          C      	SBC	HL,DE
  71E8'   E5             C      	PUSH	HL	;Restbyteanzahl retten
  71E9'   7C             C      	LD	A,H
  71EA'   B5             C      	OR	L
  71EB'   CC 7237'       C      	CALL	Z,UK.KBW	;Block lesen
  71EE'   E1             C      	POP	HL
  71EF'   AF             C      	XOR	A
  71F0'   BC             C      	CP	H
  71F1'   20 05          C      	JR	NZ,UK.GETK2
  71F3'   7D             C      	LD	A,L
  71F4'   FE 01          C      	CP	1
  71F6'   28 08          C      	JR	Z,UK.GETK3	;---> letztes Datenbyte des
  71F8'                  C      UK.GETK2:
  71F8'   CD 7206'       C      	CALL	UK.GETK4
  71FB'   B7             C      	OR	A
  71FC'                  C      UK.GETK5:
  71FC'   CD 6C8A'       C      	CALL	U1.RRST
  71FF'   C9             C      	RET
                         C      ;
                         C      ;
  7200'                  C      UK.GETK3:
  7200'   CD 7206'       C      	CALL	UK.GETK4
  7203'   37             C      	SCF
  7204'   18 F6          C      	JR	UK.GETK5
                         C      ;
  7206'                  C      UK.GETK4:
  7206'   CD 6E7C'       C      	CALL	XY.LDDX	;HL:= aktuelle Pufferadresse
  7209'   15             C      	DB	21
  720A'   7E             C      	LD	A,(HL)	;Datenbyte laden
  720B'   CD 6EBC'       C      	CALL	XY.INCDX	;Pufferzeiger erhoehen
  720E'   15             C      	DB	21
  720F'   CD 6EBC'       C      	CALL	XY.INCDX	;Pufferzaehler erhoehen
  7212'   17             C      	DB	23
  7213'   C9             C      	RET
                         C      ;
                         C      ;******************************************************************
                         C      ;
                         C      ;        KMBG  Eingabepuffer bereitstellen
                         C      ;
                         C      ;*******************************************************************
                         C      ;
  7214'                  C      UK.KLPFB:
  7214'   CD 6C82'       C      	CALL	U1.RSAVE
  7217'   CD 6D7E'       C      	CALL	U1.KTIN1
  721A'   21 0100        C      	LD	HL,100H	;max. Blocklaenge Kassette
  721D'   CD 6EAC'       C      	CALL	XY.STIDX	;max. Blocklaenge initialisieren
  7220'   07             C      	DB	7
  7221'   E5             C      	PUSH	HL
  7222'   C1             C      	POP	BC	;BC:= Blocklaenge
  7223'   CD 6E9C'       C      	CALL	XY.STDX	;Pufferzaehler "Leer"
  7226'   17             C      	DB	23
  7227'   21 0E66        C      	LD	HL,UE.PUF	;Systempuffer Kassette
  722A'   CD 6C93'       C      	CALL	U1.CLRB	;Systempuffer loeschen
  722D'   21 8010        C      	LD	HL,UE.KPUFF
  7230'   CD 6C93'       C      	CALL	U1.CLRB
  7233'   CD 6C8A'       C      	CALL	U1.RRST
  7236'   C9             C      	RET
                         C      ;
                         C      ;******************************************************************
                         C      ;
                         C      ;        Einlesen eines Blockes von Kassette
                         C      ;
                         C      ;         - Besonderheit gegenueber MBW: Blockinhalt wird vom
                         C      ;           Systempuffer in den E/A-Puffer uebertragen
'Einzelzeicheneingabe fuer KMBG'	MACRO-80 3.44	09-Dec-81	PAGE	1-81


                         C      ;
                         C      ;*******************************************************************
                         C      ;
  7237'                  C      UK.KBW:
  7237'   CD 6C82'       C      	CALL	U1.RSAVE
  723A'   CD 7214'       C      	CALL	UK.KLPFB
  723D'   DD 36 05 02    C      	LD	(IX+5),02H
  7241'   CD 5668'       C      	CALL	UF.EXEC
  7244'   DD 7E 09       C      	LD	A,(IX+9)
  7247'   DD B6 0A       C      	OR	(IX+10)
  724A'   28 2A          C      	JR	Z,UK.KBW1	;EOF
  724C'   CD 6E7C'       C      	CALL	XY.LDDX	;HL:= Blockadresse
  724F'   07             C      	DB	7
  7250'   DD 46 09       C      	LD	B,(IX+9)	;BC:= Blocklaenge
  7253'   DD 4E 0A       C      	LD	C,(IX+10)
  7256'   E5             C      	PUSH	HL	;E/A-Puffer
  7257'   CD 6E7C'       C      	CALL	XY.LDDX
  725A'   19             C      	DB	25
  725B'   EB             C      	EX	DE,HL
  725C'   E1             C      	POP	HL
  725D'   ED B0          C      	LDIR		;Transport in E/A-Puffer
  725F'   CD 6E7C'       C      	CALL	XY.LDDX
  7262'   19             C      	DB	25
  7263'   CD 6E9C'       C      	CALL	XY.STDX	;Pufferzeiger auf Anfang
  7266'   15             C      	DB	21
  7267'   21 0000        C      	LD	HL,0
  726A'   CD 6E9C'       C      	CALL	XY.STDX	;Pufferzaehler rueckstellen
  726D'   17             C      	DB	23
  726E'   CD 6EBC'       C      	CALL	XY.INCDX	;Blockzaehler incrementieren
  7271'   11             C      	DB	17
  7272'                  C      UK.KBW2:
  7272'   CD 6C8A'       C      	CALL	U1.RRST
  7275'   C9             C      	RET
                         C      ;
  7276'                  C      UK.KBW1:
  7276'   CD 6EBC'       C      	CALL	XY.INCDX	;Labelzaehler incrementieren
  7279'   11             C      	DB	17
  727A'   18 F6          C      	JR	UK.KBW2
                         C      ;
                         C      ;********************************************************************
                         C      ;
                         C      ;        Einzelzeichenausgabe fuer KMBG
                         C      ;
                         C      ;*********************************************************************
                         C      ;
  727C'                  C      UK.PUTK:
  727C'   CD 6C82'       C      	CALL	U1.RSAVE
  727F'   F5             C      	PUSH	AF	;Zeichen retten
  7280'   CD 6E7C'       C      	CALL	XY.LDDX	;HL:= Pufferzaehler
  7283'   17             C      	DB	23
  7284'   01 0132        C      	LD	BC,UE.KMPUL	;BC:= max. Pufferlaenge
  7287'   B7             C      	OR	A
  7288'   ED 42          C      	SBC	HL,BC
  728A'   3F             C      	CCF
  728B'   CC 72C5'       C      	CALL	Z,UK.KBA	;---> Puffer voll
  728E'   F1             C      	POP	AF	;Zeichen auskellern
  728F'   CD 6E7C'       C      	CALL	XY.LDDX
  7292'   15             C      	DB	21
  7293'   77             C      	LD	(HL),A	;Zeichen in Puffer eintragen
  7294'   CD 6EBC'       C      	CALL	XY.INCDX	;Pufferzeiger erhoehen
  7297'   15             C      	DB	21
  7298'   CD 6EBC'       C      	CALL	XY.INCDX	;Pufferzaehler erhoehen
  729B'   17             C      	DB	23
  729C'   CD 6C8A'       C      	CALL	U1.RRST
  729F'   C9             C      	RET
                         C      ;
                         C      ;******************************************************************
                         C      ;
                         C      ;        Ausgabepufferbereitstellung fuer KMBG
                         C      ;
                         C      ;*******************************************************************
                         C      ;
  72A0'                  C      UK.KSPFB:
  72A0'   CD 6C82'       C      	CALL	U1.RSAVE
  72A3'   CD 6D7E'       C      	CALL	U1.KTIN1
  72A6'   CD 6E8C'       C      	CALL	XY.LIDX
  72A9'   07             C      	DB	7
  72AA'   E5             C      	PUSH	HL
  72AB'   C1             C      	POP	BC	;BC:= Blocklaenge
  72AC'   21 0000        C      	LD	HL,0
  72AF'   CD 6E9C'       C      	CALL	XY.STDX	;Pufferzaehler = 0
  72B2'   17             C      	DB	23
  72B3'   CD 6E7C'       C      	CALL	XY.LDDX
'Einzelzeicheneingabe fuer KMBG'	MACRO-80 3.44	09-Dec-81	PAGE	1-82


  72B6'   19             C      	DB	25
  72B7'   CD 6E9C'       C      	CALL	XY.STDX	;Pufferzeiger setzen
  72BA'   15             C      	DB	21
  72BB'   21 0E66        C      	LD	HL,UE.PUF
  72BE'   CD 6C93'       C      	CALL	U1.CLRB
  72C1'   CD 6C8A'       C      	CALL	U1.RRST
  72C4'   C9             C      	RET
                         C      ;
                         C      ;*******************************************************************
                         C      ;
                         C      ;        Ausgabe eines Blockes auf KMBG
                         C      ;
                         C      ;*******************************************************************
                         C      ;
  72C5'                  C      UK.KBA:
  72C5'   CD 6C82'       C      	CALL	U1.RSAVE
  72C8'   CD 72A0'       C      	CALL	UK.KSPFB
  72CB'   CD 6E7C'       C      	CALL	XY.LDDX
  72CE'   07             C      	DB	7
  72CF'   EB             C      	EX	DE,HL	;DE:= Blockadresse
  72D0'   D5             C      	PUSH	DE	;Blockadresse retten
  72D1'   CD 6E8C'       C      	CALL	XY.LIDX
  72D4'   09             C      	DB	9
  72D5'   E5             C      	PUSH	HL
  72D6'   C1             C      	POP	BC	;BC:= Blocklaenge
  72D7'   D1             C      	POP	DE	;DE:= Blockadresse
  72D8'   C5             C      	PUSH	BC	;Blocklaenge retten
  72D9'   CD 6E7C'       C      	CALL	XY.LDDX	;HL:= E/A-Pufferanfang
  72DC'   19             C      	DB	25
  72DD'   ED B0          C      	LDIR		;Block in Systempuffer
  72DF'   C1             C      	POP	BC	;BC:= Blocklaenge
  72E0'   E5             C      	PUSH	HL	;aktuelle Pufferadresse retten
  72E1'   21 0132        C      	LD	HL,UE.KMPUL	;HL:= max. Laenge
  72E4'   B7             C      	OR	A
  72E5'   ED 42          C      	SBC	HL,BC	;HL:= Restbyteanzahl
  72E7'   CD 6E9C'       C      	CALL	XY.STDX	;Pufferzaehler setzen
  72EA'   17             C      	DB	23
  72EB'   E5             C      	PUSH	HL
  72EC'   C1             C      	POP	BC	;BC:= Restbyteanzahl
  72ED'   CD 6E7C'       C      	CALL	XY.LDDX	;HL:= aktuelle Pufferadresse
  72F0'   19             C      	DB	25
  72F1'   EB             C      	EX	DE,HL	;DE:= Pufferanfang
  72F2'   E1             C      	POP	HL
  72F3'   ED B0          C      	LDIR
  72F5'   EB             C      	EX	DE,HL	;HL:= aktuelle Pufferadresse
  72F6'   CD 6E9C'       C      	CALL	XY.STDX	;Pufferzeiger setzen
  72F9'   15             C      	DB	21
  72FA'   DD 36 05 08    C      	LD	(IX+5),08H
  72FE'   CD 5668'       C      	CALL	UF.EXEC	;physische Blockausgabe
  7301'   F5             C      	PUSH	AF
  7302'   CD 6EBC'       C      	CALL	XY.INCDX	;Blockzaehler erhoehen
  7305'   11             C      	DB	17
  7306'   F1             C      	POP	AF
  7307'   CD 6C8A'       C      	CALL	U1.RRST
  730A'   C9             C      	RET
                         C      ;----------------------------------------------------------------------
                         C      ;	END
                                ;
                         C      	INCLUDE KM.ASM
                         C      	TITLE	'Kmbg'
                         C      	PAGE
'Kmbg'	MACRO-80 3.44	09-Dec-81	PAGE	1-83


                         C      
                         C      ;	PN	KM01
                         C      ;****************************************************************
                         C      ;*                  DEG2000   V.1.2   ---   Programm:   K m b g *
                         C      ;*  Version         --------------------------------------------*
                         C      ;*                  Programmierer: R. Sieber   A d W            *
                         C      ;*  V 1 . 2         --------------------------------------------*
                         C      ;*                  Stand        : 25.Februar 1985              *
                         C      ;****************************************************************
                         C      
  730B'                  C      KM.ANF:
  730B'   730B'          C      	DW	$
  730D'   4B 6D 62 67    C      	DB	'Kmbg'
  7311'   21 7501'       C      	LD	HL,KM.DEL	;Taste:   D E L
  7314'   22 0D58        C      	LD	(SM.FKTAB+58H),HL
  7317'   21 74BF'       C      	LD	HL,KM.ABS	;Taste:   A B S
  731A'   22 0D24        C      	LD	(SM.FKTAB+24H),HL
  731D'   21 7374'       C      	LD	HL,KM.HOME	;Taste:   H O M E
  7320'   22 0D74        C      	LD	(SM.FKTAB+74H),HL
  7323'   21 737E'       C      	LD	HL,KM.SL	;Taste:   SCH_LINKS
  7326'   22 0D26        C      	LD	(SM.FKTAB+26H),HL
  7329'   21 738B'       C      	LD	HL,KM.SR	;Taste:   SCH_RECHTS
  732C'   22 0D36        C      	LD	(SM.FKTAB+36H),HL
  732F'   21 736F'       C      	LD	HL,KM.CO	;Taste:   C_HOCH
  7332'   22 0D06        C      	LD	(SM.FKTAB+06H),HL
  7335'   21 7390'       C      	LD	HL,KM.CR	;Taste:   C_RECHTS
  7338'   22 0D16        C      	LD	(SM.FKTAB+16H),HL
  733B'   21 7379'       C      	LD	HL,KM.CU	;Taste:   C_RUNTER
  733E'   22 0D18        C      	LD	(SM.FKTAB+18H),HL
  7341'   21 7386'       C      	LD	HL,KM.CL	;Taste:   C_LINKS
  7344'   22 0D08        C      	LD	(SM.FKTAB+08H),HL
  7347'   21 7395'       C      	LD	HL,KM.CNZA	;Taste:   C N Z A
  734A'   22 0D76        C      	LD	(SM.FKTAB+76H),HL
  734D'   21 73C5'       C      	LD	HL,KM.NEWL	;Taste:   E T 1
  7350'   22 0DAE        C      	LD	(KM.TNEWL),HL
  7353'   21 73EA'       C      	LD	HL,KM.EINA	;alphanum. Tasten
  7356'   22 0DB0        C      	LD	(KM.TEINA),HL
                         C      
  7359'   21 758D'       C      	LD	HL,KM.UP13
  735C'   11 FF80        C      	LD	DE,KM.RAM
  735F'   01 007E        C      	LD	BC,KM.UPEND-KM.UP13
  7362'   ED B0          C      	LDIR
                         C      
  7364'   DD 21 2B01     C      	LD	IX,KM.KMTAB
  7368'   DD CB 00 7E    C      	BIT	7,(IX)
  736C'   C2 FF9C        C      	JP	NZ,KM.UP4-KM.UP13+KM.RAM
                         C      
  736F'                  C      KM.CO:
  736F'   CD 750F'       C      	CALL	KM.UP2	;KMBG Reservieren EIN
  7372'   31             C      	DB	31H
  7373'   C9             C      	RET
                         C      
                         C      	PAGE
'Kmbg'	MACRO-80 3.44	09-Dec-81	PAGE	1-84


                         C      
                         C      ;****************************************************************
                         C      ;*                  Auswertung der Cursor-Tasten                *
                         C      ;****************************************************************
  7374'                  C      KM.HOME:
  7374'   CD 750C'       C      	CALL	KM.UP1	;KMBG Kassette zurueckspulen
  7377'   21             C      	DB	21H
  7378'   C9             C      	RET
                         C      
  7379'                  C      KM.CU:
  7379'   CD 750F'       C      	CALL	KM.UP2	;KMBG Reservieren AUS
  737C'   41             C      	DB	41H
  737D'   C9             C      	RET
                         C      
  737E'                  C      KM.SL:
  737E'   CD 750F'       C      	CALL	KM.UP2	;KMBG vorh.  Datensatz anzeigen
  7381'   15             C      	DB	15H
  7382'   CD 750C'       C      	CALL	KM.UP1
  7385'   02             C      	DB	2
  7386'                  C      KM.CL:
  7386'   CD 750F'       C      	CALL	KM.UP2	;KMBG einen  Datensatz zuruecksetzen
  7389'   15             C      	DB	15H
  738A'   C9             C      	RET
                         C      
  738B'                  C      KM.SR:
  738B'   CD 750C'       C      	CALL	KM.UP1	;KMBG nachf. Datensatz anzeigen
  738E'   02             C      	DB	2
  738F'   C9             C      	RET
                         C      
  7390'                  C      KM.CR:
  7390'   CD 750F'       C      	CALL	KM.UP2	;KMBG einen  Datensatz vorsetzen
  7393'   11             C      	DB	11H
  7394'   C9             C      	RET
                         C      
  7395'                  C      KM.CNZA:
  7395'   DD CB 00 7E    C      	BIT	7,(IX)
  7399'   C0             C      	RET	NZ
  739A'   3A FFAE        C      	LD	A,(KM.TX2-KM.UP13+KM.RAM)
  739D'   FE 6C          C      	CP	'l'
  739F'   28 08          C      	JR	Z,KM.CNZA1
  73A1'   DD 36 09 00    C      	LD	(IX+9),0
  73A5'   DD 36 0A 01    C      	LD	(IX+10),1
  73A9'                  C      KM.CNZA1:
  73A9'   3E 60          C      	LD	A,60H
  73AB'   DD B6 04       C      	OR	(IX+4)
  73AE'   DD 77 04       C      	LD	(IX+4),A
  73B1'   CD 7520'       C      	CALL	KM.UP5
  73B4'   DD 7E 04       C      	LD	A,(IX+4)
  73B7'   CD 750C'       C      	CALL	KM.UP1
  73BA'   02             C      	DB	2
  73BB'   CD 750F'       C      	CALL	KM.UP2
  73BE'   15             C      	DB	15H
  73BF'   DD 77 04       C      	LD	(IX+4),A
  73C2'   C3 FF9C        C      	JP	KM.UP4-KM.UP13+KM.RAM
                         C      ;****************************************************************
                         C      ;*                  Routine fuer die Taste   E T 1              *
                         C      ;****************************************************************
  73C5'                  C      KM.NEWL:
  73C5'   DD CB 00 7E    C      	BIT	7,(IX)
  73C9'   C0             C      	RET	NZ
  73CA'   21 0E66        C      	LD	HL,KM.PUFF
  73CD'   22 2BE0        C      	LD	(KM.KMTAB+0DFH),HL	;2BE0
  73D0'   DD 7E 0A       C      	LD	A,(IX+10)
  73D3'   3D             C      	DEC	A
  73D4'   E6 F0          C      	AND	0F0H
  73D6'   07             C      	RLCA
  73D7'   07             C      	RLCA
  73D8'   07             C      	RLCA
  73D9'   07             C      	RLCA
  73DA'   3C             C      	INC	A
  73DB'   32 2BEB        C      	LD	(KM.KMTAB+0EAH),A	;2BEB
  73DE'   CD 2060        C      	CALL	KM.MHOME
  73E1'   CD 23BA        C      	CALL	KM.MINSL
  73E4'   CD 21EF        C      	CALL	ATACO
  73E7'   C3 FF9C        C      	JP	KM.UP4-KM.UP13+KM.RAM
                         C      
                         C      	PAGE
'Kmbg'	MACRO-80 3.44	09-Dec-81	PAGE	1-85


                         C      
                         C      ;****************************************************************
                         C      ;*                  Auswertung der alphanumerischen Tasten      *
                         C      ;****************************************************************
  73EA'                  C      KM.EINA:
  73EA'   79             C      	LD	A,C
  73EB'   21 0000        C      	LD	HL,0
  73EE'   FE 72          C      	CP	'r'
  73F0'   20 03          C      	JR	NZ,KM.EINA1
  73F2'   21 7454'       C      	LD	HL,KM.EINAB
  73F5'                  C      KM.EINA1:
  73F5'   FE 7A          C      	CP	'z'
  73F7'   20 03          C      	JR	NZ,KM.EINA2
  73F9'   21 7459'       C      	LD	HL,KM.EINAC
  73FC'                  C      KM.EINA2:
  73FC'   FE 70          C      	CP	'p'
  73FE'   20 03          C      	JR	NZ,KM.EINA3
  7400'   21 0000        C      	LD	HL,0
  7403'                  C      KM.EINA3:
  7403'   FE 63          C      	CP	'c'
  7405'   20 03          C      	JR	NZ,KM.EINA4
  7407'   21 0000        C      	LD	HL,0
  740A'                  C      KM.EINA4:
  740A'   22 0DA8        C      	LD	(KM.TTABU),HL
  740D'   FE 30          C      	CP	'0'
  740F'   38 04          C      	JR	C,KM.EINA5
  7411'   FE 47          C      	CP	'G'
  7413'   38 06          C      	JR	C,KM.EINA7
  7415'                  C      KM.EINA5:
  7415'   32 FFAE        C      	LD	(KM.TX2-KM.UP13+KM.RAM),A
  7418'                  C      KM.EINA6:
  7418'   C3 FF9C        C      	JP	KM.UP4-KM.UP13+KM.RAM
                         C      
  741B'                  C      KM.EINA7:
  741B'   3A FFAE        C      	LD	A,(KM.TX2-KM.UP13+KM.RAM)
  741E'   FE 67          C      	CP	'g'
  7420'   20 10          C      	JR	NZ,KM.EINA8
  7422'   79             C      	LD	A,C
  7423'   D6 30          C      	SUB	30H
  7425'   D8             C      	RET	C
  7426'   C8             C      	RET	Z
  7427'   FE 03          C      	CP	3
  7429'   D0             C      	RET	NC
  742A'   DD 77 03       C      	LD	(IX+3),A
  742D'   CD 7480'       C      	CALL	KM.UP20
  7430'   18 E6          C      	JR	KM.EINA6
                         C      
  7432'                  C      KM.EINA8:
  7432'   FE 6C          C      	CP	'l'
  7434'   20 1D          C      	JR	NZ,KM.EINAA
  7436'   79             C      	LD	A,C
  7437'   D6 30          C      	SUB	30H
  7439'   FE 0A          C      	CP	00AH
  743B'   38 02          C      	JR	C,KM.EINA9
  743D'   D6 07          C      	SUB	7
  743F'                  C      KM.EINA9:
  743F'   5F             C      	LD	E,A
  7440'   16 00          C      	LD	D,0
  7442'   62             C      	LD	H,D
  7443'   DD 6E 0A       C      	LD	L,(IX+10)
  7446'   29             C      	ADD	HL,HL
  7447'   29             C      	ADD	HL,HL
  7448'   29             C      	ADD	HL,HL
  7449'   29             C      	ADD	HL,HL
  744A'   19             C      	ADD	HL,DE
  744B'   DD 74 09       C      	LD	(IX+9),H
  744E'   DD 75 0A       C      	LD	(IX+10),L
  7451'   18 C5          C      	JR	KM.EINA6
                         C      
  7453'                  C      KM.EINAA:
  7453'   C9             C      	RET
                         C      
  7454'                  C      KM.EINAB:
  7454'   CD 750F'       C      	CALL	KM.UP2
  7457'   08             C      	DB	8
  7458'   C9             C      	RET
                         C      
  7459'                  C      KM.EINAC:
  7459'   DD 36 0D 00    C      	LD	(IX+13),0
  745D'                  C      KM.EINAD:
  745D'   CD 750C'       C      	CALL	KM.UP1
  7460'   02             C      	DB	2
'Kmbg'	MACRO-80 3.44	09-Dec-81	PAGE	1-86


  7461'   DD 7E 09       C      	LD	A,(IX+9)
  7464'   DD B6 0A       C      	OR	(IX+10)
  7467'   28 08          C      	JR	Z,KM.EINAE
  7469'   DD 34 0D       C      	INC	(IX+13)
  746C'   CD 7471'       C      	CALL	KM.EINAE
  746F'   18 EC          C      	JR	KM.EINAD
                         C      
  7471'                  C      KM.EINAE:
  7471'   CD FF9C        C      	CALL	KM.UP4-KM.UP13+KM.RAM
  7474'   11 35E0        C      	LD	DE,SD.BWSA + 18*80 + 64	;5E0H
  7477'   CD 7544'       C      	CALL	KM.UP10
  747A'   62 7A 3A       C      	DB	'bz:'
  747D'   0D             C      	DB	00DH
  747E'   A0             C      	DB	20H+80H
  747F'   C9             C      	RET
                         C      
  7480'                  C      KM.UP20:
  7480'   DD 4E 02       C      	LD	C,(IX+2)
  7483'   0C             C      	INC	C
  7484'   0C             C      	INC	C
  7485'   0C             C      	INC	C
  7486'   0C             C      	INC	C
  7487'   ED 40          C      	IN	B,(C)
  7489'   FE 01          C      	CP	1
  748B'   20 04          C      	JR	NZ,KM.UP21
  748D'   CB 48          C      	BIT	1,B
  748F'   20 29          C      	JR	NZ,KM.UP25
  7491'                  C      KM.UP21:
  7491'   CB D8          C      	SET	3,B
  7493'   18 06          C      	JR	KM.UP22
  7495'   CB 40          C      	BIT	0,B
  7497'   20 21          C      	JR	NZ,KM.UP25
  7499'   CB D0          C      	SET	2,B
  749B'                  C      KM.UP22:
  749B'   ED 41          C      	OUT	(C),B
  749D'   0C             C      	INC	C
  749E'   ED 50          C      	IN	D,(C)
  74A0'   0D             C      	DEC	C
  74A1'   CB 90          C      	RES	2,B
  74A3'   CB 98          C      	RES	3,B
  74A5'   ED 41          C      	OUT	(C),B
  74A7'   FE 01          C      	CP	1
  74A9'   20 04          C      	JR	NZ,KM.UP23
  74AB'   CB 62          C      	BIT	4,D
  74AD'   18 02          C      	JR	KM.UP24
                         C      
  74AF'                  C      KM.UP23:
  74AF'   CB 5A          C      	BIT	3,D
  74B1'                  C      KM.UP24:
  74B1'   28 07          C      	JR	Z,KM.UP25
  74B3'   DD 36 00 00    C      	LD	(IX+0),0
  74B7'   C3 736F'       C      	JP	KM.CO
                         C      
  74BA'                  C      KM.UP25:
  74BA'   DD CB 00 FE    C      	SET	7,(IX+0)
  74BE'   C9             C      	RET
                         C      
                         C      	PAGE
'Kmbg'	MACRO-80 3.44	09-Dec-81	PAGE	1-87


                         C      
  74BF'                  C      KM.ABS:
  74BF'   21 3000        C      	LD	HL,SD.BWSA
  74C2'   06 11          C      	LD	B,17
  74C4'                  C      KM.ABS1:
  74C4'   C5             C      	PUSH	BC
  74C5'   CD 74CE'       C      	CALL	KM.UP30
  74C8'   C1             C      	POP	BC
  74C9'   10 F9          C      	DJNZ	KM.ABS1
  74CB'   C3 74E1'       C      	JP	KM.UP36
                         C      
  74CE'                  C      KM.UP30:
  74CE'   CD 74ED'       C      	CALL	KM.UP34
  74D1'   A0             C      	DB	0A0H
  74D2'   28 15          C      	JR	Z,KM.UP33
  74D4'   CD 74ED'       C      	CALL	KM.UP34
  74D7'   50             C      	DB	050H
  74D8'   28 0C          C      	JR	Z,KM.UP32
  74DA'                  C      KM.UP31:
  74DA'   7E             C      	LD	A,(HL)
  74DB'   23             C      	INC	HL
  74DC'   CD 4040        C      	CALL	PRINT
  74DF'   10 F9          C      	DJNZ	KM.UP31
  74E1'                  C      KM.UP36:
  74E1'   3E 1E          C      	LD	A,1EH
  74E3'   C3 4040        C      	JP	PRINT
                         C      
  74E6'                  C      KM.UP32:
  74E6'   CD 74E1'       C      	CALL	KM.UP36
  74E9'                  C      KM.UP33:
  74E9'   23             C      	INC	HL
  74EA'   10 FD          C      	DJNZ	KM.UP33
  74EC'   C9             C      	RET
                         C      
  74ED'                  C      KM.UP34:
  74ED'   E3             C      	EX	(SP),HL
  74EE'   46             C      	LD	B,(HL)
  74EF'   23             C      	INC	HL
  74F0'   E3             C      	EX	(SP),HL
  74F1'   E5             C      	PUSH	HL
  74F2'   CD 74F9'       C      	CALL	KM.UP35
  74F5'   E1             C      	POP	HL
  74F6'   06 50          C      	LD	B,80
  74F8'   C9             C      	RET
                         C      
  74F9'                  C      KM.UP35:
  74F9'   3E 20          C      	LD	A,' '
  74FB'   BE             C      	CP	(HL)
  74FC'   23             C      	INC	HL
  74FD'   C0             C      	RET	NZ
  74FE'   10 F9          C      	DJNZ	KM.UP35
  7500'   C9             C      	RET
                         C      
  7501'                  C      KM.DEL:
  7501'   DD CB 00 BE    C      	RES	7,(IX+0)
  7505'   DD 36 01 00    C      	LD	(IX+1),0
  7509'   C3 FF9C        C      	JP	KM.UP4-KM.UP13+KM.RAM
                         C      
                         C      	PAGE
'Kmbg'	MACRO-80 3.44	09-Dec-81	PAGE	1-88


                         C      
                         C      ;****************************************************************
                         C      ;*                  Unterprogramme                              *
                         C      ;****************************************************************
  750C'                  C      KM.UP1:
  750C'   CD 752C'       C      	CALL	KM.LOE1
  750F'                  C      KM.UP2:
  750F'   DD CB 00 7E    C      	BIT	7,(IX)
  7513'   28 02          C      	JR	Z,KM.UP3
  7515'   E1             C      	POP	HL
  7516'   C0             C      	RET	NZ
  7517'                  C      KM.UP3:
  7517'   E3             C      	EX	(SP),HL
  7518'   F5             C      	PUSH	AF
  7519'   7E             C      	LD	A,(HL)
  751A'   23             C      	INC	HL
  751B'   DD 77 04       C      	LD	(IX+4),A
  751E'   F1             C      	POP	AF
  751F'   E3             C      	EX	(SP),HL
  7520'                  C      KM.UP5:
  7520'   CD 5A93        C      	CALL	KM.KARO
  7523'   21 5C01        C      	LD	HL,05C01H			;? ? ?
  7526'   22 0D8E        C      	LD	(SM.FKTAB+8EH),HL	;? ? ?
  7529'   C3 FF9C        C      	JP	KM.UP4-KM.UP13+KM.RAM
                         C      
  752C'                  C      KM.LOE1:
  752C'   21 0E65        C      	LD	HL,KM.PUFF-1
  752F'   36 00          C      	LD	(HL),0
  7531'   01 0103        C      	LD	BC,103H
  7534'   18 08          C      	JR	KM.LOE3
  7536'                  C      KM.LOE2:
  7536'   21 3000        C      	LD	HL,SD.BWSA
  7539'   01 077F        C      	LD	BC,24*80 -1 ;007FFH ??? (25*80-1 = 07CFH; 07FFH-07CFH=30H=48)
  753C'   36 20          C      	LD	(HL),' '
  753E'                  C      KM.LOE3:
  753E'   E5             C      	PUSH	HL
  753F'   D1             C      	POP	DE
  7540'   13             C      	INC	DE
  7541'   ED B0          C      	LDIR
  7543'   C9             C      	RET
                         C      
  7544'                  C      KM.UP10:
  7544'   E3             C      	EX	(SP),HL
  7545'                  C      KM.UP11:
  7545'   7E             C      	LD	A,(HL)
  7546'   E6 7F          C      	AND	07FH
  7548'   FE 20          C      	CP	' '
  754A'   38 02          C      	JR	C,KM.UP12
  754C'   12             C      	LD	(DE),A
  754D'   13             C      	INC	DE
  754E'                  C      KM.UP12:
  754E'   DC FF80        C      	CALL	C,KM.UP13-KM.UP13+KM.RAM
  7551'   CB 7E          C      	BIT	7,(HL)
  7553'   23             C      	INC	HL
  7554'   28 EF          C      	JR	Z,KM.UP11
  7556'   E3             C      	EX	(SP),HL
  7557'   C9             C      	RET
                         C      
  7558'                  C      KM.UP41:
  7558'   11 3000        C      	LD	DE,SD.BWSA
  755B'   DD 7E 0A       C      	LD	A,(IX+10)
  755E'   B7             C      	OR	A
  755F'   20 0C          C      	JR	NZ,KM.UP42
  7561'   DD CB 09 46    C      	BIT	0,(IX+9)
  7565'   C8             C      	RET	Z
  7566'   F5             C      	PUSH	AF
  7567'   CD 201D        C      	CALL	KM.MANZ
  756A'   F1             C      	POP	AF
  756B'   D6 10          C      	SUB	10H
  756D'                  C      KM.UP42:
  756D'   F5             C      	PUSH	AF
  756E'   CD 201D        C      	CALL	KM.MANZ
  7571'   F1             C      	POP	AF
  7572'   D6 10          C      	SUB	10H
  7574'   C8             C      	RET	Z
  7575'   D8             C      	RET	C
  7576'   18 F5          C      	JR	KM.UP42
                         C      
  7578'                  C      KM.UP43:
  7578'   FE 1E          C      	CP	01EH
  757A'   C8             C      	RET	Z
  757B'   FE 0A          C      	CP	00AH
'Kmbg'	MACRO-80 3.44	09-Dec-81	PAGE	1-89


  757D'   C8             C      	RET	Z
  757E'   FE 0D          C      	CP	00DH
  7580'   C8             C      	RET	Z
  7581'   B7             C      	OR	A
  7582'   C8             C      	RET	Z
  7583'   FE 20          C      	CP	' '
  7585'   38 03          C      	JR	C,KM.UP44
  7587'   FE 80          C      	CP	080H
  7589'   D8             C      	RET	C
  758A'                  C      KM.UP44:
  758A'   3E 7F          C      	LD	A,07FH
  758C'   C9             C      	RET
                         C      
                         C      	PAGE
'Kmbg'	MACRO-80 3.44	09-Dec-81	PAGE	1-90


                         C      
                         C      ;	ORG	00300H
                         C      
  758D'   32 FF85        C      KM.UP13:	LD	(KM.UP15-KM.UP13+KM.RAM-1),A
  7590'   DD 7E 01       C      	LD	A,(IX+1)	;<<<
  7593'                  C      KM.UP15:
  7593'   EB             C      	EX	DE,HL
  7594'   77             C      	LD	(HL),A
  7595'   3E 33          C      	LD	A,33H
  7597'   ED 67          C      	RRD
  7599'   EB             C      	EX	DE,HL
  759A'   F5             C      	PUSH	AF
  759B'   1A             C      	LD	A,(DE)
  759C'   CD FF93        C      	CALL	KM.UP14-KM.UP13+KM.RAM
  759F'   F1             C      	POP	AF
  75A0'                  C      KM.UP14:
  75A0'   FE 3A          C      	CP	03AH
  75A2'   38 02          C      	JR	C,$+4	;---!
  75A4'   C6 07          C      	ADD	A,7	;   !
  75A6'   12             C      	LD	(DE),A	;<--!
  75A7'   13             C      	INC	DE
  75A8'   C9             C      	RET
                         C      
  75A9'                  C      KM.UP4:
  75A9'   F5             C      	PUSH	AF
  75AA'   CD 7536'       C      	CALL	KM.LOE2
  75AD'   DD 7E 03       C      	LD	A,(IX+3)
  75B0'   C6 30          C      	ADD	A,30H
  75B2'   32 FFB2        C      	LD	(KM.TX1-KM.UP13+KM.RAM),A
  75B5'   11 35A0        C      	LD	DE,SD.BWSA + 18*80 ;5A0H
  75B8'   CD 7544'       C      	CALL	KM.UP10
  75BB'                  C      KM.TX2:
  75BB'   73 20 20 28    C      	DB	's  ('	;<<<
  75BF'                  C      KM.TX1:
  75BF'   32 29          C      	DB	'2)'	;<<<
  75C1'   BA             C      	DB	3AH+80H	;":"
  75C2'   11 35B4        C      	LD	DE,SD.BWSA + 18*80 +20	;5B4H
  75C5'   CD 7544'       C      	CALL	KM.UP10
  75C8'   6C 3A          C      	DB	'l:'
  75CA'   09             C      	DB	9
  75CB'   0A             C      	DB	10
  75CC'   20 73 3A       C      	DB	' s:'
  75CF'   00             C      	DB	0
  75D0'   2F             C      	DB	'/'
  75D1'   01             C      	DB	1
  75D2'   20 20 20 20    C      	DB	'      '
  75D6'   20 20          C      
  75D8'   AD             C      	DB	2DH+80H	;"-"
  75D9'   1B             C      	DEC	DE
  75DA'   1B             C      	DEC	DE
  75DB'   1B             C      	DEC	DE
  75DC'   21 0E65        C      	LD	HL,KM.PUFF-1
  75DF'   7E             C      	LD	A,(HL)
  75E0'   23             C      	INC	HL
  75E1'   CD FF86        C      	CALL	KM.UP15-KM.UP13+KM.RAM
  75E4'   13             C      	INC	DE
  75E5'   DD 46 0A       C      	LD	B,(IX+10)
  75E8'   E5             C      	PUSH	HL
  75E9'   23             C      	INC	HL
  75EA'   10 FD          C      	DJNZ	$-1
  75EC'   7E             C      	LD	A,(HL)
  75ED'   CD FF86        C      	CALL	KM.UP15-KM.UP13+KM.RAM
  75F0'   23             C      	INC	HL
  75F1'   7E             C      	LD	A,(HL)
  75F2'   CD FF86        C      	CALL	KM.UP15-KM.UP13+KM.RAM
  75F5'   E1             C      	POP	HL
  75F6'   E5             C      	PUSH	HL
  75F7'   11 3640        C      	LD	DE,SD.BWSA + 20*80	;640H
  75FA'   06 00          C      	LD	B,0
  75FC'   7E             C      	LD	A,(HL)
  75FD'   CD 7578'       C      	CALL	KM.UP43
  7600'   12             C      	LD	(DE),A
  7601'   23             C      	INC	HL
  7602'   13             C      	INC	DE
  7603'   10 F7          C      	DJNZ	$-7
  7605'   E1             C      	POP	HL
  7606'                  C      KM.UP40:
  7606'   CD 7558'       C      	CALL	KM.UP41
  7609'   F1             C      	POP	AF
  760A'   C9             C      	RET
                         C      
  760B'                  C      KM.UPEND	EQU	$
'Kmbg'	MACRO-80 3.44	09-Dec-81	PAGE	1-91


                         C      
                         C      ;SM.FKTAB	EQU	00D00H
  0DA8                   C      KM.TTABU  EQU	00DA8H
  0DAE                   C      KM.TNEWL  EQU	00DAEH
  0DB0                   C      KM.TEINA  EQU	00DB0H
  0E66                   C      KM.PUFF   EQU	00E66H
                         C      
  201D                   C      KM.MANZ   EQU	0201DH
  2060                   C      KM.MHOME  EQU	02060H
  23BA                   C      KM.MINSL  EQU	023BAH
                         C      ;ATACO     EQU	024F8H
                         C      
  2B01                   C      KM.KMTAB  EQU	02B01H
                         C      ;SD.BWSA  EQU	03000H
                         C      
  5A93                   C      KM.KARO   EQU	05A93H
                         C      
                         C      ;DRUZ      EQU	07C00H
                         C      
  FF80                   C      KM.RAM    EQU	0FF80H
                         C      
                         C      			;(C) Rainer Sieber     A d W
                         C      
                         C      
                         C      ;	END
                                
                                	TITLE ''
                                	END
''	MACRO-80 3.44	09-Dec-81	PAGE	S


Macros:

Symbols:
21EF 	ATACO           0001 	BC.AGG          0000 	BC.EGG          
FA3A 	BC.END          E000 	BC.TAB1         F902 	BC.TAB2         
F96A 	BC.TAB2A        F9D2 	BC.TAB3         E002 	BC.VTABA        
EC82 	BC.VTABE        712D'	CP.COMPR        7190'	CP.INIT         
7160'	CP.KOM          7132'	CP.NL           7160'	CP.OUT          
7140'	CP.OUTT         7167'	CP.SOKOM        717D'	CP.SOSTR        
7145'	CP.SPACE        713C'	CP.STRNG        7182'	CP.TAB          
7150'	CP.TEXT         54F7'	CRC0            54FB'	CRC1            
550E'	CRC2            7196'	DC.DCMPR        71CC'	DC.EOSPC        
71D1'	DC.INIT         7198'	DC.NL           71BC'	DC.SPACE        
71B2'	DC.TAB          71A4'	DC.TEXT         620E'	FD.BMGF         
5F38'	FD.DASU         6072'	FD.DECBZ        6129'	FD.DECHL        
61E9'	FD.DSPBB        61F9'	FD.DSPBG        619E'	FD.END          
61C7'	FD.FDIN2        5F85'	FD.FDINP        5FD8'	FD.FDOUT        
603C'	FD.FDOW1        6040'	FD.FDOW2        6065'	FD.FDOW3        
6057'	FD.FDOW4        602C'	FD.FDOWR        607C'	FD.FDUP         
61A5'	FD.FOLWR        6132'	FD.FOUT1        60BE'	FD.FSTRT        
5F31'	FD.KO01         5F19'	FD.POSK         6203'	FD.RDEND        
5FCC'	FD.SDIN         60AE'	FD.SDK0         60B8'	FD.SDK1         
60A4'	FD.SDK2         6026'	FD.SDOUT        6094'	FD.SDOW         
610B'	FD.SETJ         6123'	FD.SETN         60F6'	FD.STRT1        
5F54'	FD.WRRES        5400'	K1.BRKMB        54F4'	K1.CRC          
5441'	K1.KERN         5E42'	KH.ANZB1        5E3F'	KH.ANZBL        
5E5E'	KH.AZ1Z         5E8F'	KH.AZ4B0        5EB0'	KH.AZ4B1        
5E9F'	KH.AZ4B3        5E8B'	KH.AZ4BY        5E82'	KH.AZADR        
5E4E'	KH.AZBL1        5E49'	KH.AZBLD        5F0B'	KH.BILO         
5EC9'	KH.BLEV1        5ECB'	KH.BLEV2        5EB4'	KH.BLEVG        
5F03'	KH.KBRS         5DBF'	KH.RD1          5E25'	KH.RD2          
5DD4'	KH.RD3          5DE4'	KH.RD4          5DDD'	KH.RD6          
5E2E'	KH.RDBM         5DB1'	KH.RDSTA        5DBC'	KH.RES          
5E21'	KH.SYSRT        5EDD'	KH.WRSTA        5A51'	KI.KM           
5A12'	KI.KN           5AB8'	KI.KO03         5A35'	KI.NMR          
5AC3'	KI.RENA         5AE0'	KI.RENA9        5A9A'	KI.VERZ         
74BF'	KM.ABS          74C4'	KM.ABS1         730B'	KM.ANF          
7386'	KM.CL           7395'	KM.CNZA         73A9'	KM.CNZA1        
736F'	KM.CO           7390'	KM.CR           7379'	KM.CU           
7501'	KM.DEL          73EA'	KM.EINA         73F5'	KM.EINA1        
73FC'	KM.EINA2        7403'	KM.EINA3        740A'	KM.EINA4        
7415'	KM.EINA5        7418'	KM.EINA6        741B'	KM.EINA7        
7432'	KM.EINA8        743F'	KM.EINA9        7453'	KM.EINAA        
7454'	KM.EINAB        7459'	KM.EINAC        745D'	KM.EINAD        
7471'	KM.EINAE        7374'	KM.HOME         5A93 	KM.KARO         
2B01 	KM.KMTAB        752C'	KM.LOE1         7536'	KM.LOE2         
753E'	KM.LOE3         201D 	KM.MANZ         2060 	KM.MHOME        
23BA 	KM.MINSL        73C5'	KM.NEWL         0E66 	KM.PUFF         
FF80 	KM.RAM          737E'	KM.SL           738B'	KM.SR           
0DB0 	KM.TEINA        0DAE 	KM.TNEWL        0DA8 	KM.TTABU        
75BF'	KM.TX1          75BB'	KM.TX2          750C'	KM.UP1          
7544'	KM.UP10         7545'	KM.UP11         754E'	KM.UP12         
758D'	KM.UP13         75A0'	KM.UP14         7593'	KM.UP15         
750F'	KM.UP2          7480'	KM.UP20         7491'	KM.UP21         
749B'	KM.UP22         74AF'	KM.UP23         74B1'	KM.UP24         
74BA'	KM.UP25         7517'	KM.UP3          74CE'	KM.UP30         
74DA'	KM.UP31         74E6'	KM.UP32         74E9'	KM.UP33         
74ED'	KM.UP34         74F9'	KM.UP35         74E1'	KM.UP36         
75A9'	KM.UP4          7606'	KM.UP40         7558'	KM.UP41         
756D'	KM.UP42         7578'	KM.UP43         758A'	KM.UP44         
7520'	KM.UP5          760B'	KM.UPEND        54EA'	KOMED           
55D1'	KR.CKRA         5520'	KR.GR1          552A'	KR.GR2          
552C'	KR.GR3          55D5'	KR.KARO         565D'	KR.TYPT         
55D9'	KR.VORSP        6A5B'	KU.DD           6A58'	KU.DECIY        
69F3'	KU.TAB2L        69EA'	KU.VVOR         6A2B'	KU.ZEIR         
5B59'	KV.ANF          5D7C'	KV.ANZ          5C29'	KV.AUSG         
5D92'	KV.AVZS         5D04'	KV.BSTR         5D67'	KV.DBCVM        
5CEC'	KV.DRU          5CEA'	KV.DRU1         5CF9'	KV.KO02         
5C9E'	KV.KRW          5CD2'	KV.P1           5D72'	KV.SBC          
5D31'	KV.SPTR         5BC2'	KV.TABTR        5C08'	KV.ZEIHO        
5B8D'	KV.ZLTR         670A'	KX.ENDR         6729'	KX.EXEC2        
66FF'	KX.RSPFR        6759'	KX.UPA          69E3'	KY.AJ           
6805'	KY.ATAA         6828'	KY.ATAB         6839'	KY.ATABE        
68CA'	KY.COPY         6794'	KY.DFR          6977'	KY.EOV          
6886'	KY.EVZ          6889'	KY.EVZ1         69B6'	KY.EWK          
6802'	KY.EZYK1        69C6'	KY.JHL          692A'	KY.KOP          
6944'	KY.KOPAN        6924'	KY.KOPV         6776'	KY.MD           
67FC'	KY.NDA          686D'	KY.NE           69CF'	KY.SATR         
67EE'	KY.SVGL         68EE'	KY.VSCHR        68A1'	KY.VSTR         
67E3'	KY.VZVGL        6847'	KY.WEI          685B'	KY.ZYK          
6256'	LD.DATFU        6231'	LD.DATN         6277'	LD.DATPO        
62F2'	LD.LAD1         62E1'	LD.LAD2         62DE'	LD.LADER        
''	MACRO-80 3.44	09-Dec-81	PAGE	S-1


6307'	LD.LADF         6246'	LD.LD2          6250'	LD.LD21         
62D9'	LD.LD3          6297'	LD.LD4          62B2'	LD.LD5          
62FE'	LD.LDEND        62CF'	LD.START        6AD1'	POSIK1          
4040 	PRINT           4070 	PUF.KASS        630D'	RL.BEG          
6419'	RL.BF           6405'	RL.DATNV        6400'	RL.ECHO         
641B'	RL.FMELD        639E'	RL.M10          63AF'	RL.M11          
633E'	RL.M12          637C'	RL.M13          638C'	RL.M14          
6394'	RL.M15          632D'	RL.M16          635B'	RL.M17          
63C2'	RL.M21          6415'	RL.MN           6409'	RL.OB           
640D'	RL.RA           6411'	RL.SV           6322'	RL.UG           
63B5'	RL.UP6          54E2'	RLAD            54DD'	RRET            
3000 	SD.BWSA         0D00 	SM.FKTAB        54D9'	STF07           
54CF'	STF99           54D6'	STFRS           548D'	STT02           
54AB'	STT08           5465'	STT11           5465'	STT15           
5465'	STT21           5465'	STT31           5465'	STT41           
547E'	STT5            5471'	STT51           5475'	STT61           
5479'	STT71           5479'	STT75           6529'	SV.BYANZ        
65BA'	SV.DALO1        6457'	SV.DATN         6534'	SV.DATS1        
646E'	SV.DATV1        6476'	SV.DATVO        654E'	SV.SAVE         
655F'	SV.SAVE1        64B0'	SV.SAVE3        64C5'	SV.SAVE4        
650D'	SV.SAVE5        6503'	SV.SAVE6        65B2'	SV.STAD0        
644A'	SV.SV20         6462'	SV.SV21         647C'	SV.SV30         
6496'	SV.SV31         6484'	SV.SV37         65A2'	SV.SVEN1        
659F'	SV.SVEN2        6576'	SV.SVLS         6592'	SV.SVLS1        
657C'	SV.SVLS2        65C5'	SV.SVSZ         65D9'	SV.SVSZ1        
65C7'	SV.SVSZ2        4036 	SY.RESC         4033 	SY.SETCHL       
4026 	TA.ABFR1        6CF9'	U1.AUS          6E2C'	U1.BILO         
6CAD'	U1.BREAD        6CB8'	U1.BWRIT        6C93'	U1.CLRB         
6CC7'	U1.COPB         6CC3'	U1.COPB2        6D19'	U1.DSVG         
6CF0'	U1.EIN          6E26'	U1.INFO         6CA2'	U1.KBR4         
6E61'	U1.KRWE         6D7E'	U1.KTIN1        6D65'	U1.KTINI        
6D4A'	U1.NMVGL        6E4A'	U1.PRADR        6C8A'	U1.RRST         
6C82'	U1.RSAVE        6E21'	U1.TR           6E40'	U1.TST          
6D93'	U1.VERIN        6D9B'	U1.VERNI        6DBD'	U1.VORS1        
6DB5'	U1.VORST        6D02'	U1.VS1          6D09'	U1.VSX          
6DC9'	U1.VZS          6CAC'	U1.WAIT         599D'	UA.ALTR         
5984'	UA.ANZWD        586D'	UA.BMGF         587E'	UA.DF           
5877'	UA.DOK          573E'	UA.DS           57FB'	UA.EABFR        
5867'	UA.FRZ          57B6'	UA.GER          575E'	UA.KNAME        
5784'	UA.KOMMT        57C5'	UA.KOPFR        5959'	UA.LD           
5771'	UA.NR           58D1'	UA.STADR        5831'	UA.VORH         
5797'	UA.Z7E          58AB'	UA.ZKBEG        592A'	UA.ZKBEL        
593D'	UA.ZKBLG        5950'	UA.ZKBM         5885'	UA.ZKDAT        
58E4'	UA.ZKDL         58BE'	UA.ZKEND        58F7'	UA.ZKF          
5898'	UA.ZKLAD        5902'	UA.ZKRES        5915'	UA.ZKSDT        
596B'	UA.ZRSCH        2B64'	UB.DTAB         2B8D'	UB.END          
2B01'	UB.KTAB         2B1C'	UB.PAR1         2B1E'	UB.PAR2         
2B20'	UB.PAR3         2B22'	UB.PAR4         2B24'	UB.PAR5         
2B26'	UB.PATAB        2B2A'	UB.SATZ         2B00'	UB.ZN           
706D'	UC.ASCCO        704A'	UC.CKONV        6F14'	UC.CVABX        
6F2F'	UC.CVAX         6F43'	UC.CVAXB        700D'	UC.CVBC         
6F9D'	UC.CVBD         6FA8'	UC.CVBD0        6F9B'	UC.CVBD1        
6F97'	UC.CVBD2        6F93'	UC.CVBD3        6F8F'	UC.CVBD4        
6F8B'	UC.CVBD5        6F1E'	UC.CVBX         701E'	UC.CVCB         
7005'	UC.CVD1B        6FDC'	UC.CVDB         6F3A'	UC.CVHLX        
6F65'	UC.CVX1B        6F80'	UC.CVXA         6F54'	UC.CVXB         
6F6E'	UC.CVXER        6F06'	UC.DIVR         703F'	UC.DK1          
7053'	UC.DK2          70CD'	UC.DKOI         702B'	UC.DKONV        
6EED'	UC.HL10C        6EE6'	UC.HL10N        7035'	UC.KONV         
7069'	UC.KONV2        5400'	UE.BRKMB        3000 	UE.BWSA         
0060 	UE.COTAL        54F4'	UE.CRC          0DC4 	UE.EDEND        
0132 	UE.KMPUL        8010 	UE.KPUFF        0E66 	UE.PUF          
0CFE 	UE.STANF        007D 	UE.SVL          000B 	UE.SYSTB        
00F7 	UE.TACL         00F9 	UE.TACR         001E 	UE.TAQUI        
00CD 	UE.TASYS        8830 	UE.TEXAN        0E5A 	UE.ZEIN         
56E0'	UF.AZVB         5715'	UF.BEHB         571D'	UF.BEHB1        
5694'	UF.ERANZ        5668'	UF.EXEC         568E'	UF.EXEC1        
568B'	UF.EXEC2        5732'	UF.FL14         5735'	UF.FL16         
572F'	UF.FL17         5723'	UF.FL18         5663'	UF.RET          
56D0'	UF.SYS          56DC'	UF.SYS1         71D7'	UK.GETK         
71F8'	UK.GETK2        7200'	UK.GETK3        7206'	UK.GETK4        
71FC'	UK.GETK5        72C5'	UK.KBA          7237'	UK.KBW          
7276'	UK.KBW1         7272'	UK.KBW2         7214'	UK.KLPFB        
72A0'	UK.KSPFB        727C'	UK.PUTK         6C36'	UR.ALPH1        
6C2D'	UR.ALPHA        6C41'	UR.ALPNU        6B68'	UR.BBSA1        
6B60'	UR.BBSAD        6C72'	UR.BILR1        6C60'	UR.BILRO        
6AFD'	UR.BM           6B70'	UR.DSPZK        6C4B'	UR.HEXAZ        
6C58'	UR.HEXZ1        6AAA'	UR.KBM          6ABC'	UR.KBR          
6AB6'	UR.KBV          6AA4'	UR.KLR          6A9E'	UR.KLV          
6A98'	UR.KRA          6A86'	UR.KRE          6A8A'	UR.KRE1         
6A8E'	UR.KRW          6A94'	UR.KRWW         6AB0'	UR.KSL          
6AD6'	UR.LES          6B2E'	UR.MIMO         6B4A'	UR.MIMO1        
6B42'	UR.MIMO2        6B51'	UR.MIMO3        6C38'	UR.NUM          
''	MACRO-80 3.44	09-Dec-81	PAGE	S-2


6B0B'	UR.OK           6ACB'	UR.POSIK        6BC0'	UR.RET0         
6AC2'	UR.RPOS         6B2A'	UR.RSP          6C5A'	UR.TAREP        
6BCA'	UR.TCL          6BDC'	UR.TCLN         6BDF'	UR.TCR          
6BF0'	UR.TCRN         6BFA'	UR.TQUIT        6BF2'	UR.TSYS         
6B7D'	UR.ZINP         6B83'	UR.ZINP1        6B86'	UR.ZINP2        
6BB4'	UR.ZINP3        6BBA'	UR.ZINP4        6BA2'	UR.ZINP5        
6BC3'	UR.ZINP7        6C28'	UR.ZKON1        6C02'	UR.ZKONT        
6E68'	XY.CALP1        6E71'	XY.CALPE        6EBC'	XY.INCDX        
6ED5'	XY.JMPDX        6E7C'	XY.LDDX         6E8C'	XY.LIDX         
6E9C'	XY.STDX         6EAC'	XY.STIDX        



No Fatal error(s)


