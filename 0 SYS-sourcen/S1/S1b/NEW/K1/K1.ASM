	TITLE 'BAMOS/Emulator  ---  Kassettenmagnetband'
	PAGE
;****************************************************************
;*               BAMOS/Emulator  ---  Kassettenmagnetband       *
;* OS - Version  -----------------------------------------------*
;*               Programmierer: Marcus Herbote                  *
;* V 1 . 2       -----------------------------------------------*
;*               Stand        : 18.November 2022                *
;****************************************************************

;****************************************************************
;*               Geraetebedienroutine fuer Kassettenmagnetband  *
;*               Anschluss von zwei Laufwerken K5200            *
;*               an einer AKB K5020                             *
;*               -----------------------------------------------*
;*               E/A-Tabelle                                    *
;*               Byte  0   Status                               *
;*               Byte  1   Fehlerschluessel                     *
;*               Byte  2   Laenge der Daten im Puffer           *
;*                         1, 10H, 20H, 80H                     *
;*               Byte  3   Basisadresse der AKB                 *
;*               Byte  4   Subadresse                           *
;*               Byte  5   Kommando                             *
;*               Byte  6   HS-Bereich                           *
;*               Byte  7   H-Teil Blockadresse                  *
;*               Byte  8   L-Teil Blockadresse                  *
;*                         n      bei suchen Bandmarke          *
;*               -----------------------------------------------*
;*               Byte  9 1 0F0H  Startbyte                      *
;*               Byte 10 2       Kommando                       *
;*               Byte 11 3       Subadresse                     *
;*               Byte 12 4       Anzahl BM  bei 71, 75          *
;*               Byte 12 4       'B'        bei 51              *
;*               Byte 12 4       'S'        bei 61              *
;*               Byte 12 4       HS-Bereich bei 02              *
;*               Byte 12 4       Laenge     bei 08              *
;*               Byte 12 4 0FFH             bei 31,41,21,11,15  *
;*               Byte 13 5       H(Puffer)  bei 02              *
;*               Byte 13 5       HS-Bereich bei 08              *
;*               Byte 13 5 0FFH             bei 51,61,71,75     *
;*               Byte 14 6       L(Puffer)  bei 02              *
;*               Byte 14 6       H(Puffer)  bei 08              *
;*               Byte 15 7       L(Puffer)  bei 08              *
;*               Byte 15 7 0FFH             bei 02              *
;*               Byte 16 8 0FFH             bei 08              *
;****************************************************************
;*               Kommandos:                                     *
;*                 Hex   Kommando                               *
;*                 02    naechsten Record einlesen              *
;*                 08    naechsten Record schreiben             *
;*                 11    einen Block vorsetzen                  *
;*                 15    einen Block ruecksetzen                *
;*                 21    umspulen                               *
;*                 31    reservieren ein                        *
;*                 41    reservieren aus                        *
;*                 51    schreiben einer Bandmarke              *
;*                 61    schreiben Schlussluecke                *
;*                 71    suche n-te Bandmarke vorwaerts         *
;*                 75    suche n-te Bandmarke rueckwaerts       *
;****************************************************************
	PAGE
;****************************************************************
;*               Status                                         *
;*               Bit 0     0 Geraet frei                        *
;*                         1 Geraet besetzt                     *
;*               Bit 1     0                                    *
;*                         1 Datentraegerende                   *
;*               Bit 2     0 Aufzeichnen erlaubt                *
;*                         1 Aufzeichnen verboten               *
;*               Bit 3     0 Kassettenseite A                   *
;*                         1 Kassettenseite B                   *
;*               Bit 4     0 Geraet       bereit                *
;*                         1 Geraet nicht bereit                *
;*               Bit 5     0 Geraet nicht reserviert            *
;*                         1 Geraet       reserviert            *
;*               Bit 6     0 Aufzeichnungsverf.  38 CM*S**-1    *
;*                         1 Aufzeichnungsverf.  19 CM*S**-1    *
;*               Bit 7     0 Kommando fehlerfrei ausgefuehrt    *
;*                         1 Fehler (siehe Fehlerschluessel)    *
;*               -----------------------------------------------*
;*               Fehlerschluessel                               *
;*                 Hex   Fehler                                 *
;*                 10    falsches Kommando                      *
;*                 11    angewaehltes Geraet nicht reserviert   *
;*                 12    Subadresse falsch                      *
;*                 13    Pufferl. kleiner 12 oder groesser 256  *
;*                 14    Ende der Aufzeichnungen auf dieser     *
;*                       Kassettenseite (Lesen)                 *
;*                 15    angewaehltes Geraet besetzt            *
;*                 16    Ende/Anfang der Aufzeichnungen         *
;*                       (Bandmarke suchen)                     *
;*                 17    gelesener Block laenger 260 Byte       *
;*                 18    Bandmarke nicht gefunden               *
;*                 19    Aufzeichnen verboten                   *
;*                       (mit Kommando: Aufzeichnen)            *
;****************************************************************
    PAGE
