	TITLE 'EQUAL - Anweisungen fuer Assembler'
	PAGE	87
;         PN    UE01
;****************************************************************
;*                  EQUAL - Anweisungen fuer Assembler          *
;****************************************************************
UE.TACL  EQU	0F7H	;Kursor nach links
UE.TACR  EQU	0F9H	; ''    nach rechts
UE.TASYS EQU	0CDH	;SYS-Taste
UE.TAQUI EQU	01EH	;ET1
UE.SVL   EQU	07DH	;Laenge der SAVE-Bloecke
UE.COTAL EQU	060H	;Laenge ASC/KOI Codetabelle
UE.KMPUL EQU	132H	;max. Laenge E/A-Puffer

UE.SYSTB EQU	0000BH	;SY.SYSTB
UE.STANF EQU	00CFEH	;STACK
UE.EDEND EQU	00DC4H	;Speicherpl. fuer Adr. Editorende
UE.ZEIN  EQU	00E5AH	;Pufferzaehler Eingabe
UE.PUF   EQU	00E66H	;System-Puffer
UE.BWSA  EQU	03000H	;Bildwiederholspeicher
UE.KPUFF EQU	08010H	;E/A Puffer
UE.TEXAN EQU	08830H	;Begin Editorraum

UE.BRKMB EQU	K1.BRKMB ;04000H	;phys. Kass.Routine
UE.CRC   EQU	K1.CRC	;04740H	;CRC-Berechnung

;         END
;         PN    UB
          ORG   2B00H
UB.ZN:    DS	1,0
UB.KTAB:  DS	27,0
UB.PAR1:  DW	0
UB.PAR2:  DW	0
UB.PAR3:  DW	0
UB.PAR4:  DW	0
UB.PAR5:  DW	0
UB.PATAB: DS	4,0
UB.SATZ:  DB	0
          DB	55
          DB	80H
          DB	'                                                       '
UB.DTAB:  DS	41,0
UB.END    EQU	$
;         END
;         PN    BC
;----------------------------------------------------------------------
;
;        BEREICHE FUER KASSETTENKOPIEREN
;
;----------------------------------------------------------------------
BC.TAB1    EQU	0E000H
BC.EGG     EQU	0	;EINGABEGERAET
BC.AGG     EQU	1	;AUSGABEGERAET
BC.VTABA   EQU	0E002H
BC.VTABE   EQU	0E002H+3200
BC.TAB2    EQU	0E002H+3200+3200
BC.TAB2A   EQU	0E002H+3200+3200+104
BC.TAB3    EQU	0E002H+3200+3200+104+104
BC.END     EQU	0E002H+3200+3200+104+104+104
;	ORG	0E000H
;BC.TAB1:   DS	2
;
;BC.EGG     EQU	0	;EINGABEGERAET
;BC.AGG     EQU	1	;AUSGABEGERAET
;----------------------------------------------------------------------
;BC.VTABA:  DS	3200
;BC.VTABE:  DS	3200
;----------------------------------------------------------------------
;BC.TAB2:   DS	104
;BC.TAB2A:  DS	104
;BC.TAB3:   DS	104
;BC.END     EQU	$
;----------------------------------------------------------------------
;         END
