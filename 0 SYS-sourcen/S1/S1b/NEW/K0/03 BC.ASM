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