;****************************************************************
;*               Hinweise zur Arbeit mit der Geraetebedienr.    *
;*                - E/A-Tabelle laden (Basisadresse AKB)        *
;*                - Adresse E/A-Tabelle in IX laden             *
;*                - laden Schluessel fuer Kommando , Subadresse *
;*                    Adresse Eintrittspunkt                    *
;*                - Aufruf Geraetebedienroutine immer mit       *
;*                    CALL   KR.BRKMB                           *
;*                - wird keine Parallelarbeit mit anderen       *
;*                  Programmen gewuenscht , kann wie in         *
;*                  folgendem Beispiel verfahren werden:        *
;*                        ...                                   *
;*                        CALL KR.BRKMB ;Aufruf                 *
;*                  MARKE:HALT                                  *
;*                        JR   MARKE-#                          *
;*                  ADREP:............  ;Adresse Eintrittspunkt *
;*                        ...                                   *
;*                - bei Rueckkehr der Bedienroutine zum Ein-    *
;*                  trittspunkt ist die Adresse des folgenden   *
;*                  Befehls , bei dem der letzte Interrupt      *
;*                  angenommen wurde , noch im SP .             *
;*                  Wird , wie im obigen Beispiel , diese       *
;*                  Adresse nicht mehr benoetigt , so ist der   *
;*                  SP  um 2 zu erhoehen.                       *
;****************************************************************
	TITLE	'Steuerteil Geraetebedienroutine'
    PAGE
	ORG	04000H
;****************************************************************
;*               Steuerteil der Geraetebedienroutine            *
;****************************************************************
K1.BRKMB:
    DI
    CALL    RRET

;****************************************************************
;*               Analyse Kommando                               *
;****************************************************************
    LD  A,(IX+5)
    CP  002H    ;naechsten Record einlesen
    JP  Z,STT02
    CP  008H    ;naechsten Record schreiben
    JP  Z,STT08
    CP  011H    ;einen Block vorsetzen
    JP  Z,STT11
    CP  015H    ;einen Block ruecksetzen
    JP  Z,STT15
    CP  021H    ;umspulen
    JP  Z,STT21
    CP  031     ;reservieren ein
    JP  Z,STT31
    CP  041     ;reservieren aus
    JP  Z,STT41
    CP  051     ;schreiben einer Bandmarke
    JP  Z,STT51
    CP  061     ;schreiben Schlussluecke
    JP  Z,STT61
    CP  071     ;suche n-te Bandmarke vorwaerts
    JP  Z,STT71    
    CP  075     ;suche n-te Bandmarke rueckwaerts
    JP  Z,STT75
    JP  STF07   ;falsches Kommando

;****************************************************************
;*               Kernroutine MB                                 *
;****************************************************************
Kern:
    LD  (IX+9),0F0H
    LD  (IX+10),A   ;Kommando
    LD  A,(IX+4)
    LD  (IX+11),A   ;Subadresse

    LD  C,(IX+3)    ;Basisadresse der AKB
    PUSH    IX
    POP HL
    LD  DE,9
    ADD  HL,DE
    OTIR            ;KM - Routine aufrufen
    PUSH    IX
    POP HL
    LD  B,3
    INIR            ;Status und Fehler holen
    RET
    PAGE
;****************************************************************
;*               reservieren ein / aus                          *
;****************************************************************
STT31:
STT41:
;****************************************************************
;*               umspulen                                       *
;****************************************************************
STT21:
;****************************************************************
;*               vor-/ruecksetzen um einen Block                *
;****************************************************************
STT11:
STT15:
    LD  (IX+12),0FFH

    LD  B,4
    CALL Kern
    JP	KOMED	;Kommandoende

;****************************************************************
;*               schreiben einer Bandmarke                      *
;****************************************************************
STT51:
    LD  A,'B'
    JR  STT5
;****************************************************************
;*               schreiben einer Schlussluecke                  *
;****************************************************************
STT61:
    LD  A,'S'
    JR  STT5
;****************************************************************
;*               suche Bandmarke vorwaerts / rueckwaerts        *
;****************************************************************
STT71:
STT75:
    LD  A,(IX+8)
    JR  STT5
STT5:
    LD  (IX+12),A
    LD  (IX+13),0FFH

    LD  B,5
    CALL Kern
    JP	KOMED	;Kommandoende
    PAGE
;****************************************************************
;*               Eingabezweig                                   *
;****************************************************************
STT02:
    LD  A,(IX+6)
    LD  (IX+12),A

    LD  A,(IX+7)
    LD  (IX+13),A
    LD  A,(IX+8)
    LD  (IX+14),A

    LD  (IX+15),0FFH

    LD  B,7
    CALL Kern
    JP	KOMED	;Kommandoende
    
;****************************************************************
;*               Aufzeichnungszweig                             *
;****************************************************************
STT08:
    LD  A,(IX+2)
    LD  (IX+12),A

    LD  A,(IX+6)
    LD  (IX+13),A

    LD  A,(IX+7)
    LD  (IX+14),A
    LD  A,(IX+8)
    LD  (IX+15),A

    LD  (IX+16),0FFH

    LD  B,8
    CALL Kern
    JP	KOMED	;Kommandoende

    PAGE
;****************************************************************
;*               Fehler                                         *
;****************************************************************
STF99:
	LD	(IX+1),L	;Fehlerschluessel laden
	SET	7,(IX)	;Fehlerbit setzen
STFRS:
	JP	KOMED	;Kommandoende

STF07:
	LD	L,10H	;falsches Kommando
	JR	STF99

    PAGE
;****************************************************************
;*               Register AF , BC , DE , HL retten in SP        *
;****************************************************************
RRET:
    PUSH    IX
	PUSH	HL
	PUSH	DE
	PUSH	BC
	PUSH	AF
    RET
;****************************************************************
;*               Register AF , BC , DE , HL laden aus SP        *
;****************************************************************
RLAD:
	POP	AF
	POP	BC
	POP	DE
    POP HL
    POP IX
	RET

;****************************************************************
;*               Verzweigung aus Steuerteil zum Eintrittspunkt  *
;*               des Steuerprogrammes                           *
;****************************************************************
KOMED:
	DI
	RES 0,(IX)
	CALL	RLAD
	EI
	RET
    PAGE
;****************************************************************
;*               CRC-Zeichen berechnen                          *
;*               <B>  = Blocklaenge , 0 = 256                   *
;*               <HL> = Pufferadresse                           *
;*               in  DE  nach Aufruf CRC-Zeichen                *
;*                <D> = 1.Byte , wird zuerst gesendet           *
;*                <E> = 2.Byte , wird danach gesendet           *
;****************************************************************
K1.CRC:
	LD	DE,0
CRC0:
	PUSH	BC	;Bytelaenge
	LD	B,8
	LD	C,(HL)
CRC1:
	LD	A,C
	XOR	D
	RRCA		;Ergebnis Antivalenz Wort-Byte/CRC-Byte,Bit 0
	PUSH	AF
	RR	E	;Verschiebung von DE um 1 Bit nach rechts
	RR	D
	POP	AF	;Rueckretten F
	JR	NC,CRC2	;Sprung wenn Antivalenz 0 + 0 = 0
	LD	A,D	;Korrektur = Umkehr Bit 13/Bit 0
	XOR	1	;Maske fuer D
	LD	D,A	;Korrektur  D
	LD	A,E
	XOR	20H	;Maske fuer E
	LD	E,A	;Korrektur  E
CRC2:
	RRC	C	;Schieben Datenbyte
	DJNZ	CRC1
	POP	BC	;Byte abgearbeitet
	DEC	BC
	LD	A,C
	OR	B
	RET	Z
	INC	HL
	JR	CRC0

;	END
